Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91041C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CF22070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5+fPhip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKVKTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:19:40 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:45465 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVKTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 05:19:40 -0500
Received: by mail-vk1-f176.google.com with SMTP id s4so1504260vkk.12
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pKLBKm8hxqOBa6UT21/HSZ+YZZQqcSujGpJvkNAcebU=;
        b=U5+fPhipdbM3cQuiNxHB8+iMRCVVxGEUgv44G63KlUFaQlT43L41veii+fLtHzl79L
         f5/9VkT3rwoYeP8IQfYUj9p30Mr27AoEk5xqeikaAVhhP7ZDP46bP85tQXp/OX5sVnsY
         u5kTnpRrXlGdNwuhFPNbVVaJS8wY+kVGVClxkReGm9bbD6UI174lR/oqVRuvmzqrBqmR
         sx5+Ev0DaKRn1Kkb+WChl8oZYqqgsvr0GO1TgtfIPyU3I3BSQclK5L+DopP5FUbpmGNj
         L7um7dX19fDBzupqNcPv1WLI5JjlUJ+kKTDJDmGwpCOxrecVO/ZYlz6PLZFwps1b5eQE
         5BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pKLBKm8hxqOBa6UT21/HSZ+YZZQqcSujGpJvkNAcebU=;
        b=BgxX8PueFdM1jy7hIXJHyKOoJAAz2w/eJYD9vWMdJmg+V60lX5CmwsrzdvKUCr9PK9
         BWGseH8TZ83Pe1HJ4N485mQIPMQW0UI2gzlXLNdGYHN7m3MkOXjlvJt6sUtVk6rpn1Ko
         QDeRcTAGrSqDeF2R4YrPmQNlKxVbCkkpHFFDlFJ5r2RIiCjbZ2R5lHcoFRghIycmHVQL
         G74EtXaz7excdMir+CxRQ+UUjhm3W8M/pcqJpN9owTGZdXEKMS8jeUcvZ/h8HCX3tSqn
         zZ9AK8XZ8Q+tVklz0lYl+guyjeUeQzRRkObuFxLIRgA/RICUI35PmTJFxb9BeXmtn4mb
         W0Gw==
X-Gm-Message-State: APjAAAXVirop7YNP45doYyMSljTyrEcvyBGa+vEoyXgoNOs6pmbkm9/B
        Gm4L3/gimwv/s6dqa9ByNjeIk0+JxALCbXrOGKfJPPd2
X-Google-Smtp-Source: APXvYqxSDDB4wvW5WozoQ2+MfCXgVxmv+E+qiP0Ool83Wxpm+4W3i9zF77h/CC77QqtFjtp+p7pMwoPNBAkk5s3pNH0=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr9080966vkc.71.1574417978829;
 Fri, 22 Nov 2019 02:19:38 -0800 (PST)
MIME-Version: 1.0
From:   ryenus <ryenus@gmail.com>
Date:   Fri, 22 Nov 2019 18:19:27 +0800
Message-ID: <CAKkAvaywyh2bY4tHX2XvugM9V8NBUfG-hM_TyK-Ob7Pzm+6xBA@mail.gmail.com>
Subject: No tab completion for git version?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tab completion works for `git --version`, but not `git version`.
Of course, it would work with a custom executable script git-version on PATH.

Interestingly, it works even if the git-version script is an empty file.
