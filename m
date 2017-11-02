Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B4320281
	for <e@80x24.org>; Thu,  2 Nov 2017 22:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbdKBWsZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:48:25 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:43972 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbdKBWsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:48:24 -0400
Received: by mail-qk0-f178.google.com with SMTP id w134so1276202qkb.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5V3chklupIEAKBXe3ExzApYTUurQNb6Bi5E8hVofdME=;
        b=MrwRK0tNyu7y3biqx6z2Ga0LwS1UyZxqXSEbTeHtClJQ+bQBfWA1eFVjmlcf2126l1
         At4EECCExRmDilTHjT05yyud3SY6y+INQ5Uxqoh9L5hlS/wwJeWNo8rl+OfiFbbTKRbJ
         D1fp8WMeF9oJtyc0gcMpvK3GvOSHhnoxX92SkS1Zkj3MmBh7bvDStDIJOAw6uHb1EIaG
         zBBoTp95cFuFq+QAIlkx36LZZRlG3xeCHPZtV8uYpMTEw6tRKMyBtorM7iDcMHW62Ge9
         uOSE12bUzJdRdL7Q7LjiWPxiFpBc8i7JypWN8Xz2Kz2S5ygKd68ZZOktWGXYPGSrQo3R
         RIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5V3chklupIEAKBXe3ExzApYTUurQNb6Bi5E8hVofdME=;
        b=ptHpv1mHgucWwU5KLEwveHeP7em8DWvVmnzPdSNtfdJTQvGO7kobG4s1qrT/Ho5HrC
         KUwwKC/y8f+QsN6Tcbq1icAxisTjEwWKDDIFM8J+gdV1Iad8WnfRi/GCIaPBRUE5tR0j
         rQSkHWWe+5rBZxwmaovLVkzXXttQIlh5/CisCbMWJYtJdLBvjoHi/F5dxGEyPyRcLOQ0
         lCH3/yK5eazaA26T1y5c46m3tBcwqAvCS3chhDGbUSEtEzBFjeUXkvYsyWVgSOMPYjV7
         WZ42zINrNbcpbyvai8nSo8N/bVpbtjNiTJut2DUWEniehZ128TIFdsbHIRSSrNGcPj51
         CqDQ==
X-Gm-Message-State: AJaThX6MUJ4U2RpneGy+UUFP8Si/eB5Qreu+lo0Md0HH8QcyAOoUVktY
        xJpqZJjRTHoaHyzT3aQm5WV3jz/LVVrv/mtfMig=
X-Google-Smtp-Source: ABhQp+SXVBIcYMNQ2Ujy+QBTmJdKbmFDXVzpYnW80ry91cmBJboq3Evro7S4wHCH25cn31MDhDkgKPfJEzjD0KsyYOY=
X-Received: by 10.55.77.214 with SMTP id a205mr6859596qkb.196.1509662904069;
 Thu, 02 Nov 2017 15:48:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 2 Nov 2017 15:48:23 -0700 (PDT)
In-Reply-To: <20171102212518.1601-6-anarcat@debian.org>
References: <20171030025142.19421-1-anarcat@debian.org> <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-6-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Nov 2017 18:48:23 -0400
X-Google-Sender-Auth: krwYk6GF3WgDQI_ZDxXU0yafMC4
Message-ID: <CAPig+cRtz7xuBy7QUgr_BHomH+txs1ynxdV9Z28xu1CDVW+uuQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] remote-mediawiki: support fetching from (Main) namespace
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
> When we specify a list of namespaces to fetch from, by default the MW
> API will not fetch from the default namespace, refered to as "(Main)"
> in the documentation:
>
> https://www.mediawiki.org/wiki/Manual:Namespace#Built-in_namespaces
>
> I haven't found a way to address that "(Main)" namespace when getting
> the namespace ids: indeed, when listing namespaces, there is no
> "canonical" field for the main namespace, although there is a "*"
> field that is set to "" (empty). So in theory, we could specify the
> empty namespace to get the main namespace, but that would make
> specifying namespaces harder for the user: we would need to teach
> users about the "empty" default namespace. It would also make the code
> more complicated: we'd need to parse quotes in the configuration.
>
> So we simply override the query here and allow the user to specify
> "(Main)" since that is the publicly documented name.
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

As with the previous patch, it would be best to drop this Reviewed-by:
since it has no value with my name attached to it and was not provided
explicitly.

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
