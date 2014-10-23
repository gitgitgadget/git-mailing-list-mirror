From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Thu, 23 Oct 2014 10:44:42 -0700
Message-ID: <CAL=YDWm0-6rNrmm2xG18qf9DrAoEOVdtE_o0onQUGu14AwTRxQ@mail.gmail.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-2-git-send-email-sahlberg@google.com>
	<xmqqy4s6smwz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:44:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMRL-00047n-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbaJWRon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:44:43 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:40345 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbaJWRon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:44:43 -0400
Received: by mail-qc0-f173.google.com with SMTP id w7so1069152qcr.4
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2NOQRt3/tgCxzuXN3BBcSQvTHIpvLlr6g4y0kLgl+j4=;
        b=LBp3uCWxFeakJFgbcExp8aXhA+FqogoygMutsaMPkXkfPq82UE12ZL6nJcYXzEOgwr
         cLsZAn29gGJzV5Ux7yaq2XZQy57H+G7v23wcwEMzt2p52UHcT7YF48QvoxGHGCTz8sJz
         eGgskFx+LxUdRwkbN84FPvXGA2EkTHn4LTfoBcDiLATlKNHELKoS+V/G2aRBbc8RL0tM
         8CLyYyUQ+m1gZiEz27OIX1C3oIEOgIW4e9MyXfVcT6CxaUiuxtB1VMdUXEL9GXxnWL/D
         isZseIeppau7w6e5EYcwByXk/ZYc0aqG7FWhtDwX1jThiHiVBcRykgZp4vI+4ur8hAnq
         eyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2NOQRt3/tgCxzuXN3BBcSQvTHIpvLlr6g4y0kLgl+j4=;
        b=XtEf4Ar4hc3fa8W3PH3hO+Si5H+5CFbtop8UDbyFFbGvgPtC2P6Bgz3FzTFjNNhuzN
         Y1HrZZiA9SWT9PHuxv84HlECiLWk4Kq1q4bz3icbYMaMjjwKbftYWkIgpU+6T06ClyqE
         IPjgpOL2N9z9n5b/nKvQst2JEjKWkM05SDoHn4/p6pygiBLYkp68awtyDHAfpbxSYJv5
         DInBeDxWEYUV/hjdA6Orp/CM6ZkyzuaanFwiYY6lvFAWyKVBfn1l4MRjX5OxC0YHpBBf
         x7+1nM/8Bx2f6bK0oJRDj2zArgmxEWMrKCmF2NtufygPA0CCbwFTRBqSf3+7O3YvNROq
         OXOA==
X-Gm-Message-State: ALoCoQnJSghgX0fyGcsNWeTpsYiFXYyZmdq0FLLA5RdPVrBNe49fN1m2RTrn+I/uTmH8Vqq58ylJ
X-Received: by 10.224.136.130 with SMTP id r2mr10071064qat.80.1414086282298;
 Thu, 23 Oct 2014 10:44:42 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 23 Oct 2014 10:44:42 -0700 (PDT)
In-Reply-To: <xmqqy4s6smwz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
>
> Missing colon after "refs.c"
>
>> commit 03001144a015f81db5252005841bb78f57d62774 upstream.
>
> Huh?
>
>> The ref_transaction_update function can already be used to create refs by
>> passing null_sha1 as the old_sha1 parameter. Simplify by replacing
>> transaction_create with a thin wrapper.
>
> Nice code reduction.
>
>> Change-Id: I687dd47cc4f4e06766e8313b4fd1b07cd4a56c1a
>
> Please don't leak local housekeeping details into the official
> history.

Ah, Ok.

Do you want me to re-send the series with these lines deleted ?


>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  refs.c | 27 ++-------------------------
>>  1 file changed, 2 insertions(+), 25 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 0368ed4..ed0485e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
>>                          int flags, const char *msg,
>>                          struct strbuf *err)
>>  {
>> -     struct ref_update *update;
>> -
>> -     assert(err);
>> -
>> -     if (transaction->state != REF_TRANSACTION_OPEN)
>> -             die("BUG: create called for transaction that is not open");
>> -
>> -     if (!new_sha1 || is_null_sha1(new_sha1))
>> -             die("BUG: create ref with null new_sha1");
>> -
>> -     if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>> -             strbuf_addf(err, "refusing to create ref with bad name %s",
>> -                         refname);
>> -             return -1;
>> -     }
>> -
>> -     update = add_update(transaction, refname);
>> -
>> -     hashcpy(update->new_sha1, new_sha1);
>> -     hashclr(update->old_sha1);
>> -     update->flags = flags;
>> -     update->have_old = 1;
>> -     if (msg)
>> -             update->msg = xstrdup(msg);
>> -     return 0;
>> +     return ref_transaction_update(transaction, refname, new_sha1,
>> +                                   null_sha1, flags, 1, msg, err);
>>  }
>>
>>  int ref_transaction_delete(struct ref_transaction *transaction,
