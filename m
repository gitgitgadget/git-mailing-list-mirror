From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] strbuf: make sure buffer is zero-terminated
Date: Mon, 11 Apr 2011 14:49:26 -0700
Message-ID: <7v8vvgtq55.fsf@alter.siamese.dyndns.org>
References: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
 <20110410205711.GA2069@sigill.intra.peff.net>
 <BANLkTinKzatY-1kxLJ73TeDyMW175pr77A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, jwa@urbancode.com,
	drew.northup@maine.edu
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 11 23:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OzS-0005Cn-EZ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab1DKVtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:49:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1DKVtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:49:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E79914D99;
	Mon, 11 Apr 2011 17:51:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2Pbfrm/xpu4ArZIxfOGzs6soPeE=; b=YL4izOGBuCOL3/q2Ja8y
	pm5snPJOzJxVOxYiUpR4IMo/LvSTUQ1Sa36EftQhAFf+gWO7JSjsh0uRMEXE4sum
	928BkyKtp9j6bZJmJL4/1TVcBhNhko+/LmQpH9R4k33TPXB9yTgIt7AM1cmmZAWm
	ndcQ6g67xLiZdtWNcEPB2iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mLRDXjrirjhokshNTiQUwk0gRfPEGT9NRTDfJjoxw2+VVg
	MReznrV3g6j2jm18rE6MUw5UZ+WyoPR88YkdpIPkWM7e4HXzRbZlYLsY8tTXF/9c
	TyijTsKO/tX76yqJgbXxX0j23vx7idw3k8vTLoprp3a39VJ5dNzT99gRSbAao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92EE94D97;
	Mon, 11 Apr 2011 17:51:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E64B64D96; Mon, 11 Apr 2011
 17:51:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD2370E0-6485-11E0-8DF9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171363>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> You're right. How about something like this instead?
>
> strbuf_init does not zero-terminate the initial buffer when hint is
> non-zero. Fix this so we can rely on the string to be zero-terminated
> even if we haven't filled it with anything yet.

Sounds sensible.  Thanks, both.
