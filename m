Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261C31F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJEUOr (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:14:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46710 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJEUOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:14:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a2-v6so6453390wrc.13
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CVKc4FyNTlPk9stKhiCtH7AeAHPggkU4m2lEkaApvgc=;
        b=ibaWBpC0lmg5E+tVVmj3cw4tc2u8jCTEpKuRNtaG2oq7eAHFOnoWcv2UvyJBa5CBUT
         5VnopEngRYThQ/JWTlmCZUySMDKVcADi0r/DCsBcnG6d2WKpVHKgb6hEX9ADzeT/0KuU
         ofoDa5JqbuGjbSaDcz9ftqWqBQUerdyYnwJ5WxyjWIxl8lHHYSa6WHuQHVw9i9PchAAR
         gZpx+ar0At2pK8YEpw8lc434mAOYAXBfSk0/800FsPOYgFjzBrpu854vjjywty20k2/g
         ZpE6ZSYZzbCJWxsPosfG0uRJu6r8wscZqmhIe868gLP8LMQ3KQyoX5PXw3opgdlSeBza
         KIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CVKc4FyNTlPk9stKhiCtH7AeAHPggkU4m2lEkaApvgc=;
        b=ZHxZtPD6EzrMI3WEbsD/FQzRpUoPbszpUql6BKEOE++wca6BpZi7DcDKXGrBHb8V/b
         rRx3xToXdog2K18fOo9OySMXXPxEplpms+MYhpmLyQHPTGhYeJgCJnBXQkdO++kIH/BF
         DjtP6zd0S/vMK/PSXw3a3xPMAOFCTfPRnoAUJvv4WsFpZ4VR3Nkc9dPa2/RWBH8sLRrn
         vK608j/sETl/Zh8IR94NCE4J6Nl0k6Upbon6LL9NbVgFloFDe9UosHs8YFoC8SkFpG/L
         8P3zZOd3YLt8mlNjcGW7ABJz01C2TwGTIDbTj2nm7H+qKWw2L7ymrKB39ONKl/dH9XY2
         KJnQ==
X-Gm-Message-State: ABuFfoh0AjLq6AFMJBJURKtpt4FkwWKRfrjHMVsy8d/cMlXojPFq+uC3
        kwhqB8CX6s4H8Bw6qIz6wzE=
X-Google-Smtp-Source: ACcGV62PSvTJ2EVB5Somrqm9kn9Kitp51stdpGBtfKRFYdWeTx/lpnx3bsnKcMrAe70f3qetWskd5w==
X-Received: by 2002:adf:9d26:: with SMTP id k38-v6mr8798488wre.18.1538745364921;
        Fri, 05 Oct 2018 06:16:04 -0700 (PDT)
Received: from localhost (x4d0c6f69.dyn.telefonica.de. [77.12.111.105])
        by smtp.gmail.com with ESMTPSA id x139-v6sm7091006wme.3.2018.10.05.06.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:16:03 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:16:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eneas Queiroz <cotequeiroz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Error while trying to git apply a patch; works with patch
 -p1
Message-ID: <20181005131602.GU23446@localhost>
References: <CAPxccB1VnDV5BjkcFcoPVmegJSg6iN_tD3o0e9G2XKXaM_=4KA@mail.gmail.com>
 <20181004214533.GS23446@localhost>
 <CAPxccB2B2Cq=CQZ3D8rmvqc63pUV3f1hc_Ngt5nWStR-getpjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPxccB2B2Cq=CQZ3D8rmvqc63pUV3f1hc_Ngt5nWStR-getpjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:17:54AM -0300, Eneas Queiroz wrote:
> Em qui, 4 de out de 2018 às 18:45, SZEDER Gábor <szeder.dev@gmail.com> escreveu:
> >
> > On Thu, Oct 04, 2018 at 06:01:11PM -0300, Eneas Queiroz wrote:
> > > I've sent this to the list 2 days ago, but I can't find it in the list
> > > archives, so I'm sending it again without files attached.  I apologize
> > > if this is a duplicate. One should be able to reproduce this with the
> > > current PR files, but if not, I can provide them.
> > >
> > > I've hit a strange error while trying to apply a patch from github
> > > here: https://github.com/openwrt/openwrt/pull/965
> > >
> > > 965.patch:452: trailing whitespace.
> > >
> > > 965.patch:559: space before tab in indent.
> > >              -o $(SHLIBNAME_FULL) \
> > > 965.patch:560: space before tab in indent.
> > >              $$ALLSYMSFLAGS $$SHOBJECTS $$NOALLSYMSFLAGS $$LIBDEPS; \
> > > 965.patch:564: space before tab in indent.
> > >         -o $(SHLIBNAME_FULL) \
> > > 965.patch:2334: trailing whitespace.
> > >
> > > error: package/libs/openssl/patches/100-Configure-afalg-support.patch:
> > > No such file or directory
> > > error: package/libs/openssl/patches/110-openwrt_targets.patch: No such
> > > file or directory
> > > error: package/libs/openssl/patches/120-fix_link_segfault.patch: No
> > > such file or directory
> > > error: package/libs/openssl/patches/1.1.0/100-Configure-afalg-support.patch:
> > > No such file or directory
> > > error: package/libs/openssl/patches/1.1.0/110-openwrt_targets.patch:
> > > No such file or directory
> > >
> > > If you get the patch file from
> > > https://github.com/openwrt/openwrt/pull/965.patch and apply it with
> > > git apply, it fails.  If I apply the same file with patch -p1, it
> > > works fine.  I've tried it with git 2.16.4 and 2.19, and they both
> > > fail with the same error, and at least 2 more people have confirmed
> > > it.
> > >
> > > git apply fails even when using git format-patch -13 --stdout as a
> > > source, so it is not github doing something weird.
> > >
> > > The file is a series of 13 patches.  If I split the series after the
> >
> > So this is no _a_ patch, then, but a mailbox of patches.  'git apply'
> > is supposed to apply a single a patch; apparently 'patch' is more
> > lenient.
> >
> > Have you tried 'git am'?
> >
> > > 3rd patch, it works.
> > > Also, if I use https://github.com/openwrt/openwrt/pull/965.diff, it also works.
> > >
> > > I'm not subscribed to the list, so please CC me.
> > >
> > > Cheers,
> > >
> > > Eneas
> 
> Thanks for the reply.  Is that expected behavior?  git apply seems to
> work in most similar cases.

Oh, I'm surprised by that; but I rarely use 'git apply' directly, as I
apply even single patches with 'git am'.

> git am works fine--although it complains a lot about whitespace errors
> when patching *.patch output files.
> 
> I know they're just warnings, but perhaps git apply/am should suppress
> them when creating/patching a *.patch file, since context lines in
> '*.patch' files all start with a space.

'git am' and 'git apply' don't know or care about filetypes, and
neither does the rest of Git for that matter, unless you explicitly
tell them to.  With a proper .gitattributes entry you can tell them to
ignore all or only specific types of whitespace errors in '*.patch'
files, e.g.:

  *.patch -whitespace

or

  *.patch whitespace=-space-before-tab,-blank-at-eol

