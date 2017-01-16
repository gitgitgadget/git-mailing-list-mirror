Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0736120A17
	for <e@80x24.org>; Mon, 16 Jan 2017 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdAPWot (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 17:44:49 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:33559 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdAPWor (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 17:44:47 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id TG14cVpImgKstTG14ckeYW; Mon, 16 Jan 2017 22:44:43 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=5rxgeBVgAAAA:8 a=xtxXYLxNAAAA:8 a=s-AkO8JaRkloYrdsGIsA:9 a=wPNLvfGTeEIA:10
 a=Bn2pgwyD2vrAyMmN8A2t:22 a=PwKx63F5tFurRwaNxrlG:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <F9099DB3F0374D898776BD2621BF36FA@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Cc:     "Pat Thoyts" <patthoyts@users.sourceforge.net>
Subject: [RFH - Tcl/Tk] use of procedure before declaration?
Date:   Mon, 16 Jan 2017 22:44:43 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfLGBGDqI3nT1x6oFuENSHolDWuBwwjk6XMVxdfgTR9T52mhemvo6clumaYZylAGD9Mg8ZGq/ETL581GtgCzKX6Aobt1/SfNWgVbbzI8cZiADQqkdg2gW
 Tc8+hYsLUpFYt5S96pnEo5thZtLS3miEqtI73AAgbS4Ra6Ak5SrvfC1Mbq//WJIU4QUKHZR3F+EuLnyGEVk8l8xw/w4VRKjZ8bg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking into a user git-gui problem
(https://github.com/git-for-windows/git/issues/1014) that I'd seen in the
past - I'd started some patches back in Dec 2015
http://public-inbox.org/git/1450310287-4936-1-git-send-email-philipoakley@iee.org/

I'm trying to make sure I have covered the corner cases correctly, and I'm
not sure if the current code actually works as advertised.

In
https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L242
the procedure `_unset_recentrepo` is called, however the procedure isn't
declared until line 248. My reading of the various Tcl tutorials suggest
(but not explictly) that this isn't the right way.

Should 3c6a287 ("git-gui: Keep repo_config(gui.recentrepos) and .gitconfig
in sync", 2010-01-23) have declared `proc _unset_recentrepo {p}` before
`proc _get_recentrepos {}` ?

--

Philip

