From: Dylan Reid <dgreid@gmail.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command 
	line
Date: Tue, 4 May 2010 17:46:59 -0400
Message-ID: <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
	 <4BE0918C.9090204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 04 23:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9PxV-0006ka-IT
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934144Ab0EDVrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 17:47:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38770 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934098Ab0EDVrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 17:47:01 -0400
Received: by gyg13 with SMTP id 13so1862083gyg.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=feqMp/QGInws2jG6THhZHFCd0pPaV5t8NqokvhmQCX4=;
        b=JNKLqCF7LU3bKIWVSisd84/p0G3UUo43eagpfBq63P/C2FXw38V5P7XpDgqSdEVJ5f
         S7m+ez41ze9Dktj+ZkR5YoKxSE1rutNDyqtvywg/AJn9jLQAXGJssCEnTGzvI01bq27l
         BlCV4+UOylkdFV1FRqEUxDvzaMALp3qXcBv34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hz26jmCQge+WgnXlht7ZT+GglwIRkVoDfG3LZJcuY9vs2bK46ihPysRrz/4rRxP2uH
         uqd51U2dXsr4aurGvQujPCbaV39Ee7zJsg+DOY8d6AQcH+kY+qJvJnrzkqOuQkCh5AHO
         7fxJWa6upBPTEQ/Tz8t8UqB02lY8vPpkUSAxU=
Received: by 10.150.249.6 with SMTP id w6mr13519823ybh.157.1273009619634; Tue, 
	04 May 2010 14:46:59 -0700 (PDT)
Received: by 10.150.145.11 with HTTP; Tue, 4 May 2010 14:46:59 -0700 (PDT)
In-Reply-To: <4BE0918C.9090204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146349>

Thanks for the speedy reply.

> Only the long option --ignore-commit works with your patch, -I doesn'=
t.
>
Correct.  I took that out because I didn't want to use "-I' which
could eventually be used by a more commonly used feature.  Do you
agree or do you think it is worth using it.  It's a UI decision I
didn't want to make.

>
> This function was moved from below, but it seems to be indented with
> three spaces instead of tabs now. =A0Adding a declaration without mov=
ing
> the function would avoid that and result in a smaller patch.
>

Good catch, I'll do that and re-send.

>
> An ignored commit can still be blamed if there is no other commit to
> pass it on. =A0So e.g. the initial commit for the file could end up b=
eing
> blamed for lines that were added by later commits which are being
> ignored. =A0That may look confusing.
>
> Would it make sense to pass the blame to some kind of null commit, i.=
e.
> a special marker that says "I could tell you who is to blame for this
> line but you said you don't want to know"?
>

A null commit could work.  I think the behavior should be to not
ignore the commit. Meaning if you specify a commit that introduced a
line of code that line of code will still be blamed on the ignored
commit.  Does That sound logical or is it too confusing?


Thanks,

Dylan
