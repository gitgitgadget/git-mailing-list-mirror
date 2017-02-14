Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6D32013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbdBNJpH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:45:07 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35844 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbdBNJoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:44:21 -0500
Received: by mail-oi0-f67.google.com with SMTP id u143so2370273oif.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C4v4q2Jc6+VH1mHCFre9M0vk4omEXzw8LWfNGly6nCI=;
        b=MCWLMTCSTDDOOCDjcL6thVChydgwifjJYDdnCZ0wnHlR8C6CNRFdt+jtJU8dTNlWTm
         n5j75doIUtZXKF7/SEjSlo8ro74yKt3zZfsOBsrnFt+8MXJzlpu9Hhn3NsvArJrtqF5j
         jeumjXQqZt5ltGVXrUe8Ltl04KG3bmvouzt593uGh5SfvENJg3Ouub6yAvfTGb1UmkWm
         ivW1w80x3a5xOPDsEEBb2aYJpA0Y74Cfk6hkDCxkdRMEcEahwHyvt4dDVz8Cpo+4xBMm
         /LGMwy8+R7Q8Ol5EyRMpCi2ntki88SuyZWuIHimXyzyeVFIhn34jOvIyCw/JNUOy31nx
         ddLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C4v4q2Jc6+VH1mHCFre9M0vk4omEXzw8LWfNGly6nCI=;
        b=jwvWTy5kVhw4Fu3bISuupUarnANCxe35H6OKd85T9MV9Y1OGLE9aNJP3eriVGjs0s8
         oZmfh1hFAhG/eMlxXLn+9HdtLSHcW9wQDtgIUfylIGGg43OEOYdxUOaBFyiIWs0sLLI0
         DnOJgdjZ2wDhY+xVzbnQP5gfGA9Bz3Nd/8a/vEYgYJp3QAuYyNAplLBwxEbP3oCvavaV
         yw1chY+5Ao7FWdesBeoHqslpRI5JHFkCcSp8unHp9HSB/BRtNIukQevFLu7XGzW8+5TD
         TXEnAsyeO+vF3sTLpLqI+A4igSoJpa6Nzr1pbpWrKeOtUw0tUS24/syCRxpOAMZHEG2C
         vhHw==
X-Gm-Message-State: AMke39ljA2Fg/yPIe6OtmD+dRanOVB6Hm6j9Sq5BbXTKWZGIQjX+QKIAgyYt0/eomRcyWAkC7OsvwMpzVT28pw==
X-Received: by 10.202.182.7 with SMTP id g7mr15312391oif.175.1487065460427;
 Tue, 14 Feb 2017 01:44:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 01:43:49 -0800 (PST)
In-Reply-To: <8f6e09aa-f578-6faf-6acc-e35be71ee990@ramsayjones.plus.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-5-pclouds@gmail.com>
 <8f6e09aa-f578-6faf-6acc-e35be71ee990@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 16:43:49 +0700
Message-ID: <CACsJy8CeEZ9XESGaCLZs8uznw_XazjTmbumzo6foiGbUp6Qa5Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] files-backend: replace *git_path*() with files_path()
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 3:58 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>> -void files_path(struct files_ref_store *refs, struct strbuf *sb,
>> -             const char *fmt, ...) __attribute__((format (printf, 3, 4)));
>
> You only added this in the last commit, so maybe mark it static in
> the previous patch! Also, just in case you were wondering, the 'Why?'
> of the previous email was, "Why do you need this forward declaration?"
> (hint: you don't ;-)

Yeah, my compiler considers unused static functions an error. But I
guess I should adjust those million compiler flags instead of doing it
like this. I'll need to check if it's an error with DEVELOPER_CFLAGS
because people may bisect with that.
-- 
Duy
