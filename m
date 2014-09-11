From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Thu, 11 Sep 2014 15:15:40 -0700
Message-ID: <CAL=YDWmhSuk9rqBKRbJLfNSn8QTtebbBMwSJqqAYOKS=ZZ1=qg@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSCel-0003ny-7g
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaIKWPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:15:54 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:34729 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbaIKWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:15:42 -0400
Received: by mail-vc0-f176.google.com with SMTP id la4so4840314vcb.35
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fOo9MNegYkyoRzGqXKcDROXksFf9+nCuhIjJ49wZmpw=;
        b=m/FDHFwd2KbZWXG5fy6C0aWgLVGJ/gN58LnDfimZMCIHx3OPSA7Z3LwdbVgJNaRKBK
         fViVbP+6R+O7jf2trseMOwc9eCeWcPjsvojOcTAqJzrsb9OCto3Hm3cCboXOCbBCeAd+
         Fav2ncXxdTy3581rW/P64Jk0Y77xzrLrYRuh+u0tuQ3/5RtLlMm3Rb1Iqvk1kjAcd/Lr
         PWiHLAadrgfk4IitTTf8QL8ZVJqxEOduKI4+7gUsCbAbTWgbzcqqdRFdnMYp02HzcCPn
         w9NYiqgtnpPG5LT7Wvd4TaEOhhX/bUy2V9H7oqTliUh0N1zqK0mRK/sXJ0rguBU+g6MN
         mrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fOo9MNegYkyoRzGqXKcDROXksFf9+nCuhIjJ49wZmpw=;
        b=UUXVnPl1N2P/57lPn/qx4ViS+5CbWk1yYQQzooPGMIpqurz5foCPu3iifPifZSOEYc
         KBRgcWC0qTBN5tIWfyTh/8oVWb+nBNgOrFh8+8cn44TBj8LkEjsdDoHf1atggJKF5yGz
         AGOnoEk9d9NlBhmw+fz1sgAqe63Qv+kMzBBvhJeTIExymGDZTFfnVm2Kp5xxq02hJ9QJ
         paj/FOz+t+EvJ+xokffdglNrlBdXI0gjOv6RETXvo0+ZfUUWo7cGzjYin8fcNxBR+sh6
         gAL3m04jpFPBX15FPOQIwzmkcAE0piUrcjIw+wxDeTVF6zNZ+LGWlqbL1n++PmqJPOsf
         xmeg==
X-Gm-Message-State: ALoCoQmlVkyR/k9QVtCSyGvZjhJYdbwezJxED2rbLi/57/XePoL4PWoGgG0KDf1uI9B5hwIDzaMP
X-Received: by 10.52.245.66 with SMTP id xm2mr2634413vdc.36.1410473740756;
 Thu, 11 Sep 2014 15:15:40 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 15:15:40 -0700 (PDT)
In-Reply-To: <1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256883>

On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There are a few places that use these values, so define constants for
> them.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  cache.h    |  4 ++++
>  lockfile.c | 11 ++++++-----
>  refs.c     |  7 ++++---
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index da77094..41d829b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -569,6 +569,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
>  #define REFRESH_IN_PORCELAIN   0x0020  /* user friendly output, not "needs update" */
>  extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
>
> +/* String appended to a filename to derive the lockfile name: */
> +#define LOCK_SUFFIX ".lock"
> +#define LOCK_SUFFIX_LEN 5
> +
>  struct lock_file {
>         struct lock_file *next;
>         int fd;
> diff --git a/lockfile.c b/lockfile.c
> index 964b3fc..bfea333 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -176,10 +176,11 @@ static char *resolve_symlink(char *p, size_t s)
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
>         /*
> -        * subtract 5 from size to make sure there's room for adding
> -        * ".lock" for the lock file name
> +        * subtract LOCK_SUFFIX_LEN from size to make sure there's
> +        * room for adding ".lock" for the lock file name:
>          */
> -       static const size_t max_path_len = sizeof(lk->filename) - 5;
> +       static const size_t max_path_len = sizeof(lk->filename) -
> +                                          LOCK_SUFFIX_LEN;
>
>         if (!lock_file_list) {
>                 /* One-time initialization */
> @@ -204,7 +205,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>         strcpy(lk->filename, path);
>         if (!(flags & LOCK_NODEREF))
>                 resolve_symlink(lk->filename, max_path_len);
> -       strcat(lk->filename, ".lock");
> +       strcat(lk->filename, LOCK_SUFFIX);
>         lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
>         if (0 <= lk->fd) {
>                 lk->owner = getpid();
> @@ -314,7 +315,7 @@ int commit_lock_file(struct lock_file *lk)
>         if (lk->fd >= 0 && close_lock_file(lk))
>                 return -1;
>         strcpy(result_file, lk->filename);
> -       i = strlen(result_file) - 5; /* .lock */
> +       i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */

Not a new bug since the previous code is broken too.
Should probably checkstrlen(result_file) >= 5 here before subtracting 5.

Otherwise, a caller that calls commit_lock_file() with an already
committed/closed  lock_file can cause writing outside the bounds of
the array on the line below.


>         result_file[i] = 0;
>         if (rename(lk->filename, result_file))
>                 return -1;
> diff --git a/refs.c b/refs.c
> index 5ae8e69..828522d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -74,7 +74,8 @@ out:
>                 if (refname[1] == '\0')
>                         return -1; /* Component equals ".". */
>         }
> -       if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
> +       if (cp - refname >= LOCK_SUFFIX_LEN &&
> +           !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
>                 return -1; /* Refname ends with ".lock". */
>         return cp - refname;
>  }
> @@ -2545,11 +2546,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
>  {
>         if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>                 /* loose */
> -               int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> +               int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
>
>                 lock->lk->filename[i] = 0;
>                 err = unlink_or_warn(lock->lk->filename);
> -               lock->lk->filename[i] = '.';
> +               lock->lk->filename[i] = LOCK_SUFFIX[0];
>                 if (err && errno != ENOENT)
>                         return 1;
>         }
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
