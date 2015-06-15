From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/12] Improve "refs" module encapsulation
Date: Sun, 14 Jun 2015 22:20:04 -0700
Message-ID: <CAGZ79kbx4Cc3hfd2jnvOWt1eUfLNGSjVu0oJ8vR2gnyf9m6QWA@mail.gmail.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 07:20:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Mog-0000Dm-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 07:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbbFOFUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 01:20:08 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36723 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbFOFUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 01:20:05 -0400
Received: by ykaz81 with SMTP id z81so48115246yka.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=isq7nzcBfX3O8cTSyrdTu/9fX4rXeobnld+nV27vJMA=;
        b=CmODbTCH+s/QcEH5rRNlmxoJOrgj4Aiz5on8RbdTkkGJd7esyXOKuXm1XQkkMFyg9q
         oJ/Ywlc9z3uzpTfNdS8SdwLIxWyOAZnegGGDOyVo7V1Y+VYrVlkD7r9plUoKQ7sqNIb6
         jmbIdE3kW2NE+k9njcCHNkFbZ04SYCOG2Ts7ktMvJMI646L0DdputDPEAxl4T3Xck3cv
         xpCuMQAqgdIZdS5yruwJ4O3sfYxQZMxKeoYMmeJQYKsfemUbROOmUvCjwGiDeLvolTy0
         5I5VRa5QgTGmy1xhG0iBOqpO/Ifmjd8sB6UWS8sTO9hkgKUfcBcP01ykQ1YwUI7iPnxm
         /OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=isq7nzcBfX3O8cTSyrdTu/9fX4rXeobnld+nV27vJMA=;
        b=jgXRleu/NEwzufSRNg82aw/JY+Uo+pdorTl32Mz2WTBPqRmYzBACQQBOpns7HShLtV
         4rKMmY3YD05NPLnSqprSqWb3DTJMWQNP8giApMJNm9FQxgkS5mhuJ/6Hkyp2I3sCDF7g
         jbCaRaiDtmtDUtdSE7fUSfwUOubXPoFhz+mF7kZ461Fdf3j0j6a/w4zhrYUNi/kP1WRg
         DlVXwjxlLOIPf04IicBM5TQBTrfUrQEJUIoqDhoZOBDkgrErGTPPVlDOCCHF/gTPTyAW
         qGO/Pshm75TfPLdglmkwpGP/QgI5F0qEtt1r+8BsmHQhNxAIC1+yZSSJUUj4VAQhH//0
         952A==
X-Gm-Message-State: ALoCoQmXSMIXJoZcQYPfBZfZf9f5wVqdGFUq1e3y7aDCcpeH3uYVyAPNNH0loHqYetPfPVAsgjJC
X-Received: by 10.170.217.85 with SMTP id j82mr32156845ykf.25.1434345604974;
 Sun, 14 Jun 2015 22:20:04 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Sun, 14 Jun 2015 22:20:04 -0700 (PDT)
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271659>

On Sat, Jun 13, 2015 at 7:42 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is v2 of this patch series. I think I have addressed all of the
> feedback from v1 [1]. Thanks to Stefan, Peff and Junio for their
> feedback.

This version looks good to me.

>
> Changes since v1:
>
> * Change docstring for delete_ref() and a comment within the function
>   definition.
>
> * Squash together two commits dealing with the error message in
>   delete_refs().
>
> These patches are also available from my GitHub account [2] as branch
> "init-delete-refs-api".
>
> Michael
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/271017
> [2] https://github.com/mhagger/git
>
> Michael Haggerty (12):
>   delete_ref(): move declaration to refs.h
>   remove_branches(): remove temporary
>   delete_ref(): handle special case more explicitly
>   delete_refs(): new function for the refs API
>   delete_refs(): improve error message
>   prune_remote(): use delete_refs()
>   repack_without_refs(): make function private
>   initial_ref_transaction_commit(): function for initial ref creation
>   refs: remove some functions from the module's public interface
>   initial_ref_transaction_commit(): check for duplicate refs
>   initial_ref_transaction_commit(): check for ref D/F conflicts
>   refs: move the remaining ref module declarations to refs.h
>
>  archive.c               |   1 +
>  builtin/blame.c         |   1 +
>  builtin/clone.c         |  19 ++++-
>  builtin/fast-export.c   |   1 +
>  builtin/fmt-merge-msg.c |   1 +
>  builtin/init-db.c       |   1 +
>  builtin/log.c           |   1 +
>  builtin/remote.c        |  33 +-------
>  cache.h                 |  68 ----------------
>  refs.c                  | 171 ++++++++++++++++++++++++++++++++++++---
>  refs.h                  | 211 +++++++++++++++++++++++++++++++-----------------
>  remote-testsvn.c        |   1 +
>  12 files changed, 321 insertions(+), 188 deletions(-)
>
> --
> 2.1.4
>
