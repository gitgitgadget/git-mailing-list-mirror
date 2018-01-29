Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751F41F404
	for <e@80x24.org>; Mon, 29 Jan 2018 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeA2Pr1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 29 Jan 2018 10:47:27 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37004 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeA2Pr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:47:26 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0TFlHC4058160
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Jan 2018 10:47:18 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jack F'" <jack@bytes.nz>, <git@vger.kernel.org>
References: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
In-Reply-To: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
Subject: RE: Missing ? wildcard character in gitignore documentation
Date:   Mon, 29 Jan 2018 10:47:10 -0500
Message-ID: <000f01d39918$70009eb0$5001dc10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKVZzOJtk/08YHwkRyqQzrU/njAeaIHYKhA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 29, 2018 6:30 AM, Jack F wrote:
> I have just noticed that the documentation for gitignore is missing
> documentation on using the ? to match any single character. I have included
> a example below with git version 2.14.1.
> 
> |11:05:09 j ~/Development/ls-ignore [master] $ git status On branch
> master Your branch is up-to-date with 'origin/master'. nothing to commit,
> working tree clean 11:05:11 j ~/Development/ls-ignore [master] $ cat
> .gitignore *~ node_modules yarn* 11:05:21 j ~/Development/ls-ignore
> [master] $ touch test.swo 11:05:31 j ~/Development/ls-ignore [master]?1 $
> git status On branch master Your branch is up-to-date with 'origin/master'.
> Untracked files: (use "git add <file>..." to include in what will be committed)
> test.swo nothing added to commit but untracked files present (use "git add"
> to track) 11:05:35 j ~/Development/ls-ignore [master]?1 $ echo "*.sw?" >>
> .gitignore 11:05:40 j ~/Development/ls-ignore [master]≠1 $ cat .gitignore *~
> node_modules
> yarn* *.sw? 11:05:51 j ~/Development/ls-ignore [master]≠1 $ git status On
> branch master Your branch is up-to-date with 'origin/master'. Changes not
> staged for commit: (use "git add <file>..." to update what will be
> committed) (use "git checkout -- <file>..." to discard changes in working
> directory) modified: .gitignore no changes added to commit (use "git add"
> and/or "git commit -a")|
> 
> 
> 
> Noticed it when checking an npm package (ignore) that uses the
> documentation (https://git-scm.com/docs/gitignore) to determine its
> functionality. It is documented in https://git-scm.com/book/en/v2/Git-
> Basics-Recording-Changes-to-the-Repository#Ignoring-Files

The implication of support for ? is there through the following paragraph from the gitignore documentation:

    "Otherwise, Git treats the pattern as a shell glob suitable for consumption by fnmatch(3)
    with the FNM_PATHNAME flag: wildcards in the pattern will not match a / in the
    pathname. For example, "Documentation/*.html" matches "Documentation/git.html"
    but not "Documentation/ppc/ppc.html" or "tools/perf/Documentation/perf.html"."

Of course you have to go read fnmatch(3), so it might be good for expand on this here :).

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



