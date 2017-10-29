Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC3A202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdJ2RYF (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 13:24:05 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:53548 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdJ2RYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 13:24:04 -0400
Received: by mail-qt0-f174.google.com with SMTP id n61so13764786qte.10
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bztZKMIe6k/qD173tdYTWptWI+6d6NXz6LHI2PyWE08=;
        b=jwZbQznnCWFD46oy6tIoRlaYhx7XarcBvvrS/0tByypOWHGqJqI8djgYsl8NvEIVgP
         +SrrTxjUYiAiKuuoV9RDKxpCTgsRTEH2a+0+7396ukIwsptkjK+pPEDH0KfZ/9vQJnod
         +ZzzFOzjT5bI1v27GfEXmwIVnRH0H8pzAtgWLt3uC5Uz0EiuoPK2i4QlBZ0CGXxqR63z
         c+X7tmWs8c/RMB5iflfKoeDzOq4uuFsMjVoQGpQ0eZ6U6j7I7Q28n1qpbpAWut+ZPY8S
         TDhWKxGXXd0YjQEuMamp3Y8ZqgVq6jKnnYk82HIfmNcNWYSuLh4O2L3VLVOZdHn4JOTT
         TvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bztZKMIe6k/qD173tdYTWptWI+6d6NXz6LHI2PyWE08=;
        b=rBugfUJacsxaRM2n0RyZucCWULJ0tMotoiqMHPPKIp/HwvIOPFy8UANDT/ZTRqRTs1
         ccEf9Yj1/ZK9M862UBc7H24vKKBG/cRq54lUdYack7ohS4vUGE6OTGKd4Hss5epDR63G
         /pT9eeQQgtLe8T3P9pOupgv8ZsyD5pGEwormNhrCNmYFjTNKrXiO6cFTdWuefCMEoafJ
         VjWbnzv5ByO+C44w2APim0ei9BT5OK9/RNwCCorniKEezDLm2sYp6IQPANOhMTRNA1uf
         CQjTeynffHqqcTsU0o5sX+FVsNX13wCZ/12Yo/9hnV5GY3Sbx0tO0t0/Ef8NF8Y+3qNI
         tjKA==
X-Gm-Message-State: AMCzsaW1iPweUX5vYRlb86fZn+gsJ/RwL1y6MXStp25Dd9TtFHPmRos7
        AL0QOTwJGgxFSBZcQHwgt86Ck1PDFLMPDqt+JfhVPA==
X-Google-Smtp-Source: ABhQp+QB8pDRyNocO0y2EvRkC6B1/sGBeA8jE3j4cYr1gawWNuRYnQ87D+U0Zodvpt51w4eOPc0G6ejdNCCyye4pI2M=
X-Received: by 10.200.53.12 with SMTP id y12mr11049798qtb.84.1509297843662;
 Sun, 29 Oct 2017 10:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 10:24:03 -0700 (PDT)
In-Reply-To: <20171029160857.29460-2-anarcat@debian.org>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-2-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 13:24:03 -0400
X-Google-Sender-Auth: u8DLSxAWTvfQbxVB7lARGGvuK7s
Message-ID: <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>, Kevin <kevin@ki-ai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> From: Kevin <kevin@ki-ai.org>
>
> this introduces a new remote.origin.namespaces argument that is a

s/this/This/

> space-separated list of namespaces. the list of pages extract is then

s/the/The/

> taken from all the specified namespaces.
>
> Reviewed-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> @@ -1331,7 +1356,12 @@ sub get_mw_namespace_id {
>  sub get_mw_namespace_id_for_page {
>         my $namespace =3D shift;
>         if ($namespace =3D~ /^([^:]*):/) {

This is not a new issue, but why capture if $1 is never referenced in
the code below?

> -               return get_mw_namespace_id($namespace);
> +               my ($ns, $id) =3D split(/:/, $namespace);
> +               if (Scalar::Util::looks_like_number($id)) {
> +                       return get_mw_namespace_id($ns);

So, the idea is that if the input has form "something:number", then
you want to look up "something" as a namespace name. Anything else
(such as "something:foobar") is not considered a valid page reference.
Right?

> +               } else{

Missing space before open brace.

> +                       return

Not required, but missing semi-colon.

> +               }
>         } else {
>                 return;
>         }

The multiple 'return's are a bit messy. Perhaps collapse the entire
function to something like this:

    sub get_mw_namespace_id_for_page {
        my $arg =3D shift;
        if ($arg =3D~ /^([^:]+):\d+$/) {
            return get_mw_namespace_id($1);
        }
        return undef;
    }

Then, you don't need even need Scalar::Util::looks_like_number()
(unless, I suppose, the incoming number is expected to be something
other than simple digits).

In fact, it may be that the intent of the original code *was* meant to
do exactly the same as shown in my example above, but that the person
who wrote it accidentally typed:

    return get_mw_namespace_id($namespace);

instead of the intended:

    return get_mw_namespace_id($1);

So, a minimal fix would be simply to change $namespace to $1.
Tightening the regex as I did in my example would be a bonus (though
probably ought to be a separate patch).
