Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA85211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 12:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANMVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 07:21:18 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34454 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANMVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 07:21:18 -0500
Received: by mail-yb1-f195.google.com with SMTP id w186so7632810ybg.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fETFEX3QERZSTBorCG77WRDf1p041lOyjR0K3f9aDZk=;
        b=OQkwC+HxctER3CmJIVCq9IcEPROxKBWojzNiQ6lC2XzKGSh25TSBuMm22p8IbUyG0x
         ju1N1a748CH8EWMk1oNNUvLJfZ+PJuj8hdtMzh5+Rdk+rhyICbVSs9yd1v+hDX88Z0+b
         EAW+sKUIMj0dCGSg+AL2hxvK6IhZHIXldX/6cUgAMDQ5eqt4mch/qfHqzSHVv/bE5ZPK
         dokZ1bnBjB/VYPEVpNL1MHsuLMRe5HNhaCI7fLf0lNnINZ9QZRVXo+nhWklf5W3fR6ZQ
         8o2C/TFohDqnnZL7SoZ3dxxdGue4XmSwytwmxKrQMzZ68hkQPWHiIU3KWaiWYG+4WDCo
         BOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fETFEX3QERZSTBorCG77WRDf1p041lOyjR0K3f9aDZk=;
        b=iutlnYFNFZNWx5neV7fM4Ok2mmssbku4e3L45po9sghOx7dcUS7L9+eFl8PYQEY/9G
         aD4r1dqyjII1CJXuWXTqmYErvVApBUnI2rq/ozSUgXk4enRkUbw4u1lU4O3ESD2mcDk+
         vl+KlanbtpdT3OdMnW9clLKcv3FvSj4iX+hC0Nbjg1YYezUBRcNASVGlh4ZAqIjJNFb6
         dhHqSccDEF82R0aL7WL3C7d30pV1JXEbNgFDqK+hREz03lFwxb9Iob2qo1d518keUHgf
         a4wj5/PbJo9o1ORmtc52m2hsdmUUWUEq3ukRUl5k4e6oHcum8FNnRBnpMeMWCsrh7n1F
         d9Hg==
X-Gm-Message-State: AJcUukfit0ovRnVkD3fNlOiYil1wKvhpch4/w9Dkc3wQDT9rmDjcvRvv
        uUnL9/8n93vINKUl4TMGFAygZOBAgdDQZ6NEAx0=
X-Google-Smtp-Source: ALg8bN611YxMVWj87LlpFT1FE8Z6Q/P8XqfBohORn93arkxSW+R1GUQgEh5XlyKGXP3EB38z9vi94L97xnPmxr4Ue9U=
X-Received: by 2002:a25:b091:: with SMTP id f17mr23107700ybj.25.1547468477275;
 Mon, 14 Jan 2019 04:21:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxUDN4xKD9GfmOEx1bW1jDeWUgYgg_xdAtvLrFgMV2oCLQ@mail.gmail.com>
 <CAHMHMxWutm=jWC2nLJCEEE4CZ-ERc79vvwrbo8VnfC0VGwei0Q@mail.gmail.com> <CAGZ79kZCSen-jNE=XCzVds-gxFsnkK_nPoJw8sE00bXtTPf5+w@mail.gmail.com>
In-Reply-To: <CAGZ79kZCSen-jNE=XCzVds-gxFsnkK_nPoJw8sE00bXtTPf5+w@mail.gmail.com>
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Mon, 14 Jan 2019 14:20:41 +0200
Message-ID: <CAHMHMxU4ngCKYxc3CLw6QFjzWPf0AThSODKRPbFF+c8fGjEPFw@mail.gmail.com>
Subject: Re: git difftool does not give the --cached option
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FYI $ git --version
git version 2.20.1

solves this. I am not aware if you somehow track them / how to close
this thread.

Ntentos Stavros

On Tue, Oct 9, 2018 at 8:59 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Oct 9, 2018 at 7:33 AM =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82=
 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 <stdedos@gmail.com> wrote:
> >
> > I have install the latest git version from the PPA:
> > $ git --version
> > git version 2.19.1
> > $ lsb_release -rd
> > Description: Ubuntu 16.04.5 LTS
> > Release: 16.04
> >
> > However, trying to autocomplete git difftool --cached gives:
> > $ env -i bash --rcfile /etc/profile
> > $ . /usr/share/bash-completion/completions/git
> > $ git difftool --
> > --dir-diff          --extcmd=3D           --gui               --no-...
> >          --no-prompt         --symlinks          --tool-help
> > --tool=3D             --trust-exit-code
> >
> > Please direct me on what would require more attention.
> > /usr/share/bash-completion/completions/git is the same as the
> > git@master/contrib/completion/git-completion.bash and e.g. here:
> > https://github.com/git/git/commit/6cc4bc15f92e85b41d9da9075905f20c6a900=
8fe#diff-f37c4f4a898819f0ca4b5ff69e81d4d9
> >
> > It seems that --cached exists.
>
> and it seems that there are more options that are not completed,
> not just --cached. I don't know offhand where to look further, though.
>
> >
> > (Side question: What is the "--no-..." option shown? I cannot seem to
> > find it anywhere in the documentation :/)
>
> Answering the side question, see
> b221b5ab9b (completion: collapse extra --no-.. options, 2018-06-06)
> https://github.com/git/git/commit/b221b5ab9b92f3def37184db6e052ec87d7635b=
4
