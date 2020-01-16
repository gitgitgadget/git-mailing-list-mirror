Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF6C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA41920661
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWMmu+/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437723AbgAPTVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:21:20 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:34337 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437718AbgAPTVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 14:21:15 -0500
Received: by mail-il1-f176.google.com with SMTP id s15so19274813iln.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1fJnnhBCzlDXMJ+tNxG8tQ84X59K9VdfthHWO5p+3G0=;
        b=gWMmu+/Av1LcPaybp7ubXI4y8/HlOMlvpKukyyu/jiiUX6vAxBBbQsIiyqHdgh3UFJ
         02FMhcgWJjUaAtwy3Wcs2LRMkZEr2CJlP1TolBlE6su8sm+Mtnjfuuiz9FgSfnIUNAcJ
         moWg5ubLF4W9SlBAeRvPFpRGLjLGorCPZKf8qpEnTfUzQIo6CTOKN1C1aXkErz1r6Swv
         7U3Y50nCT3LPmk3bI+s+EFXjJPEknRB9qtCA+5827jU/a5HPa59NSsUXUC+zJPe9n5jR
         baIAVOfHfoUiIqRevKqG4uXT9sAYh1x39MinL+MwHtNZ+Rdx/63gxSkCBkK2VeJNOipL
         KICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1fJnnhBCzlDXMJ+tNxG8tQ84X59K9VdfthHWO5p+3G0=;
        b=GxFUJb6gYMB4MLuBUj9QUW8gjlynuMKbocE9NO7QAzD5CBzWMuDVqIVbTGWrR8wg1v
         y1kM6wsvXmqgqF8b3/3cmJZgtmJFyVwN157QvRhjTEZDOECX1Q26LUMlBkA8GQXS7Vpl
         nEyubxMmkainfpkhRYzZ9Io2KN37DAfb1BwKyDdRLdCZgfOtu6g8CYvMUEO3dwfAAAuP
         ttfLDb1jU3/bgUOn5jPD0G7+X0zVWT4/5DP877IHJ+Aw1EohpaBnTvAabo7s4lN5M3gI
         OUhkJBsgBeLV8FSXHtw/56zmasMxVGwP192aubHW281Toc/KnhUAi3D9iItyAZByJI6B
         RptQ==
X-Gm-Message-State: APjAAAVHSNiZ930TzsJidHshO2nvFtOURx2C2VUNejKcRuzgGAgv/umB
        kgXCNwmVVF0BeaJnpTI0HkzmdHSn5SLU0mXLbeAzo6RwGV8=
X-Google-Smtp-Source: APXvYqzNC/bsV+9ll+59vmRYfV6VczU16lJkVxXivyuy8iCCX5g8NEVTK4gZbv6HTwY5DSOacSvUfmlmI/GI9Er/cWA=
X-Received: by 2002:a92:cd02:: with SMTP id z2mr5190595iln.286.1579202474019;
 Thu, 16 Jan 2020 11:21:14 -0800 (PST)
MIME-Version: 1.0
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Fri, 17 Jan 2020 00:50:37 +0530
Message-ID: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
Subject: Facing error in git-imap-send while compiling Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!
I've been facing this error everytime I run the Makefile:
-----
LINK git-imap-send
imap-send.o: In function `verify_hostname':
/git/imap-send.c:252: undefined reference to `sk_num'
/git/imap-send.c:254: undefined reference to `sk_value'
/git/imap-send.c:260: undefined reference to `sk_pop_free'
/git/imap-send.c:260: undefined reference to `sk_pop_free'
imap-send.o: In function `ssl_socket_connect':
/git/imap-send.c:287: undefined reference to `SSL_library_init'
/git/imap-send.c:288: undefined reference to `SSL_load_error_strings'
/git/imap-send.c:290: undefined reference to `SSLv23_method'
collect2: error: ld returned 1 exit status

Makefile:2454: recipe for target 'git-imap-send' failed
make: *** [git-imap-send] Error 1
-----

I'm unaware of git imap-send and what it does. I've not done any
changes in the above-mentioned files. And now because of this error, I
really cant test any changes I've made. It'd be helpful if I could get
some guidance on this.

Thanks!
Regards,
Nirmal Khedkar
