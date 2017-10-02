Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A492036B
	for <e@80x24.org>; Mon,  2 Oct 2017 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdJBOSV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:18:21 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36359 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdJBOSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:18:20 -0400
Received: by mail-qk0-f194.google.com with SMTP id z14so3941375qkg.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jRg6PnxP11qdOlYY/jkyCQXsNJlQ5UsBHOIOHZWFILs=;
        b=MxC1RbHiNjhXBm9OgMWN2eIvzPl8E1ueq9ZKU+22flig2LSGy1g8xeA68kncWBfy/t
         l7pQMwo3dS7ErXmTUuwP7s5IC4RTElKY6O2JyW0pRK3451wSo0FnTzVwD6qJlIwwCyRb
         90EAVcZJufRZDDuCRQo0fCB/1rhWzyb9lsfnGlwzZLpLpbcSsMWPtT8x3ddKRgWOUHy7
         yi5Y1pWD129dQ6olhHnzLfILBucWmODP8676BpVuu2zPmXFtx5Uh9ABUpdnV5eC9ehhE
         T55k4zlaCeUoBTMWcGlh09zQ2w4vCz/Agur11EcjzNq4dLRTninUlNRobIvECXPxGyxs
         bVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRg6PnxP11qdOlYY/jkyCQXsNJlQ5UsBHOIOHZWFILs=;
        b=GP4qj/bsEiidki/4sQTnurCFDbCTJSuev5g60LgKK75ELTfJ/VC/m6F3RIYWyXiySf
         VoeuKO2UaTb1HNu+XESzGXWcFFLjS4Nr3FwxZToYt93Z978p5/IPtcPBSe/BTK1KQIQ8
         DINewDBOtEezjcnYeUGFzdA8N7eR5y1aNlIak0ERaLuNoMdT3NrKMR7uXo2eqJ5d5f7E
         mYbtpAgWq2UmufQH/um6NGrx0/X08/d+p44YdLub4qjyncFykqrTD2/z4Si0O24EA4pZ
         4dndILo64rSlKmXUHaCzQYA0A3guv5557KnfFEhXJASss+DNN/IavVYJo/C9xPHvxZQ2
         d8+w==
X-Gm-Message-State: AMCzsaWxlpmoVjZqqJXwwrwMdyHqjPZaVxLufb6wlj8eLHutHrIci3q7
        f9W7HocSJHfPwzLrMiK0Asc=
X-Google-Smtp-Source: AOwi7QBt1vTL+0dpKhnZln+Bb9cZDtczU9p6Eh5j4yW/Q9c1zExCdws5qqNeuDF2tssAFg4o7C+Hdw==
X-Received: by 10.55.21.39 with SMTP id f39mr14387659qkh.222.1506953898960;
        Mon, 02 Oct 2017 07:18:18 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g1sm7173292qta.95.2017.10.02.07.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 07:18:17 -0700 (PDT)
Subject: Re: [PATCH v6 00/40] Add initial experimental external ODB support
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1d53569f-4bc8-0d8e-0182-eec0eb6634cd@gmail.com>
Date:   Mon, 2 Oct 2017 10:18:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/2017 4:06 AM, Christian Couder wrote:

> Highlevel view of the patches in the series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

This is a massive patch series and IMO keeping it a single monolithic 
set of patches makes it difficult to review and unwieldy to make 
progress on as an "all or nothing" series.

I highly recommend breaking it up into multiple smaller patch series 
that can be reviewed and accepted individually.  I have to admit I've 
skipped reviewing the last couple of iterations simply because of the 
time investment required and difficulty separating out the various pieces.

I think using your division of the patches below is a good place to 
start.  Many of these would be good changes even if they weren't part of 
the larger external ODB effort.

       - Patch 1/40 is a small code cleanup that I already sent to the
>        mailing list but may be removed in the end due to ongoing work
>        on "git clone".
> 
>      - Patches 02/40 to 07/40 create a "Git/Packet.pm" module by
>        refactoring "t0021/rot13-filter.pl". Functions from this new
>        module will be used later in test scripts. According to Junio's
>        suggestion compared to v5 we now first fully refactor
>        "t0021/rot13-filter.pl" before creating the "Git/Packet.pm"
>        module.
> 

This seems like a very logical thing to do and should be split out so 
that progress can be made independently.

