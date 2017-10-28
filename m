Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37D0202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdJ1Ly3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 07:54:29 -0400
Received: from mail.resplendentwebservices.com ([192.232.194.124]:38805 "EHLO
        mail.resplendentwebservices.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751029AbdJ1Ly2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 07:54:28 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Oct 2017 07:54:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=resplendentwebservices.com; s=default; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MV+05Lw4dSCeHGyiz5Gikwuy4msyNWAxnKU/IWBjXTI=; b=CNiqMQsgirwZLWtIBTDk7IZWQ
        GQE92sN0wQHLQEp0/p2xj2kCNiYGY8l4DQImD3QP6LmvTujcIGKd/i24+t8TJINPPlzhdoQMrQA/z
        jpGei+IJd17GVaK88gzxwIUTMR6EVg8MZFARAhqY0XhuFmQqJ0TbL+AMNqDQVIBFK2874=;
Received: from cpe-174-104-112-166.neo.res.rr.com ([174.104.112.166]:59325 helo=[192.168.132.102])
        by mail.resplendentwebservices.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <jim@resplendentwebservices.com>)
        id 1e8PRt-0001nd-RB
        for git@vger.kernel.org; Sat, 28 Oct 2017 06:38:46 -0500
To:     git@vger.kernel.org
From:   RPS <jim@resplendentwebservices.com>
Subject: Wildcards with git rm
Message-ID: <cbb7340e-aa8c-1980-41eb-95cd965d4037@resplendentwebservices.com>
Date:   Sat, 28 Oct 2017 07:38:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 171028-0, 10/28/2017), Outbound message
X-Antivirus-Status: Clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.resplendentwebservices.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - resplendentwebservices.com
X-Get-Message-Sender-Via: mail.resplendentwebservices.com: authenticated_id: jim@resplendentwebservices.com
X-Authenticated-Sender: mail.resplendentwebservices.com: jim@resplendentwebservices.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rm doesn't seem to be very useful without the use of shell 
wildcards, especially with the use of a .gitignore file. If a .gitignore 
file is used, the git rm command does not consider the .gitignore file, 
and errs out when an ignored file is present.

In my opinion, git rm should take .gitignore into consideration and 
suppress errors for those files along with all other commands in order 
to target valid repository files in the current version. Also, git rm 
should either remove the ignored files and other present  files in the 
working copy to act like a shell rm command along with existing version 
controlled objects from the version, or skip ignored working copy files 
and err out on files not accounted for in the current version.

Have there been any design considerations on these things?

Jim Lutz


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

