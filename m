Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DD41F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965062AbeALTxB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 12 Jan 2018 14:53:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45890 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754584AbeALTw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:52:59 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0CJquH8016435
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Jan 2018 14:52:56 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Lars Schneider'" <larsxschneider@gmail.com>
References: <20180112163644.14108-1-randall.s.becker@rogers.com> <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH] Fixed pervasive enumeration warning in convert.h.
Date:   Fri, 12 Jan 2018 14:52:50 -0500
Message-ID: <004c01d38bde$f0e6bb50$d2b431f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIaHxLWcrG4akzpY1ZwYOznE60qXALrzaZXoswgLzA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
On January 12, 2018 2:25 PM, Junio C Hamano wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >  {
> > -	return convert_to_git(istate, path, NULL, 0, NULL, 0);
> > +	return convert_to_git(istate, path, NULL, 0, NULL,
> SAFE_CRLF_FALSE);
> >  }
> 
> I think this is being solved a bit differently with a1fbf854
> ("convert_to_git(): safe_crlf/checksafe becomes int conv_flags", 2018-01-
> 06), and 0 becomes the right value to pass at this caller to say "I am passing
> none of the flag bit".
> 
> I am hoping that the series that ends at f3b11d54 ("convert: add support for
> 'checkout-encoding' attribute", 2018-01-06) will be rerolled and hit 'master'
> early in the next cycle.

Got it. Will revert this one on my end. On a related too many warnings subject, hashmap.h has a variable unused (void *item). Is that addressed soon? If not, I can deal with it.

Cheers,
Randall
(also, sorry about the other email address in use. It's the only way I can use send-email, fixing the annoying prior wrapping/tab/space garbage I had).

