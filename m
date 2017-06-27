Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BF5207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 03:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdF0DIs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 23:08:48 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33996 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdF0DIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 23:08:47 -0400
Received: by mail-yw0-f176.google.com with SMTP id s127so7410749ywg.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hAj07gg2vwWdLgUVZ6HejGnIx8+m5HMLJ84Bc9hg1K8=;
        b=rBZGNhtR2N79uHxUz/+fQldGEzDZV84xMdHOc7Fk4H0fY2lQgBAg9i8fqt1nQtDaZ7
         +aVTCC0jCzWqTZTnOG43jCEquiJ7NO+0MFdB0BvkXnauE1Q10RjSw11zt/D6kdjhcy+d
         GmAqZIDgtbfCNGLHoF6XRFznGKca4ngIEDWc0dccOqNxN6yeLGUVARhoC1LNY0DQ/0tM
         wUV7BNYChChLQnNNGrnXhuKpwXzT0eK8RVqelfDwNgUVQ5sZIW1SCEcRslTQDktJn30/
         bmRLK+hpTIy0oy5aV6yMwv4kd1K28I7SlfU3GA6qz16+E3eRrEFiDZD6LZQCZGHW3gzm
         Tc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hAj07gg2vwWdLgUVZ6HejGnIx8+m5HMLJ84Bc9hg1K8=;
        b=cv4bo7z+kCRC3klkGZL0eYTX50rzVU+E/rqvGcAIr7MJ1KD7lXzKguVO3xuU9gjmcN
         QTn84IP672UDMEvb4Xu7mUbQao6M49yQ5T9TorYxdVRfEnpXegpjx2quZis7842JrG8c
         D6egmkZ44E8b7AphVUF7EYbPY2X013N8MCDh1nIV6/d7FnApYJ/4joj7bbymnd6qk839
         f4m2rbCWnYZdFdQpG2J0gshefSXNjkw40xEyLzQuxI9BTIFp+F/yVr7bUSEgpa5NK+wW
         CqueufJE50+6PAe4t0TjtaemDk6BdsqhKtmsSz6IgHNG3pa9UZPJsaSItvAvAYDrUK9t
         8aGA==
X-Gm-Message-State: AKS2vOxLDI+i8DXdYdtEkfVaAD+h0VgbIvSmwzGusos9mmRFvewiU7p0
        l27+KtxO5cRcVShw04eng8qB1g4UclyW
X-Received: by 10.129.182.81 with SMTP id h17mr2496676ywk.140.1498532926210;
 Mon, 26 Jun 2017 20:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.83.12.79 with HTTP; Mon, 26 Jun 2017 20:08:45 -0700 (PDT)
In-Reply-To: <CAGZ79kYR_Vw454RBw7A7ygJdiOauzepVZXBb_CvsCoN9AGE-sA@mail.gmail.com>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
 <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com> <CAGZ79kYR_Vw454RBw7A7ygJdiOauzepVZXBb_CvsCoN9AGE-sA@mail.gmail.com>
From:   Gyandeep Singh <gyandeeps@gmail.com>
Date:   Mon, 26 Jun 2017 22:08:45 -0500
Message-ID: <CAHaNChdhg-nHv34-jgumeKw8iJXaXwfY2DAe797nRXPU1VzT3Q@mail.gmail.com>
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure what you mean by output. But its just goes back to normal like  th=
is

Gyandeep@Gyandeep MINGW64 ~

$



It was working fine on first release of git 2.13. It broken with
releases after that.

Will try with =E2=80=93no-pager flag and let you tomorrow.



Thanks

Gyandeep
Regards,

Gyandeep Singh
Website: http://gyandeeps.com


On Mon, Jun 26, 2017 at 9:55 PM, Stefan Beller <sbeller@google.com> wrote:
> Which exact outputs of Git are invoked?
>
> Does it change when giving slightly different options e.g. --no-pager?
