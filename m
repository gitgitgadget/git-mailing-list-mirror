From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is ident_is_sufficient different on Windows?
Date: Wed, 06 Feb 2013 12:47:27 -0800
Message-ID: <7vip65b25c.fsf@alter.siamese.dyndns.org>
References: <991CBC1C-912C-4DD6-B911-93F6B41D895E@quendi.de>
 <7vmwvhb2fm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BuO-0005mO-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758640Ab3BFUre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:47:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758625Ab3BFUr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 694C5DC67;
	Wed,  6 Feb 2013 15:47:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qhUDv1L7jdOIxWpTJvGudcEL9eM=; b=KrbKWK
	CHWMX9FrWg4CHH9sAwLo4a89qMgPugP/fQI3LetZPktnaBlvHW2HoFU3rZkDRbF0
	/HOJMGcKVnaJqXmH8WlLqWqiZW9YhVrfjU/bje0P39pCSBp8NAafmcXfMtpUHCuA
	VAA7C4Vbcwugpm4OfjEhpZKN2/t3lFVwbVHD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmkzbSF69yqorOgTkO4HvVw061SLrFI6
	IddZiA6BMVWEWdfBtkhcW/jhSLshabWK2Um065XXKOdMJwAyuOD2iTUTC1ytIpqb
	2qZjC4hhFbVunMVFn0z9TSL73eEKSNl7G/XtGhue78pl1yt+bzLbYBLfRRUmseO7
	tWVDfYaAcU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E25BDC66;
	Wed,  6 Feb 2013 15:47:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D508DDC64; Wed,  6 Feb 2013
 15:47:28 -0500 (EST)
In-Reply-To: <7vmwvhb2fm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Feb 2013 12:41:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BB660E4-709E-11E2-BB50-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215636>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect somebody from the Windows camp saw a patch I posted
> without the ifdef, noticed that there is a problem to expect
> IDENT_NAME_GIVEN to be set on Windows for some reason, and resulted
> in a reroll of the function in that shape.
>
> I didn't find anything in the list archive, though.  So I am
> stumped.

The only thing I can think of is that on Unix we can guess name from
GECOS, which could be considered sufficiently your name, while on
Windows we probably do not get anything useful there.
