Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB5B20373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdCNAka (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:40:30 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33858 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdCNAk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:40:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so8363437qtc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VohWyOk2+1DF7A7NbAyjNqVF63is+gAHcJO4M+SqoKw=;
        b=azEfxJZLvFz9uYnD7O/yyh1y5Qd+H1LEdrnsJ5MfU9YkmUZS1WUKYQXAzvMwP5tEzc
         AalazwFh2xzXH38v7oBh4NqYmtCD/0BNBE6gqyGIdXfFmXPo1UbnRAVqPprGVYZ5nf1S
         jashTreCl4hIxHHAHuhdV9OWzv86aSBsit+yD2xtBjTGDE4NeuSai86aw4t7YrGQadNk
         SQ9QMm/v3L1LbnFFBSN49icOgbyUW0H0rFFMDqUE49qlZbdUTFK4//EGE5roxRcGHYA+
         rjI8g5RYVhZTwNqJ1R9fMvD6rT19HC7SVhO7tFkXNWPczCu5RoLj00b4N4fEAviTGydZ
         b+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VohWyOk2+1DF7A7NbAyjNqVF63is+gAHcJO4M+SqoKw=;
        b=rvKMcnYca1ErBG7b54T0aj+RNzs85G35PqSgpjXUyBbdHI7t3OvpFAwc3HFZkKB8Uq
         bmaR9DEqOUGDHJb3WQ1KoMu+1v6MegB3VOPgjxwCl9rJVtvIRgimEz/vTK+5wY+WuYr8
         viYWx9TTuRJipkcFBJOzm7XUpDNN6tcI/Jw8utAq59Zo8yYafGM4k2Ba3QDjM5nY08i9
         CKF1VtBCroB6j8vLpGcaRahqInDa9YQt0/lrWw1JeNXItM2M/vkEayaLTfF5O+F3Yyr2
         ZUQqIh5qo1TryYXjibgls0goypV/brB4JdeT1UeSzyqrxYJqHBK0GM7s39KKbnhVj4ox
         OfxA==
X-Gm-Message-State: AMke39l4dPvXzte60jFx3kxHN2ygqP0MBvXp45Txry5zGp23EPP+RlIsPzam45UkL7Yg3g==
X-Received: by 10.200.46.91 with SMTP id s27mr37437236qta.278.1489452028525;
        Mon, 13 Mar 2017 17:40:28 -0700 (PDT)
Received: from dhcp-ccc-4425.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.gmail.com with ESMTPSA id 23sm13350152qtu.47.2017.03.13.17.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 17:40:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket
 if a socket
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <20170314003246.71586-4-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 20:40:27 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ACF39EA-B76A-462E-993C-ACBB143A1581@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
 <20170314003246.71586-4-lehmacdj@gmail.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>, gitster@pobox.com
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static int is_socket(char *path) {
> +	struct stat sb;
> +	int ret =3D lstat(path, &sb);
> +	return ret && S_IFSOCK(sb.st_mode);
> +}

This patch won=E2=80=99t even compile. S_IFSOCK(sb.st_mode) should have =
been S_IFSOCK & sb.st_mode.

(I guess I should have compiled first)

After making that change this patch compiles (currently running tests).

-Devin=
