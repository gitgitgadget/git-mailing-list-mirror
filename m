Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02ADC1F406
	for <e@80x24.org>; Mon, 14 May 2018 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeENRlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:41:16 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:45265 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENRlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:41:15 -0400
Received: by mail-qt0-f172.google.com with SMTP id j42-v6so17195074qtj.12
        for <git@vger.kernel.org>; Mon, 14 May 2018 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YiD4Z4jqE25LrFrhz7gQ0EZSuCIS5DetQLBMV6OXbzc=;
        b=HvLEd/UUFeEilSd5Fmaa4zO7XNkOZXH1bD5qHv+ZlUFG+Q/dpQF4Rq5xMrCFBcy9wt
         cv6tmP7rWAAeupmbZGkPaJblOcrcF97xX3866LFMK0GfxYuz9/dcFYBDUYy0abYLu/GM
         Ds4JISkHW8AfNJcl7sgadlh6a/SZN0Hcguv50YgnknqHcOxC6M6VdGAZPT5IWGLcSStO
         wyhhTzI8xqw/grnDjcRfmImU7mIqdv4OlydjpDjCOWXM34Y4pGx62n++zIQCNccWddt2
         GtqlcQxFsZ/UCJLegdHWTJqp18eAFHGXni5+bmxm5OvbJirClg5C6dR2ep4LZRRTtn2r
         wiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YiD4Z4jqE25LrFrhz7gQ0EZSuCIS5DetQLBMV6OXbzc=;
        b=OXgHRaHS4aFqnfwVw5LlOKiYyb6D9WJz3h9X+fEMCyVta3kQjqN0ekDL+ZFKX9CLgL
         uKGCvRw/K5LmWPBz5D2M0vAUf3eoerHh/0KGFd177iBRk2M6lxYFZEHzAScO6vCfaIUx
         bnjvr3ZqRuchRR/PRDBUhSzW4zDHj69mm9mWxPKhCbOPZjHUFiWRgZfHsg3wTq73b99Y
         078sVpb5wpqQqe3H2YbXh3cFpED7wmVI4DswRfhigyX3mLattSvtjg2YURImim6uqttX
         JffH1AXlCWa5a622ooq8RO/VwsK3+riOdyH/vYZs5L/DbisafQkqFNx+pgr8wx0kW9WL
         IdQQ==
X-Gm-Message-State: ALKqPwcGvpjfzFsdrztNHjwLVO3JHOTdJDFqnXJ7u6pNeatmm9+kUf96
        1vN0NwzNgWMyYrQSUnhyDZMlRtAh049ySNJpJO96ZQ==
X-Google-Smtp-Source: AB8JxZpvaWgx5lnn43uO2pmZez9rIvN3cmNyOjl7XQo84CNc97bVyzJ1p7itHQqxm4WXWvk5QrBajKd+5ctvT6MgIGQ=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr10291582qti.35.1526319674623;
 Mon, 14 May 2018 10:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Mon, 14 May 2018 10:41:14 -0700 (PDT)
In-Reply-To: <20180514102812.7924-1-szeder.dev@gmail.com>
References: <20180514102812.7924-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 14 May 2018 13:41:14 -0400
X-Google-Sender-Auth: 9-7ZZV07XJQGnOa1l--sZGN34rU
Message-ID: <CAPig+cRx8WZ1+DoxoJV3w+568DN=XqLMnfT8vmL8tb5FrzvWLw@mail.gmail.com>
Subject: Re: [PATCH] t7005-editor: get rid of the SPACES_IN_FILENAMES prereq
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 6:28 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> The last two tests 'editor with a space' and 'core.editor with a
> space' in 't7005-editor.sh' need the SPACES_IN_FILENAMES prereq to
> ensure that they are only run on filesystems that allow, well, spaces
> in filesnames.  However, we have been putting a space in the name of

s filesnames/filenames/

> the trash directory for just over a decade now, so we wouldn't be able
> to run any of our tests on such a filesystem in the first place.
>
> This prereq is therefore unnecessary, remove it.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
