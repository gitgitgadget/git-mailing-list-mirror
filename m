Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553C01F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeH2ACb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:02:31 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39145 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2ACb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:02:31 -0400
Received: by mail-ed1-f42.google.com with SMTP id h4-v6so2288599edi.6
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Rz05s9Yq14jvJSNPrSIJfZZVktbwosfIKclU9ZSJ08=;
        b=I1kEwQ7n/SF9cpTYQcek5TVvrt10r4N7MRCspD/H7uFtZRmWam5X91vxJDu7Rq5o3E
         VZdu990FvwLxFxBVF00pQSfl3BwAKwXXt+jwMKCuZ/bG3H61S3fY51DGgeSEdNMcOwje
         zKoM2w/2cH6obAiTsPpFMTXDvx/Daw8k2dI9AKG/0r7BPtv2cuTbGHsYwIoQtx5R7DSu
         oUDKJponHGIfMSeEyCktzMUDgyiuKPM/Rf5U3hDn4modMjEBRvntYrwj9iM6gMGoN2KR
         JqQGtrTQObvOXhE21eIWiuoig71w1q9Huwmh1ijWLs5LSb3csrrbkRZP/Bg4D877sRN/
         j6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Rz05s9Yq14jvJSNPrSIJfZZVktbwosfIKclU9ZSJ08=;
        b=NljaL6PJ01LGqapbZ46hF9wmccziCoWwkFMitR8xyLYdOwyYwR0Xhmv53KrNkhHMyT
         Y9Vwv+aqhL10nfnMJ4NDQJaZIkZwfhDnObiZBe2CpA3LMTxfuqU/eOUauVBdtSalCLmd
         G55GjHNTWX5hiTymEoRpi6IQqIfe5y7xznE2UqmBJsKx456wZEdjHh9ub0o2TZIETFro
         KPQiOcX+0MCYB/KkYtfpnsp2cqXe1l1gWWvBcth+fb5E5rWgWtrz1nwXPpndiehSJ0UH
         ElOD6ABphZjxPI11oqsq4bAW5AdSpqvT9jaAuyV4OYLIlwfpZ2PBIY9heG5FFmQRfr31
         SBQw==
X-Gm-Message-State: APzg51BhNf7hJwQWhHDRjJyZg/c8nI/EuQV6wG0iRyz7YQ/xEQkM11wo
        Ips1Hw/f3dei7gV9xR9D85SmHZNNpHm7ISvKtMY14Q==
X-Google-Smtp-Source: ANB0Vdbb3SJWw8g/0GFkIgbtQ6+PJPtJAjCHq5eEjETRjJe/xm1Z7xTuf+g9VcGghdKvB8q5QRqcUEnJrEbz09P+ScU=
X-Received: by 2002:aa7:ca51:: with SMTP id j17-v6mr4000664edt.45.1535486956232;
 Tue, 28 Aug 2018 13:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-3-pclouds@gmail.com>
 <CAGZ79kbZRuzaoK=922b2JyfY9u8kOqm44KzKmbpWdWAkJ=SVDg@mail.gmail.com> <CACsJy8CYUcL+BNBYqX51vCZXahG6sO03=GJZCihCvh8MLn3KqQ@mail.gmail.com>
In-Reply-To: <CACsJy8CYUcL+BNBYqX51vCZXahG6sO03=GJZCihCvh8MLn3KqQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Aug 2018 13:09:05 -0700
Message-ID: <CAGZ79kai0nmiiVDq6MX12NfRZo9bgwVhSf6fcxHHrPC=c+HxNw@mail.gmail.com>
Subject: Re: [PATCH 02/21] read-cache.c: remove 'const' from index_has_changes()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "r" it is! I forgot about it. But this is for local variable or
> argument names only right? The field name (in diff_options for
> example) should stay something more descriptive like repo, I think.

Yea I agree, we should have more descriptive things in long lived structs.

Thanks,
Stefan
