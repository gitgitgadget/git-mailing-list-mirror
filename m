Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A671F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 12:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeKKWDp (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 17:03:45 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40718 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeKKWDp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 17:03:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id p193so3237141vsd.7
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/x2JcWz5CQHE6kW+67bo8M2doIS6cXyyruWxUcOAU9A=;
        b=bUCfdWMXXTvQ5wP+9WLKe9jif0KckJCjsh+xJqe7dUZyEOGGuzOI5c+ucYWKCJMc0u
         SWYNTCFtE5gZ5xpWi0OYkm+r+AYyM0bHDzUfj9RMCv5rky7Gk2rZjjL2XLdYruTA+nfS
         zdU5dMvKQASNRUyyWnig19h6OQsJOCqeUfSxeQ88wspl0kIAHWNY1nkGaARM4X3FLY4e
         4crTVkmwNazu4ES65+z4uksB1OcROTPXTkI1vbgPZsbJqhxkIoFAyr2etveZnQFGfES4
         U1IcTFCFHatkUCVU8zWlJFrrF4lkyIBE8798hPqU9otxXtm8f/ftRa6vFZb1LN5UnMg5
         zIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/x2JcWz5CQHE6kW+67bo8M2doIS6cXyyruWxUcOAU9A=;
        b=t5Dr413cG4zbnekmKnYvtoLc7tuphaNwMsZobg6CKcFTOYnIA28l5ZSMIZ7fJO9m+S
         K97JOpV/OYvDD2PUwrKuzrQX3QUl6WEo3NCclsLQttDS6B57a+NNV6JjhwlW4mrXJMOj
         9bLIaxwu93bDi/TSdSckCqmgUJqJeOn2t4/BR3UEibCa6SWRfCqmgw06/uZytiePJGQF
         DtIOh+KHNEPNZnW5GCKNSplcy6vLlULhOPfyosNDklh8dsRMazfYts5g0VKll0fEqLIY
         ckZuNe+nUHshuSjacjgt1rOvkXfpqMrsAGth99nxGLRg+d824OZCc5jRBwUkKZKxk+gQ
         5bgA==
X-Gm-Message-State: AGRZ1gJcXxz+F7ZQefXFIO/EQhBQs/DGI2PF01KrrmkCJldADCcTn/Dn
        B2ekhIjIxbf3+tB9cUbQJ1eUtdHBWLMUOGcWQR4=
X-Google-Smtp-Source: AJdET5ePvFF21RjISp2YYmA1i8MLZkzDkmY+Z7KXG8B431GO45uyvzM8ccAF2b+Q0TI1YmNVWdPZshbd2U2W8/uvgZA=
X-Received: by 2002:a67:60c7:: with SMTP id u190mr6645044vsb.85.1541938519504;
 Sun, 11 Nov 2018 04:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com>
In-Reply-To: <20181111095254.30473-1-pclouds@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sun, 11 Nov 2018 13:15:07 +0100
Message-ID: <CAKPyHN3xB3o8eFssqr9014TGoX2qYUz8b9Zw0r-f=R4+sv95gw@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 10:53 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
> Also while "precious" is a fun name, but it does not sound serious.
> Any suggestions? Perhaps "valuable"?

"precious" is also used by POSIX make:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html

Bert
