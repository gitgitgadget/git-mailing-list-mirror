From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH jn/merge-renormalize] merge-recursive: expose merge
 options for builtin merge
Date: Tue, 24 Aug 2010 11:52:53 -0700
Message-ID: <7vk4nfvo56.fsf@alter.siamese.dyndns.org>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino> <20100824033922.GA19628@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 20:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnycZ-0003EN-3B
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 20:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab0HXSxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 14:53:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0HXSxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 14:53:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78262D0972;
	Tue, 24 Aug 2010 14:53:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IkLkU88TDLZ0nxTmZBdF+SjcerM=; b=MHCbW/
	c53MXKdeKQJVuxdYICT8Lc32nOVqnk/dTq5yb8/1SFFPH/xWN+IQHP6OgDIfb4yj
	IZhiGcdiXVmVDyzmgSxsnO8h4lMvCrHUgaN7Vjx4nYczIT8XbipcoHGI0WkOi6Po
	GYZC6Nx9HJYZJFOnHmvKPh0JQTd67wEogo098=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KfsiZCFAYfskvtIjuYjPrRWJ3depS79w
	uDZ/qH6Q8+0fZ/qp9GGuGLR9thtaDVr4Ee65RBWVswIv3s9rd8qjbfSqXXcIRiaz
	QirbWJFzGDbPJBO4a1t6v/EdPdY8Mdo/ih7RDaY3t4qRnMuaLbXf9P+y2u8b8Zwk
	4sM/s9qsbGw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08099D096F;
	Tue, 24 Aug 2010 14:53:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F33B3D0969; Tue, 24 Aug
 2010 14:52:54 -0400 (EDT)
In-Reply-To: <20100824033922.GA19628@burratino> (Jonathan Nieder's message of
 "Mon\, 23 Aug 2010 22\:39\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2323872-AFB0-11DF-846C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154332>

Jonathan Nieder <jrnieder@gmail.com> writes:

> There are two very similar blocks of code that recognize options for
> the "recursive" merge strategy.  Unify them.
>
> No functional change intended.

It makes sense, but I wonder why you chose to do "if (fun() <= 0) error"
instead of usual "if (fun() < 0) error"...
