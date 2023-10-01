Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F05E748E9
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJANfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjJANfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 09:35:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B19B3
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 06:35:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40652e5718cso33671645e9.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167336; x=1696772136; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbGGnZ+iGKH5SYARMXqmimlqWFsmyKsQrB+/z51DaMQ=;
        b=Ck6M2ALqw2JUSB37UzTkjQKTOG/xzdROgEcLYn+iBleothEInRZRUTgZWZayXIvFcU
         aML5EQoULVmCY3VFwbU0HootP3nYqHQWM9wjmsT7jNwwOKlYrJgpLfHG3jVyJjcmwT3n
         6lFo7JKHwqLIQjsv469Lz18yy5/7IqRsnXfVUQJTQbrE5mpj+Y40qqlWIo4CP/wMl9RO
         qTG18vF9SZKQakg/X6f3x1MS/TdOXBIM3/IzrNUNJV7I/xHeQJkh1uFStB8gzEmNwSvS
         XisESRcMq8aBa3nGx3EOUsmlQDRfuHn7EN0Gxasii8PgTG9Sxq3MW94GvUINQZs/h3SE
         +baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167336; x=1696772136;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbGGnZ+iGKH5SYARMXqmimlqWFsmyKsQrB+/z51DaMQ=;
        b=opI6pGpPXrVodic/69JI2NVhSPu02rVO7nnlPsW+m+UO4K1Dcw3OW2X9iUo092JCxk
         /yqXhcuJPiZgaykk67Q9w94L4fjDhIUckJr5cddBQTMDJHBJ77U6li/Eql/6KV1TvJ2B
         J7moHno2GCCkJnwionV6bZcnw3c+YODiolRBtBaN3KlKEqeRjVYBwA8XCOa1ZdN0IjTN
         IfCcuoAxr16DqOkeyH34vk252gmUullh0SL7cxw5NpOV0GVZe0jfw1xj4TPjfeWhOeGC
         EOzDjsP2xAN56k5ATcKPpsnEXpIwQJ6VXu8B2vkEwV8CnwSVxZ40ZMRFlpWFMKorn4h4
         tzcQ==
X-Gm-Message-State: AOJu0Yx9dg2bUfiYKM3GzoAY3kwHMEfi0Xx4pNplD2aX0ZQ4VDNRfsS9
        TMMOJl/NiAlWE/tq3mVroXntl6FhagGcPI7u
X-Google-Smtp-Source: AGHT+IFj3U1RK10mxHsAN0fVVglW1lAf6nmM8Cfod4dpaxeVZ13qVrI0iJZEsHnjepj2vIu3PaodTQ==
X-Received: by 2002:a05:600c:1c9c:b0:405:3ab9:eb07 with SMTP id k28-20020a05600c1c9c00b004053ab9eb07mr838335wms.20.1696167336436;
        Sun, 01 Oct 2023 06:35:36 -0700 (PDT)
Received: from [10.121.165.223] ([105.113.68.223])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fc02e8ea68sm5231720wmk.13.2023.10.01.06.35.35
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Oct 2023 06:35:35 -0700 (PDT)
Message-ID: <651975a7.7b0a0220.e1220.21d2@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Please I want to discuess something with you  reply me Urgent,
To:     git@vger.kernel.org
From:   "M X" "chris colin" <chriscolin994@gmail.com>
Date:   Sun, 01 Oct 2023 06:35:34 -0700
Reply-To: inf658@daum.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Holle,
Please I want to discuess something with you  reply me  for more informatio=
ns.
COLIN
