Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DBC1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeAZS3z (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:29:55 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:34135 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeAZS3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:29:54 -0500
Received: by mail-yb0-f178.google.com with SMTP id u35so523739ybi.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ne8xDAIsEb3UMT7PZaMFQvu1+hJFuzEjCn1i7x2GTH0=;
        b=L68asxdAtoaVJoGSJ+ElMz8Cgtw3CSzD2ygOhx7Uf3ELWxYU9pkk8w6dAoS8ChbBrm
         Aq0OuKQNcH7pgO0K5YdO6wMLn0j1UaKf5bAHSeDGLeaKEFC4HfMTm/5OrnXAusoHwMPH
         watv0EcWDwB6ezbtjcVgGYUHbftHcOANfAYRa5PdXMwKApwfZSBVzkjzViTJ69flJEkZ
         38qTzXp7Dby825SoMxSJHbeZBBab/jIjPxWIdJr1HF6o9x8d3y1hhYw4C7j5Ci1BM2iF
         D8Ews6NQs4l3MObohAq+ddqCUxl1iZW74dKxpyj0thNMYMc1pbPzl/3jjCbzWjZb1hAk
         TcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ne8xDAIsEb3UMT7PZaMFQvu1+hJFuzEjCn1i7x2GTH0=;
        b=iry0RlEg4ydLO8WTAltSpRn5D7WfdI9/p3K4IZR2fO3fcu7vX3UlQ1JfVlaBswe/fx
         ltW4WylmXjyBkVQfgMd8fAtlyb87/ZBcNjgvknlEdeEEx+7w84JYxKFgVnB1LqwtePd+
         wPUVF/xxcUhl96ptcVqXSnRQ2lmFxZGvpTQe3fwzLOT+ShAq9Z69ZxHVbuxoDmJgHb8h
         8rO2Dbu3zNj13LJqha7Hwq6BmYCfaXVbjPQQbit04SRA4kXouSS8heFIpUwknLYiCtht
         KSBEXse4hDbX5jfSNYEzEfPAWYmvPQCNvvMrILLPNSqLwZAuc2fTa36YdbvupM50E3Ho
         t+6w==
X-Gm-Message-State: AKwxytdC1J5hVLIaSZq8x4PBz/gFkHRZwtQ3XPfHrZh8iFlj5Q7xUKxO
        415Rqa81nzCq1x2EUu7nU61aRMPV1JV7dyV2+EtqOA==
X-Google-Smtp-Source: AH8x2257aijVw2gJ85q0tlWMOPHLedmemDs/Vha5zwBF9h31gWLhN0DEbzBhoACHaNzlvH4SVmBX1AdFxLzvqFD6DrU=
X-Received: by 10.37.59.139 with SMTP id i133mr12135169yba.420.1516991393430;
 Fri, 26 Jan 2018 10:29:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 10:29:52 -0800 (PST)
In-Reply-To: <12531516812201@web36o.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
 <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
 <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com> <12531516812201@web36o.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 10:29:52 -0800
Message-ID: <CAGZ79kZX3NOb4ttXvjV0=vrLrMTj7z7N=+=DUtd0+3gYWJ6wng@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     KES <kes-kes@yandex.ru>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 8:43 AM, KES <kes-kes@yandex.ru> wrote:
> Here is another place where diff can be improved:
> @@ -141,8 +140,9 @@ My_runops(pTHX)
>                 // Do not trace variables in DB:: module
>                 if( SvOK( inDB ) ) continue;
>
> -               sv_inc_nomg( inDB );
>
> +               // save_item( inDB );
> +               sv_inc_nomg( inDB );
>                 dSP; SINFO; SAVETMPS;
>
>                 // printf( "SWITCH\n" );
>
>

(Manually reconstructing), the before:

                 // Do not trace variables in DB:: module
                 if( SvOK( inDB ) ) continue;

                 sv_inc_nomg( inDB );

                 dSP; SINFO; SAVETMPS;

                 // printf( "SWITCH\n" );

and after:

                 // Do not trace variables in DB:: module
                 if( SvOK( inDB ) ) continue;


                  // save_item( inDB );
                  sv_inc_nomg( inDB );
                 dSP; SINFO; SAVETMPS;

                 // printf( "SWITCH\n" );



> This would be better it the patch looks like:
> ( this patch is manually created just to light the idea. It may contain errors)
> @@ -140,6 +140,7 @@ My_runops(pTHX)
>          // Do not trace variables in DB:: module
>          if( SvOK( inDB ) ) continue;
>
> +
> +        // save_item( inDB );
>          sv_inc_nomg( inDB );
> -
>          dSP; SINFO; SAVETMPS;

Before:

          // Do not trace variables in DB:: module
          if( SvOK( inDB ) ) continue;

          sv_inc_nomg( inDB );

          dSP; SINFO; SAVETMPS;

after:

          if( SvOK( inDB ) ) continue;


          // save_item( inDB );
          sv_inc_nomg( inDB );
          dSP; SINFO; SAVETMPS;

Seems like the diff is the same.
I agree that we'd rather want to remove/add empty lines
instead of moving full lines. Maybe we can add a penalty for that
in the diff code. Currently each line costs the same, as diff algorithm
optimizes for number of lines to be minimal, which both these diffs
satisfy.


>
> As we can see, here the `sv_inc_nomg( inDB );` line is unchanged and `// save_item( inDB );` is added.
> Here we just add/remove empty lines and patch looks more better.
>
> I think (and this is my assumption), the the diff algorithm should take into account the string length.
> This is more better to add/remove more short lines

Yup. Thanks for giving an example.
