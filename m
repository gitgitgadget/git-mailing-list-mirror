Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4501D1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 23:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIYFKR (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 01:10:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49569 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbeIYFKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 01:10:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CAA1A21BF1;
        Mon, 24 Sep 2018 19:05:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 Sep 2018 19:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=7rNta7STu65oTEV7GXgU/XrpTmJ6x
        vsRVWx5kLfmbo4=; b=EO5DcnSVVli+HvWkt0QgUOMHS3vG9jx7IHP8xE7Z+r5wr
        K3sohG0nHiN/9Bg6vZ7fuxh8MmL+eakZ0fRRtAwkv6GVe2Jsv/VgJJsrF58IUOkb
        IP45fDlkprpMlQrVn10Yxy0ds2eB4ZH13SA91JXJBdziryJE85QGXu6sn8Wy/eM3
        6sc2MSwWZ4XpzFx4MBJpV6gZFuFOCcrD0RO5tyY+dCkPy8TtHY51udKvufpwxF8n
        eTIgtYyrZ1T/MNwZvbBqIc1HotyfvetwKXhduMLaYf3Q0WgH6ZCs1JABcO6JbuFD
        33Z9bcVlF2uKS9d0NKF5bbY0Iw6xqXjzsufPQjtRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7rNta7
        STu65oTEV7GXgU/XrpTmJ6xvsRVWx5kLfmbo4=; b=AceyulE4y1KFrUnTj5cfvj
        ASwPVx9vC5wZPM0Wlumh8DQapmrpsw8i4T1ESuvprjxZaAp3Z6WmKjVAJArEEmdC
        O5rdVjByTinBNMvhmVDpn7l3AFL9m0hqUf5DJhyzVSAvlZKMs0cKgflYJmFKXTTk
        Hkxw0+p8++60aecj9uidCAysWUyJ4UZ7NpCFu9dCHCNxLLLXuJysqc3J9HxMk6jJ
        uNc2z1MC8rAEj2pmMCspba/8n3Q4bWb3jkYyAbh4GcajvEjl0pGcn2jm67dvGldP
        k18LF1oHJvKlk+xRTOV2Sk41vHtMznbKTKkgwTNaO+TqpbkoOKHylLhdl7Ceh9SA
        ==
X-ME-Proxy: <xmx:xm2pW9Hd-ld_N43p1sIRVcOsH0eq9IUFiQ5TvG4n_My-k41iM2M1bA>
    <xmx:xm2pW9RbXg7K-ZA3CWjQR9hwXNiuPEtSAzR6rxf6OaeClGkfNljIwQ>
    <xmx:xm2pW_0tpb26sE57hioXZ3woMfWJ7tAOYAZ81Kebcsco0WkBZdFceg>
    <xmx:xm2pW8A-ycbNAPE_a_3AKZui-o3eAFI63Ytq37r-o6xycmKseZt3Uw>
    <xmx:xm2pW2p1OKX-DeOntUoazqalwlvO1GusLHlHIwDKnP_zlAwi8Eyf4A>
    <xmx:xm2pWybMOUnsxx-xPIVsB0UKLlKox0360RjcTf1KpURvhQxd_mdkbA>
X-ME-Sender: <xms:xm2pW-Yq6cPfVijaQfJv6gvtPmKKfMeJRKQpVw5menIZ8rUBy0DMfQ>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26750E4118;
        Mon, 24 Sep 2018 19:05:41 -0400 (EDT)
Subject: Re: [PATCH 0/1] Re: git silently ignores include directive with
 single quotes
To:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
 <20180924222416.5240-1-philipoakley@iee.org>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <fc846d71-e3cb-6eb7-587c-2abeac1a7383@stason.org>
Date:   Mon, 24 Sep 2018 16:05:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924222416.5240-1-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-24 03:24 PM, Philip Oakley wrote:
> Rather than attaching the problem with code, I decided to simply update
> the config file documentation.
> 
> As the userbase expands the documentation will need to be more comprehensive
> about exclusions and omissions, along with better highlighting for core
> areas.
> 
> I would be useful if Stas could comment on whether these changes would
> have assisted in debugging the faulty config file. 

Thank you for writing this doc patch, Philip.

The documentation improvement would be most useful in conjunction with a
an improved debugging/tracing facility. So that a user can see what git
is seeing. Once a user sees that their configuration is broken then they
can peruse the improved documentation to find why it is broken. Without
the debugging ability, the docs would help but it'll be a much longer
journey, since words like:

"Single quotes are not special and form part of the variable's value."

aren't necessarily going to stand out as an indicator of a potential
problem, when you won't think twice that quotes could even be a suspect,
even though the docs say so explicitly.

A trace saying:

"./.git/'.gitconfig'" is not found

would speak volumes and be self-documenting.

In lieu of that, the docs would be need to have more examples.

Here are the potential expansions to the patch you shared:

1. "Single quotes are not special and form part of the variable's value.
For example, if the configuration includes:

  include = '.gitconfig'

then git will look for "'.gitconfig'", single quotes included. Also note
that it'll look for the file relative to "REPO/.git/", hence it'll look
for "REPO/.git/'.gitconfig'", which is most likely incorrect, since you
can't check in files under "REPO/.git/". The correct configuration for
including "REPO/.gitconfig" is:

  include = ../.gitconfig

2. Same with:

"Both the `include` and `includeIf` sections implicitly apply an 'if
found' condition to the given path names."

To a user this would be a difficult statement to make sense of. An
example would fix that:

"Both the `include` and `includeIf` sections implicitly apply an 'if
found' condition to the given path names. For example, if the
configuration includes:

  include = ../.gitconfig

and git finds "REPO/.gitconfig", it will include its configuration. If
git can't find it, it will silently ignore this include statement until
this file appears. It has been designed this way to allow for optional
user-specific configuration facilities."

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
