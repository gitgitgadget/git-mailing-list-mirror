Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5AB203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571AbcGZMbU (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:31:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:63217 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756507AbcGZMbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:31:17 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LyEJp-1bDXe11tH3-015Y0O; Tue, 26 Jul 2016 14:31:04
 +0200
Date:	Tue, 26 Jul 2016 14:30:55 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 11/16] am -3: use merge_recursive() directly again
In-Reply-To: <xmqqy44p2wds.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607261426340.14111@virtualbox>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de> <667d2f991f1423b138a746f4c685b13c5b572a83.1469187653.git.johannes.schindelin@gmx.de> <xmqqy44p2wds.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q8+cQjR5nRtH2OtlwzHsWgqPRVhXOSKayj6MygroFaUmgmo7K7A
 k56Shhm2fHNlFKvDqp+XKNbGwZfH6jcaM0afIFt7CUq26WxHEdKSbVw52h5t3f2l4adb++u
 CAl/7liRc77X0EzhqO9s2BF9TMx+I+S9HK53KDXLbDIMe31CkNRw2/4A03Hjsu3FuNJUCfd
 Hwb2Wxvn06bMpHCwq2Axw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:5HK9AABey2g=:9R+JP0+cE/CINCD5eTi3LD
 4F9cwebKKgoSjDbzStqagXd90ERMOvprQlaARxh6MFOxQPgxvAookGfQSyut11mX79kWRWilD
 +BR85Y37U5whSMAmo6Cu5a1pF0oPtkn96LzZPmF0Pl1NWBqmChnFVxKQgWk3Hp7Wyv5EO4bXs
 BpewsuU4YR/0TD1HvDEiGSpGQk9mvknELhIdMkDx54Y33uM+tRZAWgTpOcKj+MsBiJ9T9cKNg
 9OZ6A+xHX4dltfjTdOLhtzimjNDKFhKUr7Thc97ONRNSD2wrydmFsKQUTg0NBFpmiMTitqG6J
 SSNLUMZSeqS6YYgC+Ji/+qhECC7amvK4zgUoLqAxR5CHYB0wPWAtiryeMPrh2NHs+Fhuhj2V8
 neAjMG0USKMTGonz446qEK/b67GUmLxoaZt1H83OqtivbZ6LlUE5nV2/4Pq20y8NpETnHmLva
 xHGlRC+XduRj9T0/c4hPHReXLF+ARbVh4dQBN1NfDxKCV+M6/pf7UXofWRS0J1Oeo0exhlnUd
 icEPG2d8+hOaI1aJiBqZYyHplRdf82gvu1f+XrXOiADEX46ASomKhdz6vKHulrRYlINvYsisG
 5eu87Rz60mNBR5Zj5DHW+X5uCa6oIqY+jzKp0fJ+Pb5hl+PDoE67FJ2aOH74zKHxPA4js4Wfk
 y3+VWB4PhbZbr1FZlMj/3VqmGG3TfeT6WNyRk3N5bHqzQMff7zfPe2FpZf165yB80HgKrDfhH
 WUhkysVQ1v0LbLJISja8/4ugJU8LhYBgBugb7/BrPoq0UwnDpyMePjKtLXi6r6Mn+uB4boPKF
 rRTcEaS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 25 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Note: the code now calls merge_recursive_generic() again. Unlike
> > merge_trees() and merge_recursive(), this function returns 0 upon success,
> > as most of Git's functions. Therefore, the error value -1 naturally is
> > handled correctly, and we do not have to take care of it specifically.
> 
> I've finished reading through up to this point and I'd stop for
> now.

If you want, I can break out the subsequent patches into a separate
series. I just thought that you might want to have them here, as I
implemented them in response to the concern you raised in a previous
iteration of the same patch series: you pointed out that returning a
negative error value still does not let the caller handle the error
message, and with the subsequent patches that is now possible, too.

> Some of the patches I didn't look beyond the context presented in
> the patches, so it is very possible that I missed leaks caused by
> early returns and things like that, but I didn't see anything
> glaringly wrong.  Looks very promising.

Thanks.

I did try my best to catch all resource leaks, but I did stare at those
patches so often and so long that it is easy for some obvious bug to have
slipped by. Therefore, I would appreciate it if you (or somebody as
diligent as you) could have a careful look in particular at the
"merge-recursive: switch to returning errors instead of dying" patch.

I may have missed something as stupid as an unclosed file handle, after
all.

Thank you,
Dscho
