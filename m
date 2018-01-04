Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C3F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeADV7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:59:07 -0500
Received: from mail-yb0-f174.google.com ([209.85.213.174]:35647 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeADV7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:59:06 -0500
Received: by mail-yb0-f174.google.com with SMTP id u107so1189226ybi.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ZZrzOV8+lhUh5eOSml7v/bUcfHA21vzHMxfNcnRsScs=;
        b=P9vNEEhqzm8GTvGftQAkH1p0Wj37HiiDEkHe1Hnx17lWzKrbIKq+yj81RZ12ithx+S
         97yddUt7r3HAE5xetEKHB0MFBiqiWGGWLY26ek9I4Gx0DjmiMvtIW6s6Yo1pjirdJ31f
         rYkyy9DbyGtZBDxsijtjFRZBcOD6GvIxn5tNCqDEVKedok7grWpKSadtEAoKMEuieFCq
         At23Kh6IVpzuK0nl5JI5tdGyObzU9bBz96gnT7iiVD5/mDBSrZz38gD2v81R6/DC6G17
         HsEMCVf8qq06jUrGrC/WBIVQ4lKM+Kt+lN5RTYDYELtBKz31UXXK5bzIqjp/rvo2Geft
         BGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ZZrzOV8+lhUh5eOSml7v/bUcfHA21vzHMxfNcnRsScs=;
        b=DdIf1W84n3mFK9eMU7EUZYj66sg0Iw6JCfZ6TeZIxPr7SQRTadR61VltQirizkErGb
         xnxPf2ZwV8i+eMq3bubC7SpW80Fsf+PDJlNfBRticr+lfw27ZUm2GtXjXLT7sebRMouh
         XztYefpq1zgb5Z3nNzDj4pjYY0vxbWaa/fhDnrSiU3bUlIO5LLHSoofcVOi1RnAu5QNr
         FpvbYMyemiw9/XUdTP2fX0GIufHeH4aoCPsdTnSfZ6mG+HtNjMjgN+z/dIej4P+yMM/M
         WJ1a4aZ8d0buNNF2cVIT04GtMhLwnjKdJu+EkAuxBQ3Hi3eUoht5+7zAGGhXtyv7YEEC
         D2kg==
X-Gm-Message-State: AKGB3mLoCU8+l2d1qUcRKhpPOJT5Feb/PpLAIV4yElm9SSHnX4LrPSpG
        eCxlUkA0F7lSEQlyxU049qk7HMxThkMOsDF6dsGLDQ==
X-Google-Smtp-Source: ACJfBovBsalmqvdzHx2rnnIolwekuSDmBpJESPp+V+pxM9hQwKMSOx+jwJdOo/UwY6CM6Y44Jp1RvYb7ym4BLQnVeuI=
X-Received: by 10.37.59.129 with SMTP id i123mr1007916yba.420.1515103145852;
 Thu, 04 Jan 2018 13:59:05 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.103.65 with HTTP; Thu, 4 Jan 2018 13:59:05 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 4 Jan 2018 15:59:05 -0600
X-Google-Sender-Auth: 9kfb0YPY5n8FKnqfrxkyq8HWkuY
Message-ID: <CAHd499C7sNWSr_rQKLNQMZNUpueVsebbBOQ7ADC0wx_GJkrVmA@mail.gmail.com>
Subject: Previous hunk in different file during add --patch
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I keep expecting that pressing K during patch add that it will cross
file boundaries and go to previous hunks in files before the current
one. However, it reports "no hunks" when reaching the top hunk in the
current file. Is there a way to go to the previous file?
