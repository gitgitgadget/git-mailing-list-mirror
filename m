Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB1D1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdJXUMg (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:12:36 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50640 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJXUMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:12:35 -0400
Received: by mail-wm0-f50.google.com with SMTP id u138so17906194wmu.5
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XWH7e2I3vjI6poS1L92EO4EXtQvzWSBGpibqfl3C/Ng=;
        b=KZ9upFaCxJyEfhaVtMIa0SAeU24WkGRLVI2hAwQ7RpZ810eTo/LxTSL7B4P4MNrqG3
         y/LqdqsAgwfRYiJex2bFKKuS+X+tClrFoCdOc9gxmxglYiI7ROXtDfhbo3M5LjXmhoJN
         xuE9C2iNdUPekTfO9e3yz9GpknI6Rg30vjZ/OazYmb3Vh1lShLq58qwsDUmTrEhoswD8
         soQZTl+e0vwbScnBIolxKwfT8z9gZ+AqD2LUx3JZUy+EmyKa1gUwWpE/Pxhvji5tSkT+
         NoehUK2oNUeFJ2AQ35BxWbxyDzC+ucjvC3DgRBFAqEY+EdUeGmRKdNPCwCyVXa/xqjbB
         NcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWH7e2I3vjI6poS1L92EO4EXtQvzWSBGpibqfl3C/Ng=;
        b=Hbd5AQT6PsGlepzCSeiHgdppZ0pRvRGt8vYdmdR/CAzYPKHNUrs6lrYzhHJD/blbUg
         Ialdi/6RZps27+u5IDxAStDXNyeEO+xRyu0ZfFBEsBYH1ZIvNoUHgAHRANL2wygzAW+7
         Ygc16CzIpfeDAdsQxEdGnXXRydR6kZ/SDcpRDSKIzpbAS+ar/JhDLBVneDU2mSYQH6ZK
         WQBMv6BUqRGACzW3oh+suHURby+otl7L0HrB8gcwE1Mu6198sFhSqwkzXDXB/7mYL40i
         eohJvn3NSs6g+8J1sAaCfRCesnGOmaINi1ZbVJofO3SSSi+y3trD0G3zzrd0lVrCikr2
         Xgpw==
X-Gm-Message-State: AMCzsaXr1xbXmrmoTdR+wVKN+99i555iUihGGuLbO+617MSzstXP721O
        +mYRB4wECKuwEbP6D8XVWt9ML7j9WA==
X-Google-Smtp-Source: ABhQp+TMwT6OJL5pArKHf664DJViQAHLPkbvQc95du6zBp24bY6T5iBIVsYuP7cGdq3vA98JSgfnBw==
X-Received: by 10.80.172.122 with SMTP id w55mr6134139edc.293.1508875954343;
        Tue, 24 Oct 2017 13:12:34 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id x10sm691969edb.24.2017.10.24.13.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Oct 2017 13:12:33 -0700 (PDT)
Message-ID: <1508875952.2750.35.camel@kaarsemaker.net>
Subject: Re: Multiple paths in GIT_EXEC_PATH
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Nikolay Yakimov <root@livid.pp.ru>, git@vger.kernel.org
Date:   Tue, 24 Oct 2017 22:12:32 +0200
In-Reply-To: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
References: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-17 at 18:21 +0300, Nikolay Yakimov wrote:
> For why I need that is another matter. Long story short, I need git to
> look for '.gitignore' in a particular non-standard location, since I
> have multiple git repositories in the same workdir (that workdir being
> $HOME and git repositories being stores for my different configs)

That is solvable without needing multiple directories in
$GIT_EXEC_PATH. vcsh, which also solves the 'multiple repos with same
workdir' problem in a very thin wrapper around git, does this by
setting core.excludesfile in the per repo config to a unique path.

hurricane:~$ vcsh dotfiles config core.excludesfile
.gitignore.d/dotfiles
hurricane:~$ vcsh secrets config core.excludesfile
.gitignore.d/secrets

D.
