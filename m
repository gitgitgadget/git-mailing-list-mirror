Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECE41F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKGFd5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:33:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44136 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeKGFd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:33:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id n19-v6so11544244edq.11
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 12:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LfPlgZ4aqq9oB09Bw7Vyfirdv+wabUDbHkkWVBH6w0E=;
        b=Ey57TpX4uLmk/QsbW6La2gzfhx50AacPznlKqbRP9YcUGTCRirUCHteg5mOuijjC7e
         nmqiP4kUK/DQQOYfBy14xvRS8o2AU1Z+z7vrxz036UV87h0cUsUoMkLSjvBD4dOr/1nV
         BTacxoy4wEan7Dt/CNU3G9S/rCZQQOquS3BFtfjoYEPvPZvS2nvbbUzKYho/ISQg56bI
         Wyg0cYSGgXvKkSp5ykIKwjkVXaIhIqkErHH1npmo8eCwHswHheb1yR7f8H6eoup7lCU+
         d+G1RlmT1rb+gXiiddPXcCAgPWvxuqKMqXGB5pNQ5xAhuH70mZu5x2x0AwJgOE0+7YCc
         Dc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LfPlgZ4aqq9oB09Bw7Vyfirdv+wabUDbHkkWVBH6w0E=;
        b=TeU8S6CynciPqKIlwdk2uSWTIpqYax6en8a7Gyaw8Y2FcruafpE826bw6TCYxVRhPb
         R/6NG3eAHjeaWVylsrVxxJA8OqqoZw98fdxPgK7o/6sHclIk6GTELnqqhmxUx5nGKoc3
         pZala10butM4PC3xoSJBHmPQ9xWhjdJY1EPRrPmUnSOeBmK+l3z6GIyWOqgL6XjdB80V
         MD2NAek/hnZm0cFLo7esywWGCZCFWpdrLmXw/qK2cuz/q/GPfngliUAwsazVk7mT7n8Y
         d97WFflxI+TQTHJjbJi0MLglrcN+JcRNyxXfZuIxxmQ1bddUMh9oVAl+grcLxyud+Qt5
         nhQg==
X-Gm-Message-State: AGRZ1gIYtIu0qgpFdK0pdjUCtRJ/IlzvEUnZENEMVW9lo1QzzuS4VUfe
        S3DPAaCZeQ7z+ESuGaNu+F4Lhw44nIp1GpQSyG8wzJTuE6ymDw==
X-Google-Smtp-Source: AJdET5elcNlp2Mh6KXK5OV51MfaAaEZaacqcXFt9aiVbzi/Cs3gn2i6OlwZwgxgI/Fcwnot/lZ7rN9iOSo+HyKvkr8Y=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr17944835ejb.70.1541534821084;
 Tue, 06 Nov 2018 12:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20181106195417.5456-1-dpb@corrigendum.ru>
In-Reply-To: <20181106195417.5456-1-dpb@corrigendum.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Nov 2018 12:06:49 -0800
Message-ID: <CAGZ79kZKN8U5+F+BAhQMkLuJVupgAvUgCaMt5-e_FDmY1RUY5g@mail.gmail.com>
Subject: Re: [PATCH] gitk: don't highlight submodule diff lines outside
 submodule diffs
To:     dpb@corrigendum.ru
Cc:     git <git@vger.kernel.org>, Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 12:03 PM =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=
=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru> wrote:
>
> A line that starts with "  <" or "  >" is not necessarily a submodule
> diff line. It might just be a context line in a normal diff, representing
> a line starting with " <" or " >" respectively.
>
> Use the currdiffsubmod variable to track whether we are currently
> inside a submodule diff and only highlight these lines if we are.

This explanation makes sense, some prior art is at
https://public-inbox.org/git/20181021163401.4458-1-dummy@example.com/
which was not taken AFAICT.

Thanks,
Stefan

>
> Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=
=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>
> ---
>  gitk | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/gitk b/gitk
> index a14d7a1..6bb6dc6 100755
> --- a/gitk
> +++ b/gitk
> @@ -8109,6 +8109,8 @@ proc parseblobdiffline {ids line} {
>         }
>         # start of a new file
>         set diffinhdr 1
> +       set currdiffsubmod ""
> +
>         $ctext insert end "\n"
>         set curdiffstart [$ctext index "end - 1c"]
>         lappend ctext_file_names ""
> @@ -8191,12 +8193,10 @@ proc parseblobdiffline {ids line} {
>         } else {
>             $ctext insert end "$line\n" filesep
>         }
> -    } elseif {![string compare -length 3 "  >" $line]} {
> -       set $currdiffsubmod ""
> +    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  >" =
$line]} {
>         set line [encoding convertfrom $diffencoding $line]
>         $ctext insert end "$line\n" dresult
> -    } elseif {![string compare -length 3 "  <" $line]} {
> -       set $currdiffsubmod ""
> +    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  <" =
$line]} {
>         set line [encoding convertfrom $diffencoding $line]
>         $ctext insert end "$line\n" d0
>      } elseif {$diffinhdr} {
> --
> 2.19.1.windows.1
>
