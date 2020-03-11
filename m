Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD687C10F25
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 07:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DD9208C4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o4FkWUeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgCKHfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:35:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38864 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgCKHfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 03:35:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02B7Zc7J060077;
        Wed, 11 Mar 2020 02:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583912139;
        bh=KKk06n13LWpPxYhCxXmsr7f7PFG7xRzorRZ7feMKG8Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=o4FkWUeuDFKWK3ck5IWsdRaBOeeM/0KSQ6zclT4O4t67iVNxljhngfOabbWn5r4nn
         3XuYa/0mZRxi7JL4N8U0Xaq0VzVV4U0MjgR1kzVvUKNziS4Z+XNAbLnAulQFA4+WTI
         mT6K/4J80DZFh4hict5UDf4Zk+r7URN81fGi4KF4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02B7ZcNR038082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 02:35:38 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 02:35:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 02:35:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02B7Zbol081383;
        Wed, 11 Mar 2020 02:35:38 -0500
Date:   Wed, 11 Mar 2020 13:05:37 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
CC:     Git List <git@vger.kernel.org>
Subject: Re: gui: error "missing close bracket" when doing a reset
Message-ID: <20200311073535.nwde2ujbsrslmggo@ti.com>
References: <CAGr--=L9nEfX1c6DnaqQHqNMh9Ci=q=dMZLE_gpgyoneBcJ_Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGr--=L9nEfX1c6DnaqQHqNMh9Ci=q=dMZLE_gpgyoneBcJ_Kw@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/20 04:52PM, Birger Skogeng Pedersen wrote:
> Hi,
> 
> The last couple of times I've done a reset in git-gui
> (Branch->Reset...->Yes), the repo is reset but I get an error message.
> The message header says "Error: missing close-bracket". Error message
> is as follows:
> 
> missing close-bracket
> missing close-bracket
>     while executing
> "set status_bar_operation ["
>     invoked from within
> "if {[ask_popup $op_question] eq {yes}} {
>         set fd [git_read --stderr read-tree --reset -u -v HEAD]
>         fconfigure $fd -blocking 0 -translation binary
>         ..."
>     (procedure "merge::reset_hard" line 28)
>     invoked from within
> "merge::reset_hard"
>     invoked from within
> ".#mbar.#mbar#branch invoke active"
>     ("uplevel" body line 1)
>     invoked from within
> "uplevel #0 [list $w invoke active]"
>     (procedure "tk::MenuInvoke" line 50)
>     invoked from within
> "tk::MenuInvoke .#mbar.#mbar#branch 1"
>     (command bound to event)
> 
> (end of error message)
> 
> Does anyone else experience the same issue?

I fixed a similar issue in 6b9919c (git-gui: add missing close bracket, 
2020-02-17). Do you have that commit applied? You can pull it from [0].

If you still have this problem even with the commit applied, let me know 
and I'll take a look after I get off from $DAYJOB.

[0] https://github.com/prati0100/git-gui.git

-- 
Regards,
Pratyush Yadav
Texas Instruments India
