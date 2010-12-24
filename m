From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] msvc: Fix compilation error due to missing mktemp() declaration
Date: Fri, 24 Dec 2010 02:00:26 +0100
Message-ID: <AANLkTineKS2e8PJs76PLZP4L4APwX2kAiFPg4pz3esae@mail.gmail.com>
References: <4D139D91.8080503@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 24 02:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVw1d-0000v5-IM
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 02:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0LXBAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 20:00:49 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59199 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0LXBAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 20:00:47 -0500
Received: by fxm20 with SMTP id 20so7575302fxm.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 17:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=980Ogmj64zC0bDNZaPoqulGozLzyhbVMTAHcAr3vGVY=;
        b=x68aJdGNhh8VBOtqrvR6jbi46XzVVGesRykbPhfNXY+DtzP8BMQh+6GcTXi3FLd5zl
         lxRsE14o+Oy1MrOeRlPKEOXh2tISziXLpjJVEBIr4xHjRiExP1Oebs3e2SXoP3DvweLh
         ocDXNFB0hqmcvPvbSYxzvQnKMD4lqdpbjzKXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=R1lRc/uEhHNjj4Sl95cx+FX+cdliM0WUUEWndXkgmspXQdBFzbqSTNBbHxl0Hn9I/W
         n2pgGl5l5FprxFLQaHypIwl+C5AGfs/BH0QHJvNEXGfVrhfS4Af8oqMtdACGhZcTNcSJ
         h/pEoXEQUqZUhEf30atupRgzGW3MAJ6zIcTlw=
Received: by 10.223.83.194 with SMTP id g2mr719813fal.75.1293152446610; Thu,
 23 Dec 2010 17:00:46 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Thu, 23 Dec 2010 17:00:26 -0800 (PST)
In-Reply-To: <4D139D91.8080503@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164143>

On Thu, Dec 23, 2010 at 8:05 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
> the compat/vcbuild/include/dirent.h compatibility header file.
> This file, among other things, included the <io.h> system header
> file which provides the declaration of the mktemp() function.
>
> In order to fix the compilation error, we add an include directive
> for <io.h> to the compat/vcbuild/include/unistd.h header. (The
> MinGW build includes <io.h> from it's <unistd.h> header too.)
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

Thanks. But shouldn't this header be included in mingw.h (or perhaps
msvc.h) because of _get_osfhandle and _commit?
