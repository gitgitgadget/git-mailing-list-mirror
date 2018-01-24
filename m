Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469071F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932894AbeAXXEH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:04:07 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38506 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeAXXEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:04:06 -0500
Received: by mail-pf0-f195.google.com with SMTP id k19so4317781pfj.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 15:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QmSQaxbNs4FIBql8o3bhl4W2fUboteXFkZ/2HmfPqjc=;
        b=YX0uc8AQ458BHzQXQJTTN0QSFTmdCoeLh7unvkqqQ84LVQLfvAfny7u3XwKQcl92Jd
         31b9P1iowtmdrjmLI3kqfGASsw4KQiyf7W3hU1N7rUa9Mtn20EEpI1rmBARm3EvEjagj
         0BEahW9Hs05g2ZYozkJrhx0ytidOgqprJC+VpIKH9hbfzNMlcO5QLCT7Y71LgwOJPz95
         Pxg3T3xger9SESi1j/nGqaGqiu+EZu9CjGHtPV/Yq2ciqB8Oe05YBDKUv8Dl67NPlvtJ
         CqZPk9AtrN7UumMkak9zvUedATra75qSD2/7iLr3iyn+pPQr7/Oxptt6Xzf1iF/UXcnY
         sZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QmSQaxbNs4FIBql8o3bhl4W2fUboteXFkZ/2HmfPqjc=;
        b=CicmQ0hZ5w2zIHvYmd2IVsdN2K6o2vrMsKdTGGPEEM66P8n7nXVHQhQ9ASGvzZ+Tca
         zNphIOIMji1qViJMeV+iPXNE4HeVgb4NoOp4ivukM/CUT6OKuMW2spYPVmUxq09ofhih
         apR40vjaotpc+IEHUeUJAVIrNW1YuYJD8fNBD2r229r9q6vcrpcND7vIVxfEQ7LRxt7C
         yPYaYdMUJU6xD5nVXXiVPH6MprYKSzoxb9eTDEtxVXJYfYUiGY16gZMLSAvBrkcCndoa
         nXnJ+uYj5xm9TMqMq8EskGegMW5K9/bvpUyAhfxo3y4qcK4S6x7Dwyniy7DXY3or0uqk
         em7A==
X-Gm-Message-State: AKwxytd2eeDeisYPeOmMVIkHK6bfEL/wX8I0j5NR2YQYS/x4/bnJQRsr
        vMLY7hYncZX5Y2ktGPKETTQ=
X-Google-Smtp-Source: AH8x226pMcUehviIDYW1YnDEf0xVXsctSu367Sf95Rcd5FzLnUks36LcQQPp/fTAKRron1rMEveqkg==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr9238450plt.351.1516835045352;
        Wed, 24 Jan 2018 15:04:05 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id 65sm12333237pfm.152.2018.01.24.15.04.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 15:04:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180123221326.28495-1-avarab@gmail.com>
Date:   Wed, 24 Jan 2018 15:04:03 -0800
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Jan 2018 22:13:15 +0000")
Message-ID: <xmqqwp06amfw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  Documentation/config.txt               |  20 ++++-
>  Documentation/fetch-options.txt        |  18 +++-
>  Documentation/git-fetch.txt            |  76 +++++++++++++++++
>  Documentation/git-remote.txt           |  14 +--
>  builtin/fetch.c                        |  37 +++++++-
>  contrib/completion/git-completion.bash |   2 +-
>  remote.c                               |   5 +-
>  remote.h                               |   3 +
>  t/t5510-fetch.sh                       | 152 ++++++++++++++++++++++++---------
>  9 files changed, 275 insertions(+), 52 deletions(-)

I've queued this round but saw a few minor conflicts with another
topi in flight, so please double check the result when I push the
result out shortly.

Thanks.
