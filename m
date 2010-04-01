From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/6] Gitweb: add ignore and clean rules for minified
 files
Date: Thu, 01 Apr 2010 14:26:20 -0700
Message-ID: <7vaatmooeb.fsf@alter.siamese.dyndns.org>
References: <4BB430A0.7040700@mailservices.uwaterloo.ca>
 <201004011024.50615.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 01 23:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxRuP-000176-3B
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 23:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab0DAV0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 17:26:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab0DAV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 17:26:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAD45A75D1;
	Thu,  1 Apr 2010 17:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=83uskXIBrOlmg4///TOYvBP3nmQ=; b=Fzvo9GqE2CjNCBtQkkuBPpr
	pQ05GQMDXBaiJHtYKRV/RpLBwKfecaunD82hY/i/JhuHKkhGgxpE6F4Xd/zqjaYN
	IjJaqbmV1L6RHwhZKob+ZqNrklOny/6hHiLwuCfU1euxL8WNu99f8pCS50a9Tp4o
	U2TIZ4YKPKsJEa4cAbCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DMUoRPPpHhZT7ig8MC3n0AmURVia2lHlgE91D8t2NlB2DDTsi
	ZsBRVpougplB8jB6CDhZ7UE/AyQeAsiiUaAONq4Hat+Fz+Pw0CFzHH1mqEAbGMQ/
	eG2lau1m2yE4FMVWfDc3LeMhIvg2eoPYgo3iWNlPKhX2ABajhJPi/KNrvw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DBA5A75CE;
	Thu,  1 Apr 2010 17:26:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C74CBA75CD; Thu,  1 Apr
 2010 17:26:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AA350B0-3DD5-11DF-B971-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143751>

Jakub Narebski <jnareb@gmail.com> writes:

>>  ifndef NO_PERL
>> -	$(RM) gitweb/gitweb.cgi
>> +	$(RM) gitweb/gitweb.{cgi,min.*}
>>  	$(MAKE) -C perl clean
>>  endif
>
> Minor nit: this would be first line that uses {a,b} shell glob 
> construct.  Why not write it as:
>
>   -	$(RM) gitweb/gitweb.cgi
>   +	$(RM) gitweb/gitweb.cgi gitweb/gitweb.min.*

Very good point and it is not a "minor nit"; I cannot apply the patch
without your fix.

My understanding is that you Ack 1 (with this fix), 2 (with another
paragraph in the log message), and 5.  Eric Acked 4 and 6 needs to be
reworked.  I wonder if anybody has comments on 3; I didn't look very
closely at it, but it looked sane to me.

With that understanding, I'll queue the whole thing to 'pu', so that they
can be reworked and replaced before hitting 'next'.

Thanks, all.
