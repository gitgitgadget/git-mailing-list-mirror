Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7854207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165896AbdD1Rul (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 13:50:41 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35577 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165918AbdD1Rub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 13:50:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id v14so51769140pfd.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CugboRWYQY2Ypkdgm1J7g3HKomujcnzLIU+L9HFrtqE=;
        b=ivu1dkRiiAtSXpJlTgkx6Km5unBPXFwR/d+WO+ZAKvX6bNIlB80w4hbTxCRAMcuS8+
         CKfxTtORxb9kMgn295WPxQ4XMU4z5ZStx81TPJw/iHsrIGlHJn4BWC/HhithSwFMc0pc
         FMhtzCBYiw7FifjNIi+LjB3RfSR8eDhDhdILqGCN7YW5Gp6FS1UXCSEFJ/UiM06ayr0d
         9nEm13Qa+54T2cuR5FtKVjJ3oW7hY/ztBLosIJQEA/FmARkTb5GphuBfKkSg538zbp6E
         3Q5z+Y2izOTVZIVzYyQKWSOzNVGpkIhlUFtSNfxflY5CboTCWPCJDJzDVJQlBnRsz3w+
         VBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CugboRWYQY2Ypkdgm1J7g3HKomujcnzLIU+L9HFrtqE=;
        b=AgyW8MbEKl+vNQXOrT5+XRfUZili2mVbOoq0w9jktF6VMmg9owSXJlfwM55MzQZ7vv
         urp3/QXkgnDniMSk1fNcKhtM2cSb/7wHf9dg4sm7UHGY4xEtPOSY6gQZNaXpQt4myOFh
         ZczfrzUkAXS1qqbdmf4i+udvT3bSEeMhm6f4LbAyqXx8gy1ereniu8gvdNznWLO+tGSe
         xH8W+sTeWHSqBBQMcyTJ5EUo6X2WwQT2fq8szyDjDJH0QUe8k1Ql/Y8l0UWr7BkFglJW
         PUlLGLFjkhgAs3kmoJoWVRUMc1w3fV0AHhnIeZeulFPG3mBTvEbCLnaGLMyZZfZJOwEn
         5oZw==
X-Gm-Message-State: AN3rC/7g6yGhSVEbTkfHTYzbQHETYU7QcGneo8mubWZ3J4eKQ2CHaqOP
        f14pKujLPdUISqrxC4pWSmzrWxRrWsfn
X-Received: by 10.99.44.140 with SMTP id s134mr13368879pgs.178.1493401830399;
 Fri, 28 Apr 2017 10:50:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 10:50:29 -0700 (PDT)
In-Reply-To: <CACBZZX7VHURHOoRMmcJq1e-pv7x3gKhYyWF5F5X+FgbunY-xhA@mail.gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-4-avarab@gmail.com>
 <CAGZ79ka1_eJEa56TU5v++1FKsGY=nvZ4rWBK1begKvqecH17mQ@mail.gmail.com>
 <20170427221337.GB146047@google.com> <CACBZZX7VHURHOoRMmcJq1e-pv7x3gKhYyWF5F5X+FgbunY-xhA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 10:50:29 -0700
Message-ID: <CAGZ79kYYXKmiJUshss0E+L8qqBX=qt636Az3_0iZX2ZW8oojdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] tests: rename a test having to do with shallow submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 1:59 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Apr 28, 2017 at 12:13 AM, Brandon Williams <bmwill@google.com> wr=
ote:
>> On 04/27, Stefan Beller wrote:
>>> On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>> > Rename the t5614-clone-submodules.sh test to
>>> > t5614-clone-submodules-shallow.sh. It's not a general test of
>>> > submodules, but of shallow cloning in relation to submodules. Move it
>>> > to create another similar t56*-clone-submodules-*.sh test.
>>> >
>>> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>>> > ---
>>> >  t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shallow.sh}=
 | 0
>>> >  1 file changed, 0 insertions(+), 0 deletions(-)
>>> >  rename t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shal=
low.sh} (100%)
>>> >
>>> > diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules-s=
hallow.sh
>>> > similarity index 100%
>>> > rename from t/t5614-clone-submodules.sh
>>> > rename to t/t5614-clone-submodules-shallow.sh
>>>
>>> Thanks for formatting the patches with rename detection. :)
>>> The rename looks good.
>>
>> Do you have to turn that on or is that on by default?
>
> Looks like it just uses the diff.renames setting which I don't tweak,
> I didn't do anything special, but maybe it picked up some part of my
> .gitconfig that doesn't look like it has anything to do with
> renames...

After reading the man page of format-patch, I do not think you'd need
to configure anything special as the default settings easily pickup
a rename with 100% similarity.  It is only hairy when changes are in
there as well, then you may want to play around with -B/-M.

Thanks,
Stefan
