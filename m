Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1CC352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A81C20718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIcW0tMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBOVtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:49:11 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:42552 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgBOVtL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:49:11 -0500
Received: by mail-il1-f178.google.com with SMTP id x2so2292423ila.9
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kHkAzYg0+50AarzXb/a3XkjV7fujZP89tz6n9PQdSs4=;
        b=WIcW0tMojjVqra/U9Vay3XQtGGbETc7JuiNVavSDfsusGChwZoq/LqHhnHoCqpggQp
         f1pUQGEjubhIkc9EAR2KH36aQ8kas9suaZv5penNKPns5mSArpcLQgcAaHV1QienPckN
         fezJ3KignFSUKDFirF0GSZx2Dnwm3/K1PYIVjj7/0XHRuWzVFQXky0xcdv7wWhgugQRY
         xEsazCsJ4DGaUc+HgnLT+uKCM68qog68gYNNc04/YrBuhN9fmTmT1Jk6gvNVVVBS2nQ+
         3uAeS+ynV6avlrmAVBRb0cPc01OVRkW4a3hBWJuRoPtxTsrWhiTpYceRvA88LoRvm/oX
         qT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kHkAzYg0+50AarzXb/a3XkjV7fujZP89tz6n9PQdSs4=;
        b=ShdfYrLjPLSVX3Ha8/5JIitafzyxRb2EIEdSJCfuAckLSLn7YR7NX+zit93ze1WsEf
         6wKSuc5O/SgZMgxmdx25KhtTv5jiiGWrImAKfAA113qNp4vsjbslQGFJt5hTygy3+Egp
         dmdIoMZHBSbkCKChtNMQM9wo5PG8A/3GGb65QH6AqHqDuZ6dFZnxxvfzd+XQoChp1Ozx
         SNJLYKRssN4nnOSbrxVGRqOPTvZzUhQAeq8Ay9lduGkCwg/98cvHiE17qdC1lEtlnpO5
         Wdfg+J0DohTKyITDyWwilCwiqxRZY3y7N8UYaGRfxgWZkrZlTLGHwfPKpJFRu/vO71p3
         EqSg==
X-Gm-Message-State: APjAAAVFJqyDfy4HhDvIVyDHQpYZEJpS7NzdVbKXVzf/yP9Cu9UfRN0F
        uFvKIEaQBd+G6d9RPpET2Z0NYgdRgL1yFzSmsFmIutwY
X-Google-Smtp-Source: APXvYqxwMrNPATMH/jBXS849Igk1lJVIetsds8U9DGIbqzHFIlct2d7wYsePC7UIExrV3z3QNFwXzp/ZZTBbEQLrfPE=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr8608908ill.55.1581803349181;
 Sat, 15 Feb 2020 13:49:09 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 15 Feb 2020 16:48:58 -0500
Message-ID: <CAH8yC8mnjmz7cTGzkpVQ2+ss7VGuSZ84hY-kHs8h5k53uEGSCw@mail.gmail.com>
Subject: What does Git call services like GitHub and GitLab?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Forgive my ignorance... What does Git call services like GitHub and GitLab?

Jeff
