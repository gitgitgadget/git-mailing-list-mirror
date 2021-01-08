Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C64C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9766F23A9A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbhAHTJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:09:22 -0500
Received: from mout.web.de ([212.227.15.14]:33973 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbhAHTJW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1610132832;
        bh=j4aoWTtlwbjnhDa6CsQuzRSZKKhHBqglEJRLZMdi8U4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=n+ENaY+gCeh4vhsuN7N1snVpE3R8oBl57YZWa/1mfwikaj5HmULL1HVOTyrlINqKa
         3yLulrBx8/SyaWIEtURx8RkxYu2W5W1Kll91r0pxQdHou+2fFz9hYIGcrA4yH3BwLP
         hP36NVPxlKcd+fcA45xACY9DfPwjP5bwF8CglymE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lz2zw-1jts360vOy-014FpO; Fri, 08
 Jan 2021 20:07:12 +0100
Date:   Fri, 8 Jan 2021 20:07:11 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Daniel Troger' <random_n0body@icloud.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210108190711.hdafki7kxani7s45@tb-raspi4>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
 <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
 <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
 <ffe0a3ae-780d-95ae-524d-7b029eda21ee@gmail.com>
 <20210107154926.6tb7ukgemn7kmpnl@tb-raspi4>
 <613fb31c-c23d-0568-f311-74eb14bba2ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613fb31c-c23d-0568-f311-74eb14bba2ca@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:tIcsOLLGYRD+dUzq9GNLLodUOZwKLmar2qQsBX9HbzEJlQzTRLn
 kwp9x1BaSQD+O6fS36SrvT8w3XN5TUqW3CcFZd/8/X2peyqsAZ5TzLniaVsKQ4BDeWMxkaG
 MV9y02kRP9BotM4FIFtqOtMDOzpvseSwitr1Xo6gGGuXf0YbZQTfdEys/KYTp8TobKjBI7N
 2+MuehqemhpisRPZm9ErA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MCqGs/6YN6A=:BapqlzQOXUpy5aM87xbdq2
 MisODRu+QSCvdKbxjt84TlKBStKep8BhVG2RmYH5zs9vsjYV1dXsJnWTkc53MQMViltMoPdqP
 zzQMtoferjPAsqOOXiUbjxwJaXUpcqEHR/3tEMNIM+lTCE+6/eDMBm2+UPxrPym1wX09gANj0
 nKEvXGFh+JHXcX9bOtU0MQCYpIYZwNgUP29mlM7t7G/gdFPO7vga7Rik4/5siZQua+p/3Bekr
 p6pJ1K1O+GSAjWzVFxigdW0s+zjB4M+TailkAFp9eq1vUvxuybEYTMDBa11YdFXexoYCiKWhz
 RVcWERSzwxYHgfV8YF1SJis65SOcVkpomlF2ll9LLmPXBITM6xM5LN+WmKtbCvt8DB/Ifr6LB
 SSoHdF0Ds52bUrr3MBdSF+qlpcWi3oH4ThAjBOPqwwjmn4m/nu7/3htwlKqFmYJiUTNAwoRUt
 zZVi0TRBH3nOa950RTq2DvY4whqwRYAJeOp0BJZ//UBGcQY/wejmclCLuj5BIF14DL4exBdzB
 fg40Igh41pPU/9EfYKFi2jjTAwyA3JIwPftlODNA0wm1Djwj9xe3Hipv5wBpkx7Efk87CUjnx
 WE3lxYP+zU0KUKzLTMMK3m1RMZ54qiEYrKIRFnrhhOqw9BCxoed6kxiQPLO1xXfz+OspkpZfk
 l27FOHI900WhU2Gi1laiUFfZZ6XC0o8374XaMDjFPmpJGFHpYttXXzu5Ff5F+v1IczW6qr9K8
 cvkcXfGIM/nGZqGyIf++3+X/82e+ORU8QwHLtpxsk99GlOCFZD5T8+pshyps6YF+GJydzVoh2
 fuxW0lHQGwtwmILn96uVphqW/x5NAazZicRd/0IN/qioMSZuYh7D4aRyPkluRJw7tN9zHO44G
 tscjZksGkTg5tH57pv4Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 11:21:56AM -0500, Philippe Blain wrote:
> Hi Torsten,

[snip]

>
> change to:
> FILENAME=3Dfile
>
> >
> > rm -rf $DIR &&
> >      mkdir $DIR &&
> >      cd $DIR &&
> >      $GIT init &&
> >      mkdir $DIRNAME &&
>
> add:
> cd $DIRNAME &&
>
> >      echo "Initial" >$FILENAME &&
[]

That did the trick, the test case is now reproducible here.

I am looking into the stuff, somewhere inside the pathspec machinery,
determinating a "prefix" and using xgetcwd we need a precompose_string.
But only if core.precomposeunicode is true.

And I am still digging.
It seems as if there could be a patch in a couple of days, but no promises=
.
