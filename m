From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] http: expand http.cookieFile as a path
Date: Wed, 04 May 2016 16:03:13 -0700
Message-ID: <xmqqwpn9ctou.fsf@gitster.mtv.corp.google.com>
References: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
	<1462387335-57937-3-git-send-email-computersforpeace@gmail.com>
	<20160504193051.GF21259@sigill.intra.peff.net>
	<20160504193531.GA62336@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:03:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5pB-0004oM-MR
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbcEDXDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:03:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754091AbcEDXDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:03:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82E82190A3;
	Wed,  4 May 2016 19:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KDJXBe7v+gNac7gvzTHt3v3emAc=; b=MUQynh
	YulaRYx6RQwlBVpHDG+VOK1eoVD/Af/LSsVf9Lyr1Tg9z9A7hHnGAQCMax2AduDW
	rIY9EaMAE1yvgYGh5Qi17AV6nPPo8n6udKwcWbdOw6Si/wg8whTMcvAWyUcIwp5q
	XHtbuz7NCspaJU0z7J0yCyq+Si5lKh1pip/PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IqHw5RUGYxF73d4/6pC+rWmMTubIQ8Kn
	cg+GWDO716wfIbqRWJPWs5GmMD3fSdD+jm8O4S7Hvkqw+IazuUSl/ExCm4asX31p
	P8zBVqhLUk7NgiDiBdPMnEmSkF8UilK9yDe9s4WUSoOf7TpMLYyi9UlTzottgntH
	svwawGZe28c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 793E1190A2;
	Wed,  4 May 2016 19:03:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE11D190A1;
	Wed,  4 May 2016 19:03:14 -0400 (EDT)
In-Reply-To: <20160504193531.GA62336@google.com> (Brian Norris's message of
	"Wed, 4 May 2016 12:35:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61DA1928-124C-11E6-935D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293620>

Brian Norris <computersforpeace@gmail.com> writes:

> On Wed, May 04, 2016 at 03:30:51PM -0400, Jeff King wrote:
>> On Wed, May 04, 2016 at 11:42:15AM -0700, Brian Norris wrote:
>> 
>> > diff --git a/Documentation/config.txt b/Documentation/config.txt
>> > index e655b9729a7d..4c3cd7621ad0 100644
>> > --- a/Documentation/config.txt
>> > +++ b/Documentation/config.txt
>> > @@ -1664,7 +1664,8 @@ http.emptyAuth::
>> >  	authentication.
>> >  
>> >  http.cookieFile::
>> > -	File containing previously stored cookie lines which should be used
>> > +	The pathname of a file containing previously stored cookie lines,
>> > +	which should be used
>> >  	in the Git http session, if they match the server. The file format
>> >  	of the file to read cookies from should be plain HTTP headers or
>> >  	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
>> 
>> I think we usually re-wrap paragraphs when adding to the documentation,
>> but I do not have a strong opinion (and certainly understand the reasons
>> for not doing so).
>
> I chose the wrapping mostly based on the diff suggestions y'all kindly
> provided :)
>
> I can rewrap and resend if necessary.
>
>> The whole series looks fine to me. Thanks.


If the rewrite were a lot more extensive, then it no longer would make
sense to refrain from rewrapping (which reduces the number of lines
eyes have to scan), but doing this without rewrapping I think
strikes a good balance.
