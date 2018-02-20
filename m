Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A751F404
	for <e@80x24.org>; Tue, 20 Feb 2018 12:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBTMmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 07:42:42 -0500
Received: from mail.javad.com ([54.86.164.124]:34093 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbeBTMml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 07:42:41 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 0DA1E41736;
        Tue, 20 Feb 2018 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519130560;
        bh=p7jXR+NjXE2D4Jj/qYNPRY+nLY/rfaTSLp1TC3Q2OBA=; l=973;
        h=Received:From:To:Subject;
        b=S3zx5/LoLBPCIWcPFFhE54U9px+rZepK880FvLMUmttIgrBEPl8soBIG9VV/ijHrW
         G4Nqr9Pnvwh1fFYXjAoKW+Zigp4AGYq9fG8YIraH1DGXLeo6slRUYK8QK2Oa3VNVX8
         GRFpfIX2mfPF7aJptOPU70YwiPvM2/TWtrUwH55A=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eo7Fm-0005fE-AC; Tue, 20 Feb 2018 15:42:38 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
Date:   Tue, 20 Feb 2018 15:42:38 +0300
In-Reply-To: <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> (Igor
        Djordjevic's message of "Tue, 20 Feb 2018 00:44:52 +0100")
Message-ID: <87woz7ltmp.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>

[...]

>
> Even though this behavior is known and documented, it still left some 
> to be desired.
>
> Might be I`m missing something, but so far I like how described 
> approach just "feels right" (to me, for now), being really simple, 
> yet robust :)
>
> As my humble contribution to the cause and discussion itself, I`m 
> providing possibly naive, yet simple demonstration script[1], and 
> clearly showing where current `git rebase --preserve-merges` is 
> lacking (in my opinion, even though being expected and documented), 
> and how your proposal seems to improve the situation here.

Thanks for the test-case, -- it's nice to see this thingy working!

>
> Thanks for your thoughts, and hoping to see this going somewhere :)

So do I. Even if nobody volunteers to adopt it, I hope I'll be able to
implement something myself, not very soon though.

-- Sergey
