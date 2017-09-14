Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680C020281
	for <e@80x24.org>; Thu, 14 Sep 2017 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdINJ7U (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 05:59:20 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:47519 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdINJ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 05:59:19 -0400
Received: by mail-it0-f48.google.com with SMTP id o200so58384itg.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s+oWa8VUBjSkwFPKafAXfp1UE+N509ZcGEcMPqRtXLI=;
        b=hdfWj1XUDoefrEspeGx21h75Glb5Bi9n0dtL+9IPDHsiHjj/jrUEhOgwsPbN6oJu/C
         3lRa5X3uD958sfiDNMEsjbz63I5VzJ7tE8C0kLG8Hv1oi3wY0q8WKHTF5gRxR/TYmUM8
         G2QGKjxnI1j47TEFocU8xjhqnDKQWOLNlFWRltHgR4Tie1YcUqELG5nuY3K7h/yig2fl
         XniNeq3KMSQATCDySAY7XrRasBdcgWmXzzwcffXLEkBXPabb1X7LYNpoEOHi5Oq2YeAx
         QCwvmVYg2+jphgYAN7WyeGHurYcNutJ6q7tQxhbUgEjAUOVKIKFVbHPxc0zrDfqHj0Ps
         a2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s+oWa8VUBjSkwFPKafAXfp1UE+N509ZcGEcMPqRtXLI=;
        b=fsH9A4eiDlbxuhPasrOwYgbv2Z6fNQzeFfeLLAopZC7T10nSnM7esZpW4tJ4IkYXOF
         NJEfO0v8mQ6kaYxdjhFpvAQWqut00cdb93HTl+Q89k+35xbZw7fdmoA8DhTG6OMk05My
         ApsvzJJ8dkldrO4s6Qn6Uj+mGF4yJxdUUCas89x7hv9OWmxNp7/Sbx/UWcWvpKfULQvK
         N+dt7yFhZ4gqoC6ww2oj2Z7c52uSHR0NuDIcFdifg/NOpdS5Imgr6UwNoxVdZtWU/rlF
         vYFoRmPuG7Pl3tDDoNyg5wCJ0Ub/X+OqEAGGAVykfbVJ+zFHJSiASlmyOF1bhOJJA1OE
         zS/Q==
X-Gm-Message-State: AHPjjUifuxXRaw9N2O6YWTK8EmpJ+ZHxfEv/2Ee3x8v8wAn1/Dwbf+Ge
        /D4ZKr4X7xD8bH5MfsnRzpKHb/e1YWbBNtSFS5M=
X-Google-Smtp-Source: AOwi7QByP4ihFizOewFvbyGZn5y8LGl9SK6LbEE83EDupojD/Os4MkKC4f+BIUHIMDoZp4PbV/MfsZ6BoLf2RvnWRm4=
X-Received: by 10.36.111.4 with SMTP id x4mr2101515itb.144.1505383158659; Thu,
 14 Sep 2017 02:59:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 02:59:17 -0700 (PDT)
In-Reply-To: <xmqq7eykxwbt.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-15-chriscool@tuxfamily.org> <xmqq7eykxwbt.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 11:59:17 +0200
Message-ID: <CAP8UFD3=nuTRF24CLSoK4HSGm3nxGh8SbZVpMCg7cNcHj2zkBA@mail.gmail.com>
Subject: Re: [PATCH v5 14/40] external-odb: accept only blobs for now
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> The mechanism to decide which blobs should be sent to which
>> external object database will be very simple for now.
>> If the external odb helper support any "put_*" instruction
>> all the new blobs will be sent to it.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  external-odb.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/external-odb.c b/external-odb.c
>> index 82fac702e8..a4f8c72e1c 100644
>> --- a/external-odb.c
>> +++ b/external-odb.c
>> @@ -124,6 +124,10 @@ int external_odb_put_object(const void *buf, size_t len,
>>  {
>>       struct odb_helper *o;
>>
>> +     /* For now accept only blobs */
>> +     if (strcmp(type, "blob"))
>> +             return 1;
>> +
>
> I somehow doubt that a policy decision like this should be made at
> this layer.  Shouldn't it be encoded in the capability the other
> side supports, or determined at runtime per each individual object
> when a "put" is attempted (i.e. allow the other side to say "You
> tell me that you want me to store an object of type X and size Y;
> I cannot do that, sorry").

I agree that it would be conceptually better to be able to support
other kind of objects in external odb, but realistically most use
cases for 'get_*' and 'put_*' instructions are for storing/retrieving
blobs as other kind of objects are in specific formats that are well
supported by the current object store.

I also agree that it would be a nice feature if external odb could
decide by themselves which objects they accept and I really want to
leave the door open to a future improvement implementing that using
the capability mechanism or perhaps another mechanism. For now though
in "[PATCH v5 34/40] external-odb: use 'odb=magic' attribute to mark
odb blobs" the attribute system is used to decide which blobs are put
into which external odb as it is probably good enough for many use
cases. It is also simple to implement in Git and makes helpers simpler
to implement.
