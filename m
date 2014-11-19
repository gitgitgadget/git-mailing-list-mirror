From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 21:52:49 +0100
Message-ID: <1588976.dNB1P7S71u@al>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net> <xmqq61ebrl1g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCFG-0006AW-UI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbaKSUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:52:55 -0500
Received: from lekensteyn.nl ([178.21.112.251]:60135 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbaKSUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=osM33CHpW7lAEDiKxU3SL5rU1myO9dMYTJ/zDXmhg1M=;
	b=pXZFgFMKoXBiA8QaFO23XbMHKSGV7NpwzO9wcAFPNMQPaFdaNsqRLH2Ubu92r/RkH3RKdxL7C5sZpKkBYgJvoYlbewqdYqQylXhi+Y4A6l2jgCLzpzN0/eTFiF8nC6gJsidwfPN4FrFT0PMxnmr25+wS3MrauLMlNzRbZRsC40VV2CuqTta7JsA3BJzw3s3IusR5cKFqOREIM53PDZrRQJX62eMWisfnqwJoebyFZ0zqtvVLCBhAqHFOB94q9rrk4+LMFJTfzLQVdDZpDZteLSnJad29jmtLlIshseOF0/2kVzePNXmcwlvKwI/I46qf1Kr13IueEXnp0UeABxU2aA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XrCF8-0008N9-1v; Wed, 19 Nov 2014 21:52:50 +0100
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.2; x86_64; ; )
In-Reply-To: <xmqq61ebrl1g.fsf@gitster.dls.corp.google.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 19 November 2014 12:29:47 Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I dunno. I guess that is more convenient, but it seems like a lot of
> > code for a very marginal use case. But more importantly, I'm a little
> > worried that the presence of --fetch creates confusion about what
> > set-url without a --fetch or --push does. That is, it implies to me
> > that:
> >
> >   git remote add gh old-url
> >   git remote set-url gh --push push-url
> >   git remote set-url gh new-url
> >
> > would replace both the "url" _and_ "pushurl" values in the third step,
> > since we did not specify --fetch.  But it is in fact identical whether
> > you run it with "--fetch" or not.  That is, it creates a weirdly
> > non-orthogonal interface.
> 
> Yes, the semantics the updated code gives feel very strange.  I
> wouldn't be able to write a three-line summary in the release notes
> to advertise what good this new feature brings to users myself.

What about:

    "git remote set-url" learned a new "--fetch" option which can be
    used to change the fetch URL while leaving the push URL intact.
    Useful to keep a ssh URL for push and change the fetch URL to https.

which is effectively the functionality I am using it for.
-- 
Kind regards,
Peter
https://lekensteyn.nl
