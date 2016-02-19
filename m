From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 09:38:17 -0800
Message-ID: <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
References: <20160207162540.GK29880@serenity.lan>
	<20160219115928.GA10204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:38:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWp0l-0000Et-TV
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947700AbcBSRiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:38:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030364AbcBSRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:38:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21A144378E;
	Fri, 19 Feb 2016 12:38:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RIiQQyV377nN0cqIxZHeY21u/aw=; b=J+SDXA
	ZnkLnGUhAnKDV+8REJILHZhqE56sCMJ9T8at/PWL1e/BEeT4PtO+gFfMFUC7gx9Y
	bBO02JQghKYpPLCGHB97LRmT+Dhktlib5FCSyksBa/GKJO0O7TgYTdTXpMEr5Xdv
	/NBqhwQWi4ibHgeSvCZmSCHTris/G4nyIDvb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KvuGo8zqSTm0LBCM3Wanw9YeUuVRJHbo
	KjQWNFN4bPiIzAJboQUSUx3UZ6oElSbiue0dPg+OYt9G5Z/abbRo9GJ2N++lW8AG
	dQQK5GjS1VcMlFd9Sw22pJHl5uS2QGR/4ELG4OoYJap1sHkBYBYvxt/OYq6k2p42
	savLE9jyeLE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19F984378D;
	Fri, 19 Feb 2016 12:38:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BB9143789;
	Fri, 19 Feb 2016 12:38:18 -0500 (EST)
In-Reply-To: <20160219115928.GA10204@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 19 Feb 2016 06:59:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 901BF0C0-D72F-11E5-9C1C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286723>

Jeff King <peff@peff.net> writes:

> Yeah, I'd worry that "-a" is not portable. OTOH, BSD grep seems to have
> it, so between that and GNU, I think most systems are covered. We could
> do:
>
>   test_lazy_prereq GREP_A '
> 	echo foo | grep -a foo
>   '
>
> and mark these tests with it. I'd also be happy to skip that step and
> just do it if and when somebody actually complains about a system
> without it (I wouldn't be surprised if most people on antique systems
> end up installing GNU grep anyway).
>
> Another option might be using "sed -ne '/^author/p'" or similar. But
> that may very well just be trading one portability problem for another.

Would $PERL help, I wonder?
