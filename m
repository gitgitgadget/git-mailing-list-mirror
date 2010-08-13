From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Sat, 14 Aug 2010 09:52:52 +1000
Message-ID: <AANLkTimD34VqsMJzUyTawBbdKoXZNXbcTUxLwk5Rj_S3@mail.gmail.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
	<AANLkTinwQhD-b0-6uQYwBa3r7psNvPp5LMcjqHVKLF+c@mail.gmail.com>
	<m2ocd6yx3h.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 01:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok43W-00079Q-Rz
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 01:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab0HMXwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 19:52:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35329 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab0HMXwx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 19:52:53 -0400
Received: by qwh6 with SMTP id 6so3359910qwh.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gSDAHgyLxRNvz3BbbgSsGa8daygWg/6ZNjBQXH24QzM=;
        b=QpQe4dbHzQFK8yG8XeTJ71jhXh0b8G41pNuaS//mfUs4C2Y5EJhnIfGjDfpXACcvJV
         ueTi2yoUfa7f0lK2k8qTBeJ30mwxT08CrBSl8VO3uhN0WJtQb8b0VjISlP15jgyqw942
         UhypP1j9+Y/S5x65+H5XPyuXXQ0FZRee9Q7ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mHxRTjT7Oxl6dbAzYnIzv6Ep3TX8cfgaPJX8sK1ue/cSEQTAMsMDx9acXZedmv/8Z9
         whAejyMGLAMfpi1Zcl/GzyHf/FEd3ttJzFjxQV51JDl4iiuwE/1UY/5hATr6Zykfm+tQ
         ACeTmAAh/VHrZzTn0M+Cq5u9f4KsQoo0+/ev8=
Received: by 10.224.29.14 with SMTP id o14mr1536448qac.142.1281743572574; Fri,
 13 Aug 2010 16:52:52 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Fri, 13 Aug 2010 16:52:52 -0700 (PDT)
In-Reply-To: <m2ocd6yx3h.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153528>

On Sat, Aug 14, 2010 at 8:19 AM, Steven E. Harris <seh@panix.com> wrote=
:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Otherwise, I keep them clean and merge them into the base of my
>> working branch (as described into an earlier note). =C2=A0By always =
merging
>> into the base of my working branch (and never the tip) I can keep my
>> working tree stable and my patches clean.
>
> Can you clarify what you mean by "merging into the base" and "never t=
he
> tip"? Perhaps a pointer to the earlier note you mentioned would suffi=
ce.
>

Here is a link to the earlier note:

     http://permalink.gmane.org/gmane.comp.version-control.git/153168

this explains how I am using the term base.

Informally, it is the first commit your history which contains work
that your current work depends on, but is not part of your current
work.
It is always directly reachable from your head via a path which does
not include a merge (and, as such, defines a linear range of commits
that is easily re-ordered or rebased as required).

The idea is that the base of your working branch accumulates
dependencies, while the head (or tip) of your working branch
accumulates your work. By merging at the base, you are never "hiding"
work in progress with a merge. As your view of what your dependencies
are changes, you can rebuild your base at will, and then rebase your
work on top of that.

jon.



> --
> Steven E. Harris
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
