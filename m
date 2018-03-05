Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6696D1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 19:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCETBl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 14:01:41 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41246 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCETBk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 14:01:40 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so18401399wre.8
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VoA07xXxJI2buW5dvXfMfP18yXrS+jkDNh+6tQxBdnQ=;
        b=U3Umjza0MAysTTGPjIsM4RjYx7ArE98AvMjw6h/Oc9k0tG/kMzQqk/zMLfqPtd2TNb
         E3qcXYPf4LfPUqR19FW0a5uwRDCyt2NMxTmuMQ96clYbOQtPE+WEW+DPBy4l0z/q7wlx
         SF3s96mnS8JCGMsOUI/tqmGbzexX5s0te8TfAF10nxMvyI1Xdx+j6ELIQxsXAhVzHcJT
         eFjLqouCib28MevFrAjRODwOkhQXtesL+YmnKhGl9bWsoOEON6+fsFYq9upBJDCgxxVN
         RQTR5rcoBTmh8pyMcTyIpLDl5qdtXwEeeXiDmXSIRUMkYcpDYODl81uHxfQCv+iK53/J
         uQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VoA07xXxJI2buW5dvXfMfP18yXrS+jkDNh+6tQxBdnQ=;
        b=NywLBs4TkWTq2DI5HxQlDVzBvtDXKqWm6ObewlrltFoCy8mX5kSRt8/Bfk1lpICCys
         /wwP46EScaFtlspbxIFWeNpC1KwUNwgR68FDBdC3OY0G2BoHn/p11GbQlQxx8BBVyAyk
         wm6KP6WwN7NEcOEBXpHBA9ufV/4qspnFS6mkc5bAsl+r1jy6skP11O5ibczcqwzWugJl
         lhxFtDV31CQNHR1KYOO4sbkW6NOEOSR0165nao7acCkTH9itjLio/DqYP8dF9BR1WeKV
         Ny28fZJTueBcOw6X6i0pxaI2jAxoPNxZrjVSf4z04IwhdUAW5NzmrZtd4HUOO2WaBcLC
         rkSw==
X-Gm-Message-State: APf1xPBU9XNWOnowSfymqGAKAbD4ORfbuxh6HlpEXNclB4B8+mXQH6QU
        popVsMSvsUfSoSC4Yk9W0x8=
X-Google-Smtp-Source: AG47ELvgGtCkVRDCm3aT6RVH3XtiVz7lyAV+I5pojnX7MtYIErp7SvufrJ26v51R7qElKYLYpvk8ew==
X-Received: by 10.223.150.42 with SMTP id b39mr12863804wra.55.1520276498686;
        Mon, 05 Mar 2018 11:01:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z197sm13554748wmz.24.2018.03.05.11.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 11:01:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>,
        Petr Baudis <pasky@ucw.cz>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] various perl fixes
References: <20180225194637.18630-1-avarab@gmail.com>
        <20180303153817.20270-1-avarab@gmail.com>
Date:   Mon, 05 Mar 2018 11:01:37 -0800
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 3 Mar 2018 15:38:04 +0000")
Message-ID: <xmqq7eqq9wj2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Same as v2 except rebased on master & a couple of commit message
> fixes, thanks to Eric Sunshine (thanks!). tbdiff with v2:

Noting that the series was rebased is a good thing to do, but a
statement of the fact alone without justification makes readers
wonder if there was a valid reason why it was rebased, or it was
just because the 'master' saw more commits that do not have any
impact on what the series does.  For the former, saying something
like "A recently graduated $name topic added another instance of the
same kind of glitch this series addresses, so the series has been
rebased to cover that codepath as well." would make it very helpful.

Thanks.  Will queue.  After scanning it again, I think this is ready
for "next".

