From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] Support ignore rule "**" using wildmatch from
 rsync
Date: Mon, 07 May 2012 12:05:11 -0700
Message-ID: <7vy5p34xso.fsf@alter.siamese.dyndns.org>
References: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 21:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRTFT-0006ro-A5
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab2EGTFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 15:05:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757653Ab2EGTFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 15:05:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7077B7AEB;
	Mon,  7 May 2012 15:05:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmrlBLn/2vZ8OXQXabbyaesUWnY=; b=EdO+ud
	MqFZCsmxzb7DFTJwQ8Hc31W89PHnnTHE54qRY5QcMrXUNdclVThub4v7BOYCs3W+
	5+aNjaxXPnij5fAgZDxfTqHqz4gW1LmOl+WqTEY/VYs0owlXnuSIdqoElLIeZdwm
	fp1T5ema0qM85uek1eQrajwGnz6CARal0B4vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZsZ+rDCFe5noHdVfqrgQvEBH1p/gC1U7
	4POnVDmolKZzZj8jEw8K/kx7073kPe0Q7f/4F+e3HXC9xvKNCc2fQmnm0AtqID6D
	+zxIKcICmz8xxilOhFGl0wN9SmB/X6V1TVPavFOSXjSYHv/G4ZBN9adcNrjH5BK1
	xC560usVldI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67FDF7AEA;
	Mon,  7 May 2012 15:05:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F31227AE8; Mon,  7 May 2012
 15:05:12 -0400 (EDT)
In-Reply-To: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 7 May
 2012 20:01:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92D91126-9877-11E1-8186-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197299>

I skimmed the series and I think it would be a good change in the longer
term, but I suspect we probably have an unfinished business on the core
side that sometimes uses pathspec->raw field and assume that they only
need to do the leading-path match, which needs to be fixed first before
changes like this can be sanely added.
