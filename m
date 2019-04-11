Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567FB20248
	for <e@80x24.org>; Thu, 11 Apr 2019 11:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKLKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 07:10:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKLKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 07:10:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so3305248pfc.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=jfYZoc7uFIKrnZga2UsawN6f6Cn23kTOx8qsALUEhoOFu61sVWfPTkabiPZF2wS2q1
         /Yr1sBBE3F50cdflNcN8xFecTOys0VMMHA1UrHB5sU7/z0TUkxHizudPZK6Wdh1JYNcs
         +051Qdj/mkno2dFP5UQJ2r5aNUBexqcYDmGK2z4O0Xuq2kKGvnNpgmfxRFsNr2eAu+DN
         2dq20a8V3uImz3roZB3hhwbrBEAZ9S4uZ1S9bC4mXA2xoDeGrBtQAw72sV++EQknrncv
         /PzdpWx9f4f3GLKFBiBU4WsO6ehxDPzadJmdyyEQx5aeOpE4aFmI8y7bebH9nqhR97Eb
         FPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Zrev4VodpS82Hzc98p86IfPx1+t8KJGfaS85U0P63O5ftsbiT2V4C4QB2nY1HxQItq
         H3CiRGw73RK4gIL1fdGlsYeaL1vTqD4L0wXTYh7MOvG/je2XxOpTQVya8Ni03s02hW+s
         Q2+mSzywrBZXC8nEfzqWo0PUK9PFCXU17voqIFjCBgaKgBgx6NUUYE5MamftJd+sgn5v
         b1cc+xlPTiEUFt/uEo2XpvNRg1xWRpKOx5SK4tqk7M9X9Z9l0LXKUFZ0bHwCqYvH7ciN
         SWm3CL7W72GiGtiI+vTWRVhymoAFSTm+UbwHqxCFwyYaH+7F0v2ner53wKxcWOzYFnP7
         gkXA==
X-Gm-Message-State: APjAAAUhH2LY9qoA9dOwtc2cXZAfXmyeNIrJVRJhaIDZ9CTfUZl+CAB0
        inYtHh3q/mMK8pjk+8ZmcRGLgoru
X-Google-Smtp-Source: APXvYqwCn/ZkR7Q6yQIMlCA5T7L0csXBo0PPPvdEXJvaeGUFQn+E2NzpwbvnfdkpSQ647FM+BOQw9Q==
X-Received: by 2002:a63:da4e:: with SMTP id l14mr44342504pgj.96.1554981044114;
        Thu, 11 Apr 2019 04:10:44 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id n1sm43499044pgv.19.2019.04.11.04.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:10:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 18:10:38 +0700
Date:   Thu, 11 Apr 2019 18:10:38 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
Message-ID: <20190411111038.GA5620@ash>
References: <20180116103700.4505-1-pclouds@gmail.com>
 <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


