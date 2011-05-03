From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] git-add.txt: document 'interactive.singlekey'
Date: Tue, 03 May 2011 11:51:42 -0700
Message-ID: <7vbozjipmp.fsf@alter.siamese.dyndns.org>
References: <20110501045140.GA13387@sigill.intra.peff.net>
 <1304343872-1654-3-git-send-email-valentin.haenel@gmx.de>
 <7v1v0hngs9.fsf@alter.siamese.dyndns.org>
 <20110503153857.GC2211@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 03 20:52:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHKhW-0006bR-Tw
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 20:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1ECSv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 14:51:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1ECSv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 14:51:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEEA53D40;
	Tue,  3 May 2011 14:53:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8LBDV5bI6CIHrZDCBUXu6lZGUg=; b=dl/xUz
	xriPR5ql9fCs8MmNu5r4Bt7v/CFSRsRxxxbcIdO/8Wrum7qfYQ45SBu+nCDrm7i1
	Efvk+k/HLc4MXFzgeCyHvV5BrfSZIM/I+JeVr0AVDkdnGcXHfDEkDjAeaQ3iw/CC
	//xoKAMjZlHichLVCi9+g8G4VMaGWztZmmSTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T96Oj/DVAKuNYLjwa9Z4LMrRH/JBr7F/
	+okWOyGYUwxCbPxDEex2sYjB/CKnWnMTHY2Fs8YbyD+Z4DvWyfTm+d5Nwr1uC3Mv
	CDIXjq4qPtZeJJBYeaSVxHDD3ORxbGgmgGaSQCL5aSWuyql3reLVNyA52mbVpLej
	p9iyxGaXYe8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CCB53D35;
	Tue,  3 May 2011 14:53:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BFC2E3D33; Tue,  3 May 2011
 14:53:46 -0400 (EDT)
In-Reply-To: <20110503153857.GC2211@kudu.in-berlin.de> (Valentin Haenel's
 message of "Tue, 3 May 2011 17:38:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B059A84E-75B6-11E0-8760-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172683>

Valentin Haenel <valentin.haenel@gmx.de> writes:

>>  	If some files could not be added because of errors indexing
>>  	them, do not abort the operation, but continue adding the
>>  	others. The command shall still exit with non-zero status.
>> +	The configuration variable `add.ignoreErrors` can be set to
>> +	true to make this the default behaviour.
>
> Its unrelated to 'interactive.singlekey', can i 'stuff' it into the
> series too, or better make a seperate one?

Yes, this is totally unrelated; I just wanted to write it down so somebody
remembers.  Please make it a separate patch that comes before anything
else.

>> @@ -189,7 +191,8 @@ interactive command loop.
>>  The command loop shows the list of subcommands available, and
>>  gives a prompt "What now> ".  In general, when the prompt ends
>>  with a single '>', you can pick only one of the choices given
>> -and type return, like this:
>> +and type return (the configuration variable `interactive.singlekey`
>> +can be set to true to omit hitting return, by the way), like this:
>
> If what i wrote above is correct, this should go into the section about
> the patch mode, rather than here?

Yes, please move find a more appropriate home for that description.

Thanks.
