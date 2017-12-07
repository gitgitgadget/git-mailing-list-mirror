Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A51920954
	for <e@80x24.org>; Thu,  7 Dec 2017 22:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdLGWaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 17:30:35 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34891 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdLGWae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 17:30:34 -0500
Received: by mail-qt0-f170.google.com with SMTP id u10so21735737qtg.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 14:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bod5w1zgBjZ4zghVUsUkW/HqmhuZe5jUHxqcl2xQzn8=;
        b=kFB/jvBfVJH/Tjv0TN68JRxa2REcgxyDuvZ0YQJd3cn4aP6HxgXybI2bNgQOPW5CY5
         5/bL0kDAIy1HhlWuHxY0SkyAogi0ek7dVLQYlIAF7OLvydc9/10YmNXEofWPr6phR2JL
         vJvhgn/KGPSCdjX2DdUyJugiNmZmBr8hz3fTG19FTH4lTcV9l3Wk115zhOOgupuiEY3y
         is9dq4OcCpLaH1O0IHETQ8Aaf/qaWEKFPWo3g3fUCvZeks1CP9AykKclNXaHfmPrhMMD
         HV5tglZJmVmQy4ZvQEA7hfltXOUjyh0DsxuL/mizOme8lFvEP5Oozp1lRASYI3SOPVUy
         LQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bod5w1zgBjZ4zghVUsUkW/HqmhuZe5jUHxqcl2xQzn8=;
        b=N9XI5gAzwB1vNS3RoRyqi6yexNx5zhdzl0ZDrTxOTHW0dpkQ12U6g18/klSbcJJf/P
         QY1/01DOVPhsD095w/jLnB5Q0PR9Q2H5eQaglT1GwNSrMo20mr7femjaQB5v5GlfG3+L
         MrXWhXuJRHNaXNJIcp+d3USup2KEN1Ljd+hZPbzDoXe7L4RzT04L8/qRud2FEkFlepfp
         UfB8DYnD1WU3vyarvY+JRHdp3SE08xke++/k36YH4aZ+zcvLoGnDm5heBDflyfu+SEqH
         wLWzJo3naxAWTo2GhStjN9eP0rJb948o+T3uZNZG+BuBZXH7CzMf4XZsnC2oUUktz2vl
         Og9w==
X-Gm-Message-State: AKGB3mJ8h5RAvNW2tipq0O2TmAxp36Vpe1XHrV477HfRldUGI1enUJMd
        tF6V9J+omj3uO12gyCq+HRBwPEbQtrRsA0GBqc5uaf+I
X-Google-Smtp-Source: AGs4zMb1q2FnFpqtEvWLwWt7gzvYTBXpxlUzoBh0iAmuvtEzJMHLlqzyW2/QWoyZoDuwz+NSxtK+Sd/vHKbqyoAGGsQ=
X-Received: by 10.55.212.16 with SMTP id l16mr32897204qki.40.1512685833935;
 Thu, 07 Dec 2017 14:30:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 7 Dec 2017 14:30:33 -0800 (PST)
In-Reply-To: <20171204235823.63299-4-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com> <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Dec 2017 14:30:33 -0800
Message-ID: <CAGZ79kYw3y3grehEbFeoA2r7pEra079M7zVpcVwxcoK5BPN1Dw@mail.gmail.com>
Subject: Re: [WIP 03/15] pkt-line: add delim packet support
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> One of the design goals of protocol-v2 is to improve the semantics of
> flush packets.  Currently in protocol-v1, flush packets are used both to
> indicate a break in a list of packet lines as well as an indication that
> one side has finished speaking.  This makes it particularly difficult
> to implement proxies as a proxy would need to completely understand git
> protocol instead of simply looking for a flush packet.
>
> To do this, introduce the special deliminator packet '0001'.  A delim
> packet can then be used as a deliminator between lists of packet lines
> while flush packets can be reserved to indicate the end of a response.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

I presume the update for Documentation/technical/* comes at a later patch in the
series, clarifying the exact semantic difference between the packet types?
