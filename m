From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 02 Dec 2009 09:35:48 -0800
Message-ID: <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202171117.GY31763@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFt7h-00066O-39
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbZLBRfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbZLBRfu
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:35:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbZLBRft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:35:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D2584042;
	Wed,  2 Dec 2009 12:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7YxJBtZRyqnH+fhFv8/JFVGciQ=; b=ZMn2cK
	YObLou0GURxuZlcqkXvVvNfZJfHdWnfDa7vn4tENSsQ9K8RZuzU3OobvLcwk8j/n
	+sYTaqQ4MFmtd4kfrFvcJcqtjNKiFf/f2y8epGmbN0np8mMYPx7mhKC7qwbZfx1j
	UqOzq83qxy3zFkYYhImKl6UIA0u4/FHTGE8Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJlfSjU563mGRFrTHz2x9OnDq2GtdP5s
	VYoba+tpkj6g+V+YhxkWXKC1e+S63c4YEyty77baSg8kbvjA8TnoUuhLQDdD2Lry
	NnNNY3iWckT5LisapMuQBvC9gpVg4FVYr0JWAXlmptZYQmiuOSZR0CzQ/XFjO59v
	j4kVxODJHoQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFE184041;
	Wed,  2 Dec 2009 12:35:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8A5784040; Wed,  2 Dec
 2009 12:35:49 -0500 (EST)
In-Reply-To: <20091202171117.GY31763@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 2 Dec 2009 18\:11\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2344592A-DF69-11DE-953A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134360>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Dec 01, 2009 at 01:27:32AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> +--date=<date>::
>> +	Override the date used in the commit.  The format is the Git
>> +	native one and is `<time> SP <offutc>`.
>
> I just noticed that fmt_ident() calls parse_date(), so other formats are
> supported as well.
>
> Is there any documentation describing what does parse_date() accept?
>
> Based on t0006-date.sh and the comments in the source, I see 3 supported
> formats:
>
> 1) <unix timestamp> <timezone>
>
> 2) A format like 2008-12-02 18:04:00
>
> 3) RFC 2822 (Thu, 21 Dec 2000 16:01:07 +0200)

The above are all supported (you can label 2 as ISO even though the
official ISO8601 wants "T" instead of " " between date and time).

For more amusing ones, see

    http://article.gmane.org/gmane.comp.version-control.git/12241

and follow the discussion there ;-)
