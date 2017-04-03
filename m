Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A592C1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 16:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbdDCQEb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 12:04:31 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:35843 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbdDCQEa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 12:04:30 -0400
Received: by mail-yb0-f178.google.com with SMTP id i124so36901636ybc.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=S0hs8B+w7FUAT97cRPYFZ/nImaOOBI6zVwuWNFdEjL4=;
        b=S7v8SoylnqzkYUJGcpBtTCj0mABPQGyshzM42MwhgzbNL/JyiEWS3Kb+hrvi8u0ZJl
         BUDIsiM6M6jmsQbZq9mcZNEkwCrWy11V52Bns57beBpq00tUERXMvDeNzWZa1az1FjYb
         kBe9mG98fkShYOZaYtkAWt23X3V2Y8P6D3twqus98c0oqLTl3IHSXLCNSac1nWTUI9mK
         NCfZ/eTICfIJjtYdZK5R4B+e+xOqJKbwxkWl4pWKE7YXxSa0U804/MT7pLrYKlMvQA41
         p/OHWUe4UsZLgK6tZ1K1Z3QW5ASj1mVD48iukPWlppnrjU/yl4FXmSIxsoYRZUfwz0aC
         HGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=S0hs8B+w7FUAT97cRPYFZ/nImaOOBI6zVwuWNFdEjL4=;
        b=GycqIFgb9a7R4FUTUGHWECK3G+AKgQ72MDSF0Hxi5sewvAVIIRRXGJPu2uYPt1ZY1C
         +MPVaB6yKv3WqFWsvMuC8NQ0sxjY9jTIm9rgFt1bGSDphArrDUTaLfaWD261lQxrAMBM
         ifTcJnhbprTYiRp3sKItgfLyKKkN2BavnO/GoSurAkOgtgMyevpDXdqUWQ0/Vjd190Il
         VVEmIMqIqmAGTJbJKMDBvnXuVJgd5wDYThYmO0C4Qp4mx+eSd/NBxpc9eewOiJzNyTgS
         eFFWb3qLItFI7r2r/WswO+FpdEN20umdajm1AtttjRN25iA7xkctfbWn3CIj5MyHzTRe
         VFcA==
X-Gm-Message-State: AFeK/H3FYCR50HWZ/1XrjGu2WKe9kKXvIr2XK0ngl2pt5O1MvbbFrkaZo9wXyU+a9VsOx/ODK+Pnw/6m0NTuWA==
X-Received: by 10.13.219.74 with SMTP id d71mr12055256ywe.305.1491235469564;
 Mon, 03 Apr 2017 09:04:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.83.23.74 with HTTP; Mon, 3 Apr 2017 09:04:29 -0700 (PDT)
From:   ken edward <kedward777@gmail.com>
Date:   Mon, 3 Apr 2017 12:04:29 -0400
Message-ID: <CAAqgmoP2uyd5_k-JDOBpBV8ay6BueUvKkwcWAZ_C1n4=4xpECg@mail.gmail.com>
Subject: How do you script linux GIT client to pass kerberos credential to
 apache enabled GIT server?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have my git repositories behind an apache server configured with
kerberos. Works fine if the user is logged in on their workstation.
Apache gets the kerberos credential, and validates, and  then sends
the GIT repo being requested.

BUT, I want to write a script on linux that will also pass the
kerberos credential to the apache GIT server without having any
manually intervention. Seems I would create a kerberos keytab for the
principal and then use that to authenticate.... kinit supports
authenticating from a keytab using the -k -t <keytab-path> options,
but has anyone done this?

Keith
