Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74F71FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 07:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbcFPHeH (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 03:34:07 -0400
Received: from edge02.zimbra.com ([162.209.122.184]:58897 "EHLO
	edge02.zimbra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbcFPHeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 03:34:06 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jun 2016 03:34:06 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edge02.zimbra.com (Postfix) with ESMTP id EE918A6358
	for <git@vger.kernel.org>; Thu, 16 Jun 2016 02:26:55 -0500 (CDT)
Received: from edge02.zimbra.com ([127.0.0.1])
	by localhost (edge02.zimbra.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id thdGBCIXo5QY for <git@vger.kernel.org>;
	Thu, 16 Jun 2016 02:26:54 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edge02.zimbra.com (Postfix) with ESMTP id 55C65A6359
	for <git@vger.kernel.org>; Thu, 16 Jun 2016 02:26:54 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 edge02.zimbra.com 55C65A6359
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=zimbra.com;
	s=C2AA288C-EE47-11E2-9BB0-E820BDD9BDBF; t=1466062014;
	bh=XhLc5VG+7ISORKeSt1Cb/oA/9tMI/VmWc9a3iV61Vx0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=XpgmjLYNGG9BTUV0EBbskZ0Q9ftsxkdNBXnNeYTiDF/1kdbDc0LdUls20MMZx0xdV
	 /2E1YdQCVFcca+DTrxolR6oDgoovOdAzLS4WHuDY2VpWxYmCRuwvwrVMaVUXlyoMSw
	 F5ES0LcwtR+ClJmhbFyYsSXRvdpzRCpLEbYhFpDk=
X-Virus-Scanned: amavisd-new at zimbra.com
Received: from edge02.zimbra.com ([127.0.0.1])
	by localhost (edge02.zimbra.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bviu6OLYZmc9 for <git@vger.kernel.org>;
	Thu, 16 Jun 2016 02:26:54 -0500 (CDT)
Received: from mbs01.zimbra.com (mbs01.zimbra.com [10.110.0.177])
	by edge02.zimbra.com (Postfix) with ESMTP id 3C267A6358
	for <git@vger.kernel.org>; Thu, 16 Jun 2016 02:26:54 -0500 (CDT)
Date:	Thu, 16 Jun 2016 02:26:54 -0500 (CDT)
From:	Shrikant Prasad <sprasad@zimbra.com>
To:	git@vger.kernel.org
Message-ID: <1421824581.98623.1466062014054.JavaMail.zimbra@zimbra.com>
Subject: Issue with subtree split in git version post 2.7.X on MAC
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.0_RC1_1601 (ZimbraWebClient - GC51 (Mac)/8.7.0_RC1_1601)
Thread-Index: 28FGu4mHg9w3e2BsJQrtZI8YIZvBGw==
Thread-Topic: Issue with subtree split in git version post 2.7.X on MAC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I am trying to extract part of larger git repo to create a new smaller repo maintaining al the history of the extracted portion. For this I used git subtree split command.

Following are the steps followed: 
1. git clone of full repo in 'full_rep' dir
2. Initialised new empty target repo: 
    mkdir new_repo
     cd new_repo
     git init

3. split the desired subtree into a new branch:
    cd ../full_repo
    git subtree split --prefix='folder_name_to_be_extracted' --annotate="(split)" -b new-repo

4. pull the new branch into the new empty repo: 
    cd ../new_repo
    git pull ../full_repo new-repo:master

5. check size of the new repo : du -sh .

With git version 2.8.4 on Mac EL Capitan OS, size of repo is coming out to be 117M and also the history of new repo is not specific to the extracted portion only. Its containing commits from different folders too.

Whereas with git version 2.5.5, size of repo comes tout to be 9.5M and history of new repo is correct, containing only extracted portion commits history.

Please check if there is some issue with git version 2.8.4 on mac while running subtree split.

Regards,
Shrikant Prasad
