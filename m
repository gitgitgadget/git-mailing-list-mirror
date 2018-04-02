Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76391F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756542AbeDBUKs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 2 Apr 2018 16:10:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62018 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755846AbeDBUKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:10:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w32KAhn3075005
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Apr 2018 16:10:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Stefan Beller'" <sbeller@google.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git'" <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com> <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com> <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
In-Reply-To: <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
Subject: RE: [ANNOUNCE] Git v2.17.0
Date:   Mon, 2 Apr 2018 16:10:38 -0400
Message-ID: <014601d3cabe$ae3f7e30$0abe7a90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhLuUQLx28uJBqsgyhh0QfTRDAYAHShdv4AZlZtpCkt8BSAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 2, 2018 4:02 PM, Stefan Beller found my change:
> On Mon, Apr 2, 2018 at 12:57 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > On April 2, 2018 3:34 PM, Junio C Hamano wrote:
> >> The latest feature release Git v2.17.0 is now available at the usual
> >> places.  It is comprised of 516 non-merge commits since v2.16.0,
> >> contributed by 71 people, 20 of which are new faces.
> >
> > Just a heads up. I think this one might have gotten missed at some point a
> few months back. I think it was submitted back in January. Not sure where it
> fell off or whether it was just dropped.
> >
> > diff --git a/transport-helper.c b/transport-helper.c index
> > 3f380d87d..5ee7007f6 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1212,7 +1212,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
> >                 return 0;       /* No space for more. */
> >
> >         transfer_debug("%s is readable", t->src_name);
> > -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> > +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE -
> > + t->bufuse);
> >         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> >                 errno != EINTR) {
> >                 error_errno("read(%s) failed", t->src_name);
> 
> Patch at https://public-
> inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com/

That was it, thanks.

Cheers,
Randall

