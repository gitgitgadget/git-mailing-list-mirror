From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 16:44:55 -0700
Message-ID: <7vhaq5onig.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
 <20121007230703.GC3490@sigill.intra.peff.net>
 <20121007231156.GD3490@sigill.intra.peff.net>
 <7vlifhooe1.fsf@alter.siamese.dyndns.org>
 <20121007232942.GA5685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:45:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL0X7-0000XW-C6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab2JGXpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:45:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab2JGXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:44:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44BD48010;
	Sun,  7 Oct 2012 19:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZIyIW/X/B/RPTffC3/UvkNpby+c=; b=ppKC1b
	G+WpzvK4kQKR447WFKZp/HR0NhPeHS8FtlGOLom7ua5EnoviGtyyd4uokVfYjnt6
	eYb1MQtbby1FzlZFGHYRyedC5Gddoq494jo1WhDuwK2B2ISxEsAiAQTR8/XxMM2g
	R/DcfSTK/EjIt140HlrlGQohAoAKZ3Kaf3TZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVP70LDN9VKTSzUkaRCsEbxuPTbjC1X3
	ynUDxb0p7M3kpuGh5iWXjD3Xh3WI+eIfg9Zmq8knEEde3CdlUvtQHrUfsKsRxvHC
	F24iJzz+BWfudkX0PhjUlpiwV9ZEJNIT7ChW7oTIZ6JCbpTQkXpRce5g68antDEf
	HFJwmatFoN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33200800F;
	Sun,  7 Oct 2012 19:44:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94DF2800E; Sun,  7 Oct 2012
 19:44:57 -0400 (EDT)
In-Reply-To: <20121007232942.GA5685@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 7 Oct 2012 19:29:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00755670-10D9-11E2-8917-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207217>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 07, 2012 at 04:25:58PM -0700, Junio C Hamano wrote:
>
>> Yeah, modulo that the "defaults" is tracked and does not have to
>> have the dash before "include" (it is an error if it is missing,
>> no?).  It may want to be named with s/defaults/autodetect/, though.
>> 
>> > diff --git a/Makefile b/Makefile
>> > index e3e3cd5..c00fd32 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > ...
>> > -endif
>> > -
>> > +-include config.mak.defaults
>> >  -include config.mak.autogen
>> >  -include config.mak
>
> Yeah, sorry, mindless copying on my part from the lines below. It
> clearly should not have the "-".
>
> I'm fine with something besides "defaults". I meant it to be "these are
> the config defaults before you tweak them", but yeah, it is more like
> "these are the config options we picked up from uname".

Let's put this on hold in the "possibly a good direction to go in"
pile, and defer it to post 1.8.0; I haven't even looked at (and do
not plan to before the release) these "auto-detect" bits are all
safe to be included in Makefiles in subdirectories.
