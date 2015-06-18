From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Git completion not using ls-remote to auto-complete during push
Date: Thu, 18 Jun 2015 10:27:16 -0500
Message-ID: <CAHd499DeUOqsuSoysaOAAYORk3B=XBXco9yEKdXt8m4XJYFyZw@mail.gmail.com>
References: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
	<1434626973-4801-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>,
	Git <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:27:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5bj1-0004OC-HK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756123AbbFRP1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 11:27:22 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33967 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbbFRP1R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 11:27:17 -0400
Received: by igboe5 with SMTP id oe5so21416967igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=U/HHEiIAYfvC3VqrJwh8nPGgpgoQYl6c4qq0e6cO3gI=;
        b=PGibd3DG6QE1j89NbyJ1YBf3O+nDDvxK9C9ww9pyRZBh7saR+J4233YVjbku86BCvc
         srTWhx6pt8VrkQbNaVSpN1ak7qKwRUyZ6JX3BjpEEWDmfS5OAfBXkYHgeGL95zkia7A6
         Zv0KSBVEmsKc9QbOFbscuWCJGpp8DxuxbUYqPx6AIFkkcoT1brH2q+9RtsZcR7nTnPsd
         tUexJIeY7zwsjTnhngkPpzyE03rb61MecOkAdhbmio4m8WgSNeXEK1XsYj84EDoJJnjR
         RwjxK/JkKt1Z1mQk2yjuohV0HXvK5PXMA30P0lfbofET/z+6lLQdrOTcZAnC8tUKFl4P
         HSZQ==
X-Received: by 10.50.4.66 with SMTP id i2mr43370296igi.40.1434641236738; Thu,
 18 Jun 2015 08:27:16 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 18 Jun 2015 08:27:16 -0700 (PDT)
In-Reply-To: <1434626973-4801-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: yrvyCvny1W7LDhpZd_oxs4ZDhbI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272014>

On Thu, Jun 18, 2015 at 6:29 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Quoting Robert Dailey <rcdailey.lists@gmail.com>
>> I do the following:
>>
>> $ git push origin :topic
>>
>> If I stop halfway through typing 'topic' and hit TAB, auto-completio=
n
>> does not work if I do not have a local branch by that name (sometime=
s
>> I delete my local branch first, then I push to delete it remotely). =
I
>> thought that git completion code was supposed to use ls-remote to au=
to
>> complete refs used in push operations. Is this supposed to work?
>
> It's intentional.  Running 'git ls-remote' with a far away remote can
> take ages, so instead we grab the refs on the remote from the locally
> stored refs under 'refs/remotes/<remote>/'.
>
> See e832f5c096 (completion: avoid ls-remote in certain scenarios,
> 2013-05-28).  The commit message mentions that you can "force"
> completion of remote refs via 'git ls-remote' by starting with the fu=
ll
> refname, i.e.  'refs/<TAB>', however, that seems to work only on the
> left hand side of the colon in the push refspec.
>
> G=C3=A1bor
>

If that's indeed the case, then completion should work. I have a
'refs/remotes/origin/topic'. Why will auto complete not work even
though this exists? Do multiple remotes cause issues (in theory there
is no reason why it should cause problems, since it should know I'm
auto-completing a ref on 'origin')?
