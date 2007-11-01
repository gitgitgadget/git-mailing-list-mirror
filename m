From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 08:09:20 +0700
Message-ID: <fcaeb9bf0710311809o41703bc5hda36a9d44a538eeb@mail.gmail.com>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InOZ0-0003O0-8o
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 02:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbXKABJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 21:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXKABJX
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 21:09:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31422 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232AbXKABJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 21:09:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so335260nfb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=10FOOp/n+3o8cUUmsR2B0tgLIjDeHg6ZQiMBUrkhcko=;
        b=Ppoi5dGcvsjhR2b1kM78IUSMf35XwMBiDxeWHKealSENmHdjSylEzbhiQMCLmIxNhA6h/+wluyWte2AnBoNjbNJwarZw9qPWVqBXWQXpznp561+DeWfLQIKBB4D0fRfaHemFJrR/+6aJ5N7FNGXCehp7pqvnE/y7raa+Z4rp0Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nQ2iAosHZbWvxb3vn4f+E4FB+NJPvxF3b30O/KI65g1OPd6f11sT8fYrNkOVVH61RuaB0jd3ZcD5KqrDj3ivldloVDceSju+qH5FHT+IPeV/F8vIGXhPyH3Lstol2luWgWdNi5qv1GS9neFX7jhz4DQkrPd5ezVQluRmBjwkoRk=
Received: by 10.86.80.5 with SMTP id d5mr22791fgb.1193879360578;
        Wed, 31 Oct 2007 18:09:20 -0700 (PDT)
Received: by 10.86.73.5 with HTTP; Wed, 31 Oct 2007 18:09:20 -0700 (PDT)
In-Reply-To: <1193861145-20357-1-git-send-email-mh@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62903>

BTW, you have workaround for git-merge also? It uses cpio to save/restore state.

On 11/1/07, Mike Hommey <mh@glandium.org> wrote:
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  git-clone.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/git-clone.sh b/git-clone.sh
> index 0ea3c24..57e96ae 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -191,7 +191,9 @@ fi
>  # it is local
>  if base=$(get_repo_base "$repo"); then
>         repo="$base"
> -       local=yes
> +       if type cpio > /dev/null 2>&1; then
> +               local=yes
> +       fi
>  fi
>
>  dir="$2"
> --
> 1.5.3.4
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
