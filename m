Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74792C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A83321556
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbgFSTfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:35:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:35362 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbgFSTfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:35:02 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05JJYwc7009989
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jun 2020 15:34:58 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>        <20200619150445.4380-4-randall.s.becker@rogers.com> <xmqqa70yhmxz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa70yhmxz.fsf@gitster.c.googlers.com>
Subject: RE: [Patch v1 3/3] strbuf.h: remove declaration of deprecated strbuf_write_fd method.
Date:   Fri, 19 Jun 2020 15:34:52 -0400
Message-ID: <02c101d64670$b72ab840$258028c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKpTDE+t6IzuT5QyP1r/drrysHRPAGMqbuqArqatUunGA5XYA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 19, 2020 3:32 PM, Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
> 
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  strbuf.h | 1 -
> >  1 file changed, 1 deletion(-)
> 
> I think this should be part of 2/3 (otherwise we'd have a decl that nobody
> references that declares a function that nobody implements).

If I understand, combined the strbuf.c and strbuf.h modification into a
single commit, correct? I normally would do that but missed this part of the
contribution standard. If so, I will create v2 accordingly.

> 
> > diff --git a/strbuf.h b/strbuf.h
> > index 7062eb6410..223ee2094a 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -473,7 +473,6 @@ int strbuf_readlink(struct strbuf *sb, const char
> *path, size_t hint);
> >   * NUL bytes.
> >   */
> >  ssize_t strbuf_write(struct strbuf *sb, FILE *stream); -ssize_t
> > strbuf_write_fd(struct strbuf *sb, int fd);
> >
> >  /**
> >   * Read a line from a FILE *, overwriting the existing contents of

