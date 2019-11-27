Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE37C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EEF20684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sZFtsEbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfK0Hvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:51:38 -0500
Received: from mout.web.de ([212.227.15.4]:38125 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0Hvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 02:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574841093;
        bh=VUfsQy3tErg0pYDeC/4yxRPkm9DeiiEMpl/BxZD93rY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sZFtsEbiNywTj2itiMwQuFwReZhp8/gFiHaIYV68zonDkJDZPLx6soGO75x7dyxA2
         1Nra3bCTlR2UMbzFoRLvCTJ1YWcUyA/pynE4SGfH6QsYAj/SLOs4SDIkea0Y8Jg9eA
         FtKX14tXBPcAqSfqc60lZZfP1kAf1nmxIzKCuL2U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lr59f-1hw9Rf3sFn-00efVK; Wed, 27
 Nov 2019 08:51:32 +0100
Subject: Re: [PATCH] test: use test_must_be_empty F instead of test_cmp empty
 F
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
 <20191126200239.GA36748@generichostname>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8dc0b50d-4e41-bc79-33a1-7e2a1ef7aa0b@web.de>
Date:   Wed, 27 Nov 2019 08:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126200239.GA36748@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2TtLuTvtaknNk8+DSvMoa1GSBY0yzettpuK3HtDwZgw8XDD5M+
 YNp4d8c2sMxibsMenz5ic0w1OzUbYs9SDlA8xp3RXwwh0co2DWFNr0JL2PkWNMvCP3Kzxbn
 zpyzHD3nzcht1iVQThoV3zyxy3cyL0zkNC/r+7MlvKJAs52G5q60wwfttNMlGDQb9Cxw+WI
 DcXZ7w0nWuUOEU1qhDfCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXGE/E6g9DM=:OSNFVAXV/WfKBBkKy0MS3H
 oAQxlHo0kWkFOugPTlXuigSZU5Zd7l9D44BFM88KbxSFcSc9jF8VeCKPS5eUT05RnNXuSeJbr
 L8QcFqFcVajqqKC10kQvRDzavszMPtfbqEvhqVpkDVtTlEOajFiJw88SuTKN531MdkKPjiYFw
 EgYBl+rVsB4epCJl1KXtejP0soRmQn66DltsOI0a6w444sTukpWPd/aNT3IqBJcc+EOb6B8K8
 /tcHRLir3Li0xvUt62yNn2R6z/LAvooNlYCkaIDPcmO7WtLus6lWl+C1Ikws9W+A8GEWtfgX4
 k6oaGMXNv6Nd+exKbjpgk96riMqUXCkVon/fu4AEVTzDV/L1NpocHt3/SaaMqCJYh9xBfrT9H
 IZ3X0jFPmRbQ/Va6IO/VWqv3AwQsvEYSpRD6s9FH6euel2OD9w7JN1YF7Uip5C0sDCkI+48jk
 GvC+QZAWmUQjWvxuqrE7AQDuAowGDcoPieyHPP/BA0ANkA6TrloUSVBZKlFkGmBFbye+JQapQ
 N90hxpF4az4hVXKolBEpb4lde5FPjHahyJ1HlCG7WshfcqVRr1LvZAW0K7j3lp8FskzNw9ie8
 JvEWpbx4ad1P1qib4j4JgTjEtDe4Fd0JsxVXrOMNZSgZtyq4IK2JJJgOCKrtc9UephXAGf7rf
 UZMopuL9C934ZckajjbupC2ul8HEKXoUDBOQsE9guQT46zzw/qpyUxe3kx95hrfBvvpuGLdob
 ueyMve7+PBxHHeMc6y58HBjGbOGIZ5bzKLgZQuP//bowANvsbHPlzaFeBO2hT6V3s8+biDJUk
 +M7qbx0Uf2n4eoGUV/OBPL8mElO2MOJOVql1lh9StXokjBcD3bp3Nu+mqZxPO50I5xZFzfjvu
 EoKlSlJw1cQTi0a38jNRIJ2rmX92a+StfueMxWzIFdbV3+EJcPmQ9y/DsrC4vHBasYh4ORnXc
 idylp30jNNpfRVe0/O4iJ4AMJRcKa8+mJtp3Pz+D0xJaA7eZCQOzrK30GnmuvYprJuYxq+Iou
 XNOt7FZZHNPmx+pcW5vbe4QkbF/1zsZunAgt2CayvrZxAIPaqSCZYYda7BJ/FwJO1rlcrGCNG
 HYgg/ILsLsNrlklAN6PfPe8IzDZNll9pQ234dtpaIEh2AmIW1RcK6AtBxQ1ZCzkWyrcoUoGtU
 e5eWu5PJ8IbPxuEtXyYKblYeLYkESV9kkRckuLYq1g7h/8elAzA+k9t4ZmYjyQJd4VFEHPFee
 6e65VpVlVAazYcjbcgLi2430r6DFLZtq0ygqSfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.19 um 21:02 schrieb Denton Liu:
>> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
>> index 0b20b07e68..3a3d8d3bd5 100755
>> --- a/t/t9010-svn-fe.sh
>> +++ b/t/t9010-svn-fe.sh
>> @@ -53,9 +53,7 @@ text_no_props () {
>>  	printf "%s\n" "$text"
>>  }
>>
>> ->empty
>> -
>> -test_expect_success 'empty dump' '
>> +test_expect_success PIPE 'empty dump' '
>
> How come we need the PIPE prereq here? At the top of this file, we have
>
> 	if test_have_prereq !PIPE
> 	then
> 		skip_all=3D"svn dumpfile importer testing requires the PIPE prerequisi=
te"
> 		test_done
> 	fi
>
> which should guarantee PIPE at this point already.

Right, we haven't needed it since 7236a34c98 (t9010-*.sh: skip all tests
if the PIPE prereq is missing, 2017-09-17).  Thanks for catching this!

My patch had been gathering dust here already before that time, and
sometime along the way I did a sloppy rebase.  Didn't see it before
sending because I was focusing on "can we remove the empty file?".  O_o

Ren=C3=A9
