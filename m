Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F1420374
	for <e@80x24.org>; Mon, 15 Apr 2019 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfDOTUD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 15:20:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33255 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfDOTUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 15:20:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so648807wmi.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUDHbBElEHXNnGwtFLINgJ5RJDkEdQqkFsRki55VfMk=;
        b=WbZrBf/Q/KNFwQ9fmVfs4yQ2MO4Ltoi9MWybK0mDjc/ysHku3qRQIVWtPFVgmYxKKu
         pDxSliH5CUp2ulWXyZP3+LsaXte4WwKK9e4INP8gGumlUo4VM56V0IqfMwMZUqoRM5gb
         NaVzldafGHT4kl8l9V5IYIijZKbMMWB8bvyW8SmGn1RxclJVs1VNjZdjbBnAkvKVpZAq
         I5vtQ2VDYhd3s9G+uvXrF+a1g2Z2jfnaggseO0AlINDd5Id3zchulljiPhotIfs5rl/C
         CivhyArI9faNxgnRokswO3sP45ywd+0PxMBXHfAeSSSt8dhhoVzJuF3WYiuaGzxqjvMV
         vUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUDHbBElEHXNnGwtFLINgJ5RJDkEdQqkFsRki55VfMk=;
        b=Mflsp38t4Xx3s/pxu1QkbRyDaw2GMsf21v750mjWZvJC2/N1xgJvKNWGCiKMTTa1PR
         wuqgc8pQdpB7L1bCokwoS9mlFLw6rKkRJ/TTZ/r/crBs2JZzN9cRU5TpMIpjxCP22uzu
         OsdHS//XD+X4rD0ZzfdrjAEpSBjJJoNLZ2VENY/En+l3j7dwdbxy5OmJPcVbjl2zPK+5
         YtUJtFXf0xFfSfnZjlPcPNca1CSfPqVzQ8MzT5bt84OmbDwQ8yt753fGt0PiwOF0x4R3
         eTE6CBLrUjy/y4SLZVozQ+BOwA9ixoMtYwHH7VlOyG08OeugnvDU2KKstlEQ9mkdQMDr
         8V2A==
X-Gm-Message-State: APjAAAVqtnOl3xBlN2JQTjt6FMhUd878zSka0+WHpVCUR4xLmPpRRk5h
        geCXjS8rD53NvMj6f6o8NiM=
X-Google-Smtp-Source: APXvYqwd3ypQ+e+AoeCL+gIzDmZiKhn95o0DMQIEbOeiYL+nEk0sVv8u27kNifHdu5OFTn+HtEiT1g==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr24644192wma.120.1555355999492;
        Mon, 15 Apr 2019 12:19:59 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id 204sm27243187wmc.1.2019.04.15.12.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 12:19:56 -0700 (PDT)
Date:   Mon, 15 Apr 2019 20:19:55 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/3] *.[ch]: remove extern from function declarations
 using spatch
Message-ID: <20190415191955.GE1704@hank.intra.tgummerer.com>
References: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
 <cover.1555352526.git.liu.denton@gmail.com>
 <7895255fdbe027b671a77dac6d0ee2e4700974be.1555352526.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7895255fdbe027b671a77dac6d0ee2e4700974be.1555352526.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Denton Liu wrote:
[...]

> -extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
> -extern void *object_file_to_archive(const struct archiver_args *args,
> +int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
> +void *object_file_to_archive(const struct archiver_args *args,
>  				    const char *path, const struct object_id *oid,
>  				    unsigned int mode, enum object_type *type,
>  				    unsigned long *sizep);

Just skimming this patch, I notice that this now leaves a bunch of
oddly indented parameter lists behind.  We might want to re-indent
those as well, as part of this patch or a follow up patch (so this
patch can remain purely mechanical).

Personally I dislike this inconsistent indentation more than the
extern keyword, but not sure how others feel about it.
