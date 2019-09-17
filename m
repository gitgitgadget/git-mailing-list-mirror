Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38A81F464
	for <e@80x24.org>; Tue, 17 Sep 2019 22:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfIQWcn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:32:43 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50251 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIQWcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:32:43 -0400
Received: by mail-vk1-f201.google.com with SMTP id f199so1900941vka.17
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KNrk3EpmS1p1kW8VKH+Pg9Qs1vkX4VNmMpQ0eNxf+yY=;
        b=obS56A3ynE9WOhYmgdw3TxLOIT0F3LnQ2EW0xaIFU7wT4l6ZsJ46vcD22hTQqbI6Q8
         QB2T51q1Z45xVxSwrLH8dXeuLDKXfMardiO8K2tzZTIfKvhlaYPqjrFdfuO30ThBbOu2
         p633BZxaOA2CfzY6a0md+Tf8BBCU2VbdR/TEi6lP3ta98+LDF4KWEXDkTuq/I2dfLZiD
         7l3QqoYVfX0QYVN+f6d5cYXnaphxp2yIlAp4dtDtAOkA2/IOE7JfLZWtknDdJKVk86S6
         7FMfmTrLM2b4cmMWENiL5r6LcTaEq9Au2Ms2myK3KwdmtcZvxQ6ZxI2NRzRIsQJIE5tQ
         mMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KNrk3EpmS1p1kW8VKH+Pg9Qs1vkX4VNmMpQ0eNxf+yY=;
        b=axuBla2LYcLUZwpnorzxMtaEnDZbMFm4W+oixu6GFEPm+Dj0FQLIMC7Yefzk5olhgn
         S+Lb82cw3pH2QGV8ezC2Ml952wl9NVVC+Uv2pnBOPSFVG15dKpiK0ex2IQrCB2YdX5B/
         KD1EC/ctIT+TpfHI6ZG2zdKURVxyA9WTQEcpqR37vH2o+VSR7mzcPoYtDhBBbC2a/CzI
         W9pFAvn+YvmNuUCfuze2G7QXfezhcnf5W6KaC15pjsmIZgNz2xFIlG0lwKRV8Da8sFlv
         vaMQpfSTyVYF8GT2cssNDo0BSH1bGRVl32Egmin0SM5XICFuvo/dU5v9tqcMeSYXlITc
         ueoA==
X-Gm-Message-State: APjAAAV5BSE7xSUh4CrFHXB1pXmcyTfez6zLOhb0R20WS5lLkFRMSzAi
        r+IInnbzpKEa1QQVsFUtzITse1mBO0FChciX3WLV
X-Google-Smtp-Source: APXvYqymS6vMv0r/xPj6Whmz5045gTNFuk8u/j1P+3qzTDD03oDXTxC3x7ww986ya0DoUjbui/vLwogkguh1d05vz25S
X-Received: by 2002:ab0:6244:: with SMTP id p4mr777791uao.0.1568759561027;
 Tue, 17 Sep 2019 15:32:41 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:32:36 -0700
In-Reply-To: <xmqqh85a7eax.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190917223236.149613-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh85a7eax.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When the working tree has:
> >  - foo (symlink)
> >  - foo/bar (directory)
> 
> Whoa, wait.  I assume, since this is about merge, the assumption is
> that the working tree is clean with respect to the index, so 'foo'
> is a symbolic link that is in the index.  Now, if foo is a symlink,
> how can foo/bar (whether it is a directory or something else) exist,
> which requires foo to be a directory in the first place?

I was trying to be concise but I guess I omitted too much detail. This is
what's happening:

Working tree:
 - foo (symlink pointing to .)
 - bar (directory)
 - bar/file (file)

And the new commit:
 - foo (directory)
 - foo/bar (file)
 - bar (directory)
 - bar/file (file)

I'll update the commit message when I send out another version.

> In any case, if the working tree has 'foo' as a symlink, Git should
> not look at or get affected by what 'foo' points at.

Git should not, but it does - there is a call in process_entry() that calls
lstat() on "foo/bar", which indeed reports that "foo/bar" is a directory. This
patch adds a check that none of its ancestors are symlinks.
