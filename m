Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B093F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeA2VbP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:31:15 -0500
Received: from mx4.wp.pl ([212.77.101.11]:48945 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeA2VbO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:31:14 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jan 2018 16:31:14 EST
Received: (wp-smtpd smtp.wp.pl 25385 invoked from network); 29 Jan 2018 22:24:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1517261073; bh=VXfwCMz8oNl/+/ywkknbppFAvrTo+SEoDj9VU3aL66o=;
          h=To:From:Subject;
          b=IuZHEcYFZZHgGwdeVQ4ZN+kSEp7Q5FNT02/nmO6JrInQsEkMlJK8z1iVZO3B+ykYE
           P7bCq1i6X3QdMSzHKyoUcYs1617CZZR90WJc2SjdQ1ARupxi2QYQAWgtqqwrSBEMQB
           1Fq/nNnm2cdkuPWws7rQGpfFQtyF/ywMyXNlsC74=
Received: from public-gprs350495.centertel.pl (HELO [192.168.0.103]) (borucki_andrzej@wp.pl@[37.47.0.96])
          (envelope-sender <borucki_andrzej@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with SMTP
          for <git@vger.kernel.org>; 29 Jan 2018 22:24:33 +0100
To:     git@vger.kernel.org
From:   Andrzej <borucki_andrzej@wp.pl>
Subject: How juggle branches?
Message-ID: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl>
Date:   Mon, 29 Jan 2018 22:24:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: pl
Content-Transfer-Encoding: 7bit
X-WP-MailID: 2509b2ca559cebc979e13532199006be
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [cSJw]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, I develop program which uses mysql in branch master.
Next i change name this branch to before_hbase, and began develop HBase 
in branch master. I also develop before_hbase.
Now, instead HBase will be MapR-DB which will before_hbase , not master 
succesor.
How do:
- change before_hbase to master
- old master to hbase
- develop MapR in mapr branch
?
I am in master branch and am changing to hbase:
git checkout -b hbase
git push origin hbase

now worse:
I am in branch before_hbase and need change to master
git checkout -b master  - not works because master exists

I must use rebase? I hear, that rebase can be used only in private 
(.git), not github repositories.
If I change to master and copy files and next commit - change will not 
atomic.
