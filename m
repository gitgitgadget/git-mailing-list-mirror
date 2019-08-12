Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2087B1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 21:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfHLVtG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:49:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47927 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfHLVtG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Aug 2019 17:49:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E2A4E21BF9;
        Mon, 12 Aug 2019 17:49:04 -0400 (EDT)
Received: from imap29 ([10.202.2.79])
  by compute2.internal (MEProxy); Mon, 12 Aug 2019 17:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailc.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=XXQ8uU6Cs1gClr64eraiEvMkgCBr44t
        TBPZsxIr890c=; b=Wrp10Cy/Fl8EcsNIIf9qprNw7/RqdKxm0xOK/+645H8By9M
        X4kJv+ti/YqiuPhuC0mJ6ihUD7ue7JnUGc30ZAiaXuQfPBMSGPqIlspjVSeNonuZ
        WVq4ycIlLsg+6sqEGkL82lmg/EfVKJBs9DAnf3v6l1Mry19J8HsDCoIYuTPpXDxd
        KK4Dg2TMDWD/KwLLTW8stysm9ncf/IknaY9tZQfE17CwFEVxjFT+/hp5DE5I+RQs
        LO1Or5xybuiNtz1hAGV6tB4a2DQ8PXV2yWlzjs63NaAhYUJ/VfxI99LBtqUrYOrk
        Q8c5Ul2Xbudz7o496zR6dyDWfDNkVpOcNDzJDsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XXQ8uU
        6Cs1gClr64eraiEvMkgCBr44tTBPZsxIr890c=; b=0Jsu6qFC1etey+015Ytr4j
        PKt4Mu1sHRF2p58Hf7nIB6s7FHqTC0ng40K98hwXJe5SJcLM93by8yJ0STbBBtuv
        ESk8pvwzJH66no3wMy3/zu/HqjHlmflK1I4PZBnC3bVfZRqQyNxs8JkeyCKiPmXq
        QL4AlHygtfLJIT+kjfRMdgpshB7E2ExvtLFKfu+D2dPiNMnsO2z2uKBP61h0xdJt
        3z3IEI545K78lFKNp/HrILFTUlg9PBszeA7IFl1XvGSWWArGtzAOt8weRJwxwKzq
        /3aY+xejDr7i857gHVVxu62qK7I9iGrRp1TXIj4PaVgUQf3+ifh+J+JOz8vmSMyA
        ==
X-ME-Sender: <xms:0N5RXRe8QHIDza_0vBkMMQ2ARg9bIbzI33ZRs9WT2VtCDhJmdcG3ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepkhhoohgt
    rhesmhgrihhltgdrnhgvthenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrrhgthh
    hlihhnuhigrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkohhotghrsehmrghi
    lhgtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:0N5RXeX6S-77jBoMCdDROj2gNkGWb769Q42Askvlf3U6FbghQuLZtA>
    <xmx:0N5RXfijXZXtgKCUkDknewVC0oQMKex9tFizXfUPqfU5i2dQWQ2Log>
    <xmx:0N5RXaiz04wKtx3G9OFz39Aq-NaVC_dSH8qHyEaRcx3Tz8fKWd6cVw>
    <xmx:0N5RXcL-yihihWoCUaAtG5uKF42x4rUa9KKgyn35L2bD8Vgltbdc1A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 41D2D9C009E; Mon, 12 Aug 2019 17:49:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-809-g8e5c451-fmstable-20190809v1
Mime-Version: 1.0
Message-Id: <61e897e6-ec5d-4973-b3e0-8e7c997b7bc6@www.fastmail.com>
In-Reply-To: <20190812191610.GA24499@chatter.i7.local>
References: <88cc039d-2bf8-4c1d-90c4-486ff661c1e9@www.fastmail.com>
 <20190812191610.GA24499@chatter.i7.local>
Date:   Mon, 12 Aug 2019 14:49:03 -0700
From:   koocr@mailc.net
To:     "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: How to get gitweb setup with nginx + uwsgi?
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 12, 2019, at 12:16 PM, Konstantin Ryabitsev wrote:
> We have it working in a similar configuration, but with CGit instead of 
> GitWeb. Unless you have specific requirements to run GitWeb, I recommend 
> you use CGit for your web frontend, as it offers many features GitWeb 
> doesn't, such as caching -- plus it works really well with uwsgi 
> (git.kernel.org runs in that configuration).


Didn't realize that!  

I'd picked gitweb in the first place as I figured, being part of git, that kernel project would be using it.

Clearly I'm wrong.

Switching to CGit now.  Thanks for the suggestion.

I don't use Arch (Opensuse User), but am trying to follow their CGit + UWSGI + Gitolite docs:

https://wiki.archlinux.org/index.php/Cgit#Using_uwsgi

Since my distro pkgs have different paths, systemd setup, etc. having some challenges getting a everything-working-together config setup.  That'll just take some reading and staring ! ;-)

If you know of any other good examples , please share :-)

TA!
