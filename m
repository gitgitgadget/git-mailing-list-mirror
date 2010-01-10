From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Sat, 9 Jan 2010 22:49:50 -0600
Message-ID: <20100110044949.GA8974@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 05:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTpkP-0004Bp-CM
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab0AJEtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 23:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509Ab0AJEtp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:49:45 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:39708 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab0AJEtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:49:45 -0500
Received: by iwn32 with SMTP id 32so3986426iwn.33
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1mnKuFuKu2Cl6E+eKM6sRun/LrV9hgeAgZG3gsDPeu8=;
        b=EIDNNUPFss8E/Vgkhpr6M9tQCF5hvkwxE/gH2h+/1VWfmqRrPs0+S5yYi142qvHfvI
         wQSrhXIZsbf9EHNEs1E3Q08tSQ9XXSjYwol+Yil9jQ6SuvSpxRNPjPa9Y0/V8n8QEjJK
         5Y3doiTD0K+7m8yVkOx6ZvLcVDcwnRADGJFUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fbKllznKMroK0tmJYr4Bh6j+bUT1b+9c2Qy89rifqL0hcsoWxD898ZQrFENVjwVa9U
         ZMfxNyo2k6qjZK3vWd5CrpFpORUcL89nVWYZbzFobivEf8ngog4g8faVeFUDY3ynKQsp
         HMpa49/EMXy83IQMo/x+j6Zp9EYfuRG01Vi9c=
Received: by 10.231.154.213 with SMTP id p21mr2305488ibw.42.1263098984369;
        Sat, 09 Jan 2010 20:49:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1148108iwn.2.2010.01.09.20.49.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:49:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136556>

Thomas Rast wrote:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 4896587..3277f4e 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -22,6 +22,10 @@ The second syntax (<msg> `HEAD` <commit>...) is supported for
>  historical reasons.  Do not use it from the command line or in
>  new scripts.  It is the same as `git merge -m <msg> <commit>...`.
>  
> +*Warning*: Running 'git-merge' with uncommitted changes is
> +discouraged:

Is this true?  The 'git reset' manual page gives an example of something
I end up doing pretty often:

| Undo a merge or pull inside a dirty work tree
|
|         $ git pull                         (1)
|         Auto-merging nitfol
|         Merge made by recursive.
|          nitfol                |   20 +++++----
|          ...
|         $ git reset --merge ORIG_HEAD      (2)
|
|     1. Even if you may have local modifications in your working tree, you
|     can safely say "git pull" when you know that the change in the other
|     branch does not overlap with them.
|     2. After inspecting the result of the merge, you may find that the
|     change in the other branch is unsatisfactory. Running "git reset
|     --hard ORIG_HEAD" will let you go back to where you were, but it will
|     discard your local changes, which you do not want. "git reset --merge"
|     keeps your local changes.

> while possible, it leaves you in a state that is hard to
> +back out of in the case of a conflict.
> +

Oh, that is a problem.  Maybe 'git merge' should refuse to merge
unless told otherwise, if there is a dirty index and there might be
conflicts.

In other words, would it be possible to fix this without relying on
people to look at the documentation?

Jonathan
