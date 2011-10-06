From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC jn/ident-from-etc-mailname] ident: do not retrieve
 default ident when unnecessary
Date: Thu, 06 Oct 2011 11:19:22 -0700
Message-ID: <7vy5wyyod1.fsf@alter.siamese.dyndns.org>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org> <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net> <20111003074433.GD17289@elie>
 <7vty7pga7y.fsf@alter.siamese.dyndns.org> <20111006171719.GB6946@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 20:19:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsXc-00017H-C4
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835Ab1JFST0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:19:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab1JFSTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:19:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1CE52A7;
	Thu,  6 Oct 2011 14:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lp8bKqPx5FJCG1wDvnRCgLgPQjQ=; b=yfRQIP
	8ujQhoWaGX4cpj5Br0D13cKR5X402U5QH9VcM7kjxgBAsOwEw/6gK31u81qWvQiE
	+/XPmo5QsUx2hUwRK9DpBuQZHCR7B/IX2J5Vs1Kqhdj3z2x2M6H9dpZlmcQV9GbE
	da5dlbURWXbSz8X7GFm4O72zMmCnFXP9MSq+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QTJ9DjwsBiNM22laOEm90pHxlCO2JUsQ
	u//RHFdQlbPKz+8Yhnr22z2m+z+fJ401SATqcd0DXMd5HsjP2ymXQKv58mDWDTs1
	rinG+agj07Up/KqLTjnO8IFtF56VHkI3XOvH0GJe82S0X8ntXFLxs/BknzPkmDvK
	K4cjWgldx/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51BC052A6;
	Thu,  6 Oct 2011 14:19:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE66B52A4; Thu,  6 Oct 2011
 14:19:23 -0400 (EDT)
In-Reply-To: <20111006171719.GB6946@elie> (Jonathan Nieder's message of "Thu,
 6 Oct 2011 12:17:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7DDE27C-F047-11E0-9664-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183005>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Avoid a getpwuid() call (which contacts the network if the password
> database is not local), read of /etc/mailname, gethostname() call, and
> reverse DNS lookup if the user has already chosen a name and email
> through configuration, the environment, or the command line.

Oh boy that is a hard to parse paragraph that took me three reads.

In any case, both the motivation of the patch and the change itself make
sense to me. Thanks.
