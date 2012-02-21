From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Tue, 21 Feb 2012 15:43:55 -0800
Message-ID: <7vsji3eoqs.fsf@alter.siamese.dyndns.org>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
 <7vobstjfcs.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
 <7vehtoiqae.fsf@alter.siamese.dyndns.org>
 <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jnareb@gmail.com, philipoakley@iee.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 00:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzzNX-000541-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab2BUXn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 18:43:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2BUXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 18:43:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2888F74D0;
	Tue, 21 Feb 2012 18:43:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDBc+xp8Rc4TqmPf6kNROmv7dKc=; b=yCvsxB
	jrxXMdXe9MGzRNr4yyNmtxNmvn5PAGTcvZH/J7LqxbwNusnegcLtUJbT4CBAe52l
	roKacmmjP2a/Aj8ZaT7d0B7X5ck5ki8E5rA6jkrIwanhtdG4DIGtZ8PwMbDdqgUJ
	73ruskbjpH1wXDjCkyPDAD+ebRF5pQQ7KvSpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PMcffVkQx6jeFAleDMNbzo8FiCX+5mK6
	AeJGrlXpk4uHEJQ4aNlq9dMnrdj+eeMS4FylirD03pW5VnS2GcdQQMrcZoVs4L3P
	nhHtVbVPjWuDYkyQ4Ij/YoI6PdVkDilAkpoyoU4IQn0UO/xVwTYp5Z2DMEjMND7t
	xjO42MU4bqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D7C174CF;
	Tue, 21 Feb 2012 18:43:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8824174CE; Tue, 21 Feb 2012
 18:43:56 -0500 (EST)
In-Reply-To: <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com> (Johan
 Herland's message of "Wed, 22 Feb 2012 00:23:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB794E72-5CE5-11E1-82E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191198>

Johan Herland <johan@herland.net> writes:

> history"[1], but won't cause any false positives (and small enough
> false negatives). If there really is no way to implement this, then we
> shouldn't give users false hopes by putting it in the survey...

I think that question should be "warn before pushing out a commit that the
user may later regret to have pushed out" ;-)
