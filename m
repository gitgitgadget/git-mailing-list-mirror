Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A678E20193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbcHDPGJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:06:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:58352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095AbcHDPGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:06:07 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MQRWm-1bhNrM39xM-00TjbS; Thu, 04 Aug 2016 16:59:24
 +0200
Date:	Thu, 4 Aug 2016 16:59:23 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] import-tars: support hard links
In-Reply-To: <xmqqinvhaji7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608041658220.5786@virtualbox>
References: <bb3b91403fae1964aa990fc16fd8a4e5f16885e6.1470230877.git.johannes.schindelin@gmx.de> <xmqqinvhaji7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4zEHgt7VM9lYkdyUSarSwhn0zArP+k0870IWql9eCbnAYn/sHrl
 IOIBBUVYlesUnesOFACDaTEbzvfZzX7gyfotteVcFppzrtyHXoeOXurUtYmW7cRz7XpxabQ
 zTQAHVXA+BslGxYM7stVstd4RdhpNcxtA462exPYOk16O583WPO6iqWgeae75FX4YxlAfgW
 FYw3VLLq9Y2c+Mo1n4CpA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kgyAbOUl5TI=:v9eTktvAPsX1QmYShNUEoB
 49oVLHhQ0ykEjiefo+gvXs3tEUmftdJ9Cjfu3StQI+yH/BLa638fBDYhxKdXDOIMekTcoTrGK
 UMUUjG8TMYG//pOz0GGyGVp7CwlteYju2cro7DZYU8FCpJe1a0SV043s4pcVBCxMrFyzXHzCH
 PQnkcIWxS9TYNizVLg+QzUO4WDkFmrSzulEv4qpG625Gwhq1DimyNnD9FdysTpiiXrYwYkmpc
 SjElZXm2FSCev9GO4kGcDLlsvl8c6cvuYF1NYfDUD9BZPWX0nw4XNVGzKiYkXaj4Ijxn9R0CW
 rxaNph+NQ+q1iRzcBB46FjcsAQfGKTZ7eUJNXdWlshNX84U7FQk6SRPjbdWKChyEaqngX96I6
 g3+W0g8OA6V+RmWcKT4AJKNOiN/nyfskt5dVi1jqYArW5AhUDdui7RUQIpCoPJFx17JsumWbC
 fbAMw96m5BGZfwcUfH5bwxhwABaUjujdWLZjpgB+T7Ks8A8vhHIVAp5mTCZvriqCgCgNlQK5P
 cRcBZEbNkRReUa1/mkmLslBatqxuYyceCH8thqJaI09+xGAp/ZHeLQBMiZLUvUdwXXCXSQHUY
 S8ruSmuELzKNpeOLbUWtVcooHJ2uznBuyBBx4q0dbf8uqzdWib7trkG3+XwwN7hfI8VWe4EVo
 ffouBOTBSkE/oHAht5Twymm635kXHVZndDrY/HgJajzFLeNK6TLwAA0ydgaSN5gOkwtvIt3WV
 nY/+W9iFeraIfKJyYC62qBznF72a43FwoNR3JqQH1ksLY3ZjNhGNIybaLVSx58DLkfaKTLuzD
 Q8YWIz2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 3 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > ---
> > Published-As: https://github.com/dscho/git/releases/tag/import-tars-hardlink-v1
> 
> A link to a page that lets you download entire source tarball is not
> very useful to most people, except for those who want "this exact
> change on top of some unknown base which may or may not have other
> things they need", which I think is a minority.

True. I added a second line that describes how to fetch it (see the t5533
patch I just sent out).

Ciao,
Dscho
