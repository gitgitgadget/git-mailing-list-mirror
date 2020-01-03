Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53840C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 12:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A59820848
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 12:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+fjMhgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgACMkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:40:21 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34245 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACMkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 07:40:21 -0500
Received: by mail-wr1-f48.google.com with SMTP id t2so42311658wrr.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/9E0MDWQ1PcolRwos+7nnT4MygrDtJly0Ow0xu10g2w=;
        b=M+fjMhgqV+L1FooUovIK0Pn/MwMgbZxo7PhpZE4a1YqwKb8rpy8Lu2n4daR5/fPfFg
         BywySd+XIzOnzAJ2pEcQVL4xDrtdF/VGYcBWfLoPVvvoifXXLq+BQum6b4qcMj8n/Zn+
         wE8yCaGDoWTl23dJzG2OqTw9/7MYm2k0FFJmxsD11XJuPIq63sBxMqBejY/udb7uWjKj
         KXsZxmXJWSCD48sXsRhRU7tXX7au5EbD6A2z7Mt1PUirGjCrPrYHbcpUJOV3KsAPaTp3
         HrREuD0XhQX+2Rl2JjLzxFtsMW2M3liUEqiBvkpYpiX9RfVu0HkmDDFZnG/0gC5oUVu1
         0fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/9E0MDWQ1PcolRwos+7nnT4MygrDtJly0Ow0xu10g2w=;
        b=Sn6MjJdkdayqHPPhjo0NCfBs5FIV9q8a97WFzgcka+9UUPqSJUHpDaWnv/jfaEhoKu
         yUmYkBKB8sNsJ1BX1y11dG84hIaBFgdIyhmbaqopmdR9LwtSMGSUccmpD3zPXWQQrgP4
         158P3kqimXybIOg8dw6Wz4yNMRCqehjkBgDoHAPXVZfCntnehkn1OfESusrCKDD38oiC
         PD7vrHi9pdvxfUQbUkdnDFne8liEdX8RrcEqYQUlBFJMUafOvyQ+oJneAgDMXc28/L5q
         274hCooVyv4h7GWp2mcn3PJ2qLI8rgUucwz4m/IY7TXd0dwG+mUhO166NvIpbJTtRxwA
         OJpA==
X-Gm-Message-State: APjAAAWwkzUyWR95YFdpAeR1GsWN7zITkBmASmc4Ex24PbT5OXuEYzgy
        pYn3+9miGfoRNwHTpNFUjGDMIFadZ3ovvHhwXHMscBG1
X-Google-Smtp-Source: APXvYqwWDXnMcSaDD6J98xGWGxYKHukJDw/eGf53s056noo9k8/0lw8Gm1wETbWmZbB1+n27eb+vV4kQG5AwYgldg+I=
X-Received: by 2002:adf:bc87:: with SMTP id g7mr91774604wrh.121.1578055219211;
 Fri, 03 Jan 2020 04:40:19 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Fran=C3=A7ois_WAUQUIER?= <wokier@gmail.com>
Date:   Fri, 3 Jan 2020 13:40:08 +0100
Message-ID: <CAFS-fjvhAB5EcfHhfp6HYN57W11tkHOc8K8T3oey8qceutuYsg@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

$ git checkout -

I often use this command to go back to previous branch from my history.
It is quite natural as it uses the same syntax as =E2=80=9Ccd -=E2=80=9C

But i found out it is not documented in
https://git-scm.com/docs/git-checkout/2.24.0
I report this to help others to discover this time saving command.

Thanks for the great work with git
Happy new year

--=20
Fran=C3=A7ois Wauquier
