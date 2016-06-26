Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8463820179
	for <e@80x24.org>; Sun, 26 Jun 2016 23:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbcFZXFa (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:05:30 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35316 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcFZXF3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 19:05:29 -0400
Received: by mail-it0-f48.google.com with SMTP id g127so52559287ith.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 16:05:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1g6P6h1dCskm13VyjvT7sRvNZCH4CvY7mrK9NgT1QFA=;
        b=YXMTqQ2tlyzp0tTnSyK5XzGpEP72jQVR85w68hu/ahbX4rR5yOsoPz6nEQnr2febZX
         NxnHUwAG0lrb3FVSsAbl9JzCQ74xZBrZKboKp7QlNqZIPoUHMPeGlE8KmaFPAtWHNor+
         R2c4Xa0fClR4Qy5hvunhmfQHT3M/aK/azGNlLvtUEtbQMLhtTqXhiSze823fp0IXYE8x
         T5TfsXNZWoTCEGvaZRqIBRlqj2+S6iB+I7zKpETxZhOOxIcjeKb36mx1c0Vai16Bt0IC
         kSjNOmegrGTgg3QSc/oPwz3soMAebxE/Puu+VkaBf/tZu+gOjPlx/9kSM28RReI3qjKt
         YcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1g6P6h1dCskm13VyjvT7sRvNZCH4CvY7mrK9NgT1QFA=;
        b=lQj6jMSF3YZwlbqjz+wNsnnvdM1YJFIPcKj9hnNNL3uQx9df/47EEUfQuDy4GKuz3n
         Ss4kXTKOd0ptP5u9NZ57dkzd5TQsxSKPIRgb9v9F2MQebfAw/lSlXg5X7tKp2UnbSen9
         AwWmYuMniTnUPx8ER8RvDtvk4EtS9pM5tmrI6uCP8aCFSXpfCWRW7Rw1bslzAiguxZL9
         PCBqNVWRZymZqDSXFu5jV2RJH/rAg0FyMbjotrIMhRcgILDYIu6BNNaW6q13kHSIXxXs
         wS7SHg1+1UtLcJHRooIM43JTh/8JG3lLaeogyg47JRB2rQ3h0rdTDKPwC5crtajQ2Ea9
         cwMg==
X-Gm-Message-State: ALyK8tIR29160jXfGRtTroynApwKPkiNHLB5etmy5Xr66RItcOhEesILv12GbT3VNlf5vpZC8VgPcmclM2Dmjw==
X-Received: by 10.36.98.136 with SMTP id d130mr6097092itc.84.1466982328929;
 Sun, 26 Jun 2016 16:05:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sun, 26 Jun 2016 16:05:28 -0700 (PDT)
In-Reply-To: <20160626171616.27948-4-pclouds@gmail.com>
References: <20160626171616.27948-1-pclouds@gmail.com> <20160626171616.27948-4-pclouds@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sun, 26 Jun 2016 19:05:28 -0400
X-Google-Sender-Auth: JYBQIBxnGjLBqKjPZ-QrJXodrio
Message-ID: <CAPig+cRQynnXzNSkYGGzuZH25+UAovYHqeBWyaFjb03OHvuCFQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] diff.c: add --relative-names to be used with --name-only
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 1:16 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> The difference with --relative option is, this option does not filter
> paths outside cwd. You can add two more chars " ." on your command
> line for that.
>
> This serves two purposes
>
>  - user friendlier to copy/paste. When full paths are shown, you can
>    still use ":/" magic to get around it, but unless you're a lefty
>    you need to move your right hand between the keyboard and mouse for
>    each path. Not very efficient.
>
>  - script friendly. Strictly speaking a very light form of scripting
>    from command line prompt when you just pipe paths to the next
>    command. Paths relative to cwd would be much easier to pip this

s/pip/pipe/

>    way.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
