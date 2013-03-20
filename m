From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 12:52:30 -0700
Message-ID: <7v38vpetmp.fsf@alter.siamese.dyndns.org>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com>
 <20130320182830.GJ3655@google.com>
 <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
 <20130320184157.GO3655@google.com>
 <20130320185844.GB30165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:53:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIP4N-000473-JB
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab3CTTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:52:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757969Ab3CTTwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:52:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29AA7AF96;
	Wed, 20 Mar 2013 15:52:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+T/mG/8O77mjczrNJjE0fjKWxg=; b=kRHpAn
	ke3YfCV96yDWpNDxZQk5z0pI19byr6ZVQQeVuXa5gi9GqgRhJisVcdGAQ+qYY9ks
	GF8YdzAfFDhqixtRjM/E0L5GEze+4PkrNZZBZ8axHCREfm+eFt8/sX/7gXqh2EoU
	m0NrlcM9mqwRy6OqqQtROhGsJtT5QSB7xEgUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ewhAuPODkLNQ3MCZaYOJrcO93DkGJ8tG
	J4A3Ma/fiYAn0lL5jV+UbF5tMZWYFNLzzdS5BU2Am2667GTr4yWStlXOgQuIQHnB
	5JbVSegcsAU/Eue98qRh/D7r7pL89G0xY8DSaXryPjCSA8reVCOcYAnHFdeHk/wK
	CYPOVYYCrZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DDE6AF95;
	Wed, 20 Mar 2013 15:52:32 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9251EAF92; Wed, 20 Mar 2013
 15:52:31 -0400 (EDT)
In-Reply-To: <20130320185844.GB30165@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 14:58:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3BC7404-9197-11E2-8E0D-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218669>

Jeff King <peff@peff.net> writes:

> ... even though it is more typing, I would argue that:
>
>   mk_empty testrepo &&
>   git push testrepo ...
>
> is better, because the test script is more readable as a unit.
>
> None of this is that huge a deal to me (and yet I seem to have written a
> page about it :) ), but I figure while we are bikeshedding about test
> style...

;-)  But the above is a good point.
