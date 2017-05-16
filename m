Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E6B201A4
	for <e@80x24.org>; Tue, 16 May 2017 09:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdEPJGf (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 05:06:35 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35005 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEPJGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 05:06:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id n23so72195163pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OelysulNHDtQUzEpgo4En6dBI0DIVFkWvJUvdWqr6u0=;
        b=FwLYl7uy8cp+nK3bDAuTcPxa7RRdGtdWtioIUIVyUYi1TSGoKutfUn+RwwoGrj5vZL
         qZja+tPj2EWE4K+d7F7VSO0yACWEQjoTAD3PZUUjcRu4DdBuunorMZWuhTCOscWute1Z
         B07Ff0Eg5B2EgCTivMBY78NTzihi5iqJ5KVA7W4aP4te2XDzn6m7gh5jvDGPyNWo942n
         /9y68rBYByfUTyaFEYGkUW+3/W16NQZE/JlgOHTSaq9okjVysnxgjvzqEiGEOl/ofGkl
         DfEWlR/VAZjd8oFZ2MmOGPEiPVq5q92nS5Zd8QKa+sj7FRyI7ECW7TQ+ehOXa4MySbQj
         1rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OelysulNHDtQUzEpgo4En6dBI0DIVFkWvJUvdWqr6u0=;
        b=ZhQ5Btw2i3JIDC2aHPtsGBMF0LqKhsAZFxQhhMqYQb7LwKvpkBpBbESFpx72xSPoIZ
         ZuaWKppXnxJVuwRqIOaHqRur/MqKM3tYYnJp26y2rfBy6F6uZiz0G80ORMI3dU7p91TJ
         g4NuuETE1I+iJv2DLNidYKXV9CbrLV3WP3sbgjfrIw3iw0GbDLFfKARw6rwS4lSwo5Cz
         zWBOp+yCnBpgbovj7uJXA2uiL2dmtI/DfibyVBfieGhGna/6WzVREgAkX0jXFduGx1CN
         BiFSqvUllxKmwKxdXEkyli8zjOAVoG6gyoItmIBGojdf0ggH16YwLGh5fQGR+igdszu/
         rdxQ==
X-Gm-Message-State: AODbwcCZBnG8Xgqveh5dmQ6oXP2WTUSQ9uxko+OWZBFyrMHM5CJhOko1
        FCtcYfCfyiCt9Q==
X-Received: by 10.99.124.68 with SMTP id l4mr10907521pgn.175.1494925591400;
        Tue, 16 May 2017 02:06:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id o10sm27436763pge.67.2017.05.16.02.06.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 02:06:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
        <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5EXxsB3TWiiB0TH-ZpOsadcAPAe4chrQBe7py9VAMY+Q@mail.gmail.com>
Date:   Tue, 16 May 2017 18:06:29 +0900
In-Reply-To: <CACBZZX5EXxsB3TWiiB0TH-ZpOsadcAPAe4chrQBe7py9VAMY+Q@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 16 May
 2017 10:05:09
        +0200")
Message-ID: <xmqqh90l188a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This and many other discussions on-list basically come down to:
>
> 1. Someone wants to change X.
> 2. This would have user impact Y.
> 3. We have no way to quantify Y.
> 4. X doesn't happen out of fear of unquantifiable Y.

You forgot the step 0. You need to answer two questions: "Is
changing X necessary?" and "Does that necessity outweigh the
inconvenience caused to existing users by the deprecation flow?"

You need to answer yes to both before you even consider going into
the later steps.  Once that happens,...


> It seems to me that a way out of this that would make everyone happy
> is to go through some deprecation cycle through several releases with
> X where:
> 
> 1. We detect that you're using X, and warn that it's a candidate for deprecation
> 2. In another release, we turn off the feature by default, threatening
> that it's going to go away forever unless someone pipes up (this is
> what we did with rsync:// accidentally)
> 3. In another release, If you turned on the feature after #2 we emit a
> noisy warning every time it's used, saying "it'll really be removed in
> $release+1"

... the deprecation practice is very well established around here.

In this case, however, we haven't even seen the first question "Is
it needed?"  answered "yes", let alone "Is it needed enough?".
