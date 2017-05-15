Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84915201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966556AbdEOTu4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 15 May 2017 15:50:56 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:41939 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbdEOTuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:50:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id D02891000D8;
        Mon, 15 May 2017 19:50:53 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K-YOLxxLyn9w; Mon, 15 May 2017 19:50:53 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id BC23D80035;
        Mon, 15 May 2017 19:50:53 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 15 May 2017 19:50:53 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 15 May 2017 19:50:53 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "benpeart@microsoft.com" <benpeart@microsoft.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that
 integrates with the cross platform Watchman file watching service.
Thread-Topic: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that
 integrates with the cross platform Watchman file watching service.
Thread-Index: AQHSza90VZIRcf+aS0Cz7gtDriFBZaH1xfKg
Date:   Mon, 15 May 2017 19:50:53 +0000
Message-ID: <fb609e259c714469b5528888e14c2e3a@exmbdft7.ad.twosigma.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-6-benpeart@microsoft.com>
In-Reply-To: <20170515191347.1892-6-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Ben Peart [mailto:peartben@gmail.com]
> Sent: Monday, May 15, 2017 3:14 PM
> To: git@vger.kernel.org
> Cc: gitster@pobox.com; benpeart@microsoft.com; pclouds@gmail.com;
> johannes.schindelin@gmx.de; David Turner <David.Turner@twosigma.com>;
> peff@peff.net
> Subject: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that
> integrates with the cross platform Watchman file watching service.
> 
> To use the script:
> 
> Download and install Watchman from https://facebook.github.io/watchman/
> and instruct Watchman to watch your working directory for changes
> ('watchman watch-project /usr/src/git').
> 
> Rename the sample integration hook from query-fsmonitor.sample to query-
> fsmonitor.
> 
> Configure git to use the extension ('git config core.fsmonitor true') and
> optionally turn on the untracked cache for optimal performance ('git config
> core.untrackedcache true').
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  templates/hooks--query-fsmonitor.sample | 27
> +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 templates/hooks--query-fsmonitor.sample
> 
> diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--
> query-fsmonitor.sample
> new file mode 100644
> index 0000000000..4bd22f21d8
> --- /dev/null
> +++ b/templates/hooks--query-fsmonitor.sample
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +#
> +# An example hook script to integrate Watchman #
> +(https://facebook.github.io/watchman/) with git to provide fast # git
> +status.
> +#
> +# The hook is passed a time_t formatted as a string and outputs to #
> +stdout all files that have been modified since the given time.
> +# Paths must be relative to the root of the working tree and #
> +separated by a single NUL.
> +#
> +# To enable this hook, rename this file to "query-fsmonitor"
> +
> +# Convert unix style paths to escaped Windows style paths case "$(uname
> +-s)" in
> +MINGW*|MSYS_NT*)
> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
> +  ;;
> +*)
> +  GIT_WORK_TREE="$PWD"
> +  ;;
> +esac
> +
> +# Query Watchman for all the changes since the requested time echo
> +"[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1,
> +\"fields\":[\"name\"]}]" | \ watchman -j | \ perl -e 'use JSON::PP; my
> +$o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o-
> >{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"});
> print(join("\0", @{$o->{"files"}}));'

Last time I checked, the argument to 'since' was not a time_t -- it was a 
watchman clock spec.  Have you tested this?  Does it work?

