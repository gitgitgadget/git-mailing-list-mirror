From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict
 resolution
Date: Mon, 11 Jul 2011 14:31:43 -0700
Message-ID: <7v62n8bj28.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com>
 <7vbox0cz1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgO52-0000bV-P3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab1GKVbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:31:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1GKVbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:31:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01B736B15;
	Mon, 11 Jul 2011 17:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d2RJJwGvyakdYvRwXCJZ8CRO5fE=; b=bwywH9
	bdugcT0HIkM4RpFHFxca1OfjKga7KCiRWHzBCK4+aIBisagniKAM+fqC55ylje3H
	OewF/xF0fOCKjU05yhgKogqHhD2+k6PJIlV6AFE8kVo0qifapWXIrfPtO4GNSgpH
	oQqHqXx28Ei9NcVO74wpXGX6L5fr1vahVA2kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rb9OycxpSnPhei5o0riSsl1XaLEVuYdw
	YmDk4IlYc0reijJlb3tUuKZA9shysM85d4HYaxAnR2VF0Sn+cd2lRKrox+jAKoqr
	S6AKPCoKh8ItoudTvE1RhHL1oIygAFtnQm9m+xJJCHrPzaMsdNdS6idiX2ZgqV0W
	mDUMZtsYNAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE7A16B14;
	Mon, 11 Jul 2011 17:31:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5DEF06B13; Mon, 11 Jul 2011
 17:31:45 -0400 (EDT)
In-Reply-To: <7vbox0cz1j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jul 2011 14:01:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D2E5A8E-AC05-11E0-B7F6-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176901>

Junio C Hamano <gitster@pobox.com> writes:

>          * next starts by pointing at the variable that holds the head of
>          * the list when the for an empty commit_list, and is updated to

s/when the//; sorry for the edit-o.
