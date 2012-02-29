From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] grep: use static trans-case table
Date: Wed, 29 Feb 2012 00:51:11 -0800
Message-ID: <7v399uuio0.fsf@alter.siamese.dyndns.org>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-2-git-send-email-gitster@pobox.com>
 <20120229082814.GB14181@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:51:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fFn-00036M-RG
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab2B2IvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 03:51:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab2B2IvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:51:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC854ACE;
	Wed, 29 Feb 2012 03:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ef3ccLNY5WKy09zGsDz81L2MUJc=; b=AQ5O+9
	5DY2vk6vTKGFiwUJbLPZOpjfYSA48MF+Ewcxe+rSlEl26+iBpJJ/RTeneKdZx2KW
	K1/nFmUmpDOAkeFLDmAxb6oLCKcpvZ9zrw0q2ZOHA3HJDp2HkBN/13NauXqzHg/K
	2KhIbPstGXVDeIVzH4IAnpRVAp+3Ea8agRUZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eoSDpEhkY4Wyxnb8Igpqzs5p0mZKvTch
	b+hkjjaFjG8VBpVek4cMMHWcJCoKspk7qYIlZ0bzg+Pf7cucStfvZgsJHyVE60VU
	Qnxokb1keLbDRTs29yjxzQKhBbsbvaRPnN7Tv7gJo0YX3qOrThz2i3gIX3HVk2+c
	rpuTs5r2Z8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04B9D4ACD;
	Wed, 29 Feb 2012 03:51:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D8404ACC; Wed, 29 Feb 2012
 03:51:13 -0500 (EST)
In-Reply-To: <20120229082814.GB14181@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Feb 2012 03:28:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88AD6706-62B2-11E1-AA2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191822>

Jeff King <peff@peff.net> writes:

> So I don't think your patch is making the problem any worse. And even if
> somebody wants to tackle the problem later, the solution would look so
> unlike the original code that your change is not hurting their effort.

Yes.
