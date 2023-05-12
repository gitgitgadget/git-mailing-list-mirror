Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDEC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 03:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjELDjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 23:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjELDjY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 23:39:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5449F3
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:39:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf706768cso72737865ad.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683862763; x=1686454763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMr3cyId994tBxrrF+n+k5N+VopfXhBjz5zYXRk72MU=;
        b=K+O9p4h/cYcpUQ2HmYoRH0WBd+EDxxLDdnsYGPr8bRN7hGlLcRJugX6m3aAWnz+LZw
         bjhmTCWyecRcBpEWOYq2PO5fv23gpsFTy5y+xtlx5ee5QOdpnWKErrETX6Qk2API5V2R
         EC86ASTwfp5GBoSe2sTaak9C89TEdkoXX4xjIzlyWvGq8uvHCKI4OMIH1o2jPN6FF4rh
         P7TJi2+ROEt4aOrh+8Q9kH1edkb95DXBHoQQxRoreBEm+YuPvIDJHdmQ0CUEHMdb+RjD
         Qiha+AoxbkcJDngCL/TGvuYMsz0ku+bjLkDp2EHs6DthKSZmjuLCAdlunytvxlb9Fi+7
         sJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683862763; x=1686454763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMr3cyId994tBxrrF+n+k5N+VopfXhBjz5zYXRk72MU=;
        b=NgJ4sXu6aYrVGKIixZsXPZztznfattVQf6N3hLCV4zQ8J6oXZSJHbt1j2D2iwI4O/L
         Pfykzr1CmrjTauhHlvz//zSD5g8wKwgB+uav530BKWo2qltF0z0zTPTvKedmWTLZVmfs
         tw2AIAwd2GKkuN+pNpUq0tZmQI+TuSaOd9YlVCR741ha9fvsF+G7yNgjN3SY9N53rFWt
         e2J4SDgkb5/8vZpWZm0RckifEkJ4FWorb6vIcDUGlKIi1Jk2GZNdQtDVbg66msY5yVxw
         RlSwZjFj1z08CIxTkp7l//lx5cc7z0++RhEwhhkF0L7JHcNW0MA7wEsCcW2EaoBAO1q1
         svUg==
X-Gm-Message-State: AC+VfDzRdEvBJqNESJi8aU2vcY5To77/TJUUs0cVVi6gyU1HpW2O81Fq
        R22XaQ7fnZMjUuGs59EPsIvzx1V0kUu3+2ubCk8=
X-Google-Smtp-Source: ACHHUZ55NaiNndqWpw7CYTTiddSZepwxM1JjHEtbSCOUNj3/U/gnQwfsx/0UhJ1zZaHB1rbf3dSLsA==
X-Received: by 2002:a17:902:f543:b0:1ac:6084:1f4 with SMTP id h3-20020a170902f54300b001ac608401f4mr28217246plf.27.1683862762700;
        Thu, 11 May 2023 20:39:22 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b001acae9734c0sm686686plq.266.2023.05.11.20.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2023 20:39:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     calvinwan@google.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org
Subject: Re: Join us for Review Club
Date:   Fri, 12 May 2023 11:39:17 +0800
Message-ID: <20230512033917.1881-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.516.gd3e7951b
In-Reply-To: <CAFySSZCaE2zRtbsu0-VEHx12U0GeVy21GAATpTH0LNWKk-PX1g@mail.gmail.com>
References: <CAFySSZCaE2zRtbsu0-VEHx12U0GeVy21GAATpTH0LNWKk-PX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>No worries, you're welcome to just spectate and learn about the
>process! Part of the goal of review club is to show newer contributors
>and reviewers how the review process on this project works

Sounds good!

Thanks.
