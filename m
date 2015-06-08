From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/13] delete_ref(): move declaration to refs.h
Date: Mon, 8 Jun 2015 09:43:44 -0700
Message-ID: <CAGZ79kYy3zUezRzAG3Uo7bDbLgJ7srj3F1k-ama1C44ZdbHr=Q@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:51:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20H2-0008Oj-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbbFHQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:51:40 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34857 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFHQvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:51:40 -0400
Received: by yhak3 with SMTP id k3so38029046yha.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vLCDdF0Zu+aId5KCGXk0K/MVth/0LBG2ySU1NPwlmA4=;
        b=kU6tz/l1Hu4if6E5LgF49HAvJ27i3nM4LnME+qFM+zTFVzdivT083n/lQPygPMWP+b
         5MNVtdZ/WMsXmukLasqCjkEcD1QrLyPFxoo4k+rmSR41O6yU+EXmwqrVXA5mdTLFbpgV
         UAK3xne8Xl52KmOqLDSVL3RkdUBclpuXacVauYa7qPGB5h+Pvpq7t4IpwuBR61hE+k2o
         qR+dVm1BbMiS/DJ2X5G4VPMaNIgdLpPS25hDrwRz0XhHjMWzMtBRoRDfZ39xAct//Gzc
         HALGquPPJ4qk9DeZUa1cVNN+FkrDlF9Ml2U4sWDrd4HCK0XZWjHzFKGMA7R7ILLOCDIB
         LxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vLCDdF0Zu+aId5KCGXk0K/MVth/0LBG2ySU1NPwlmA4=;
        b=aAJ5a53PTfV8kKkt59aSr3At+BNZSF3jGOdMDeJae13f3oYC+CC5lECS/yinP/QcSK
         Mr4Pct57ycvMmpn7xIJXJK1UXPuT1iZ+phfxCUSMmLe2TrUvild1BfEM33keiWwaB+Jk
         VcpKuWguWm2sR2vPuUgYehr4t4AnOZ7SJsvGdqGovFrFPdzBcQ241LeYyhXRySN2OKZs
         lBN4yQzvYTVCE1SElqJNhO3Wg7TTyo1TVFCb9Jg+JSNIFFyzTn9/sL80d/NtTfyFzRHt
         I5Tji4qHybuOmUtq5qKJpuBtrDoob28vu36jNJhqqEi9aTafxprCx1682p5N8C2NmJK6
         HQkw==
X-Gm-Message-State: ALoCoQn5TTK8251Tn7+owtZWxIzbJlPkTr+7zKP8YtKHj3Iq2ZrJXwt1aAJE6ZeRoBoLV64bXWfM
X-Received: by 10.170.117.142 with SMTP id j136mr19816545ykb.56.1433781825017;
 Mon, 08 Jun 2015 09:43:45 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 09:43:44 -0700 (PDT)
In-Reply-To: <2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271075>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Also
>
> * Add a docstring
>
> * Rename the second parameter to "old_sha1", to be consistent with the
>   convention used elsewhere in the refs module
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  cache.h | 2 --
>  refs.c  | 5 +++--
>  refs.h  | 9 +++++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 571c98f..be92121 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -585,8 +585,6 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
>  extern int hold_locked_index(struct lock_file *, int);
>  extern void set_alternate_index_output(const char *);
>
> -extern int delete_ref(const char *, const unsigned char *sha1, unsigned int flags);
> -
>  /* Environment bits from configuration mechanism */
>  extern int trust_executable_bit;
>  extern int trust_ctime;
> diff --git a/refs.c b/refs.c
> index a742d79..b575bb8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2789,7 +2789,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>         return 0;
>  }
>
> -int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flags)
> +int delete_ref(const char *refname, const unsigned char *old_sha1,
> +              unsigned int flags)
>  {
>         struct ref_transaction *transaction;
>         struct strbuf err = STRBUF_INIT;
> @@ -2797,7 +2798,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flag
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_delete(transaction, refname,
> -                                  (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
> +                                  (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
>                                    flags, NULL, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 error("%s", err.buf);
> diff --git a/refs.h b/refs.h
> index 8c3d433..8785bca 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -202,6 +202,15 @@ extern int read_ref_at(const char *refname, unsigned int flags,
>  /** Check if a particular reflog exists */
>  extern int reflog_exists(const char *refname);
>
> +/*
> + * Delete the specified reference. If old_sha1 is non-NULL and not
> + * NULL_SHA1, then verify that the current value of the reference is
> + * old_sha1 before deleting it.

And here I wondered what the distinction between NULL and non-NULL,
but NULL_SHA1
is and digging into the code, there is none. (As you can also see in
this patch above with
    (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
but when digging deeper, the !is_null_sha1(old_sha1) is an arbitrary
limitation (i.e.
ref_transaction_delete and ref_transaction_update don't differ between
those two cases.)

The distinction comes in at lock_ref_sha1_basic, where I think we may
want to get rid of
the is_null_sha1 check and depend on NULL/non-NULL as the difference
for valid and invalid
sha1's?

That said, do we want to add another sentence to the doc here saying
non-NULL and not
NULL_SHA1 are treated the same or is it clear enough?
With or without this question addressed:
Reviewed-by: Stefan Beller <sbeller@google.com>

> flags is passed to
> + * ref_transaction_delete().
> + */
> +extern int delete_ref(const char *refname, const unsigned char *old_sha1,
> +                     unsigned int flags);
> +
>  /** Delete a reflog */
>  extern int delete_reflog(const char *refname);
>
> --
> 2.1.4
>
