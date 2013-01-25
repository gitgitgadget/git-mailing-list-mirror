From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in
 expected outputs
Date: Fri, 25 Jan 2013 07:16:07 -0800
Message-ID: <7vmwvx5m4o.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
 <cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com> <7v38xqba04.fsf@alter.siamese.dyndns.org> <20130125150620.3b9dc9c3@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 16:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyl16-0005wn-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 16:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab3AYPQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 10:16:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756715Ab3AYPQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 10:16:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFFBBC51;
	Fri, 25 Jan 2013 10:16:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6sbvI2MlK/JKfsSm7cMpWTSNh/Q=; b=O602B0
	tpTTlZgDbB2CXVYB1Oyv8dZHCVla4wTAkdAQsyrXo1082TD08TyZ3Bg6uaHDZVvB
	yX0Epz4Ti0Z0nAaIPdbUrn/94z6HJ5pkicVkdxXU2AaqYlOYspCK/bOwV6nW44dk
	ZVOrkObLhyBTCp46thDXOpYuqlgfA+1oUCH4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PRTkTlbqcrdhuFf3rbT2BZYYlCN0BfB2
	7ceDP1saU4U2YKdT/ELaEmr86t96ZmEwfbNlVCvY8quyk0ZiXc5bVqMrxx76S+A+
	vDnUE07Agz7QLV0sUNR3M+1PG2RN4C7z6UVTxcGydNT9nRcm9C+O50qOHBkWHne7
	i5p4aZryrhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C5DBC4D;
	Fri, 25 Jan 2013 10:16:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2BB3BC4B; Fri, 25 Jan 2013
 10:16:08 -0500 (EST)
In-Reply-To: <20130125150620.3b9dc9c3@ashu.dyn1.rarus.ru> (Alexey Shumkin's
 message of "Fri, 25 Jan 2013 15:06:20 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 254EC434-6702-11E2-8E7D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214556>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> Why do we want "whatever_7" variables and use "cut -c1-7" to produce
>> them?  Is "7" something we care deeply about?
>> 
>> I think what we care a lot more than "7" that happens to be the
>> current default value is to make sure that, if we ever update the
>> default abbreviation length to a larger value, the abbreviation
>> shown with --format=%h is consistent with the abbreviation that is
>> given by rev-parse --short.
>> 
>>     head1_short=$(git rev-parse --short $head1)
>> 
>> perhaps?
>> ...
>> Likewise.
>> 
>> > +	tree2_7=$(echo $tree2 | cut -c1-7)
>> 
>> Likewise.
> but is there "git something" to return abbreviated tree hash except
> "pretty formats" that is implicitly tested here?

Does "git rev-parse --short $tree2" count?
