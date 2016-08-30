Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAFE1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbcH3Oyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:54:51 -0400
Received: from mout.web.de ([212.227.15.3]:55795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754779AbcH3Oyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:54:49 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MCqWJ-1bnr6K3Zdz-009d9z; Tue, 30 Aug 2016 16:54:31
 +0200
Date:   Tue, 30 Aug 2016 14:54:29 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not
 inherited by child processes
Message-ID: <20160830145429.GA11221@tb-raspi>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-14-larsxschneider@gmail.com>
 <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
 <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com>
 <xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com>
 <4A177D61-AA25-415A-808D-B6BDA3BB5C47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A177D61-AA25-415A-808D-B6BDA3BB5C47@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:ZAtpr9oINYeJVlm4lpEBQVJ47WdvjIIIXkNVh04XTSZ4LB843DH
 vMYHsIbJZQ+htjjXOJniMAi9Sh9wfGLp0Z/bVtUYgUF891HcccMSZ14fslSwMMccAAQzxVg
 Edmo8P75ruZ+5DzEFuvBy3DyXJccmBgQ9WHV0TUziFplR0SCMJN08UBi/4R7B14G/a3QIT7
 aHBOm6JpGdpi3q72n0GvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YZX9psk/+ko=:SyCYDm0RqdvkAVz3tt02R6
 htFw17en+Lrzy25//NRwMJc235Mn2M+eZW4YEObDF29eg5ZnEi9C7ezE5izd4ryX0B8o4WsEW
 CfxTNlVcd8o7nQ556HVsE0nGnmAmuzM3+EJQH68LcV1MJNuyrPnPQ4RpdvGHdnF5M7jYJN1nn
 9hoPl76UPB3l+UjFqE+1ZxqYG4/3DBKxnloU4QTynbNiicabw/d60Rsp4l6cPUFDdFlWozqeW
 Pm9AjSCVeuRflJYsSZ2996QbLI3HD+OfzSNpLTPtuA/oQwveScgywm0xJbiNR2bgl625xcapR
 cRcK5N/VGmmdMoN6u9dxAnIuXvObCS8ekTkc66WzaPzJ6eddmAWCESsYcWQxXX+CH9bAcN//h
 PvRxG00MDTV0Cx2cQRGOYOTNSbanQ55JZ5larfVBo+OM1MeA/a8ZDLEJ52puSmoU5mDtSaq/n
 H2KKtjkROOJ9wC+lX6R9p4SWEO+H6CCKg01hByu/gzF1deXilWG8b/U8Ajo7xp8TMvc6OQrQf
 KGc1M/ogaOsELhm6JN536CWmCm7MB58NmwlUfQVfJlVCSMXDnuO0XAqO43XOwFRZmgohah8Ps
 biQePMKsLttSCf0ynsQ1kW7aY2hT85jE+T2xS5NDSx11UOu6OG7fIU2//FNOBTKX47A2nwoIH
 M7iBBxVnTTx0wlmM0pLDh358bnB94IM3NcrTKMcOTLMR6vJt4mfcrs5iGwZmYOVhv80140gpe
 hStdXHszvtqmiVuzbclQZOJrt9uIteCl/HinP0skNOqmPBlPNMkiyAkxRco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> 
> diff --git a/sha1_file.c b/sha1_file.c
> index d5e1121..759991e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1485,7 +1485,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
>  
>  int git_open_noatime(const char *name)

Hm, should the function then be renamed into

git_open_noatime_cloexec()

>  {
> -	static int sha1_file_open_flag = O_NOATIME;
> +	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
>  
>  	for (;;) {
>  		int fd;
> 
> 
> 
