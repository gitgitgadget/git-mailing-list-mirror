From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Wed, 29 Jun 2011 14:36:16 -0700
Message-ID: <7vtyb8s4kv.fsf@alter.siamese.dyndns.org>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
 <20110628224516.GB4192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc2R4-0002Ft-0D
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 23:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106Ab1F2VgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 17:36:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1F2VgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 17:36:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B13B46F53;
	Wed, 29 Jun 2011 17:38:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qjuyT1gbJ3hDMx4lA7yNe6M+as=; b=ucWxk7
	osYXQWUVhYLO0T3+G1LKaPUAh4mmwkDdKhhPuxKVzZa9DYd/lqKkrLrhD68A8FUl
	+SeTWWcoankSSbdLBipv2pSrkWKPe9R0EgXzlVQiBOPiespreGnDGf09ysdt6eZH
	6PBhRcWpU6CTJFFUAoBI8mzobvv6KsD3QziuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LzQchWy8siCm6cQFXYvoYDd72y1N0pwh
	gGl16bpV03C5kWPFqtcsX4CkJ5FGSUPtDNU+O3dG3ICwPCLFHZkY5jS3LYj4CSgg
	IeDWooTvdihDkconBTCwcBkdl31EGxv8BaO6xZJC/38KD0lm7ClkEG2/WwGvjjZV
	CoFnj7JqqZU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA4646F52;
	Wed, 29 Jun 2011 17:38:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 132686F50; Wed, 29 Jun 2011
 17:38:32 -0400 (EDT)
In-Reply-To: <20110628224516.GB4192@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 28 Jun 2011 18:45:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 233A6246-A298-11E0-957F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176459>

Jeff King <peff@peff.net> writes:

> I'm willing to accept that there are use cases where you don't want the
> CRs, but just want a list of lines[1]. But it seems like this change
> hurts some existing use cases.
>
> -Peff
>
> [1] Actually, I would be curious to see such a use case. If you are
> planning on saving the output, is it really useful to have a hundred
> lines saying:
>
>   Compressing objects 1% (100/10000)
>   Compressing objects 2% (200/10000)
>
> and so forth?

All valid arguments against the change, I think.  Thanks.
