From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] glossary-content.txt: remove an obsolete paragrah
Date: Thu, 21 Nov 2013 15:55:29 -0800
Message-ID: <xmqqy54h1f9q.fsf@gitster.dls.corp.google.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
	<1385016260-9718-1-git-send-email-pclouds@gmail.com>
	<xmqqtxf54o83.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vje5z-0002nH-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab3KUXzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 18:55:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3KUXzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 18:55:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6164D54DF8;
	Thu, 21 Nov 2013 18:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tHM+2HUMHNIw4I7BS+AMuIqNXcY=; b=MLCUZI
	fXSTOpI5lCaNVsUNfSASzwoWlzqngXQynn5KX7v/RgqXMf6rKW4QhloUMgpecSXi
	KTJ0jCCDZDosIaNSZiEb3GzkGzzEf42G75wlZIqIfWIidRRqAPApDMqX330FUREc
	1u98DWzmSVvl6gGkyqjjKqVpWm0HdqOE8mIlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bge/ygBtkiHv2qV/tqmSh/xHH4KXa8TO
	5EfWByZrcD02T3yE+kUtqyhrJCNbhErIuCoqUUHZM5Yi90fFBK7V11S3TlV+g17c
	4x1NqrrEnWgAs+C7MpnNrcg2X6LNOWmc2BfzmYstS88744487ltcATkau9Z9dlLV
	5dznJDetjCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5063E54DF7;
	Thu, 21 Nov 2013 18:55:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BFB254DF1;
	Thu, 21 Nov 2013 18:55:31 -0500 (EST)
In-Reply-To: <xmqqtxf54o83.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 21 Nov 2013 10:13:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67BC6DF6-5308-11E3-AA40-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238167>

Junio C Hamano <gitster@pobox.com> writes:

An addendum.

> As we can see in a later paragaph:
>
>     The "magic signature" consists of an ASCII symbol that is not
>     alphanumeric. Currently only the slash `/` is recognized as a
>     "magic signature"...
>
> the correct way to read that "a character that cannot be a magic
> signature" is "a character that is not 'an ASCII symbol that is not
> alphanumeric'", which means you can do:
>
> 	:!/foo	- with magic signatures ! and /, pattern begins at 'f'
>
> 	:/#abc  - with magic signatures # and /, pattern begins at 'a',
> 	          even if in a particular version of Git, '#' magic
> 		  signature may be invalid and produce an error
>
> 	:/:#abc - with magic signature /, pattern is "#abc".
>
> but because the definition of "magic signature" syntax comes later
> than "cannot be", it is prone to be misinterpreted as "anything that
> is not currently defined as a magic signature (namely, '/')".

... and that misinterpretation may give a false impression that

	":/#abc"

is with the magic signature '/' (i.e. match from top) for a pattern
"#abc".

Doing so would mean that a version of Git that does not support a
magic signature '#' will allow people and scripts to use ":/#abc"
with such a meaning, and will prevent us from using '#' as a new
magic signature with some useful meaning in the future.  Rather, we
need to force them to always spell it as ":/:#abc" even in the
version of Git before the magic signature '#'.

And the phrasing 'if the pattern begins with a character that cannot
be a "magic signature" and is not a colon' needs to be clarified to
avoid that misinterpretation for that reason.
