Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BB7203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcGXKME (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 06:12:04 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35536 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbcGXKMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 06:12:03 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so103248995wmi.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 03:12:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/qBMdpnuW0E1N4oX2BI9D5sGaKwwJijHKu/gBD+wYyk=;
        b=kiBdUOL1TouCBGkJ0g0c4pvxhB366CzSzpkVW/Zs8Hu4W3o9CCoinVzOCXNMTxx2M6
         mEMchEt9idOROqi0mtr1u2v0I/lBBeV5ql8/h786DMXY7GycVhq1APjNmbiIITp4G1Ml
         EgUNrhfGDkiaW/Il6NpRJ4ppQ5zzCNlei9l+77VEkiSoWlvwvNg+UhDg7EP2A1Efxs5s
         ftScWVCj7ydqSggz/QCyOoEnH/rOh8mV4vmCy9feWCMMPOuVtIRDxMsPeJlRXilTMHYQ
         AsbSgq1bsAs0emfys6z7cyUz6kXwNW7UwNPTaG1G4jn7emKef+o6EShsQ8v1vtzwPUw2
         ZVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/qBMdpnuW0E1N4oX2BI9D5sGaKwwJijHKu/gBD+wYyk=;
        b=J2hlMnFieF2VXqYSNcFMnb5/BI7alwql1ZYgZBNlL2VikYUGUE1rfvITtBLoKhEq3m
         yJv4Lx3/H1LUix+IGP1QPvxle/Qu9FIMDJmmrAr512Z1/euf66jkqganGBQW24z5xOeN
         wNA9BhKszaaMF8SHh2Vb58YzujCCk0Wu/4VppUIuJjo1ND3wJbsKCR//fdzqxLdu6t6G
         S1Y+T2MBR7uf44+gd4fofilHmmh1KaYmdjJH4xjRP5EnV7BBQwpYMVA/XDV+DnBvKY3W
         DFbmZ/MW4GlqgfYV3UbGmRNSH/lmg+8tjfu45YGByWYbaIYW+9Tn62AfOAoqiUzctv0i
         oxBA==
X-Gm-Message-State: AEkoousIw1X4B9lu+nnrJ+6hsMhsDaCB2Ck/8MhyFQA32o/ylnaaAU/E+XHM/k+ncY1Iqg==
X-Received: by 10.28.225.4 with SMTP id y4mr14866597wmg.98.1469355120762;
        Sun, 24 Jul 2016 03:12:00 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id c131sm21190359wmh.1.2016.07.24.03.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 03:12:00 -0700 (PDT)
Subject: Re: [RFC 0/3] dumb HTTP transport speedups
To:	Eric Wong <e@80x24.org>, git@vger.kernel.org
References: <20160711205131.1291-1-e@80x24.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57949467.60904@gmail.com>
Date:	Sun, 24 Jul 2016 12:11:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160711205131.1291-1-e@80x24.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-11 o 22:51, Eric Wong pisze:

> TL;DR: dumb HTTP clone from a certain badly-packed repo goes from
> ~2 hours to ~30 min memory usage drops from 2G to 360M
> 
> 
> I hadn't packed the public repo at https://public-inbox.org/git
> for a few weeks.  As an admin of a small server limited memory
> and CPU resources but fairly good bandwidth, I prefer clients
> use dumb HTTP for initial clones.

Hopefully the solution / workaround for large initial clone
problem utilizing bundles (`git bundle`), which can be resumably
transferred, would get standarized and automated.

Do you use bitmap indices for speeding up fetches?

BTW. IMVHO the problem with dumb HTTP is the latency, not extra
bandwidth needed...

Best,
-- 
Jakub Narêbski

