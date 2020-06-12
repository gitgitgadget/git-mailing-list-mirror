Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA5CC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F13D20801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFLNiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:38:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54076 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLNip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 09:38:45 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jjjtL-0004jk-Fh; Fri, 12 Jun 2020 14:38:44 +0100
Subject: Re: [PATCH 2/3] git diff: improve A...B merge-base handling
To:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
 <f7c8f094e02406a7d0cb0c61f880e5b01fa413c4.1591661021.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6eadaa89-fde7-4224-dcb9-ceef315942f2@iee.email>
Date:   Fri, 12 Jun 2020 14:38:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f7c8f094e02406a7d0cb0c61f880e5b01fa413c4.1591661021.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2020 01:03, Chris Torek via GitGitGadget wrote:
[snip]
> +test_description='behavior of diff with symmetric-diff setups'
> +
> +. ./test-lib.sh
> +
> +# build these situations:
> +#  - normal merge with one merge base (b1...b2);
> +#  - criss-cross merge ie 2 merge bases (b1...master);
> +#  - disjoint subgraph (orphan branch, b3...master).

nit:
Use of b1, b2, b3 here, but br1, br2, br3 below
> +#
> +#     B---E   <-- master
> +#    / \ /
> +#   A   X
> +#    \ / \
> +#     C---D--G   <-- br1
> +#      \    /
> +#       ---F   <-- br2
> +#
> +#  H  <-- br3
> +#
Philip
