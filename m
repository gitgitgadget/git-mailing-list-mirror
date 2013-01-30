From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 23:17:41 -0800
Message-ID: <7vk3qvm962.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:18:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Rvu-0006PB-HG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab3A3HRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:17:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab3A3HRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:17:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5941B8CE6;
	Wed, 30 Jan 2013 02:17:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMEToWH+2QI9m9i81W4dp/DnVkk=; b=KwE2OX
	GBMoe8P0XuCXKohWpu34NvpzpPPMZKGZ5DZX3FCxUyH9o6K8IzDbSfnhkeMjZAWb
	4JawytOOe0tLDcpCgal+GNX1CGoX8Vj2DkIyhuymLI4qIqLmIYiO3FkfUzDy1jU/
	+YygoSzWxOhcuC11y0GtdlpZBIpvTyJHYLrCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sn3UPZGERldSSIi6peP2OZ+8c0iqBBRJ
	SKAgB9gZjU1En9fywKNwK4c/fhFdt97cvvahJ9jl/2XeyzGjiL+oRWxmlaAjCrrd
	53dTSQawTmf8XeiG70GVhwGYQnE7C29aqAjIq/ofRH7TnSiqCYF+9EXFKi0OwHHN
	2Cv7AYC3+r0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B1388CE5;
	Wed, 30 Jan 2013 02:17:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE6C38CE2; Wed, 30 Jan 2013
 02:17:43 -0500 (EST)
In-Reply-To: <20130130071209.GD11147@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Jan 2013 02:12:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23D993FA-6AAD-11E2-A1B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215001>

> True, but it is even less headache if the file is totally separate and
> optional.

Once you start thinking about using an offset to some list of SHA-1,
perhaps?  A section inside the same file can never go out of sync.
Also a longer-term advantage is that you can teach index-pack to do
this.
