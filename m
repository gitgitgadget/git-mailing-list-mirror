Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045781FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 19:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754868AbeARTRa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Jan 2018 14:17:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52907 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeARTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 14:17:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0IJHNQZ026783
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:17:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [Question] format-patch along a specific path
Date:   Thu, 18 Jan 2018 14:17:19 -0500
Message-ID: <008101d39090$f90103c0$eb030b40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0072_01D39066.A87A7D20";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK/WPpE2nT8DMwv0Z/u7ayHG0SXiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

What I’m trying to do is to format a patch based on a single commit from
2.16.0 representing the NonStop port, for review and comments to the team.
Here is a partial (somewhat familiar) tree:

*   f1a482cd8 (HEAD -> randall_2.16, ituglib_release) NonStop port changes
for git 2.16.0.
|\
| | * b2a06dcfb (refs/stash) WIP on randall: 5653e94 Removed unnecessary
void* from hashmap.h that caused compile warnings
| |/
| * 5653e943a (randall) Removed unnecessary void* from hashmap.h that caused
compile warnings
| *   b318de9ca Merge branch 'ituglib_devel' into 2.16.0-rc1
| |\
| | * a4cdf025d (randall_2.13.5) Replaced read with xread in
transport-helper.c to fix SSIZE_MAX overun in t5509
| | | * b72dbd7fa (origin/pu) Merge branch 'ds/use-get-be64' into pu
| |_|/
|/| |
| | | * 896df04e4 (origin/next) Sync with 2.16
| |_|/
|/| |
* | | 2512f1544 (tag: v2.16.0, origin/master, origin/HEAD) Git 2.16
|/ /
* | c6c75c93a (tag: v2.16.0-rc2) Git 2.16-rc2

Trying the intuitive approach of git format-patch -1 f1a482cd8, I end up
with a patch for c6c75c93a, which I assume is a backtrack. If I use
2512f1544..f1a482cd8, I end up with a whole bunch of commits along the long
path rather than the short single hop path, (I actually want the short
path). The --base=2512f1544 option complains that the base commit shouldn't
be in revision list, which I also assume is an artifact of backtracking. Is
there a clean way in 2.16.0 to do this or should I redo the commit as a
squash and disconnect it from the other path?

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



