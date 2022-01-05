Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69157C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 19:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiAETJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:09:22 -0500
Received: from avasout-peh-004.plus.net ([212.159.14.20]:42627 "EHLO
        avasout-peh-004.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiAETJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 14:09:22 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id 5BewnEGnHNOux5BeynoGuY; Wed, 05 Jan 2022 19:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1641409760; bh=p9Net1kZIcVsUbBN9hh0q9hWYw4yg3n599FpdD+3YsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=awfqOnvmDn9Oup56dHDv1mrrl/vtMgIDuxI7fKp7ybXHkrA+uhj2qJFdCVG+jiC1G
         MHcea1zaxm5r38Sken4PL99xoEGi2I16SrBvlwCAWACZEaISAt+VFXxgfYBbkFNNsk
         1xk6JqGr1LKinQL+UDmygcPOmOa33KIFSL/FVcvt1EZUCatOPReGxtU/3E1NcjudZi
         qaI/MLM7ghwwZn7l95ogPE+F+nUWS1UMLyhqgtgYb+dLRo5/anVReLBSfTOoEvWE1R
         hoiUCwhCgNpsXMjgvjtfR9vMXg09e9iUil/Ago64p+vGo0EnK1/ieejgVtf6u8ajo7
         KcwrXfCEDNK2g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HPCgqqhv c=1 sm=1 tr=0 ts=61d5ece0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=G5aqB98_fJxbKHdf:21 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=vroiPa1q9aPkxjqO7sQA:9 a=QEXdDO2ut3YA:10 a=96ywRkUKQPOUfH189dDB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
 <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ed528125-a2bb-9445-80c5-8c2994ef0d56@ramsayjones.plus.com>
Date:   Wed, 5 Jan 2022 19:09:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAw6Mge1AmWA1Jq9eiJG1Be72ZiMUg43ncotwDnliLKZysTwBfm25IEtzV6c6c2rjLKzaSMwI1Cb/DwKnAKN6NY/+n3X6IpoL9f+JXWIPM76yjFHwad+
 7o/uBVdie/sqjbagnqX7kZmmfIhCmdG5Cq7O63rcX37gNnghRUX9yCvhzQpacsDVeOt0K4k7selNahpuvrqpEpvufV13ORr7Yr0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/01/2022 17:27, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Callers of `git merge-tree --real` might want an easy way to determine
> which files conflicted.  While they could potentially use the --messages
> option and parse the resulting messages written to that file, those
> messages are not meant to be machine readable.  Provide a simpler
> mechanism of having the user specify --unmerged-list=$FILENAME, and then

s/unmerged-list/conflicted-list/

ATB,
Ramsay Jones


