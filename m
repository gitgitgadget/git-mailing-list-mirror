Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D84A2055E
	for <e@80x24.org>; Thu,  2 Nov 2017 22:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934611AbdKBWtX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:49:23 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:48625 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934551AbdKBWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:49:22 -0400
Received: by mail-qt0-f171.google.com with SMTP id f8so1305262qta.5
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FrBCkCyaqxk4wqTn/7vH2nlNPF5/7+Ichd5/cUkrHTk=;
        b=hsmqRaPKpJ6OYtR9GV+poYQbZ59R+P0HX1spjRYT89Twpl7vAe9m8khf69pr+2Okhk
         5q18/HKK2XrZfbpheItJpl7TWpfuP5ZFuzjTjOiUuyJZ5p8MNuJArRPYjCuZ6Ya65NQE
         AChkN4xfX6TbH27xP0XiL97wBuIClLwo4WU5LPZ5Osbd/bEdGju0LSS7JYC4iRE9tofm
         qVfcAWnZtKeQjpFoy0usUcjY+WNabN/r5oRr/aYrVzZLZ1Ckwy/5Dl5yuLlFTtpIohDo
         XkmJpdpFQkvSkXa9fMB1L0qNop5P3wOAClG7Mpv5GDrcLL7A+wQfZ2IeClqB5MIe5Ydl
         LmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FrBCkCyaqxk4wqTn/7vH2nlNPF5/7+Ichd5/cUkrHTk=;
        b=Uo+qqCmYG7Qn/GUpML8Wuth1qGD3O6yXC2Y9mRd+Fh41WhEotbwibMF6awR5KDjZbl
         oEPXQ1WVVkoDbf3D8NYwwZN3UM4c2EzA3VMjcSAD1ZOCSZGWbC6cUkPt1N8BMc8StEVM
         5XsqKEaxSGeiEGTQtoOFFvgUQcugBQyA1q0YcGk3hf4km/FliubtF8EaW/TVk6GshIYh
         vbSnfQdJfzl3Hj5bA/Hwz1TZL3FQX5ipTu4Cv7q7NMkEQFW7Egq7XP3sz6tzjX0TY1po
         O0ynWWOWBhI6epFhgesVei0iM+eORrsSi2URXwjLZmQSEIyK1NjYQCRLD0qLtmokXUt+
         6EnQ==
X-Gm-Message-State: AMCzsaWfq2fbaa1Qf1MZY7mFQMFJPUbNUIkL1HT6jpJe94fpBM+FxmN4
        6dV47R9gk/C5cpM/wrFJRLybucrzKiGSJTwcjq382Q==
X-Google-Smtp-Source: ABhQp+Qlh5vgjQEQaGSCX1pJY5YcTTkRkmMUndR8jCdnOF37Ww8eY1KAXYYbBbPZLhCuXbphWme/f75QOWOVIpnrTck=
X-Received: by 10.200.46.114 with SMTP id s47mr7281764qta.165.1509662961634;
 Thu, 02 Nov 2017 15:49:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 2 Nov 2017 15:49:21 -0700 (PDT)
In-Reply-To: <20171102212518.1601-7-anarcat@debian.org>
References: <20171030025142.19421-1-anarcat@debian.org> <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-7-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Nov 2017 18:49:21 -0400
X-Google-Sender-Auth: wfpry6JcbtVqCLGLoBJR8v85Bfw
Message-ID: <CAPig+cRTaGb=WNkyTT4btnhf+H+9SJC7N5hF+KxJrmy55Oi-gg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] remote-mediawiki: process namespaces in order
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
> Ideally, we'd process them in numeric order since that is more
> logical, but we can't do that yet since this is where we find the
> numeric identifiers in the first place. Lexicographic order is a good
> compromise.
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Ditto: It would be best to drop this Reviewed-by: since it has no
value with my name attached to it and was not provided explicitly.

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
