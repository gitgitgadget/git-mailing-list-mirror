From: Strainu <strainu10@gmail.com>
Subject: Re: [OpenStack-Infra] BUG: [Cosmetic] Commiting a gerrit ChangeId
 before the commit hook was installed
Date: Sat, 18 Jan 2014 01:38:27 +0200
Message-ID: <CAC9meR+zViFN5PEZxvYp_4XY28OvcR9SeiOP_5DbBCmChYPONg@mail.gmail.com>
References: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
 <20140117204132.GB18964@google.com> <CAC9meR+78_EvoqHNcuPyDKOZDjSsUngziGDa2aV1QDtOb8eOXw@mail.gmail.com>
 <CAE3ttVgs=F2bWbx5qa=dp1kNzgc5djtB3r+2Qp6tvYv-iZKoCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"openstack-infra@lists.openstack.org" 
	<openstack-infra@lists.openstack.org>, git <git@vger.kernel.org>
To: Jerry Xinyu Zhao <xyzjerry@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 00:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4J0W-0004cm-WA
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 00:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbaAQXjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 18:39:20 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36262 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbaAQXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 18:39:19 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so4607389pde.28
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GYK4xlX1FfE2E89+QvF67IVvDnf6Ci2S3/ub8/20bp0=;
        b=lXyqWqeTtd+cMWc+BCcbOQODXt0sD/EEzbpn3TJ04w5BnfIbnhAtYWtx/hjv9MyQqP
         1DwlhdQVOuPXTpqRyeaYpTmVhJBjtFRHHDyXHkrKL90HMtAG4vevHhm//hM8rXRLa5ho
         f7aviEWa4YGLlM+ThYHBvDmpTGcH+JaA4w3aS7lkU8E3YZRalkqAdzxLeCmxQp/zV5MC
         jo8DEVDpnBRl3tHsYgewDA6g8GlZDs7/NyCRhFiEl10Ts6yFVECjyny1Gg+/wq5iBp6b
         Ax+6b9BY4MfwzNXevF2w27aEv1eagoNkUpwzPUQYEFN+xvvoPMmBbHANj1UNyA8lD6Rx
         ge8g==
X-Received: by 10.67.22.100 with SMTP id hr4mr5094201pad.112.1390001959223;
 Fri, 17 Jan 2014 15:39:19 -0800 (PST)
Received: by 10.68.175.225 with HTTP; Fri, 17 Jan 2014 15:38:27 -0800 (PST)
In-Reply-To: <CAE3ttVgs=F2bWbx5qa=dp1kNzgc5djtB3r+2Qp6tvYv-iZKoCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240636>

Perhaps I haven't been clear enough: the commit already had a change
ID, added manually, so with or without the hook it would have been
attached to the correct review.

In this case, the hook will actually do nothing, making the current
wording of the message confusing IMO. My suggestion was [1] to change
the mesage to "Amending the commit to add a gerrit change id if none
is available." or something similar.

Strainu

[1] https://bugs.launchpad.net/git-review/+bug/1270301

2014/1/18 Jerry Xinyu Zhao <xyzjerry@gmail.com>:
> I think if you hadn't installed the commit hook for generating change ID,
> the commit indeed wouldn't have included a change ID, which is necessary for
> referencing the change when you submit a patch over it. There is nothing
> wrong with the message.  git review tool will install the hook and add a
> change ID for you automatically(a new feature of recent git-review release).
>
>
>
> On Fri, Jan 17, 2014 at 1:10 PM, Strainu <strainu10@gmail.com> wrote:
>>
>> 2014/1/17 Jonathan Nieder <jrnieder@gmail.com>:
>> > Hi,
>> >
>> > Strainu wrote:
>> >
>> >> strainu@emily:~/core> git review -f
>> >> Creating a git remote called "gerrit" that maps to:
>> >>         ssh://strainu@gerrit.wikimedia.org:29418/pywikibot/core.git
>> >> Your change was committed before the commit hook was installed.
>> >> Amending the commit to add a gerrit change id.
>> >>
>> >> At this point I ended the transaction, as I was confused by the last
>> >> message: I was afraid the ChangeId would have changed, causing the
>> >> patch to be attached to another review.
>> >>
>> >> I think git should not show this message if the change description
>> >> already has a change id
>> >
>> > This message doesn't come from git.  It comes from the git-review
>> > tool (in git_review/cmd.py), so cc-ing the authors in case they
>> > have thoughts on that.
>>
>> Thanks for clarifying that. I'll log a bug on launchpad then.
>>
>> Strainu
>>
>> _______________________________________________
>> OpenStack-Infra mailing list
>> OpenStack-Infra@lists.openstack.org
>> http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-infra
>
>
