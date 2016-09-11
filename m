Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3186320985
	for <e@80x24.org>; Sun, 11 Sep 2016 11:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbcIKLga (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 07:36:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33706 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755721AbcIKLg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 07:36:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so9528807wme.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=agAKgL2CZVyrhBju8dggZzCcjCJjKWdjKKiaAqBmbuc=;
        b=KfDZ/GrJWMFn6O1R1jst2k7PIsHCXTN2KcRqvii6b5AmxzLOMRwLW69l5R9j2dC9Fa
         5aX4YGypOR0p994RGTfyMgBa4zIYJFWa5GgdVMHlM/7hYELyAbcfnaEaDTOzNugxqdat
         FON99L0NL1y5odULLx3fd7ZfXb00LAHVIyO0drZemr++3r0hTwpUd4T89ZQhiqT5v0Fr
         Sf+8u3X/HclExt/k10YBnnn2aqYZL8nuRPNWYtcH7uO0jtHNUO8AOLbsR8GYhmzPxZ4A
         QCvPq9lA2mSDieYHfHz5Fp7A6sohfvp0LFbBwklg8siFntYJHMyI17joInYhRT3/k8aG
         1MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=agAKgL2CZVyrhBju8dggZzCcjCJjKWdjKKiaAqBmbuc=;
        b=Rf3ad6GD3Pl7dJH3jtYM9EO8p+QvuJM4vrmr2NK7kv4Up+ISpqEHPWcDBUZUn6jY1J
         KMCl5Tr1XI9Ww8POUj6XxJDlYFwnBePrlGFvef41LIoRxwHBtfdUHuqR1OfOxJlAcFUl
         rL4+d+lXI2Ga+ZOrz7JtmKFDLyDsAE4jpPodG0zOiqWEHK3dl+arYhIvxLm070Lae6M5
         luSaqQ0+D/OOpsrbVblFi/XD9RNf8CyqKCRMQdUIApQcdYzlIO/npTG2INOIjqs8GlVp
         S0UZFBWUcKTkpIODesUTn8L4q9hJmjnPCTYeiu9wqBQg+3nr3DVIXGCW+HdQ41N9dMKG
         bLSg==
X-Gm-Message-State: AE9vXwPtIi4wKNaAsm5umpvSGLlrenSpke4fJbXE2D9QCRfC0PvLyV1HYJR5PjRD1NqrYA==
X-Received: by 10.28.189.135 with SMTP id n129mr1992542wmf.71.1473593787238;
        Sun, 11 Sep 2016 04:36:27 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BADCF.dip0.t-ipconnect.de. [80.139.173.207])
        by smtp.gmail.com with ESMTPSA id kk6sm12577185wjb.44.2016.09.11.04.36.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Sep 2016 04:36:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 03/10] pkt-line: add packet_write_fmt_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com>
Date:   Sun, 11 Sep 2016 13:36:25 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <714C1346-6A7D-4A8B-AAA2-BA936EB6B739@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-4-larsxschneider@gmail.com> <CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Sep 2016, at 23:18, Stefan Beller <sbeller@google.com> wrote:
> 
> On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
> 
>> +static int packet_write_fmt_1(int fd, int gently,
>> +                              const char *fmt, va_list args)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +       size_t count;
>> +
>> +       format_packet(&buf, fmt, args);
>> +       count = write_in_full(fd, buf.buf, buf.len);
>> +       if (count == buf.len)
>> +               return 0;
>> +
>> +       if (!gently) {
> 
>    call check_pipe from write_or_die here instead of
>    reproducing that function?

Yes, might be better. I wasn't sure because the check_pipe is
not public.

Where would you declare check_pipe? In cache.h?
Maybe it would be more suitable to move check_pipe to 
run-command.h/c?


>> +               if (errno == EPIPE) {
>> +                       if (in_async())
>> +                               async_exit(141);
>> +
>> +                       signal(SIGPIPE, SIG_DFL);
>> +                       raise(SIGPIPE);
>> +                       /* Should never happen, but just in case... */
>> +                       exit(141);
>> +               }
>> +               die_errno("packet write error");
>> +       }
>> +       error("packet write failed");
>> +       return -1;
> 
> I think the more idiomatic way is to
> 
>    return error(...);
> 
> as error always return -1.

Of course!!


Thank you,
Lars

