Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F001F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeGIUEJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:04:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:49453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbeGIUEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:04:08 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN1Gu-1fjBxh2Ef2-006jB3; Mon, 09
 Jul 2018 22:04:01 +0200
Date:   Mon, 9 Jul 2018 22:04:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
In-Reply-To: <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1807092203110.75@tvgsbejvaqbjf.bet>
References: <20180708144342.11922-1-dev+git@drbeat.li> <20180708144342.11922-7-dev+git@drbeat.li> <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet> <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NXnJtyXTawg2eP6A7YvPprvgsr7z09cT0ALtZ+UfmvJGaGiHVer
 O3xFmhN4iWUOvwMbUYpbhXzwMCoDRtZzNxYh4O6hEJH26kKIYJDh70ng8vOd+HdarH7fQhO
 gjx/PKuSwYa6xDs75IJoE+hYAHB9BMqEAfZJgDZwcs6UHHQINWLNFVVVmm+H5SykZDpKwas
 GkJSb4Shi+KyFsVKZz8rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Togz3hGpCE=:KLfzIXiu6ZlFtHTTqgvwGi
 jgua/NDufLht62luknKtW1vHUao2ehZuzy2mpMtWZhw/GyN3xnmk9/4v8217oV5YsUlYujv/u
 3qbmuV39758v1gvibd592xXhAPnEc2XIAUPlYNcoFqyHohXa6d41ze6GItIuGhSVwovVFBsl7
 zzQQdtOColJaqb9isDz38Z5kdwGWDj1RBXtDUfh0VLv/VPhfX6Yrv58pAWkD/6IePGcyRnF75
 yzZxz+MejQ1o+u5KM4fkB8Zj2fQcWgF90xLL50Mx4eY2CnO3tj2Li30SFRuGeoKACYHrZ5tuC
 FRFI2RcZDTESd6NXbVFAXQw1TvNLtRDzMv6zngUeHS8E35Rth5GZBs/BIU5vkA6uTTomx3KMM
 meLP0RZHyAH2VLyWYEcb8AWh4W5zrX6hTW+y0/v8pYYXOdtu4Gj78BurXW6WvYNVuH+SFQ0Yi
 FXHELq9XYkxn2cWNtws/CD6kHiX6kOKOWxVndOBonwV3GTPwv0/6KFCXsqpx63UCY666+zKAI
 LTXORn8v7AY6yzPDwyxMKRDLHq68WuEjLbHDdlnr6UznFzlZu15yOMK8PZ99gRmVqjBp+5aBG
 7BVb/zSbx/YJGSKs1nyQdjNoZ7DzDKWLaEzR3mTb10iku1W5iKCYavKhVbKn84GMVWcELCneq
 TazEyXyb1ln/y52QblNqYdkjptZMgbWHFP869T/48nxXIMaJaGfhpWlfZXKyVQ9BP3li1+zVI
 k3PaJFo+v4gc+BiM8JHvVXD1OtPojrUFJi4JLLLyzq3lt32tUR/cafgo8avgUhGhtwTE/k7oN
 OZwYIr8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Mon, 9 Jul 2018, Beat Bolli wrote:

> Am 09.07.2018 15:14, schrieb Johannes Schindelin:
> > 
> > On Sun, 8 Jul 2018, Beat Bolli wrote:
> > 
> > > In ISO C, char constants must be in the range -128..127. Change the BOM
> > > constants to unsigned char to avoid overflow.
> > > 
> > > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> > > ---
> > >  utf8.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/utf8.c b/utf8.c
> > > index d55e20c641..833ce00617 100644
> > > --- a/utf8.c
> > > +++ b/utf8.c
> > > @@ -561,15 +561,15 @@ char *reencode_string_len(const char *in, int insz,
> > >  #endif
> > > 
> > > static int has_bom_prefix(const char *data, size_t len,
> > > -			  const char *bom, size_t bom_len)
> > > +			  const unsigned char *bom, size_t bom_len)
> > >  {
> > > 	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
> > >  }
> > > 
> > > -static const char utf16_be_bom[] = {0xFE, 0xFF};
> > > -static const char utf16_le_bom[] = {0xFF, 0xFE};
> > > -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
> > > -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
> > > +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
> > > +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
> > > +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
> > > +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
> > 
> > An alternative approach that might be easier to read (and avoids the
> > confusion arising from our use of (signed) chars for strings pretty much
> > everywhere):
> > 
> > #define FE ((char)0xfe)
> > #define FF ((char)0xff)
> > 
> > ...
> 
> I have tried this first (without the macros, though), and thought it looked
> really ugly.

Yep, I would totally agree that it would be very ugly without the macros.

Which is why I suggested the macros instead, in which case it looks
relatively elegant to my eyes.

Ciao,
Dscho
