From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 20/48] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Mon, 14 Jul 2014 10:44:27 -0700
Message-ID: <CAL=YDWmMoFRsupE5DNPck1PkdLDPBuMtt3OdKhf6BC=8V08AEg@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-21-git-send-email-sahlberg@google.com>
	<53BBDAA4.7020701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kIj-00018S-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbaGNRoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:44:30 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:35836 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274AbaGNRo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:44:28 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so8038604vcb.11
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L6RkRxsOB9JAcDbi7VXSn0iKViVvMT/Iay1HglZLOVo=;
        b=R0f+9mN/AqqjqrAE9A/fYt/s4OeE6JVO9UDY+LWMQYB7pUYQCIJ2SF4onS89eIvmb9
         qUVnf270Z18Sc0J8yb2rbKL0rb4AW85LBKZiwM8nkAtWuJsopquGwLp1KwvVzD+Z7281
         KvLULkwfZXJJQRbWM1G/kTxOmIH+r1rFkCse64CSX2XtnFVxUTQiCtlAswhG+eU7xYxe
         WCnlNYR81XBzhrjpnc1ShOrjB9CH1OLZA/g6l8XnpPXay3mcrqu9m6eDxLRhv8/o/GAe
         nyoQR2SEIq+Wn9Tq5svoIzeHgDdUJwQXnnQQnaf9tOTOgkSimSYzKScH4NS9yl6A12Jl
         m0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L6RkRxsOB9JAcDbi7VXSn0iKViVvMT/Iay1HglZLOVo=;
        b=YQ4dAiU49IE6roxpkOVg/vUasJpSvq41rrh0/1SbUzhndFGoKsEvFvem/pLMV2fWqt
         MJthSnc96zyIMbX/UNuRIADWom6x2IY4ob1Pc8CLaztqDSjY9ZJo9Du0F1bjWCu+8y5x
         BjpA1MjkLn6XLi6QfUwtJHMlpAD9EhlECjhja1j+RupHht52lCPfd6U3zw9kfi/8VQAY
         cranb3WKoM+xqjb36KQTVc/3pM1rpDbzp7NkCs8xVMQbO7FM+bVK/C3mL7R9eZb3oDwU
         SllC1+VHOVId/yjNg/zEK/X75Xxj9iAM/RGD9O5hWan+RBCqf+FbLLhYXT644MNCybqS
         kzXQ==
X-Gm-Message-State: ALoCoQnl1dqSCDAINXGcYfzz95gA7OC7BedHZlGG3QRaCiR3DrFJj6v5oCSGqPveMg22mrnPEQnC
X-Received: by 10.58.13.97 with SMTP id g1mr6480267vec.5.1405359867956; Mon,
 14 Jul 2014 10:44:27 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 10:44:27 -0700 (PDT)
In-Reply-To: <53BBDAA4.7020701@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253501>

I have changed the comment.  Thanks.

On Tue, Jul 8, 2014 at 4:48 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I'm in my next attempt to get through your patch series.  Sorry for the
> long hiatus.
>
> Patches 1-19 look OK aside from a minor typo that I just reported.
>
> See below for a comment on this patch.
>
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Do basic error checking in ref_transaction_create() and make it return
>> non-zero on error. Update all callers to check the result of
>> ref_transaction_create(). There are currently no conditions in _create that
>> will return error but there will be in the future. Add an err argument that
>> will be updated on failure.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/update-ref.c |  4 +++-
>>  refs.c               | 18 +++++++++++------
>>  refs.h               | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
>>  3 files changed, 63 insertions(+), 14 deletions(-)
>>
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 3067b11..41121fa 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>>       if (*next != line_termination)
>>               die("create %s: extra input: %s", refname, next);
>>
>> -     ref_transaction_create(transaction, refname, new_sha1, update_flags);
>> +     if (ref_transaction_create(transaction, refname, new_sha1,
>> +                                update_flags, &err))
>> +             die("%s", err.buf);
>>
>>       update_flags = 0;
>>       free(refname);
>> diff --git a/refs.c b/refs.c
>> index 3f05e88..c49f1c6 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3449,18 +3449,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>       return 0;
>>  }
>>
>> -void ref_transaction_create(struct ref_transaction *transaction,
>> -                         const char *refname,
>> -                         const unsigned char *new_sha1,
>> -                         int flags)
>> +int ref_transaction_create(struct ref_transaction *transaction,
>> +                        const char *refname,
>> +                        const unsigned char *new_sha1,
>> +                        int flags,
>> +                        struct strbuf *err)
>>  {
>> -     struct ref_update *update = add_update(transaction, refname);
>> +     struct ref_update *update;
>> +
>> +     if (!new_sha1 || is_null_sha1(new_sha1))
>> +             die("BUG: create ref with null new_sha1");
>> +
>> +     update = add_update(transaction, refname);
>>
>> -     assert(!is_null_sha1(new_sha1));
>>       hashcpy(update->new_sha1, new_sha1);
>>       hashclr(update->old_sha1);
>>       update->flags = flags;
>>       update->have_old = 1;
>> +     return 0;
>>  }
>>
>>  void ref_transaction_delete(struct ref_transaction *transaction,
>> diff --git a/refs.h b/refs.h
>> index c5376ce..33b4383 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -10,6 +10,45 @@ struct ref_lock {
>>       int force_write;
>>  };
>>
>> +/*
>> + * A ref_transaction represents a collection of ref updates
>> + * that should succeed or fail together.
>> + *
>> + * Calling sequence
>> + * ----------------
>> + * - Allocate and initialize a `struct ref_transaction` by calling
>> + *   `ref_transaction_begin()`.
>> + *
>> + * - List intended ref updates by calling functions like
>> + *   `ref_transaction_update()` and `ref_transaction_create()`.
>> + *
>> + * - Call `ref_transaction_commit()` to execute the transaction.
>> + *   If this succeeds, the ref updates will have taken place and
>> + *   the transaction cannot be rolled back.
>> + *
>> + * - At any time call `ref_transaction_free()` to discard the
>> + *   transaction and free associated resources.  In particular,
>> + *   this rolls back the transaction if it has not been
>> + *   successfully committed.
>> + *
>> + * Error handling
>> + * --------------
>> + *
>> + * On error, transaction functions append a message about what
>> + * went wrong to the 'err' argument.  The message mentions what
>> + * ref was being updated (if any) when the error occurred so it
>> + * can be passed to 'die' or 'error' as-is.
>> + *
>> + * The message is appended to err without first clearing err.
>> + * This allows the caller to prepare preamble text to the generated
>> + * error message:
>> + *
>> + *     strbuf_addf(&err, "Error while doing foo-bar: ");
>> + *     if (ref_transaction_update(..., &err)) {
>> + *         ret = error("%s", err.buf);
>> + *         goto cleanup;
>> + *     }
>> + */
>
> I don't have a problem with the API, but I think the idiom suggested in
> the comment above is a bit silly.  Surely one would do the following
> instead:
>
>     if (ref_transaction_update(..., &err)) {
>         ret = error("Error while doing foo-bar: %s", err.buf);
>         goto cleanup;
>     }
>
> I think it would also be helpful to document whether the error string
> that is appended to the strbuf is terminated with a LF.
>
>> [...]
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
