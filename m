Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B09D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 22:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeDWWr5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 18:47:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43443 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 18:47:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id f132so9368828pgc.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1CbSO/p4DfuqB1YH6nyOev+DAXMjBFJIlMG1HLRezeI=;
        b=TXlM5Wz49ENXgfIk5rp62lHG1DtLf+oZqcfcaiS3IG373bdpCGEqi2SGwfA+3RYBrR
         OPQrLEleu9Cfgr6sj8f06ge0VtZ2ygVztrJ44uFbzImmXBpbv5vFCIV7SCUinukAYalT
         GY+hkv/gS6w3a+j4eFpPCDfk+6jM3BsvFdT+DQZNFzzdIHWuh5lPknQ2Ac79tBHr7//b
         qTsFOOplyEEYh1bgkC+UlG3wMUZtnkFOc+kuu+9Hpoje2oeIITEwDDhxyoU3b3zVvlV4
         2l4lIh7lW5r178NApB6ysjjH7LHJjqbFkOVHZyaTgPmZ99rwVryXSByxlIlNjA7z2wMP
         aJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1CbSO/p4DfuqB1YH6nyOev+DAXMjBFJIlMG1HLRezeI=;
        b=qKESGF5+DjvjWFyCKvtj3G8TpHRFJ+qQVuLiFag/WnrORo1Z6EVJM9nf2Cr4NUGhA+
         2FBHLHwaeRGz2wErL93e5YH2lGAors9uRkNNzaPIKAzFDmCZ6F5uETRdGz4T/PlJasXZ
         GK/Ad5XDJsuHq9GvBnomqDxwr9cEV1C/YZ1K7eZvqwSWU5Aqx0MOun27ShBXqE7XvF1Y
         tEumU8QRy35X8RXuxGE4kQSzI8AbtgIqKWl9qqMtvwTBM9csjptIA8P4Psdj/azLD04p
         lqZ9bebJ1crajYX3vr41njH1icdm3+ksj2jMz2NhfBzOysvP7y9pjIUdVn1hNR3znX95
         2SLg==
X-Gm-Message-State: ALQs6tBy+jkjUTCt+DBbYPcr+AnX7dfpfNpTyI0KIekvfcaPCQ68MZkd
        KdAboSNB1r7aKTP5Yl5inH4W7ZgzJxE=
X-Google-Smtp-Source: AIpwx4+Wdumy7AzMNQIxU+clxd3bdGgwLLtBfr+lCsK7TtyVJ9qdbojl/9HOME9IyHOy8MEWppMndg==
X-Received: by 10.101.100.214 with SMTP id t22mr13307897pgv.41.1524523675445;
        Mon, 23 Apr 2018 15:47:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p6sm22353576pfn.140.2018.04.23.15.47.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 15:47:54 -0700 (PDT)
Date:   Mon, 23 Apr 2018 15:47:53 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] optionally send server-options when using v2
Message-ID: <20180423224753.GA29052@google.com>
References: <20180423224624.213341-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423224624.213341-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23, Brandon Williams wrote:
> Building on top of protocol version 2 this series adds the ability to
> optionally send server specific options when using protocol v2. This
> resembles the "push-options" feature except server options are sent as
> capability lines during a command request allowing for all current and
> future commands to benefit from sending arbitrary server options (and
> not requiring that sending server specific options be re-implemented for
> each and every command that may want to make use of them in the future).
> 
> These options can be provided by the user via the command line by giving
> "-o <option>" or "--server-option=<option>" to either ls-remote or
> fetch.
> 
> Command request example:
> 
> 	command=fetch
> 	server-option=hello
> 	server-option=world
> 	0001
> 	want A
> 	want B
> 	have X
> 	have Y
> 	0000
> 
> These options are only transmitted to the remote end when communicating
> using protocol version 2.

Forgot to mention that this series is based on current upstream master
(fe0a9eaf3) and a merge of origin/bw/protocol-v2.

> 
> Brandon Williams (3):
>   serve: introduce the server-option capability
>   ls-remote: send server options when using protocol v2
>   fetch: send server options when using protocol v2
> 
>  Documentation/fetch-options.txt         |  8 +++++++
>  Documentation/git-ls-remote.txt         |  8 +++++++
>  Documentation/technical/protocol-v2.txt | 10 ++++++++
>  builtin/fetch.c                         |  5 ++++
>  builtin/ls-remote.c                     |  4 ++++
>  connect.c                               |  9 ++++++-
>  fetch-pack.c                            |  7 ++++++
>  fetch-pack.h                            |  1 +
>  remote.h                                |  4 +++-
>  serve.c                                 |  1 +
>  t/t5701-git-serve.sh                    | 21 ++++++++++++++++
>  t/t5702-protocol-v2.sh                  | 32 +++++++++++++++++++++++++
>  transport.c                             |  3 ++-
>  transport.h                             |  6 +++++
>  14 files changed, 116 insertions(+), 3 deletions(-)
> 
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

-- 
Brandon Williams
