Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DA520248
	for <e@80x24.org>; Wed, 27 Feb 2019 17:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfB0RPB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 12:15:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:37694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfB0RPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 12:15:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34082AB87;
        Wed, 27 Feb 2019 17:14:59 +0000 (UTC)
Date:   Wed, 27 Feb 2019 18:14:58 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Need multibyte advice - Shift-JIS
Message-ID: <20190227181458.4f019d91@kitsune.suse.cz>
In-Reply-To: <001101d4cebe$7119a080$534ce180$@nexbridge.com>
References: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>
        <20190227150836.495f1692@kitsune.suse.cz>
        <000001d4ceb4$b930df50$2b929df0$@nexbridge.com>
        <20190227171103.4cbc735a@kitsune.suse.cz>
        <000a01d4ceb8$3cd19720$b674c560$@nexbridge.com>
        <20190227172841.3a74fa60@kitsune.suse.cz>
        <000b01d4ceba$39cfddf0$ad6f99d0$@nexbridge.com>
        <20190227175135.4392e9d7@kitsune.suse.cz>
        <001101d4cebe$7119a080$534ce180$@nexbridge.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Feb 2019 12:03:58 -0500
"Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> On February 27, 2019 11:52, Michal Suchánek wrote:
> > To: Randall S. Becker <rsbecker@nexbridge.com>
> > Cc: git@vger.kernel.org
> > Subject: Re: Need multibyte advice - Shift-JIS
> > 
> > On Wed, 27 Feb 2019 11:33:47 -0500
> > "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> >   
> > > On February 27, 2019 11:29 Michal Suchánek wrote:  
> > > > On Wed, 27 Feb 2019 11:19:33 -0500
> > > > "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> > > >  
> > > > > On February 27, 2019 11:11, Michal Suchánek wrote:  
> > > > > > On Wed, 27 Feb 2019 10:54:23 -0500 "Randall S. Becker"
> > > > > > <rsbecker@nexbridge.com> wrote:
> > > > > >  
> > > > > > > On February 27, 2019 9:09, Michal Suchánek wrote:  
> > > > > > > > On Wed, 27 Feb 2019 08:04:08 -0500 "Randall S. Becker"
> > > > > > > > <rsbecker@nexbridge.com> wrote:
> > > > > > > >  
> > > > > > > > > Hi Git Team,
> > > > > > > > >
> > > > > > > > > I have to admit being perplexed by this one. I have been
> > > > > > > > > asked to support the Shift-JIS character set in file
> > > > > > > > > contents, comments, and logs, for a partner of mine. I
> > > > > > > > > know there are a few ways to do this, but I'm looking for
> > > > > > > > > the official non-hacky way  
> > > > to do this.  
> > > > > > > > > This is CLI only, and our pager, less, does not support
> > > > > > > > > multi-byte, so I'm looking  
> > > > > > > for  
> > > > > > > > options there also.
> > > > > > > >
> > > > > > > > SJIS is about as much multibyte as UTF-8.
> > > > > > > >
> > > > > > > > Why do you think less does not support it?
> > > > > > > >
> > > > > > > > Last time I looked there was SJIS locale for libc so it is
> > > > > > > > only matter of generating the correct locales and using
> > > > > > > > them. Of course, if you are  
> > > > > > > running  
> > > > > > > > in UTF-8 SJIS will look like garbage.  
> > > > > > >
> > > > > > > Sadly, I did not personally build less on this platform, and
> > > > > > > the libc used did not include UTF-16, on the platform vendor
> > > > > > > supplied less. cat works fine, but the usual
> > > > > > > LESSCHARSET=utf-16 is unsupported, so I am looking for an
> > > > > > > alternative. THAT is why I think less does not support it.
> > > > > > > Sorry, I should have made that more  
> > > > clear.  
> > > > > > >
> > > > > > > cat works fine, so if I set GIT_PAGER=cat, I can at least see
> > > > > > > the diffs cleanly in SJIS, but this partner wants a pager that is usable.
> > > > > > >  
> > > > > >
> > > > > > So you want to use SJIS because UTF-16 is not supported. So what
> > > > > > is the problem with SJIS (or UTF-8 for that matter)?  
> > > > >
> > > > > The partner I am working with is using multi-byte SJIS, which is
> > > > > also not  
> > > > supported by this incarnation of less. As a result, UTF-8 does not
> > > > work either in this situation. The content is definitely multi-byte.
> > > > I know this was fixed in RedHat's Less in 2016, but did not make this  
> > platform.  
> > > > >  
> > > >
> > > > Both UTF-8 and SJIS is multibyte and both is supported by less in
> > > > general. If your particular less cannot support it then it is broken
> > > > and you should fix it or get it fixed.  
> > >
> > > To be more specific, the implementation of less' UTF-8 on this platform will  
> > present the data as unusable junk as expected. SJIS is multi-byte, but is not
> > one of the allowed encodings in less. I am not empowered to "get it fixed".
> > Thanks for your advice.  
> > >  
> > 
> > How is this 'allowed encodings in less' defined?  
> 
> When you run less with LESSCHARSET=encoding, if the encoding is not known, you get the error:
> invalid charset name
> 
> Doing the due diligence, I actually read the man page on the platform before asking the question, which listed the following as the only allowed encodings: ascii, iso8859, latin1, latin9, dos, IBM-1047, koi8-r, next, utf-8, windows. The utf-8 variant does not know how to display its multi-byte forms in SJIS, as with other platforms. Does that make sense now?
> 

Does the said man page also mention LESSCHARDEF or LESSOPEN?

Michal