>      - Patches 08/40 to 16/40 create the external ODB insfrastructure
>        in external-odb.{c,h} and odb-helper.{c,h} for the script mode.
>        The main changes compared to v5 are the following:
>          - we mark as "extern" functions in *.h files
> 	- we use sha1_pos() instead of sha1_entry_pos()
> 	- we check the size in the header when we 'get' a Git object
> 

This is the heart of the ODB infrastructure series.  I'll respond in 
more detail in the specific patches.

>      - Patches 17/40 to 23/40 improve lib-http to make it possible to
>        use it as an external ODB to test storing blobs in an HTTP
>        server. The "upload.sh" and "list.sh" files are now properly
>        indented and they use %% instead of % in parameter
>        substitutions compared to v5.
> 
>      - Patches 24/40 to 32/40 improve the external ODB insfrastructure
>        to support sub-processes and make everything work using
>        them. The main changes compared to v5 are the following:
>          - we mark as "extern" functions in *.h files
> 	- we use the new subprocess_handshake() function
> 	- we check the size in the header when we 'get' a Git object
> 
>      - Patch 33/40 uses attributes to mark blobs that should be handled
>        by an external odb.
> 
>      - Patch 34/40 adds documentation about the external odb
>        mechanism. This patch has been much improved since v5.
> 
>      - Patches 35/40 to 39/40 add the --initial-refspec to git clone
>        along with tests.
> 
>      - Patch 40/40 adds documentation about transfering objects and
>        metadata when using the external odb mechanism. This patch is
>        new since v5.
> 
> Future work
> ~~~~~~~~~~~
> 
> There are still things that could be cleaned or improved. I think I
> may work on:
> 
>    - Integrate changes in recent "read-object-process" work by Ben Peart.
> 
>    - Better test all the combinations of the different modes with and
>      without "have" and "put_*" instructions.
> 
>    - Maybe implement the missing kinds of 'put' ('put_git_obj' and
>      'put_direct'), so that Git could pass either a git object a plain
>      object or ask the helper to retreive it directly from Git's object
>      database.
> 
>    - Add more long running tests and improve tests in general.
> 
> Previous work and discussions
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> (Sorry for the old Gmane links, I hope I will try to replace them with
> public-inbox.org at one point.)
> 
> Peff started to work on this and discuss this some years ago:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
> http://thread.gmane.org/gmane.comp.version-control.git/247171
> http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
> 
> His work, which is not compile-tested any more, is still there:
> 
> https://github.com/peff/git/commits/jk/external-odb-wip
> 
> Initial discussions about this new series are there:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160
> 
> Version 1, 2, 3, 4 and 5 of this series are here:
> 
> https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
> https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
> https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
> https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
> https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
> 
> Some of the discussions related to Ben Peart's work that is used by
> this series are here:
> 
> https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
> https://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/
> https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/
> 
> Links
> ~~~~~
> 
> This patch series is available here:
> 
> https://github.com/chriscool/git/commits/external-odb
> 
> Version 1, 2, 3, 4 and 5 are here:
> 
> https://github.com/chriscool/git/commits/gl-external-odb12
> https://github.com/chriscool/git/commits/gl-external-odb22
> https://github.com/chriscool/git/commits/gl-external-odb61
> https://github.com/chriscool/git/commits/gl-external-odb239
> https://github.com/chriscool/git/commits/gl-external-odb373
> 
> 
> Ben Peart (2):
>    odb-helper: add init_object_process()
>    Add t0450 to test 'get_direct' mechanism
> 
> Christian Couder (38):
>    builtin/clone: get rid of 'value' strbuf
>    t0021/rot13-filter: refactor packet reading functions
>    t0021/rot13-filter: improve 'if .. elsif .. else' style
>    t0021/rot13-filter: improve error message
>    t0021/rot13-filter: add packet_initialize()
>    t0021/rot13-filter: add capability functions
>    Add Git/Packet.pm from parts of t0021/rot13-filter.pl
>    sha1_file: prepare for external odbs
>    Add initial external odb support
>    odb-helper: add odb_helper_init() to send 'init' instruction
>    t0400: add 'put_raw_obj' instruction to odb-helper script
>    external odb: add 'put_raw_obj' support
>    external-odb: accept only blobs for now
>    t0400: add test for external odb write support
>    Add GIT_NO_EXTERNAL_ODB env variable
>    Add t0410 to test external ODB transfer
>    lib-httpd: pass config file to start_httpd()
>    lib-httpd: add upload.sh
>    lib-httpd: add list.sh
>    lib-httpd: add apache-e-odb.conf
>    odb-helper: add odb_helper_get_raw_object()
>    pack-objects: don't pack objects in external odbs
>    Add t0420 to test transfer to HTTP external odb
>    external-odb: add 'get_direct' support
>    odb-helper: add 'script_mode' to 'struct odb_helper'
>    Add t0460 to test passing git objects
>    odb-helper: add put_object_process()
>    Add t0470 to test passing raw objects
>    odb-helper: add have_object_process()
>    Add t0480 to test "have" capability and raw objects
>    external-odb: use 'odb=magic' attribute to mark odb blobs
>    Add Documentation/technical/external-odb.txt
>    clone: add 'initial' param to write_remote_refs()
>    clone: add --initial-refspec option
>    clone: disable external odb before initial clone
>    Add tests for 'clone --initial-refspec'
>    Add t0430 to test cloning using bundles
>    Doc/external-odb: explain transfering objects and metadata
> 
>   Documentation/technical/external-odb.txt |  447 +++++++++++++
>   Makefile                                 |    2 +
>   builtin/clone.c                          |   91 ++-
>   builtin/pack-objects.c                   |    4 +
>   cache.h                                  |   18 +
>   environment.c                            |    4 +
>   external-odb.c                           |  196 ++++++
>   external-odb.h                           |   12 +
>   odb-helper.c                             | 1076 ++++++++++++++++++++++++++++++
>   odb-helper.h                             |   45 ++
>   perl/Git/Packet.pm                       |  118 ++++
>   sha1_file.c                              |  155 +++--
>   t/lib-httpd.sh                           |    8 +-
>   t/lib-httpd/apache-e-odb.conf            |  214 ++++++
>   t/lib-httpd/list.sh                      |   41 ++
>   t/lib-httpd/upload.sh                    |   45 ++
>   t/t0021/rot13-filter.pl                  |  110 +--
>   t/t0400-external-odb.sh                  |   85 +++
>   t/t0410-transfer-e-odb.sh                |  147 ++++
>   t/t0420-transfer-http-e-odb.sh           |  152 +++++
>   t/t0430-clone-bundle-e-odb.sh            |   85 +++
>   t/t0450-read-object.sh                   |   28 +
>   t/t0450/read-object                      |   68 ++
>   t/t0460-read-object-git.sh               |   28 +
>   t/t0460/read-object-git                  |   78 +++
>   t/t0470-read-object-http-e-odb.sh        |  119 ++++
>   t/t0470/read-object-plain                |   83 +++
>   t/t0480-read-object-have-http-e-odb.sh   |  119 ++++
>   t/t0480/read-object-plain-have           |  103 +++
>   t/t5616-clone-initial-refspec.sh         |   48 ++
>   30 files changed, 3588 insertions(+), 141 deletions(-)
>   create mode 100644 Documentation/technical/external-odb.txt
>   create mode 100644 external-odb.c
>   create mode 100644 external-odb.h
>   create mode 100644 odb-helper.c
>   create mode 100644 odb-helper.h
>   create mode 100644 perl/Git/Packet.pm
>   create mode 100644 t/lib-httpd/apache-e-odb.conf
>   create mode 100644 t/lib-httpd/list.sh
>   create mode 100644 t/lib-httpd/upload.sh
>   create mode 100755 t/t0400-external-odb.sh
>   create mode 100755 t/t0410-transfer-e-odb.sh
>   create mode 100755 t/t0420-transfer-http-e-odb.sh
>   create mode 100755 t/t0430-clone-bundle-e-odb.sh
>   create mode 100755 t/t0450-read-object.sh
>   create mode 100755 t/t0450/read-object
>   create mode 100755 t/t0460-read-object-git.sh
>   create mode 100755 t/t0460/read-object-git
>   create mode 100755 t/t0470-read-object-http-e-odb.sh
>   create mode 100755 t/t0470/read-object-plain
>   create mode 100755 t/t0480-read-object-have-http-e-odb.sh
>   create mode 100755 t/t0480/read-object-plain-have
>   create mode 100755 t/t5616-clone-initial-refspec.sh
> 
