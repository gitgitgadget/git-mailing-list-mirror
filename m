Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE1820281
	for <e@80x24.org>; Thu,  2 Nov 2017 22:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934551AbdKBWuV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:50:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:55891 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdKBWuU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:50:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id v41so1271309qtv.12
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=597ufNj2t3xW83gA6Bj7ixSbGwFo9/7fPCXqMzlqTsI=;
        b=rv7L283rbw7FEzGYSyTZQhdct3DKMtFheuhC1ZT3l6n3fhOGkza3tHlLhS+/N1CFK2
         JAI59cCQGn/MrzYXfW9OW+Toa4VppCpRjkD/S+oHLcxN7nBXmxI9hP5u42aUugbZTVXy
         LQ8hyGUn1WKBxb3vwfKPKXWTWV4tZBjLYhn5SBxGbW6gqllN0fL/qeiV3pI6FrIaz5es
         0oTdzlovhnw231p/vfPfJPo8qym/DqidWdOIvjHJqIG3pJ7nWmTnPGoERKIfXxW1ZpPA
         immd8R2DzjavUWmo3YvaFyCZJS7vZK7TI3iK1tLSnzM/igvZuUf0piGcGo2hfzDo+8Vg
         CZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=597ufNj2t3xW83gA6Bj7ixSbGwFo9/7fPCXqMzlqTsI=;
        b=QfNHXTNttepVAprQa1Z2yGcw/tIw2gZxgdeCucSl1v2nV/7HChIy3jupVS+LH9lo9r
         ljttIdBaPoxQ31q4egN1hNkF0wHB7TDZk2sACeWgY/gDaglWjtxHLTrztJQdy3FBwg1x
         Jfd2/D0sS5QNef7V1S9F85qY4vQvg/MBTxeFvz+sKGZ6q30+8pzNAf7UIanpR1v/D8Eh
         43VBBrL4kv1FYBEAWT1ofKHOa3dCGAqvvba98nxdZd2bZpBYL927AzY9u5qZJAmEmfgW
         3TMTtS/Bs6xx1UDxrYWwGmaP3qFyWnteQxOMKFWCF7vComS5V1ygDviqiN4A392jjmEm
         v47Q==
X-Gm-Message-State: AMCzsaVwpfFv/a0OkcQvpu/aG3z7I2MmhABNQcgNgdqYYAAqWpUGxYEL
        QpaOLICLR2yyvtDkCGhbj7nGGyJTENPUVg+NpvI=
X-Google-Smtp-Source: ABhQp+RGnC97ZqRm2aE4TWRj+LQpt17EWdVjqIrzgZmaIwL8mx+Tqknuc1NqLnkfFuc81UT9jRMAUcWzCa3a82M6jtk=
X-Received: by 10.237.34.82 with SMTP id o18mr7093545qtc.19.1509663019709;
 Thu, 02 Nov 2017 15:50:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 2 Nov 2017 15:50:19 -0700 (PDT)
In-Reply-To: <20171102212518.1601-8-anarcat@debian.org>
References: <20171030025142.19421-1-anarcat@debian.org> <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-8-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Nov 2017 18:50:19 -0400
X-Google-Sender-Auth: j9ZJMLepSGFR6R0q_V4DOqli6VE
Message-ID: <CAPig+cRFLv46hw6Mn__o5VLi5B9edA26zD_Pfca6A9xe4a6bJQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] remote-mediawiki: show progress while fetching namespaces
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 5:25 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org> w=
rote:
> Without this, the fetch process seems hanged while we fetch page
> listings across the namespaces. Obviously, it should be possible to
> silence this with -q, but that's an issue already present everywhere
> in the code and should be fixed separately:
>
> https://github.com/Git-Mediawiki/Git-Mediawiki/issues/30
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Ditto: It would be best to drop this Reviewed-by: since it has no
value with my name attached to it and was not provided explicitly.

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
