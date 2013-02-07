From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Preventing merges from one branch into others
Date: Thu, 07 Feb 2013 11:38:51 -0800
Message-ID: <7v8v6z7w38.fsf@alter.siamese.dyndns.org>
References: <20130207131440.716c1022@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:39:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3XJV-0007MT-5n
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223Ab3BGTiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:38:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145Ab3BGTiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:38:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B15C7D543;
	Thu,  7 Feb 2013 14:38:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dA6g8GmmjSGuuaa+G3HjAxRtVM8=; b=E8yQ1/
	+4cayW+qbOclSz1PXWHP7y0mVA3B9jHUe+hDMd/F7yubc20qSHLQMZ2AryxSTFMz
	3SgXrOWivpUzfRoau17Gn01FB2PDPlVSgK4gvqFxR2LWaeuC6FFsIB5JMibzH/D7
	iBE4AT9JzDE2+Yng0y+BkRyd4Nu956ekt2kwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YYj+4VKLEoMVI60p5om6GQUxe5YNci7M
	J7JQKxc2VeaPdMAm9wCplcEZIoQuN7iL+oWb3HiMyV8Owvn1qiBknHiwdgzFU4A3
	tAfVonSwVqYMD7cqNSdZ8tETYc/FFKorIAEcouEn2Km7vQc653GZy0zwFTbvbUy2
	g6h94K1IOXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A489CD542;
	Thu,  7 Feb 2013 14:38:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 232D3D541; Thu,  7 Feb 2013
 14:38:53 -0500 (EST)
In-Reply-To: <20130207131440.716c1022@bigbox.christie.dr> (Tim Chase's
 message of "Thu, 7 Feb 2013 13:14:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00F5E6A6-715E-11E2-8B07-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215718>

Tim Chase <git@tim.thechases.com> writes:

> ...  I didn't
> see any sort of "pre-merge" hook script.

http://thread.gmane.org/gmane.comp.version-control.git/94111/focus=71069

I think yours is a canonical example of "I do not want to run
command X when these conditions hold", when "these conditions" can
be checked locally _before_ you decide to do X.

While it is theoretically possible to give X a pre-X hook in such a
case, we do not want it to be the first choice to avoid hook bloat.
