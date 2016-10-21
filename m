Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD55A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934873AbcJUWyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:54:51 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34321 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbcJUWyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:54:50 -0400
Received: by mail-yw0-f173.google.com with SMTP id w3so118004077ywg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WKVBL6paY/UqfE1VhnQjoFlBAHdn0UWxPQvA4ogJWuM=;
        b=OlwQ0tKDfth7NXafOU+JnhWHbGPTxOs4bsyTDBnJqgb60i89FnBYhNsFX4Blg69IOL
         JVW5kJWraWC7eqMjwruMUsZUOw5fGticmUN4d98CknYQhwRkVTYk/fq88UH2uNiusT8l
         qGnC4gEuTytMWbr/ycGWmOdloA5YlLyT1GShd1BCAZhNynUxqfMtWUfOgJpRSnfodvhF
         4+lHQfcgcVLm1+BggOl9H6g7yXW7wPpq7o2Klq5uTshl2usb7oVcmmyQCIBsaOfrBTqM
         8w1KYGs383ztd+jaF9hTUuQEwt2FXiXxy53zfhKac+dM29LjQJLFwaDSAfHDNI3JyHgH
         tIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WKVBL6paY/UqfE1VhnQjoFlBAHdn0UWxPQvA4ogJWuM=;
        b=ebpzUJkaheAbK46PUJKQBpLDZFNir2JdKjtUTotSIX21lbxxCxHMW+4yEnvgIInQOD
         dgRChCs9BWaAELdW4QCsU/JFBsqCa4BBR9c6R9wJ6j+nLOOPqFptcGSE/P1o3YZw7f4a
         6recWplFVRApp+8s9q8Zi4+U1X08lQy9b0+bFlN5t+wdlbiW5Hy5j8bNQ827J2InC2Ci
         0E76O2cvaTzd3riLIW+Uwlg1de6eiPA5OLbM89rGbXJ1J16mtT3MUy6hablbpDMOuwTX
         KIArf1pfpuXABRUbkPerTvZDimZwhEkY6pZ54nU5OsHJdidh1KLeKV8QtPYQPYP+BadX
         AjJA==
X-Gm-Message-State: ABUngvdTrL5mmbe0kXeipYNJeBFqxgvKA+Ruo+0V4MvowIHi+LPplN3k8cvme4M8hswJt28ol4V7+dx0+qvIIw==
X-Received: by 10.13.199.199 with SMTP id j190mr3994700ywd.204.1477090490062;
 Fri, 21 Oct 2016 15:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 15:54:29 -0700 (PDT)
In-Reply-To: <xmqq60olb9zq.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xrN-_zP40uAUGtqZW+OO4D4Z65SiPRykdKvauO1zgNNcQ@mail.gmail.com>
 <CA+P7+xoTO6MqdBjekbSpSs=w_dJ-1h_ypMDAo50mm95iTOo9Pw@mail.gmail.com> <xmqq60olb9zq.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 15:54:29 -0700
Message-ID: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
Subject: Re: generating combined diff without an existing merge commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Turns out that somehow I must have messed up my command because "git
>> diff <treeish> <treeish> <treeish>" does indeed do exactly what I
>> want.
>
> Thanks.  I was wondering why it didn't work for you, as the feature
> was done exactly to support that use case ;-)

I'm not really sure. It kept spitting out usage information to me, but
then I tried again with a fresh example and it worked as expected.

Thanks,
Jake
