From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Thu, 24 Mar 2011 01:12:55 -0700
Message-ID: <7vsjud9bso.fsf@alter.siamese.dyndns.org>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <1300894353-19386-1-git-send-email-pclouds@gmail.com> <7vvcz9emrn.fsf@alter.siamese.dyndns.org> <4D8AEF9B.9050001@drmicha.warpmail.net> <AANLkTinjdi3+qcQxcBYj8SdQgbZYP=KiLwxM3Vq0c1Er@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 09:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2ffR-0003W5-2n
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 09:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933665Ab1CXINK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 04:13:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933659Ab1CXINH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 04:13:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1B243F5D;
	Thu, 24 Mar 2011 04:14:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+RdQOEzt4C41x7bdorvOKsvYLuA=; b=DrjX7w
	4rOpx94mKDe71O0WwYJQ11ORONpBnW1++HhPzOSO8p4kqQx+ljiiae5x1UCDUrST
	zk/Y0B7x54qEWrHC+f6DQa8Esit+XhSOmmBARUzTPXIMVpZCviELbjmyPPjG2nbK
	dq683LzYmPbaIYlpGkYk+Cc8u2i/bF/FD3byE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMOuEVsGIk2viTKq644FqxcdcMyEEQn6
	ZbU3tA7XG0MmVpohThZI/nsZRlTY+RMbBTCO0W4mUfaqPECEW+8fxA81xEfVFC8Q
	OMmA6XjuC/etNCoWTrp4yNk7gRIR/8D9DttZuMtT27LGYISVa5UvuqTO/Usunwmm
	XaWTo4nyLBo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B168F3F5C;
	Thu, 24 Mar 2011 04:14:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9730C3F5B; Thu, 24 Mar 2011
 04:14:38 -0400 (EDT)
In-Reply-To: <AANLkTinjdi3+qcQxcBYj8SdQgbZYP=KiLwxM3Vq0c1Er@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu, 24 Mar 2011 14:49:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5938BC2-55EE-11E0-952E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169905>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> And maybe:
>
>     . ':' to reach the superproject if user's inside a subproject. So
> '::/foo' means foo at superproject while ':/foo' means foo in the
> current project, both at root.

A magic with that meaning may be fine (or may be not---I don't care too
much about "because we could" at this point), but if you are going to use
':' as the magic introducer, you cannot use ':' as one of the magic
signatures, as it would make it ambiguous when you said '::'.  Did you
write a long-form with 0 spelled-out magic (perhaps to defeat some other
future settings like --option or config)?  Or did you mean that magic
signature?
