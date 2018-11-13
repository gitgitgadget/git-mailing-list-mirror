Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E891F97E
	for <e@80x24.org>; Tue, 13 Nov 2018 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeKNHIQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:08:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNHIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:08:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so6641389plq.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WcF+Zn2/ioIpvTYG470O/ouK4PSVxgH2fRPQtqh4EGI=;
        b=bGHHnG9YAg4ei/O3PTjbKi1rZ73UNguCsILGDrssnkh+Z+BxYixIYLTHrF0gXKMxm+
         vmMuDOGF8pePYNUPbMcwHCT6897lx4lcX+FKCFqG7KQYOk4R1N6fA7yh5lJeg6ndQO/G
         YYzy6nJP82zfPgvN2KK/uceB5j9rpxnYH/bKJBE5hY+VD5Us4P+EK740I+Qdir+pQuxI
         LnEk+TQqKg7KLGLfBlS9Cht2sCuxuOFT0bRj2tdRCrYDzgYq7V2bSWaDq7jcMwKsXRnK
         QBLevTeVhBaWGAMYrshGHx7czjoFNV+xx9lcCsMjlWZEPDtU/CbffyVS+uaD73L91ps6
         2+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WcF+Zn2/ioIpvTYG470O/ouK4PSVxgH2fRPQtqh4EGI=;
        b=B3g9hvaKJpxku8Pb2gl6QuD7483FyUW+9UxrTmZzv4JHf48kiJN+edErcLlM0rFYYO
         qmiaiDFcecyxISSkoI0X5CQTJkc+OmduweIXN0A+cK3MAKXOty9dsK2KNtRh4YDuOQFq
         r7E+sqWDyfo1RRxhP9dCNuXHZfgJUik6Xok/Sdlfl59+GaTid0BYlFF+7QZ6xae40Ugn
         3NyDSLDxP7psdRSeQFsEgsAl1y/yqb1uE+AsyNucrYKtjbgUPeuuWFcMmEGw/LZ5lavR
         sGZuAF76nybe9ZgJzASP1VuuZ3rk3pHqpLAqiFqJ8OuFB4WWQHLWwCQ/bCn5s/1Q5rz+
         QJQw==
X-Gm-Message-State: AGRZ1gJNx+uA91hHUxm6y5f0QtZe7Te9JvqQ9IRDVeYh8HLptYZWwcuL
        t8arSHrPDRspVuMgpxK21vI=
X-Google-Smtp-Source: AJdET5eBaKFvVLoaWYxKy41KzUt2r+5xUG+jFIDuEVaGFEOyhYGfxwLMqXWbFobhvsriMOBEUkcUfw==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6-v6mr6626090plo.194.1542143298477;
        Tue, 13 Nov 2018 13:08:18 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e126-v6sm10610989pfe.67.2018.11.13.13.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:08:17 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:08:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181113210815.GD68106@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <20181113181855.GB68106@google.com>
 <1b890149-ee7f-c391-9abc-46d120e4324c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b890149-ee7f-c391-9abc-46d120e4324c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Ben Peart wrote:
> On 11/13/2018 1:18 PM, Jonathan Nieder wrote:
>> Ben Peart wrote:

>>> Why introduce a new setting to disable writing the IEOT extension instead of
>>> just using the existing index.threads setting?  If index.threads=1 then the
>>> IEOT extension isn't written which (I believe) will accomplish the same
>>> goal.
>>
>> Do you mean defaulting to index.threads=1?  I don't think that would
>> be a good default, but if you have a different change in mind then I'd
>> be happy to hear it.
>>
>> Or do you mean that if the user has explicitly specified index.threads=true,
>> then that should imply index.recordOffsetTable=true so users only have
>> to set one setting to turn it on?  I can imagine that working well.
>
> Reading the index with multiple threads requires the EOIE and IEOT
> extensions to exist in the index.  If either extension doesn't exist, then
> the code falls back to the single threaded path.  That means you can't have
> both 1) no warning for old versions of git and 2) multi-threaded reading for
> new versions of git.
>
> If you set index.threads=1, that will prevent the IEOT extension from being
> written and there will be no "ignoring IEOT extension" warning in older
> versions of git.
>
> With this patch 'as is' you would have to set both index.threads=true and
> index.recordOffsetTable=true to get multi-threaded index reads.  If either
> is set to false, it will silently drop back to single threaded reads.

Sorry, I'm still not understanding what you're proposing.  What would be

- the default behavior
- the mechanism for changing that behavior

under your proposal?

I consider index.threads=1 to be a bad default.  I would understand if
you are saying that that should be the default, and I tried to propose
a different way to achieve what you're looking for in the quoted reply
above (but I'm not understanding whether you like that proposal or
not).

Jonathan
