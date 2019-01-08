Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5841F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfAHQWZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:22:25 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:60557 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfAHQWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:22:25 -0500
Received: from [192.168.2.240] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id gu8yg1qordJAegu8zgvaZO; Tue, 08 Jan 2019 16:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1546964542;
        bh=TLSX0azSU/B87MFGbXpowhsCPsMuKmU0Iah+dhkMfX4=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=D3PfDNwErewhskBS3v+J3nLSJ70Aa5gvhXRnsfyCxlTSBdKIxgH7V9t3zpKzVzl71
         vQoFcCHsVHD7n/f6cZ77MLYWp+bWhVgk14BFyNEFwot+T4nOHQ/0/YpzAaNINI5u2r
         U0vo9fVcgKABRcTdfHyG2VszI2AS/FEo0s+K8bTQ=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=kNXpgh0VPrIw56cjt_oA:9 a=nmjtdf9WV9GvODT2:21 a=bOmGnJGWFjeZLCJs:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
Message-ID: <402b9c01-cd7c-79f3-9fde-55907f03c406@talktalk.net>
Date:   Tue, 8 Jan 2019 16:22:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPP+agK/IPplDrhcekJg/wvHtAg0UvGBTyGqcshKIxOXkB/rEsTH2MUjq2cWnAxfVURhxfTuGOVUNwhlUyIDMjRugRH03a8O37lhoHBkvYuOuCWVJasM
 xjsHJFCgDPzffCVy7TBri8J0RonXuWS4UIi9VdwEiQDW1CXH0tQnjYZTs3bhwRNEZj05WYTVx9OGtb9yWGZ8pAfJs/KyuNL/fUCimDPQdzOEN/DnAOdIi8Fx
 NroHi6H4gzVoW/9WIODfmGZQLR/eSnXoUooKhkDXD+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

I just wanted to check that these patches are on your radar as they 
haven't made it into pu yet.

Best Wishes for the New Year

Phillip

On 23/11/2018 11:16, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Thanks to Stefan for his feedback on v1. I've updated patches 2 & 8 in
> response to those comments - see the range-diff below for details (the
> patch numbers are off by one in the range diff, I think because the
> first patch is unchanged and so it was used as the merge base by
> --range-diff=<old-head>. For some reason the range-diff also includes
> the notes even though I did not give --notes to format-patch)
> 
> When trying out the new --color-moved-ws=allow-indentation-change I
> was disappointed to discover it did not work if the indentation
> contains a mix of spaces and tabs. This series reworks it so that it
> does.
> 
> 
> Phillip Wood (9):
>    diff: document --no-color-moved
>    Use "whitespace" consistently
>    diff: allow --no-color-moved-ws
>    diff --color-moved-ws: demonstrate false positives
>    diff --color-moved-ws: fix false positives
>    diff --color-moved=zebra: be stricter with color alternation
>    diff --color-moved-ws: optimize allow-indentation-change
>    diff --color-moved-ws: modify allow-indentation-change
>    diff --color-moved-ws: handle blank lines
> 
>   Documentation/diff-options.txt |  15 ++-
>   Documentation/git-cat-file.txt |   8 +-
>   diff.c                         | 219 +++++++++++++++++++++------------
>   t/t4015-diff-whitespace.sh     |  99 ++++++++++++++-
>   4 files changed, 255 insertions(+), 86 deletions(-)
> 
> Range-diff against v1:
> 1:  ae58ae4f29 ! 1:  4939ee371d diff: use whitespace consistently
>      @@ -1,9 +1,10 @@
>       Author: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>      -    diff: use whitespace consistently
>      +    Use "whitespace" consistently
>       
>      -    Most of the documentation uses 'whitespace' rather than 'white space'
>      -    or 'white spaces' convert to latter two to the former for consistency.
>      +    Most of the messages and documentation use 'whitespace' rather than
>      +    'white space' or 'white spaces' convert to latter two to the former for
>      +    consistency.
>       
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>      @@ -29,6 +30,39 @@
>        	whitespace is the same per line. This is incompatible with the
>        	other modes.
>       
>      + diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
>      + --- a/Documentation/git-cat-file.txt
>      + +++ b/Documentation/git-cat-file.txt
>      +@@
>      + stdin, and the SHA-1, type, and size of each object is printed on stdout. The
>      + output format can be overridden using the optional `<format>` argument. If
>      + either `--textconv` or `--filters` was specified, the input is expected to
>      +-list the object names followed by the path name, separated by a single white
>      +-space, so that the appropriate drivers can be determined.
>      ++list the object names followed by the path name, separated by a single
>      ++whitespace, so that the appropriate drivers can be determined.
>      +
>      + OPTIONS
>      + -------
>      +@@
>      + 	Print object information and contents for each object provided
>      + 	on stdin.  May not be combined with any other options or arguments
>      + 	except `--textconv` or `--filters`, in which case the input lines
>      +-	also need to specify the path, separated by white space.  See the
>      ++	also need to specify the path, separated by whitespace.  See the
>      + 	section `BATCH OUTPUT` below for details.
>      +
>      + --batch-check::
>      + --batch-check=<format>::
>      + 	Print object information for each object provided on stdin.  May
>      + 	not be combined with any other options or arguments except
>      + 	`--textconv` or `--filters`, in which case the input lines also
>      +-	need to specify the path, separated by white space.  See the
>      ++	need to specify the path, separated by whitespace.  See the
>      + 	section `BATCH OUTPUT` below for details.
>      +
>      + --batch-all-objects::
>      +
>        diff --git a/diff.c b/diff.c
>        --- a/diff.c
>        +++ b/diff.c
> 2:  7072bc6211 = 2:  204c7fea9d diff: allow --no-color-moved-ws
> 3:  ce3ad19eea = 3:  542b79b215 diff --color-moved-ws: demonstrate false positives
> 4:  700e0b61e7 = 4:  4ffb5c4122 diff --color-moved-ws: fix false positives
> 5:  9ecd8159a7 = 5:  a3a84f90c5 diff --color-moved=zebra: be stricter with color alternation
> 6:  1b1158b1ca = 6:  f94f2e0bae diff --color-moved-ws: optimize allow-indentation-change
> 7:  d8a362be6a ! 7:  fe8eb9cdbc diff --color-moved-ws: modify allow-indentation-change
>      @@ -17,7 +17,7 @@
>       
>           This commit changes the way the indentation is handled to track the
>           visual size of the indentation rather than the characters in the
>      -    indentation. This has they benefit that any whitespace errors do not
>      +    indentation. This has the benefit that any whitespace errors do not
>           interfer with the move detection (the whitespace errors will still be
>           highlighted according to --ws-error-highlight). During the discussion
>           of this feature there were concerns about the correct detection of
>      @@ -30,7 +30,7 @@
>               they are uncolored.
>       
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      -    Changes since rfc:
>      +    changes since rfc:
>            - It now replaces the existing implementation rather than adding a new
>              mode.
>            - The indentation deltas are now calculated once for each line and
>      @@ -49,8 +49,8 @@
>        	const char *line;
>        	int len;
>        	int flags;
>      -+	int indent_off;
>      -+	int indent_width;
>      ++	int indent_off;   /* Offset to first non-whitespace character */
>      ++	int indent_width; /* The visual width of the indentation */
>        	enum diff_symbol s;
>        };
>        #define EMITTED_DIFF_SYMBOL_INIT {NULL}
> 8:  1f7e99d45c = 8:  e600f8247c diff --color-moved-ws: handle blank lines
>      
> 

