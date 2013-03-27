From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/15] t7502: remove clear_config
Date: Wed, 27 Mar 2013 08:04:38 -0700
Message-ID: <7vtxnwq3y1.fsf@alter.siamese.dyndns.org>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
 <cover.1364158574.git.ydroneaud@opteya.com>
 <25d62be2c030306929dd11f92a7ac4be8b227ea1.1364158574.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:05:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKruX-0005km-PE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab3C0PEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:04:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3C0PEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:04:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F26EBAB91;
	Wed, 27 Mar 2013 11:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=62thlQxfJuZlidVsiPjU6VcGyes=; b=LiOsrwC8mYOKgSclhYC7
	Y01ceUo4SnWjJqU2Jh8PMkLfKjLBSjPWCZGjFikuwnRXSxns4pKcOz4g1MCA23KJ
	PGmr8VPHT2qefew1mLxI4CjzPg2YHl1SsPTVeyj1a2nBXB9oSo1U/a59cM1QllNT
	Q1fpgi8ilhWTAtZfJAmtPpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=x69ew0g5isWVnS16AeUE0LuARVPlcBpOfN1Sg1lK5pJOdn
	4hwDSb72MOJhiB81uTfo8iA7xSGyBB87/oIvm82oR01Eji0Y0rKmWj2hToTwWBND
	NZAD/yb5OEe1FqallggpkNmr2Cg0XzCrb0gGmCcWpd0Ea84PYP9CcOmxcBgXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E16AB90;
	Wed, 27 Mar 2013 11:04:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66D90AB8B; Wed, 27 Mar 2013
 11:04:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6339D8C-96EF-11E2-B815-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219254>

Yann Droneaud <ydroneaud@opteya.com> writes:

> Using test_config ensure the configuration variable are removed
> at the end of the test, there's no need to remove variable
> at the beginning of the test.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>

This is a good change in the longer term, but there must not be any
other topic in-flight that adds new tests that modify configuration
in a persistent way, which your previous patch based on 'master'
wouldn't have addressed, for this to be a safe change (I assume that
you already have checked that).

Otherwise these apparently redundant unsets need to be left as "belt
and suspenders" safety.  The same for the change to 4202 in [PATCH
07/15].

Thanks.
