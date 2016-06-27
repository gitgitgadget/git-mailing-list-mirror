Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812252018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcF0QRB (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:17:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33662 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcF0QRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 12:17:00 -0400
Received: by mail-io0-f193.google.com with SMTP id t74so24089533ioi.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 09:16:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7qP8G2qPKbvYYUcITBRwwDi+cKywlOBoBBdPOSc8Fxg=;
        b=T0y6nsSyLVIobqnqaFnJ9vg/7p6vOiWb5LB643PZs0trTBCHBCVnE8zmUvPyTvgCIw
         XKmM53SuTxT4jO19mzk6o5fDbZ5jkUK/kBuxi77j24RS0ciASSrzlDmaQBfDLLc4gw2P
         ZNu7FEq0d6yWydQ+3OjjircS6z/moq5BFEKIyiIh/qJWpjCbyzX0BoH8KKrIvE4ip2ae
         RJMJj9slZ7LUdGlmM3saCOHCfnNZZPOqRpkg03tFNsY7qUewx65PxtJlRl7GrRVNjw6j
         iMR1U1ljjfBx+U8/8tMJgK7KxqCsPMR/EaN5BwaZDJaD6WY8ONzlCvzDLfJYxcfnuCLD
         QFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7qP8G2qPKbvYYUcITBRwwDi+cKywlOBoBBdPOSc8Fxg=;
        b=g7o1iN6WS3CLJbp+iBkhJEk+8cX9CY9WdjIukysg6dpb4fcGLhRozqvy6bniZKSG2z
         AFYQ1uHf1/d1F2Wdn6z6OSBGYY/8PdwWG/+a7q25KadSVxHEnP3IO5FuQ7YYaWPMIXRU
         S7quzPsb5YLXDr4bkbfPv78cZpq5OnGWe3lYxjccMSWANoGx67NvnDKOiDbsCJYe52PS
         5KG/nVXBGX5f4JamZqqKxPGHiBKVYjSg1CW2u3L7NmcU0U21CkqrFqXUar5hfXTWiPnc
         1pj4JmzemFEG9D8x7UzSf9pWR52na4jHS01CLszjBaszxk+n/ERGLoBf8pbA7gq2hqmI
         T2+Q==
X-Gm-Message-State: ALyK8tIqQIIeYoUs2idSCropb3BMqO0HvxelYYycYfRPME/Zp2zf9gF4UG4z5Dw7IHjEmbK7avTzd+Iy9OConA==
X-Received: by 10.107.159.16 with SMTP id i16mr1536716ioe.29.1467044219420;
 Mon, 27 Jun 2016 09:16:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 09:16:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606271413350.12947@virtualbox>
References: <1466914464-10358-19-git-send-email-novalis@novalis.org>
 <20160626120928.14950-1-pclouds@gmail.com> <alpine.DEB.2.20.1606271413350.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 18:16:29 +0200
Message-ID: <CACsJy8A2i9enBUtK+jcJmnChTddJBjd6O9LZfU9Tj2ikn8JqRg@mail.gmail.com>
Subject: Re: [PATCH v13 21/20] unix-socket.c: add stub implementation when
 unix sockets are not supported
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 2:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Sun, 26 Jun 2016, Nguyễn Thái Ngọc Duy wrote:
>
>> This keeps #ifdef at the callee instead of caller, it's less messier.
>>
>> The caller in question is in read-cache.c which, unlike other
>> unix-socket callers so far, is always built regardless of unix socket
>> support. No extra handling (for ENOSYS) is needed because in this
>> build, index-helper does not exist, $GIT_DIR/index-helper.sock does
>> not exist, so no unix socket call is made by read-cache.c in the first
>> place.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>
> Heh, I made something very similar (although I did not update the errno as
> your patch does): https://github.com/git-for-windows/git/commit/919cb1d79

Yours lacks the important "else" line in Makefile, so pick mine! :-D
-- 
Duy
