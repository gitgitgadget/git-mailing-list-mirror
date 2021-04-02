Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D1C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B383360FF3
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhDBLqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:46:13 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:41179 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhDBLqM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 2 Apr 2021 07:46:12 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2021 07:46:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1617363637;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=idpO6eBpimlk7Q6XKocdk5FnqWkMNGsGsfK1NsbOvnK6H2pm14h54hTH5tlchZ1Cz
         KppwxjQNMH/H13J51Z5masUTBlgQYqw/E4CnnDotmPJT+z2+7ZdKhEqNBHuQj7UKD9
         i2tA+epA+ofE9IzyN6bgbonKmHzb2b5H+/K2Okf6W2L+WKY3kv0wrdZL8llTNrtry1
         /vcC8tbgPkv8jw4jym0jcbyxKujZ8up8atdt/JZAjVBZsq7Ez3cMCnm3iGQWc4Z89p
         KJ3mSTVuctINyXA+bVUixPk8tErc7zU3gmMrhxH2RqpG/sJvU5EGbCtrcatezQyWpT
         1Yc4Rb7tuRg2w==
Received: from [172.28.142.96] (unknown [206.81.7.194])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id A0EEA7006DC;
        Fri,  2 Apr 2021 11:40:36 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Gabriel Young <wezeyf@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 2 Apr 2021 07:40:35 -0400
Subject: unifying sequencer's options persisting, was Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and revert messages
Message-Id: <B1AB25A2-36C2-474C-8EA0-9FECC99EE0BB@icloud.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, newren@gmail.com,
        philipoakley@iee.email, phillip.wood123@gmail.com
To:     johannes.schindelin@gmx.de
X-Mailer: iPhone Mail (18D61)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_07:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=370 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2104020086
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
