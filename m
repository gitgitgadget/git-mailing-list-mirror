Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADC91F859
	for <e@80x24.org>; Sat, 27 Aug 2016 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbcH0JOH (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 05:14:07 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34668 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753912AbcH0JOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 05:14:06 -0400
Received: by mail-yw0-f178.google.com with SMTP id z8so61777886ywa.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bzLqNNrOBaoi9gRvQ6e2DuXV6rS12HmK64U2+VsKNEA=;
        b=PK012mbautpcc+5unR08icNB7/yA4IHT/WsDT9iZA0Z86ecbOPi84QWn8vL5i7uhrb
         pBbemooz97qjh1gjvxIy5W/COApDjpAFZqJnMndkhiSr14QxWDZ2Z9n+mlcFrCz5zusF
         3e8DQ6a/lxfeSKfP7eg+zfKadTDZ4khJdZc+zSZHSW+cHNY0zcn306vzK72dGetOFMPu
         0euvzyO5tFMbyTs/7evtc4zzTTj8Mm+fHMHMDVoU3CQDVwogWiPx0esfh0urP+/tIOLb
         ETrDpzkLjfkYDq5r6TaAvnuX8haK4JP8kGkXf9rcXvB0NqYmTdt6R5tmgNDwynq3JciS
         8Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bzLqNNrOBaoi9gRvQ6e2DuXV6rS12HmK64U2+VsKNEA=;
        b=iGEGWnwQlWjnrl80OGk2L9fpd36d0ToCLM4NnjoVt0PLSQnVwRGuDRfAoIW3B1pL61
         XEc1tSdS8fEFls7cUmxLpKDF2fpa+RcBpWUhRIl8VOqpOPRU5vmnAgei4CbK8ouzRmtV
         fVIHzL6ny2XQxKBHYErqScitbDqwvSWFhhP6HxsY/V1AvtX8IRAEWOohChU0XoDNd5kj
         vAwNH3856Be05VkmiQW1QVOOEQbPBWIBY4NKvJcpS4AUThVJYnzUxetsJXv//88AiLYm
         SqLK6moXO9Y5mcvtSvtTe2k1BJ86p5N+oEihfgL3Rf0YGSf7q+CV1rYE5XJ/Cf+0n9zC
         PX+A==
X-Gm-Message-State: AE9vXwO35coWbp6EDjegHxRGxVBCekGJI7SSHCHeeXI1v7wdATSMfk66dkS6fXUxwZG2c8tOr41LmNQ4vUkUTQ==
X-Received: by 10.129.154.76 with SMTP id r73mr7223993ywg.164.1472289245227;
 Sat, 27 Aug 2016 02:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 02:14:04 -0700 (PDT)
In-Reply-To: <xmqqlgzlolwa.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe69f-6b734e3c-806c-431d-aa52-c96b3783f248-000000@eu-west-1.amazonses.com>
 <xmqqlgzlolwa.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 27 Aug 2016 14:44:04 +0530
Message-ID: <CAFZEwPP2j-+C=J-hiWEiW4wa=Yso27-M-QUABCTyd4WYieeezw@mail.gmail.com>
Subject: Re: [PATCH v14 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Thu, Aug 25, 2016 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int is_expected_rev(const char *expected_hex)
>> +{
>> +     struct strbuf actual_hex = STRBUF_INIT;
>> +     int res = 0;
>> +     if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
>> +             strbuf_trim(&actual_hex);
>> +             res = !strcmp(actual_hex.buf, expected_hex);
>
> If it is known to have 40-hex:
>
>  (1) accepting ">= 0" seems way too lenient.  You only expect a
>      41-byte file (or 42 if somebody would write CRLF, but I do not
>      think anybody other than yourself is expected to write into
>      this file, and you do not write CRLF yourself);
>
>  (2) strbuf_trim() is overly loose.  You only want to trim the
>      terimnating LF and it is an error to have other trailing
>      whitespaces.
>
> I think the latter is not a new problem and it is OK to leave it
> as-is; limiting (1) to >= 40 may still be a good change, though,
> because it makes the intention of the code clearer.

I can do the first change. Since this wasn't present in the shell
code, I will also mention it in the commit message.

Regards,
Pranit Bauva
