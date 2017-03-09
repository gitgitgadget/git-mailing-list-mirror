Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0255E202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbdCINZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:25:18 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36528 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbdCINZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:25:15 -0500
Received: by mail-lf0-f65.google.com with SMTP id g70so4603676lfh.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JJL+F5j3Pf+dtvSragI59hOYn2fIAaoMe8Z7dbgxOP0=;
        b=Sz7+3ORevdpwJct1pIWU0iYeo2SIOvsiuEOaQbhTaLUi+Tk8L5EB7b8kVfO1Euln3f
         2v3MystlsejaPo6YZRFcTWmpycDRJOOr7V1Sud/yTIdPTeAhiixD9a5OWCN61Mij2xYx
         j1RmEm2SQ+UqsD6EoQSggQ/qfmWs+05h84VG7QhwD3dmcEh2iEYqvHg3mWxsPk7/lB0/
         +Gxmtzkxl+YGDqOomJSsKTnIQ5ccT9l4REBAstL1Rg1DL+KCTIP7sj143AgchvXD11b8
         MdUjrCLcRvJLTk+e3CADUQ6C1uCN8PfcJRjJ2QwbaD8mkgmanE6H0n8KudWlplFZtnRL
         2LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JJL+F5j3Pf+dtvSragI59hOYn2fIAaoMe8Z7dbgxOP0=;
        b=nPE9JQt3KBhdpg6a9Wu8hp9iFPAkg3yixjTGpw7roSIbqrsehUDlW8vz2UMQV4McuJ
         rtpnmJqgfy8wDsi4mC5Cj38H7ioqDXP5m+7Po23mLWa3+TWHGcnbf+lf1sQYRZ+ZNNFz
         VvuJ+GT1hRrhGUJ5/tW44BLzxls5eJ168sLFeEu4BsiZ9AswonRnu3QZMbl8teaM+fDZ
         +WxotsTuApapwNyf0JokkNllROHN2MTldDyKxgZvX/Xv+rLREYbhvN+CsuYoPo2NBpIZ
         udRWsvmU64lbcwBeBXgmmBbEz4sW6LQSWpXOGjANYoVVm8n5Kgsy+zHobsn/hMICqYFz
         MW1w==
X-Gm-Message-State: AMke39nXH2hzTGxMTNqSzAEx0ySCTMwVd0h/BscGCraN/QXPm76u2PNNL+rmsykrKRX6Zw==
X-Received: by 10.25.16.70 with SMTP id f67mr3318525lfi.136.1489065913522;
        Thu, 09 Mar 2017 05:25:13 -0800 (PST)
Received: from [192.168.1.26] (afp224.neoplus.adsl.tpnet.pl. [83.25.145.224])
        by smtp.googlemail.com with ESMTPSA id f4sm1267075lji.19.2017.03.09.05.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 05:25:12 -0800 (PST)
Subject: Re: [PATCH] branch: honor --abbrev/--no-abbrev in --list mode
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
 <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
 <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
 <xmqqvarj1kix.fsf_-_@gitster.mtv.corp.google.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Guillaume Wenzek <guillaume.wenzek@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4d09ad56-96ac-75d3-c9df-0c23b805b478@gmail.com>
Date:   Thu, 9 Mar 2017 14:25:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqvarj1kix.fsf_-_@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.03.2017 o 23:16, Junio C Hamano pisze:
 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index cbaa6d03c0..537c47811a 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -335,9 +335,18 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>  		    branch_get_color(BRANCH_COLOR_CURRENT));
>  
>  	if (filter->verbose) {
> +		struct strbuf obname = STRBUF_INIT;
> +
> +		if (filter->abbrev < 0)
> +			strbuf_addf(&obname, "%%(objectname:short)");
> +		else if (!filter->abbrev)
> +			strbuf_addf(&obname, "%%(objectname)");
> +		else
> +			strbuf_addf(&obname, " %%(objectname:short=%d) ", filter->abbrev);
                                              ^                       ^
I wonder why the last one has leading space --/ and trailing one -----/
The rest (for default abbrev and for no abbrev do not).

-- 
Jakub Narębski

