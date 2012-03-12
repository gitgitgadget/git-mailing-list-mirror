From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 14:52:57 -0700
Message-ID: <7v7gyppjuu.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org>
 <7vd38hr22e.fsf@alter.siamese.dyndns.org> <4F5E68C5.5070300@lyx.org>
 <m34nttzeex.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:53:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7DB5-0006kp-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab2CLVxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:53:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757533Ab2CLVxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:53:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FAD2602D;
	Mon, 12 Mar 2012 17:52:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U9TdWSPtH9lYBXZ/T7zIg26qO34=; b=alXW5E
	KGYn/B/R3RJa3r8Qg9Rl2HF25Y9203kVLGaC9BavAdqD8+SHXMVsri8FD52xGBXS
	SRyCq4BKPAyWKumQUV/liwpToBbAvrwZXWWkGYW+TfDescfTbPwLgwis+Lewml3i
	bQMPxeawxiNmcL+3CkjMLOTaexcL4QzxQt/J0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOksLmr3TAj++HdMg6qYllU6TfiZoSkJ
	14Zcenld+Czfbvb04eZHNxSARPVme8XHJoMlscS6PJtrpA7jozUZDiTKXHwTbsIz
	PdMgjvlwth6CPAeUjRgqlCxFRhrOmI/qdJuzvfQkE6dW2dgh+T1kBwZ17BbWaULv
	JmQUc+KJpKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87A94602C;
	Mon, 12 Mar 2012 17:52:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B3BA602B; Mon, 12 Mar 2012
 17:52:59 -0400 (EDT)
In-Reply-To: <m34nttzeex.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 12 Mar 2012 14:40:43 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB96AE86-6C8D-11E1-A1D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192957>

Jakub Narebski <jnareb@gmail.com> writes:

> You can also use custom merge strategies, but that is probably
> overkill, and I am not sure that it would work (adding new strategy)
> without modifying git.

Merge strategies are primarily for people who want to customize the
way how the final shape of the resulting tree is determined.  Even
if you go that route, you would need to write and use your own merge
driver anyway in order to tweak the way how the file-level three-way
merge is performed.

So it is not just an overkill, but it is entirely pointless, as it
buys nothing to use a custom merge strategy in this case.
