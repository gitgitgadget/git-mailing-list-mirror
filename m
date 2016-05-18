From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 13:00:41 -0700
Message-ID: <xmqq37pfrv9y.fsf@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 22:00:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37eE-0005CU-7n
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcERUAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:00:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752101AbcERUAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:00:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8ED1DFE4;
	Wed, 18 May 2016 16:00:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXTI5uc1cJ22T89qHC55SCAz2q4=; b=mKfjoA
	RigWv2Wm7ccIvqZ+oCMhLbfrz7X6Mkmw2n8WO4QZ7mYNNtO/at7F2aS2Aw6JYVzP
	uY80nyqX/BvL6YRCRjcdWNBe8AopsO0+xFheMzhycTKuLI5yxeqvu5WK/GF1SFuB
	Gx7fTssUe3rsD5q39JrJCTUZmJcuDFe8eLvuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K02ErjeLDtMtcglrW1NztWGxRzAZHc7K
	DXhuZrW0AUnQUNGahhfa02D21L+7zaO0xnwvdvQw84L+SrR/jhQ97i2SJWFKeCfM
	viHfN9zbbSTKoZv5cZ7PFcXEC5YZJPIjqlvd/4ncpcc35GzVlV1CKzhm48a4I4Yg
	waocbJOmiwU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B691DFE3;
	Wed, 18 May 2016 16:00:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11BC61DFE2;
	Wed, 18 May 2016 16:00:43 -0400 (EDT)
In-Reply-To: <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 May 2016 12:47:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33CACD1A-1D33-11E6-A3B9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294998>

Junio C Hamano <gitster@pobox.com> writes:

Just this part:

> The last part "set, unset or value matches" does not make sense,
> though.

I re-read the line and I think you meant

    ?VAR makes a path match if VAR attribute is set, set to false,
    or set to value for the path

and I shouldn't have read it as a 3-tuple ("set", "unset", "value matches"),
but as a 3-tuple ("set", "unset", "value").  That is,

    A path (whose attribute state is one of these three) matches.

So I retract "does not make sense"; it still is "hard to grok", though.
