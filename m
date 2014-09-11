From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 09/32] lockfile.c: document the various states of
 lock_file objects
Date: Thu, 11 Sep 2014 12:57:51 -0700
Message-ID: <CAL=YDWmD71jJuZELDE-fqZ8x=p3Usp3_MU2uzyJ59HBvXtbg0g@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSAVC-0006uv-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbaIKT5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:57:54 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:60649 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaIKT5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:57:53 -0400
Received: by mail-vc0-f170.google.com with SMTP id hy4so6096187vcb.15
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bz545+9e+cZSUMSZ9eMvM56KqtUFbz4Z4k4ItQ8YjqE=;
        b=QtzLHoyrpK6OrLZ2/u8B4mVyJJIDp7tl7XHiUfRGW7cWwLLjz7yhGiGxES3W8n7Zck
         XfZSd06u6pSL3bH9qC3u0jGQ0jNWZS6BNxLg4ZEzx3Vn75bJhkqMaVc55fcSJ2mbCw5z
         EJyAnZahqwe6IJxuG9fLv07x8sjKlI5fZFsulzFGnLfLgb2GbkBhjvBBTkVdtNWjGClk
         4H1YGEoRzs+D/qpnC9o20o7LZ0yseD+LMI1AJljHC9cNTg8Sc0RCyZjiNZPAAeLFSV/a
         6BR+I0TyzbR4fWSYbbWtuK+8cO/9x7uP/lHBI1IBNG22mOrJJL5pu/l9Qzp9hwvub5EI
         n6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Bz545+9e+cZSUMSZ9eMvM56KqtUFbz4Z4k4ItQ8YjqE=;
        b=bqfgmRkPP9qen11Yr+uuyVthofBGzOM8uPMt5ostFvBc/8D02rc4mBy7jA+XXLnNct
         9YlnwjQVkdOZKWM5wFb86f6WLO6EjP2R+s2UG9kB6C1MNYk9aNQZfGMKyBY91Lta1pte
         rsRxQ5VpospYE2gUYmNkWCOOZnB70BmS1TVsBVXnoh4sCs2jS7odUxz/A2YkG/ptZR4P
         QCIcFbIAIVz6zXZ7UFLCdaeKG7JuUPk8s6YLciMbPymGQ3CmkilFwRuxFZuQWM9Tvw9D
         07qc+krHxAg6rmsUL1Gp6RGKqVBpbrJnoNSjMPGuIGWCOd4udefvL7DNItVSBL17WPp0
         qzvQ==
X-Gm-Message-State: ALoCoQlqGaJCF6rV3veCP6Le0ZMFyf6ZNaXwTarY7A7yoWglIlf4GRj7/BMHUBLhb2lpduxY6lSb
X-Received: by 10.220.99.71 with SMTP id t7mr2332887vcn.8.1410465471140; Thu,
 11 Sep 2014 12:57:51 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 12:57:51 -0700 (PDT)
In-Reply-To: <1409989846-22401-10-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256872>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Document the valid states of lock_file objects, how they get into each
> state, and how the state is encoded in the object's fields.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/lockfile.c b/lockfile.c
> index 00c972c..964b3fc 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -4,6 +4,58 @@
>  #include "cache.h"
>  #include "sigchain.h"
>
> +/*
> + * File write-locks as used by Git.
> + *
> + * When a file at $FILENAME needs to be written, it is done as
> + * follows:
> + *
> + * 1. Obtain a lock on the file by creating a lockfile at path
> + *    $FILENAME.lock.  The file is opened for read/write using O_CREAT
> + *    and O_EXCL mode to ensure that it doesn't already exist.  Such a
> + *    lock file is respected by writers *but not by readers*.
> + *
> + *    Usually, if $FILENAME is a symlink, then it is resolved, and the
> + *    file ultimately pointed to is the one that is locked and later
> + *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
> + *    itself is locked and later replaced, even if it is a symlink.
> + *
> + * 2. Write the new file contents to the lockfile.
> + *
> + * 3. Move the lockfile to its final destination using rename(2).
> + *
> + * Instead of (3), the change can be rolled back by deleting lockfile.
> + *
> + * This module keeps track of all locked files in lock_file_list.
> + * When the first file is locked, it registers an atexit(3) handler;
> + * when the program exits, the handler rolls back any files that have
> + * been locked but were never committed or rolled back.
> + *
> + * A lock_file object can be in several states:
> + *
> + * - Uninitialized.  In this state the object's on_list field must be
> + *   zero but the rest of its contents need not be initialized.  As
> + *   soon as the object is used in any way, it is irrevocably
> + *   registered in the lock_file_list, and on_list is set.
> + *
> + * - Locked, lockfile open (after hold_lock_file_for_update(),
> + *   hold_lock_file_for_append(), or reopen_lock_file()). In this
> + *   state, the lockfile exists, filename holds the filename of the
> + *   lockfile, fd holds a file descriptor open for writing to the
> + *   lockfile, and owner holds the PID of the process that locked the
> + *   file.
> + *
> + * - Locked, lockfile closed (after close_lock_file()).  Same as the
> + *   previous state, except that the lockfile is closed and fd is -1.
> + *
> + * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
> + *   failed attempt to lock).  In this state, filename[0] == '\0' and
> + *   fd is -1.  The object is left registered in the lock_file_list,
> + *   and on_list is set.
> + *
> + * See Documentation/api-lockfile.txt for more information.
> + */
> +
>  static struct lock_file *lock_file_list;
>
>  static void remove_lock_file(void)
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
