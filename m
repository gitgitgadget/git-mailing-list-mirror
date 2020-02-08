Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C576C35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4206B21741
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAjTOEuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgBHHyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:54:02 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:36589 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBHHyC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 02:54:02 -0500
Received: by mail-il1-f174.google.com with SMTP id b15so1593240iln.3
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 23:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MX2mHhjlO7crwEHDGMFnb88R44dU3g1TrUU5AWIWyXk=;
        b=SAjTOEuHBtpIFuskDflRSo+JYeKu8bNLCo2Xb3FG5DmUm+Ea4WeVn86qXSB1P06Ff7
         ZDdSTwOwNruuuIRGwmW4f3FxeFSC+qFK68jjBvSUEtq/vnMWX6YXFSNcVb0nIhMfak5v
         t7jJJTZVWfTEY/f0IJNe7ffJecGAlm/s87xegJw630sSdXfpNBFXlL7btHuGiDdlIaee
         7WZ0E5VHEjacJRQqYLz9xw7NVR0bMc6ITXe/jq4joEikbNDBlSr/KAVGdN2vd/zM01J7
         bfc5PEZWX7vubFxlulAAq3wKVUZeu5DyHGHRDilegXayVkp6zjBsxjrXws3JoS011U9U
         3ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MX2mHhjlO7crwEHDGMFnb88R44dU3g1TrUU5AWIWyXk=;
        b=RN37YXHWjTqtKQS3MUMuLvNj0+/ZKQkKxpMuuIneEyzFXtx+2reZajipkgmTs+aN65
         WFtbTDkH+iGFyrKFmk/qAFp/h7ILyq0xc1GfBKkVrqJq8Aas7pAiTr5m6S+uZJr3DGf8
         uf5KaBHQev4Pdc3Iq8ValVgm2m8cCV8IOFnW5jmbv+uG0IIHyF+78/v2DMniC3OWIJDR
         zLcElW4yfyue38gdA8sP+kV2jQBM0V394nbwhj+H83G9rAPlgrY202O7gTR6aJlCee/F
         sO3QTHW79B69iTbZ7hQz23f1FnEuT/BKP5awUvT5i++F04/i38NoKw5Y//gg2F/LifBd
         Lq/w==
X-Gm-Message-State: APjAAAWS9r7zd7SXXSvXoDN9Zk6rl5Ex4MBz6FkHGGDhr1QMwnEdgPPq
        DWboVAXgGxHNWHlYw63MEdekiWaLISqW5ESBq3jJAg==
X-Google-Smtp-Source: APXvYqy4zMBIW1iTioQCtc7u9KI8WyYeg6Zi0Z5XsGx2IJOTdS/9vR6qJf9rQgh1zCjgxAxcSHADSW75UevF1xESAkc=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr3279326ill.55.1581148441937;
 Fri, 07 Feb 2020 23:54:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 8 Feb 2020 02:53:51 -0500
Message-ID: <CAH8yC8m1M5Vg4Ftzu6dQxmQN+KW=FgmUYG6767ygyiLfX8qx4A@mail.gmail.com>
Subject: Git 2.25 on Fedora 1 and Ubuntu 4
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I was able to update to Git 2.25 on Fedora 1 and Ubuntu 4.

There were some minor hiccups, but the tools are still building and
working as expected.

Jeff
