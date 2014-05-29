From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v12 00/44] Use ref transactions for all ref updates
Date: Thu, 29 May 2014 09:13:11 -0700
Message-ID: <CAL=YDWnProozg=5ven5Xq5JJ=twWsm834pupa=CrYeLpJPzjkQ@mail.gmail.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 29 18:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2xB-00049z-JH
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbaE2QNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:13:14 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:61261 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaE2QNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:13:12 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so647389veb.11
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LX0kT+4EuzvO8swisBE/srHS4wBYYQJJmLe8xC3KShM=;
        b=VrsiyopDTJX8TIzgi6t7paPIVAcEVsoHio3KFaHDZxHC2vsa460GXoIn4wV3tFEIET
         aRTBT4nlUiVzkGnKCezlUZZREgZPOmiDaxGyNk2/hoaOa1zbEGx61k5LmYmY/eeW1lu5
         DRVM4ddAuUKtIPrWZ7mspfsv8s/Rw8JTopBigmHLNNn9DQT3i1qQ/tLAWxEfZHAXLw3U
         WzwirZ0fawF7h9FvtbBF/G7wzafFMR6xSs/QAaIXerhmyZX3oThTpSxQvogYWYy5ECXi
         qRQ/P9ETxRoOxBai/9SM+XrOo5LdwgBLigiUwHjctfAeLEHFi6R8QPwr8i5woz9qgSI6
         f5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LX0kT+4EuzvO8swisBE/srHS4wBYYQJJmLe8xC3KShM=;
        b=aujhHDwJ3iuZef1hsf+G9rONI4ucoUWkiREtai66dELFKGAUXHGHdtiSoPiht7+7c/
         rhKeGUfDDLSyOaDkubeYbPcu3bmHLu1RfK+nBVuAGR5ZyxXaxpIYQzkiiuIsvMa1tl2w
         T8zA0dRNaH130u2YNz+h941Sy11G9XzmHS1/B+TOkKXvE0T6cNd4ydkN6Uxqol1OpDMU
         gBZPiiXyjFYNmbULNyg7TpRcBcsJqprpuVrfNmVq3T2GfJlIm76e7k/6NmRZzHXDlGCh
         xM7yxgVflkt2uIVmQHpsFBHauifViuA0RVvIHiHxfhtNt4F9wAq0qeivhrcDihrRCH4d
         rm8g==
X-Gm-Message-State: ALoCoQn1+H3kC2uaJyDL3YnBElHCJ3U2DwosN1xXSS5Fk8+D4MPjMhnfRCTbQIOjB83uXErhgMgm
X-Received: by 10.58.46.231 with SMTP id y7mr7656290vem.5.1401379991984; Thu,
 29 May 2014 09:13:11 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 29 May 2014 09:13:11 -0700 (PDT)
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250391>

These patches are the remaining patches that need review in this series.
Please review them.

On Thu, May 29, 2014 at 9:07 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions
>
>
> Ronnie please review these remaining patches in this series.
>
>
>  Sahlberg (44):
>   refs.c: constify the sha arguments for
>     ref_transaction_create|delete|update
>   refs.c: allow passing NULL to ref_transaction_free
>   refs.c: add a strbuf argument to ref_transaction_commit for error
>     logging
>   refs.c: add an err argument to repack_without_refs
>   refs.c: make ref_update_reject_duplicates take a strbuf argument for
>     errors
>   refs.c: add an err argument to delete_ref_loose
>   refs.c: make update_ref_write update a strbuf on failure
>   update-ref.c: log transaction error from the update_ref
>   refs.c: remove the onerr argument to ref_transaction_commit
>   refs.c: change ref_transaction_update() to do error checking and
>     return status
>   refs.c: change ref_transaction_create to do error checking and return
>     status
>   refs.c: ref_transaction_delete to check for error and return status
>   tag.c: use ref transactions when doing updates
>   replace.c: use the ref transaction functions for updates
>   commit.c: use ref transactions for updates
>   sequencer.c: use ref transactions for all ref updates
>   fast-import.c: change update_branch to use ref transactions
>   branch.c: use ref transaction for all ref updates
>   refs.c: change update_ref to use a transaction
>   refs.c: free the transaction before returning when number of updates
>     is 0
>   refs.c: ref_transaction_commit should not free the transaction
>   fetch.c: clear errno before calling functions that might set it
>   fetch.c: change s_update_ref to use a ref transaction
>   fetch.c: use a single ref transaction for all ref updates
>   receive-pack.c: use a reference transaction for updating the refs
>   fast-import.c: use a ref transaction when dumping tags
>   walker.c: use ref transaction for ref updates
>   refs.c: make write_ref_sha1 static
>   refs.c: make lock_ref_sha1 static
>   refs.c: add transaction.status and track OPEN/CLOSED/ERROR
>   refs.c: remove the update_ref_lock function
>   refs.c: remove the update_ref_write function
>   refs.c: remove lock_ref_sha1
>   refs.c: make prune_ref use a transaction to delete the ref
>   refs.c: make delete_ref use a transaction
>   refs.c: pass the ref log message to _create/delete/update instead of
>     _commit
>   refs.c: pass NULL as *flags to read_ref_full
>   refs.c: pack all refs before we start to rename a ref
>   refs.c: move the check for valid refname to lock_ref_sha1_basic
>   refs.c: call lock_ref_sha1_basic directly from commit
>   refs.c: add a new flag for transaction delete for refs we know are
>     packed only
>   refs.c: pass a skip list to name_conflict_fn
>   refs.c: make rename_ref use a transaction
>   refs.c: remove forward declaration of write_ref_sha1
>
>  branch.c               |  30 ++--
>  builtin/commit.c       |  24 ++-
>  builtin/fetch.c        |  29 +--
>  builtin/receive-pack.c |  21 +--
>  builtin/replace.c      |  15 +-
>  builtin/tag.c          |  15 +-
>  builtin/update-ref.c   |  32 ++--
>  cache.h                |   2 +
>  fast-import.c          |  42 +++--
>  lockfile.c             |  21 ++-
>  refs.c                 | 468 +++++++++++++++++++++++++++++--------------------
>  refs.h                 |  54 +++---
>  sequencer.c            |  24 ++-
>  t/t3200-branch.sh      |   2 +-
>  walker.c               |  51 +++---
>  15 files changed, 491 insertions(+), 339 deletions(-)
>
> --
> 2.0.0.rc3.510.g20c254b
>
