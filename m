Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F101F42D
	for <e@80x24.org>; Fri, 25 May 2018 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeEYGX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 02:23:26 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33053 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbeEYGXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 02:23:25 -0400
Received: by mail-qk0-f176.google.com with SMTP id s12-v6so3276805qke.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7WiDrh4fUYWVw1f5H62KVpe11e3xRwP04lShMxgCY0=;
        b=k81pR/D0W2oVPBjAywOyH0BSqdvGUwfywVCj3d45df2YbpAyj34PXLMJeaX/jiylPh
         5c4ltrtfh86MKtE7XESJeL5jZSSAoNc8chlihvdfM9Dj9N8HPJ3daTSDB7N1ln4yjgCN
         NGyf++Z3JGdoCr3tWsKdzZEVQ6SeHXedRXCsi5ImlQwfUXuTyFtywOO4wAcnHpbzThzU
         EaE01wzvFdUrR8/JPrhLMXAxy3W3uinN7Nv7Kgr8aoV+FuVcPAE/eYPc3F6PytJ6WPEA
         vskwIS42Wzh2upk1EbjQkW8vPxvt+ANMIk4UTyYT8OC/5VV6mSQMrESVKFxzRqmN68Uw
         TedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7WiDrh4fUYWVw1f5H62KVpe11e3xRwP04lShMxgCY0=;
        b=Ohk9YCzcRmUndmvoynleAWVUKO0UkknuOF1pDJfIJlO1owwU3APLhlyKq/av+9Bh8U
         5MEnMXyoQsSDWf//IwS7d6zKVKV8mkAK8Wvcm4fQYjCXC+DZF7s2CVZ2NahIMpVdWnP+
         KCt9kpJXFexELhUVUbiG3dbmU6EwY6+OGZrSI5tk477KH/MpoiFkBO7KqApsA5GeKdVM
         o9hJ84wonTstqgt5Vtha+CpQgF5/2A43jXRtM43//EeFC6yLNrWZdPJZm82Jed7ixY2/
         fQfSzJ+Ulg5y/GuS0BKamoAE3ZgoBIFzgWPDdLj0mcX9If2fAWxsevunlmjRtzCQsvUS
         kbfg==
X-Gm-Message-State: ALKqPwfFw97M7jqg+D1SQya9qNr4gqeYDXHTuts1CVoe37KKUHXH6ZtD
        6GEyhlVuiPhdmUFFU5cBrjkYkrdGoAadF6rHEA2h6zYq
X-Google-Smtp-Source: ADUXVKKmOc3/tnYFGBsYA57g7L06eOnSuKmoLDEWqu8L4fgSXLZ4PO/x45LCi/oPEzBIl53Nqd6un04wybHNFhM2uKg=
X-Received: by 2002:a37:8942:: with SMTP id l63-v6mr817648qkd.293.1527229404890;
 Thu, 24 May 2018 23:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFazEUP5QJ+WzTkDK6qcgvW5Xwx79KYJWeb1vg41=pS8E8vypQ@mail.gmail.com>
 <CAP8UFD0ZLsZ97OJYyVTC0fqUJfxJyMzE+PRE4uYVwhDqdkgRTA@mail.gmail.com>
In-Reply-To: <CAP8UFD0ZLsZ97OJYyVTC0fqUJfxJyMzE+PRE4uYVwhDqdkgRTA@mail.gmail.com>
From:   "Etienne d'Hautefeuille" <sagoum.kakoum@gmail.com>
Date:   Fri, 25 May 2018 08:23:13 +0200
Message-ID: <CAFazEUNX4eabQWpEXa74a0vCCHyJMNcdS0ZCm9Xtm2qHGNMLJw@mail.gmail.com>
Subject: Re: git difftool with symlink to readonly jar failed
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

same problem with all program, There is a crash before the launch

> git difftool --dir-diff 4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
0244799661b993b1f78fa5afb621de3fe4c4a39c --
fatal: could not open '/tmp/git-difftool.g80nLO/left/jenkins.war' for
writing: Permission denied

> git difftool --dir-diff  --dir-diff --tool=3Dkdiff3
4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
0244799661b993b1f78fa5afb621de3fe4c4a39c --
fatal: could not open '/tmp/git-difftool.R1NgMw/left/jenkins.war' for
writing: Permission denied

> git difftool --dir-diff  --dir-diff --tool=3Dbc3
4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
0244799661b993b1f78fa5afb621de3fe4c4a39c --
fatal: could not open '/tmp/git-difftool.MNyx8b/left/jenkins.war' for
writing: Permission denied

> git difftool --dir-diff  --dir-diff --tool=3Dkompare
4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
0244799661b993b1f78fa5afb621de3fe4c4a39c --
fatal: could not open '/tmp/git-difftool.lj82wR/left/jenkins.war' for
writing: Permission denied

Le ven. 25 mai 2018 =C3=A0 07:40, Christian Couder <christian.couder@gmail.=
com>
a =C3=A9crit :

> Hi,

> On Thu, May 24, 2018 at 11:11 PM, Etienne d'Hautefeuille
> <sagoum.kakoum@gmail.com> wrote:
> >
> > #try  a diff
> > git difftool --dir-diff 4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
> > 0244799661b993b1f78fa5afb621de3fe4c4a39c
> > fatal: impossible d'ouvrir '/tmp/git-difftool.UQ4mqo/left/jenkins.war'
en
> > =C3=A9criture: Permission non accord=C3=A9e

> You should use LANG=3DC so that people can understand the error message.

> Also git difftool launches another program that will actually perform
> the diff. It looks like it is bcompare on your setup. Did you try with
> another program?
