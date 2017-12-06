Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481D520C31
	for <e@80x24.org>; Wed,  6 Dec 2017 04:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbdLFEMn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 23:12:43 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16807 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbdLFEMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 23:12:42 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB64Ceun055317
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 5 Dec 2017 23:12:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Documentation Breakage at 2.5.6
Date:   Tue, 5 Dec 2017 23:12:33 -0500
Message-ID: <008d01d36e48$747cc130$5d764390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdNuR7PWVgnJPnAuT22AaRwzHAC5kQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I'm trying to upgrade the NonStop port from 2.3.7 upward eventually to
2.15.1 and hit a snag on documentation. The xmlto component is a bit new to
me and I hit the following error:

    XMLTO git-remote-testgit.1
xmlto: /home/git/git/Documentation/git-remote-testgit.xml does not validate
(status 3)
xmlto: Fix document syntax or use --skip-validation option
I/O error : Attempt to load network entity
http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
/home/git/git/Documentation/git-remote-testgit.xml:2: warning: failed to
load external entity
"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
D DocBook XML V4.5//EN"
"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
 
^
I/O error : Attempt to load network entity
http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
warning: failed to load external entity
"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
validity error : Could not load the external subset
http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd

The -skip-validation option just takes me to a different problem validating
via sourceforge URL that appears not to exist anymore, although I had to
modify ./git/Documention/Makefile, which is vexing.

    XMLTO git-remote-testgit.1
I/O error : Attempt to load network entity
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
compilation error: file /tmp/xmlto-xsl.ie6J8p line 4 element import
xsl:import : unable to load
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
Makefile:328: recipe for target 'git-remote-testgit.1' failed

Any advice on getting past this? It would be nice to get git help to working
again. An answer of "you need to get past 2.5.6" is ok too as long as I know
where I'm going.

Thanks,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



