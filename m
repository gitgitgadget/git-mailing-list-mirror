From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Thu, 11 Sep 2014 15:42:59 -0700
Message-ID: <CAL=YDWmgwwQsCSpVsQ5U+c=4RcLdzo-j_hmxDk-AJWdRUk_SsQ@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSD51-0001Zt-4r
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbaIKWnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:43:02 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:55581 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaIKWnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:43:00 -0400
Received: by mail-vc0-f175.google.com with SMTP id hq11so2809532vcb.34
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zrSWiZS0c6jV4N0DRSK1rnyriiPo/nrBNgTJi+7fuTg=;
        b=MtWMUr9MaI5Z3xBe266rlVs5j735jjqc5cK9m7K2BzrCfQ6oSnWNrvc5H0D5dGjJRJ
         JvDM1RXkBxbLQ0Enydq1lBwpzk28FWkjVAY89fXqh7soT4qbliOsK3HpNnuH7L+WDk8x
         DeZzriS5pqS9FPruspWLqTq9Cq+vPx45tmtsedJck0YkqHmmXkK/BYzqofJm4ZASFri9
         NexdT6Ud45hTC6nbgm5fbDbP9qQOH0wQZVgKIIGgcLCzGqkBjoOyTOwzWA2FNnMBTlf7
         CzZHT6FnYLoWXA4iVAni+bRMozsfFF9kFzFbTE0XryDhVv6qBhpET9+mgqUpUaSk9D3D
         zDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zrSWiZS0c6jV4N0DRSK1rnyriiPo/nrBNgTJi+7fuTg=;
        b=i27WSoZvXmjEd9yc8utalz7yAF8s8NVAwUl6QMnIPuad9UfpmqXkj1Gi0uOWvwkpm5
         ex3dxYhiDkE+dWeoAGuuZTTnaxt580ssDZTROE9a2ec2tjhgX218RM+7LokILbgPyJ8O
         P/CY4QElqK9eFB3TpFEMQ51gtm7EdaIWGmUX19kY7NWBp0IrPL0XYb36qaBfSuG2A+Du
         pEZ5Cjzc0f7xKvbhydlp8OMOB3mFhvl4scy7DviI4tE96QEc8nIMhIOPzFq7K2xIVzEB
         xJk8ewcS33CttxgCeDi1eDczUVxIWxPHVKt0Sglzb45x0swdIhx9bwWeJ+QlHQ/SHhaU
         J6zA==
X-Gm-Message-State: ALoCoQnkqM5wzwpP78kD/bBZ2x3ubNepmkzBZ7gCiNCfLTI42H5VlnD2PjuLHjOQ7B3vb+fBJcQt
X-Received: by 10.52.30.2 with SMTP id o2mr2701823vdh.12.1410475379830; Thu,
 11 Sep 2014 15:42:59 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 15:42:59 -0700 (PDT)
In-Reply-To: <1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256886>

Maybe we should not have a public constant defined for the length :
+#define LOCK_SUFFIX_LEN 5

since it encourages unsafe code like :  (this was unsafe long before
your patch so not a regression)
+       i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
        result_file[i] = 0;



What about removing LOCK_SUFFIX_LEN from the public API and introduce
a helper function something like :


/* pointer to the character where the lock suffix starts */
char *lock_suffix_ptr_safe(const char *filename)
{
    size_t len = strlen(filename);
    if (len < 5)
       die("BUG:...
    if (strcmp(filename + len - 5, LOCK_SUFFIX)
       die("BUG:...
    return filename + len - 5;
}

and use it instead?


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
