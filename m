From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 13:51:01 -0700
Message-ID: <8c9a060910221351w12e6c610kb842263e1c02ea63@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com> 
	<19168.49405.775024.649626@lisa.zopyra.com> <19168.50232.47935.864407@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14d6-0008To-LY
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZJVUvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZJVUvR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:51:17 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:43561 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZJVUvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:51:17 -0400
Received: by pxi1 with SMTP id 1so3386727pxi.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=0qqVfhgWGY/iOF6DKmWiDMQbhMjDnpXMvt8Y4/B7Tsg=;
        b=ObiIlvm4Buzf+Vc4CLy7nQYW3gmUZwNEJTDFA24k+k8c8fQzanu/9OXKtaN684sERc
         xH8LPNHqg82+xA2Q1DddzKc0+YKp5oz0cGroc1qzwKtFa7BBckdKhpVTEK7VRFc3LWWy
         fpUS2+Y/lHoZK8OdrnwqgiZXqOQbrpRfy2v50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=boc5qVdBlJIFvWIrPf7ty4DNP6k36V+NeiP/MNREyyraVsKc/J6RhEc8EZoj0EiLM4
         AS81VN/uBgTUt34lDctDm87mvq5sB/+mqRo+dN4m1e/9Pp8TKcth9kp14E82H+MppKUk
         p/9bmFt/GnmFkhKD5kh29U1d6LB8xPM8QsTUM=
Received: by 10.140.136.15 with SMTP id j15mr1839278rvd.229.1256244681103; 
	Thu, 22 Oct 2009 13:51:21 -0700 (PDT)
In-Reply-To: <19168.50232.47935.864407@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131058>

On Thu, Oct 22, 2009 at 13:44, Bill Lear <rael@zopyra.com> wrote:
> On Thursday, October 22, 2009 at 15:30:53 (-0500) Bill Lear writes:
>>On Thursday, October 22, 2009 at 21:03:44 (+0100) Howard Miller writes:
>>>Hello,
>>>
>>>I have a branch with a whole series of commits. I want to export this
>>>work to be customer (to their svn repo if that has any bearing on it).
>>>All the stuff in the history is irrelevant to my customer ("committing
>>>now, going to bed" etc.) so I'd like to create a new branch that only
>>>has one commit.. the end point with a new message. Is this possible?
>>
>>git rebase is your friend.
>
> Someone correct me if I'm wrong.
>
> % git branch
> * master
> % git checkout -b my_work_branch
> % [work work work, commit, commit, commit]
> % git rebase -i master
>

Alternatively, you could use git merge --squash

git checkout master
git merge --squash topic

See git-merge(1) for details.

rebase --interactive it excellent for cleaning up history, especially
if you want to end up with more than one commit at the end.  merge
--squash is usually sufficient if all you need is one commit at the
end.
