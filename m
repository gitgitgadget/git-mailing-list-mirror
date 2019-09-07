Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4571F461
	for <e@80x24.org>; Sat,  7 Sep 2019 20:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406397AbfIGU5K (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 16:57:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406391AbfIGU5K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 16:57:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so5459841pgi.6
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLZY3Sd6DDGE5joHgpmfGnelFUF6+QJCShZ+OVnG2QM=;
        b=vSWjq6mX1jjvZ/V68QM2myoPm9lODXduPVzjz4XzLc1NY84KvcixU1RdQVr5BbHTQu
         MOFhgCQes0hZGTSE5408Ee8fuYCtuxXmzoSg2/O2L/pMnbtMk40lvJjL3QlWlHjFNCuy
         4gaoUHjukJ4VfPwdywHXyhQzl1x4MjRH/UlpX/TjHw4IBcLeqAVo8mPU2R1OSv65oSZ+
         9QgBXQddMW3mk3tS3Ll+IokFilz1oZEHgYBBLVirbmiEaT8lTm/xK05K2nIGW7y0bhMi
         p90UjrVFGsHpu8AtZPKzUzX+6FmHoiLE/0M7eYEvo75yhymuTeENMad19ONFXjQIoQru
         OL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLZY3Sd6DDGE5joHgpmfGnelFUF6+QJCShZ+OVnG2QM=;
        b=WywVK6GieG7LAZz7J3Jsj0ld2JmauvNHaVTv4BXPokoGLcqH3OP9WtMjBkR4Of1L05
         owlORndDzjsELEHCmDKdWUK7GnPH7jTzl9uezEtuZLiIE8kl3Gz3T6EAOlKRXHxGihlv
         ibrbGsKExNwUGutgSlgkbtgtF7Z6z3RjYPLclMqFhrIso6F3Xmhdo6c55LY3iNFx4Z4M
         ADCAWh7y60Hobq1IF/ZOkJd0jRuZ5c1b0HQI+H1WDeVYwNTXwI75BpMy0EzoH43d2Tf9
         yJAmrZKEm5eiD+gRQLpHLPvddf3a8PR8kFjCDCut2BYUKGHRO3jmmThRaFVJ/iwdSPjb
         q82g==
X-Gm-Message-State: APjAAAVoA1vxALY8DRe4MO+f0pGneP9t5UQEgfcmVVh79N8i4GZcpfev
        iiYZ4rO6vSDxk25uOr1BOFk=
X-Google-Smtp-Source: APXvYqyG5zmwU7+iy9vy9MgjqnK8DD7/cuk0LHTB/8KRO1+5OL50MZ/jgw46cpJFbC79ORKv8DM17A==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr14543418pgq.101.1567889829462;
        Sat, 07 Sep 2019 13:57:09 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id z13sm16554322pfq.121.2019.09.07.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 13:57:08 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v4 5/6] rebase -i: support --ignore-date
Date:   Sun,  8 Sep 2019 02:26:47 +0530
Message-Id: <20190907205647.11011-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-6-rohit.ashiwal265@gmail.com>
References: <20190907115034.14933-6-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat,  7 Sep 2019 17:20:33 +0530 Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> [...]
> +test_expect_success '--ignore-date works with rebase -r' '
> +	git checkout side &&
> +	git merge commit3 &&

Should use --no-ff option to be sure that it handles "merge"
commits properly. Same for [3/6]. Please Junio change it while
applying the patch.

> +	git rebase -r --root --ignore-date &&
> +	git rev-list HEAD >rev_list &&
> +	while read HASH
> +	do
> +		git show $HASH --pretty="format:%ai" >authortime
> +		git show $HASH --pretty="format:%ci" >committertime
> +		grep "+0000" authortime
> +		grep "+0000" committertime
> +	done <rev_list
> +'
> [...]

Best
Rohit

