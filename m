Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2435C201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 09:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdBWJfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 04:35:33 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32770 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWJfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 04:35:32 -0500
Received: by mail-oi0-f67.google.com with SMTP id 2so908019oif.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kx9zNGzRiQcZEbAxwwrnfVcKSFY75JJHA2sgJ70SlrA=;
        b=rya6OfYHxEYJ8WmLaCMUims7KLilQ/0pmMfEdkgLNk9cgQTJlysoAgLmhNUKKGrskl
         peVm9XlZ/FmOih0O1thnx90FaWXCIfv44n6YSwrqxez4v4CVdrapgyryy6VF65Rp38tE
         GLcvMHMbLZnrsgGCC5ubMsdowZWuIAPmZQf5wYnJefXEZMTn/LRjOocJTYLzCIaEMM09
         pgTq1sg+Z6/JDWvSgPLq4PpgluyuM71+nMdnE2M4XBRoBKGr3/Xszf66eKGViwu8Q8JW
         IpKHye1mC2HHaYUTKNrAkL6lTmthQTkIlpkJFGwdt6SLRS3SyFV3O2ZeUp1qCXAFEjuo
         mc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kx9zNGzRiQcZEbAxwwrnfVcKSFY75JJHA2sgJ70SlrA=;
        b=p2ZnWTiRD/yA6cVMM2UpDPRbZPo/K7CRyRg1TPAGfcBXFvW/cF7IvRdcOBV4i2td4O
         mZR0SUpTyfCTgE1jxBlLhXGuHt3ONrHDun35dtM7t2kGYGAL+8jWGYzS4AUBM5oGnsV3
         ImJcrqIWapGwjTGuYLprok0EedKeFzcw8leNIFGnOTYVuSXhkRs0JFZU1UID5gUtatBE
         S/IMlvVovhX4byFQX2vYJ1VVcyIKQyGfOa+z80IdDH9ex8oIyHq/oh+dfMP8Ouix8s+z
         uxX5B20YnxCOrRWtJC9of/0L44i1AsRl2kKsAmQd969EUObqNdvdY8cFY5q6V63B98XJ
         ZC0g==
X-Gm-Message-State: AMke39n0dGp7+PkdUe0fXpFnW1lb760a6GJCJju9SIz9xO9SxNnK55oLU1Y1MYsLVwZ47CcNqn9egxIP8W0yMQ==
X-Received: by 10.202.207.134 with SMTP id f128mr9746607oig.55.1487842028865;
 Thu, 23 Feb 2017 01:27:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 23 Feb 2017 01:26:38 -0800 (PST)
In-Reply-To: <CAGZ79kZTr924RrvG6RsasmhT1yswN875XShtmrrcJ8ztaAGJUw@mail.gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-2-pclouds@gmail.com> <CAGZ79kZTr924RrvG6RsasmhT1yswN875XShtmrrcJ8ztaAGJUw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 23 Feb 2017 16:26:38 +0700
Message-ID: <CACsJy8C7XaRfKnP4zUOTaOtOoLk7pmxt_obHEYOpHoHWaiC+KA@mail.gmail.com>
Subject: Re: [PATCH v5 01/24] refs.h: add forward declaration for structs used
 in this file
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 1:18 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Feb 22, 2017 at 6:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs.h | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.h b/refs.h
>> index 9fbff90e7..c494b641a 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -1,6 +1,11 @@
>>  #ifndef REFS_H
>>  #define REFS_H
>>
>> +struct object_id;
>> +struct ref_transaction;
>> +struct strbuf;
>> +struct string_list;
>> +
>>  /*
>>   * Resolve a reference, recursively following symbolic refererences.
>>   *
>> @@ -144,7 +149,6 @@ int dwim_log(const char *str, int len, unsigned char=
 *sha1, char **ref);
>>   * `ref_transaction_commit` is called.  So `ref_transaction_verify`
>>   * won't report a verification failure until the commit is attempted.
>>   */
>> -struct ref_transaction;
>
> Leaving the detailed comment about ref_transaction dangling?
> I can understand if you don't want to move it with the declaration,
> as you want all declarations terse in a few lines.
> Maybe move the comment to be part of the first large comment
> (The one that you can see in the first hunk, starting with
> " * Resolve a reference, recursively following")

I thought the comment block covered the following declarations too,
not just ref_transaction. But on second read it's not that.
Transaction functions are way down below. I'll probably move
ref_transaction back where it was.
--=20
Duy
