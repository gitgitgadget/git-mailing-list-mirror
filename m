Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075A81F770
	for <e@80x24.org>; Wed,  2 Jan 2019 18:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfABSbz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 13:31:55 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:35662 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 13:31:54 -0500
Received: by mail-io1-f50.google.com with SMTP id f4so6973359ion.2
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 10:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTCk5F6E9VOTg4y1hwP9Qd8PYb9A1PKQMKGmWwcTsD4=;
        b=hK6Lv86DQwSwtL1UU19bsTdQ2HFyvmJbgOZ5Vr6Nbl87eBNOTyqgP0N8BtRwjFFiUl
         1JbAazvFpF60ASjBUDUYfrDOxsqLqWcjToi4hMffkU2gudj52SZKbRaxXztyButwagoi
         CbUASjYQ6saqjr/ouXIBPzEvrzKb+YhUdO5Ypq+u9mWToq/c7+YktI8Us5vEsyUMQVja
         aO9QthqcKZH5NBxeNbtv6Je6UBxC2yKzMdCFDy3YM1AOTEQ4xcB1Q1xK8gfHEKSLwX5y
         tGwP27he9jcbG7WMd1mpdbFkM2uDqA4czTjQoYSXR2sRujPK70OAiSSrxfOUgteH3+Lw
         RrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTCk5F6E9VOTg4y1hwP9Qd8PYb9A1PKQMKGmWwcTsD4=;
        b=jWaQTv90IVyRQ8ppqR6ZyqexRlnNtvap+2hTXiTYIM+pSOepQk/vgwgZGGGcbYWGDQ
         669VEn1ClXnYkSQHiIoAMpe8n9njePFcUAODNcwyq+KC1eWhy5cfacgbiv4b9qTV7S0j
         0RD9w0IP/7rwmu66KqUhwhsCE343fRpKBf5LTS5VU+W/hxu6DrBbQtkOG9+OPF3RuSBp
         lUgdHAy2vIzJ6gpqKMWfKeJxZUYGcaUxfzxI5nzAfU50yOY5dUhTTpsNyFEBZAM8xqZg
         0fQC2xGjSGIv6yXBUnDgePiFwKM4SJo5DPzH5To2PMW2fT0IvH5cwURvKP88b5ff1Oac
         ObWQ==
X-Gm-Message-State: AJcUukd/YiR4X0DmmeCs0YvJ1y3C2n5sylF6ZFI3NTkZfu7bQjhnKcnb
        3soB0e40p40iRq33amQMuyrTsLeBKV7qqwQyNnI=
X-Google-Smtp-Source: ALg8bN5em/Gi7RviFZ7LL+UEKufJ4QdMnDikOkyJK46JE7WkhqXziWzmvOBjI3YtFJdJjXp0wbRKptqb0csPa4P3+3I=
X-Received: by 2002:a6b:c3ca:: with SMTP id t193mr28658099iof.269.1546453913846;
 Wed, 02 Jan 2019 10:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20190101231949.8184-1-szeder.dev@gmail.com> <CAPig+cRLqy3Zdt4rUbMXC2dd1bhOXYZ=8HEn++zsb=Rau7zADw@mail.gmail.com>
In-Reply-To: <CAPig+cRLqy3Zdt4rUbMXC2dd1bhOXYZ=8HEn++zsb=Rau7zADw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 2 Jan 2019 08:31:40 -1000
Message-ID: <CAPUEspiQyKnUWekn5iYQTP6F8CWW1rr4jSbuFUH+sS=iY9GfSg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using shell arrays
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested-By: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
