From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 23 May 2011 16:02:58 -0700
Message-ID: <7vk4dht3z1.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 01:03:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOe9d-00048V-E0
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab1EWXDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:03:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1EWXDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:03:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0866F4AA0;
	Mon, 23 May 2011 19:05:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xIqk0FQYxlzUl9b8sNvKc/ZYhHg=; b=D1GT2qWDkTmL7cbQAlZb
	IeIAdl4XYyY0Uuq8p3oLGXKa6Y1KWC60hWxFC703Jm1RGAtzWPfUZvBXQkbmZQfP
	jp1bqkRpe+50z8NzjEuaMK1GJlg60LUkkla0v8FbFPZJO7tS6geXf2XSEsYkHC8R
	qLmZ46szVOJ2n68xxjMT74g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pcxHW3z3jrBT5h2tAsLoCifW3lt77G99fNq/aYTkOtl4yi
	EIbVUwWDiGD1jTk5rSQXA+0p20vGT/naChZpE12cvIbB2jYV5ovTYo8XXbTyJ88z
	T6xO5XZtPuCQxMQj1d+LuDEwXOWTtOdanDrsF4TU91LZe2CrwflSX+Z4WD1Ow=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8DEA4A9F;
	Mon, 23 May 2011 19:05:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 730B94A9B; Mon, 23 May 2011
 19:05:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DBC42B8-8591-11E0-A41F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174287>

Jeff King <peff@peff.net> writes:

> The big question here is what we want the output to look like. I chose
> this:
>
>   diff --combined foo
>   index 7ea6ded,6197570..9563691
>   Binary files differ
>
> which contains all of the information we have: for file "foo" there were
> two parents (at 7ea6ded and 6197570 respectively), and the resolution
> was 9563691.

Yeah, I think the above is sane and matches more-or-less the conclusion of
the previous discussion Michael quoted.

I've only read up to this patch (I wanted to conclude the first round of
today's integration round before 17:00 local) and they all looked good;
will queue the whole thing to 'pu' in the meantime.
