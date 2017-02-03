Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC5C1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 21:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdBCVgE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 16:36:04 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36882 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbdBCVgD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 16:36:03 -0500
Received: by mail-wm0-f51.google.com with SMTP id v77so47998903wmv.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=WziSYY5e20naHmz1DWR8qGxUVTdFizmyubowg0jYU+Y=;
        b=AM5gANkZFE7xsZuou3yGMBy91bFKh3RjwSXcwRQem4ZqioCt3unbGUmXgWfvmZHp/v
         whDLfDNF9vCx8PNiOpzCY6fy7wbk7i+mD+KRwFbe5DvsoLxrNuh1fw99SpcaCCF6+Ead
         0F4t32tQvpyFoZhrwyRJDf0SHCXnvPzMsD1uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=WziSYY5e20naHmz1DWR8qGxUVTdFizmyubowg0jYU+Y=;
        b=OZxEEFIRLgYhP5JjqzzxOPFbxz+j0OtHCym6sOtcy6B4Ek+pC2JSTQcvke97siee/q
         kvRLUe+qCtdXeeIdBRO+SmGHm/E56rLqwg1Zs0a7RbO0g+VD6kDQwaLrWyIskbNfHYIm
         tqADD5TXvDqXXlQl8+xas1+o9H4Hm5Q1T3/SPzr/RyP2ty/Z4Ff20odPaQ/WSNyjwlQ9
         ViLxBaBbdBWfL87k54cKLGBYKWyV5GpiIOoloXnWCLTBtvexq1GV6D9SG6Gq0IqyZdMn
         vPtTqyHXB0ORKDW0M5hd4IwlDJF1tda8pQlgCJ9DlXFlWaoKLgTB75TAPL2NYIRQa6W/
         IDrA==
X-Gm-Message-State: AMke39k/Q08N4POTN0jervhi/wCJM/cQ4t3VZ5ihKURsFPjpiRcHAvZWDl5HhfREMr7OCfIO1F9dwKfCiti8OVf+
X-Received: by 10.28.92.193 with SMTP id q184mr3223626wmb.139.1486157761685;
 Fri, 03 Feb 2017 13:36:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.76.1 with HTTP; Fri, 3 Feb 2017 13:36:01 -0800 (PST)
In-Reply-To: <CAGSZTjKywt28Pq7S+Hidi0XeseDxUAMEorrspZQ6jb50yic3+g@mail.gmail.com>
References: <CAGSZTjKywt28Pq7S+Hidi0XeseDxUAMEorrspZQ6jb50yic3+g@mail.gmail.com>
From:   Kevin Layer <layer@known.net>
Date:   Fri, 3 Feb 2017 13:36:01 -0800
Message-ID: <CAGSZTjLrdYJHixsUz0ha6=E263Z-vQuA11Oq=UNSVZfOmHkRuA@mail.gmail.com>
Subject: Re: BUG: "git checkout -q -b foo origin/foo" is not quiet
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that git version 1.8.3.1 is quiet and does not print the
"tracking remote" message.

On Fri, Feb 3, 2017 at 10:20 AM, Kevin Layer <layer@known.net> wrote:
> $ git checkout -q -b foo origin/foo
> Branch foo set up to track remote branch foo from origin.
>
> I said -q because I didn't want *any* output.
>
> I looked at the git sources, on the maint branch, and it appears to
> still be the case.
> I see this behavior on 1.7.1.
>
> Kevin
