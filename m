From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git --reference bug(?)
Date: Tue, 18 Oct 2011 23:25:08 -0700
Message-ID: <7vipnlebwb.fsf@alter.siamese.dyndns.org>
References: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
 <4E9E59A7.7070307@alum.mit.edu> <7vpqhtec2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andrea Gelmini <andrea.gelmini@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPaY-0007Y0-Ij
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab1JSGZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:25:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab1JSGZL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:25:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2F12DF1;
	Wed, 19 Oct 2011 02:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUg7IIa+gHY5LXzg1kF25XoDGI0=; b=GWgJZ+
	8LMQBGy2EjsLswPrGJeyZUBH/SUDSC6eFyygE1c73/FesdSeapWYaCAiW175Jl0R
	d8TC4mXV6WKYnGjA9DpkeeESG2mLAlm90XHmyeOEfH99uptEZMRtY/d5Ls0HdHqs
	/6Q4axZPckHlHEBEL/b1leONx3Wl0oI/kvbVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tmDmE6CgC/LhyVo08543voYg9xNPgiAT
	yBIQp2OkHRurUpRI2gRpxJ3CLupcn1TrPoPBniyh0kVhx7G4RElNjD6KbgUToupT
	fulqxxVIpr4pQUO+5y6YZjcHzSt8hes5FyKabiAu65j+ZmHJ/eepbE4HOFeF/iJ7
	kvCoQzx27V4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C1892DF0;
	Wed, 19 Oct 2011 02:25:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1691E2DEF; Wed, 19 Oct 2011
 02:25:09 -0400 (EDT)
In-Reply-To: <7vpqhtec2n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 23:21:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 185ED246-FA1B-11E0-A735-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183919>

Junio C Hamano <gitster@pobox.com> writes:

>> 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a	refs/tags/v2.6.12-rc3
>> a2755a80f40e5794ddc20e00f781af9d6320fafb	refs/tags/v2.6.12-rc3^{}
>> [...]
>>
>> I've never seen this format before; is this the remote protocol for
>> peeled refs or maybe the behavior of an old version of git?
>
> This should be very well documented and has been the output from fairly
> early days of ls-remote.

I take the first half back. The ls-remote documentation seems to have
bit-rotten quite a bit.

IIRC, we started doing this when we introduced auto-following of the tag
objects. Even update-server-info knows about it so it way predates smart
HTTP and is a fairly old and established behaviour.
