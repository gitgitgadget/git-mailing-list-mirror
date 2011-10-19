From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/12] do_for_each_ref_in_arrays(): new function
Date: Wed, 19 Oct 2011 15:39:58 -0700
Message-ID: <7vfwiobo75.fsf@alter.siamese.dyndns.org>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
 <1319060692-27216-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 20 00:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGeo0-0005Db-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 00:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1JSWkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 18:40:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1JSWkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 18:40:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFCBD6D54;
	Wed, 19 Oct 2011 18:40:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oADy9EY8SI42mBlpVl0bCtYw2LA=; b=eLCK15
	UyQoFI72VbEWb5bus5WD4aR0cYJ+KATxWadf6+bTnTjwoAkrubluzmYXwsWNh0HS
	t9mXM1eoAt1kVkina7gcUjaqsIXnAIVQsXdovGKXAN4/Q1I0iQiQUmwMYmFTExaA
	r5CT/NwRS6DUOusXCOI1p4iOFsfGNxU+IptD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s61zSD4EcAPIs36wo2CzrAI/Wf9fJ178
	/8Pe69juo7dkgsuJguxazXAiFdOS8GyvJCP/QDpXaMPkh8/0h5JLhBV58wV1QeEq
	YUIX+gEpZ0wZJ75dMurn7oCyDK+z/zMdgSHdr7sBrClCw3E0AHZWNb3iv8Skw0pi
	RCcWf2wb6Ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56826D53;
	Wed, 19 Oct 2011 18:40:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DBC06D51; Wed, 19 Oct 2011
 18:40:00 -0400 (EDT)
In-Reply-To: <1319060692-27216-9-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 19 Oct 2011 23:44:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 473945B4-FAA3-11E0-8FBA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183988>

Is this necessary?  IOW, is the helper function usable in any context
other than merge-iterate loose and packed refs?
