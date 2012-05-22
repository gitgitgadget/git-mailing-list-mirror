From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 14/15] ident: trim whitespace from default name/email
Date: Tue, 22 May 2012 10:21:50 -0700
Message-ID: <7vehqc5dxt.fsf@alter.siamese.dyndns.org>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231029.GN10981@sigill.intra.peff.net>
 <7vipfo5f60.fsf@alter.siamese.dyndns.org>
 <20120522171204.GB11600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 19:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsn1-00033S-0M
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905Ab2EVRVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:21:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759855Ab2EVRVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:21:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEDD488C3;
	Tue, 22 May 2012 13:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k+fkHhUxOlOpyjpBf5kWsSZxdBI=; b=hGoX3a
	EUYQYx88YpkukVYwm0CicuvB7y9f8iucJUK0UXfpUW+sMR7IxcXo4laaxWGDq4nL
	G70UkG0kMlZUYFMjtpFY0YsFF2wOqeERtCXEfUDTW+Ay1rGcBr363NbNDtR39rHJ
	sKBmEMlRKji1Dt3M12W7Bp1i7nCYiZeqNm9wU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjsGvUYHO6vIQUzW98dFzrrJ8qYQIabO
	DBM+heBHJG+YGUBRo4UVE0mqvtHhTTd063QvyvB7CpIRAr4gQcu9wieAd5GKz6Et
	ZBQtI588GEvhxRJ+Y9JPAia/TfnMsf/xCQtZhmJwqWIUiUyFCc3dChPKhm+TOuK7
	7rjNz1WqsPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11D788C1;
	Tue, 22 May 2012 13:21:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42DDD88BF; Tue, 22 May 2012
 13:21:52 -0400 (EDT)
In-Reply-To: <20120522171204.GB11600@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 May 2012 13:12:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F2055FE-A432-11E1-B714-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198208>

Jeff King <peff@peff.net> writes:

> On Tue, May 22, 2012 at 09:55:19AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... Any other value
>> > comes from a config file, where we will have cleaned up
>> > accidental whitespace already.
>> 
>> Are you referring to the behaviour of the config parser that removes
>> leading and trailing whitespaces when reading an unquoted string value?
>
> Yes, exactly.
>
>> If the user really wanted to have trailing whitespaces by quoting, we
>> would let it pass, in other words; it probably is a reasonable behaviour.
>
> Right, that's why I said "accidental" above; you can still do it, but I
> think you'd have to be really trying. But I really wonder if we should
> be blocking that, too. fmt_ident will drop it anyway, so this is really
> only for code paths that want to use the email directly.

Thanks.

>> Other than that single small "hrm...", the entire series was a pleasant
>> read.  Thanks.
>
> Thanks. I'm happy to update this patch if we want it to be more
> paranoid, or I can update the commit message if it just needs explained
> better.

Neither is necessary. I was just puzzled a bit and was worried if I was
missing something.
