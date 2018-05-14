Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36461F406
	for <e@80x24.org>; Mon, 14 May 2018 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeENRgG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:36:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeENRgD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:36:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD5956085F; Mon, 14 May 2018 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526319362;
        bh=GCdehIr3hHoHbesppss/hd6I7yLhERZ5p9dKebi4CgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJ2UmTZGoz3bu2dshXkh52x/WSeJw4l1Bm7Kq2B7XBPDl7F6bJIitME6X1vboNBrU
         qZh4xyKmcVgjzIcoNzfXhGZGjk9J/+PyqDTIP9R7rgaAVh6xDMRuZx3aM1p1xbMpy+
         PNfEJPtgGaMwkIv1YsFRPFXys+CYntfS3TcWKu04=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 629606055D;
        Mon, 14 May 2018 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526319362;
        bh=GCdehIr3hHoHbesppss/hd6I7yLhERZ5p9dKebi4CgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJ2UmTZGoz3bu2dshXkh52x/WSeJw4l1Bm7Kq2B7XBPDl7F6bJIitME6X1vboNBrU
         qZh4xyKmcVgjzIcoNzfXhGZGjk9J/+PyqDTIP9R7rgaAVh6xDMRuZx3aM1p1xbMpy+
         PNfEJPtgGaMwkIv1YsFRPFXys+CYntfS3TcWKu04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 629606055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     "Barodia, Anjali (Nokia - IN/Noida)" <anjali.barodia@nokia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git push error due to hooks error
Date:   Mon, 14 May 2018 11:36:01 -0600
Message-ID: <5444972.XKqSDWe6bT@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <AM4PR0701MB21165697A8485CA4B42ADFFB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
References: <AM4PR0701MB21165697A8485CA4B42ADFFB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, May 14, 2018 05:32:35 PM Barodia, Anjali wrote:
> I was trying to push local git to another git on gerrit,
> but stuck with an hook error. This is a very large repo
> and while running the command "git push origin --all" I
> am getting this errors:
> 
> remote: (W) 92e19d4: too many commit message lines longer
> than 70 characters; manually wrap lines remote: (W)
> de2245b: too many commit message lines longer than 70
> characters; manually wrap lines remote: (W) dc6e982: too
> many commit message lines longer than 70 characters;
> manually wrap lines remote: (W) d2e2efd: too many commit
> message lines longer than 70 characters; manually wrap
> lines remote: error: internal error while processing
> changes To ssh_url_path:8282/SI_VF.git
>  ! [remote rejected]   master -> master (Error running
> hook /opt/gerrit/hooks/re    f-update) error: failed to
> push some refs to 'ssh_user@url_path:8282/SI_VF.git'


This is standard Gerrit behavior.  For Gerrit questions, 
please post question to:

Repo and Gerrit Discussion <repo-discuss@googlegroups.com>

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

