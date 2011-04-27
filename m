From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Refactor --dirstat parsing; deprecate --cumulative
 and --dirstat-by-file
Date: Tue, 26 Apr 2011 21:53:23 -0700
Message-ID: <7vaafcb8ho.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-4-git-send-email-johan@herland.net>
 <7vy62xezqy.fsf@alter.siamese.dyndns.org>
 <201104270402.10658.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:53:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwku-00024U-WD
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab1D0Exg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 00:53:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1D0Exf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 00:53:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A3765A90;
	Wed, 27 Apr 2011 00:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oKL4diB2XodHCgyScLAtYCYEb9c=; b=gXMQnR
	OaKPip9VLdG4P4ljlcjNvJ+4D/0R2qW32TnhquO4PHO6OyK/09w5ux/mQnKuG0Nr
	QySCvZBKoG86E7VenV361lB3vl/bIxgK9dpHNzmZXMasjK+YSCKMZxdFwVXtOq1C
	dMUXFUcvFaV9F78AMUH1hiFIPmMIFWzbpY5I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMaKRBlxcePMWgKo/zHSdZb+CuuYl4Vj
	hX/VY7A6k8/zbYikj7bjs6o42eoFFzaurGlZzvy6AS1JT5shE53jGYcw+UDr3Wlr
	Eo38AgX4Z1qakO1cEhd8kEh+BSutxbGA21jEL5/FOqGsqdu5gt5T9fccsmvKtC/t
	grvElKfiI8w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D98835A8F;
	Wed, 27 Apr 2011 00:55:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A287C5A8E; Wed, 27 Apr 2011
 00:55:27 -0400 (EDT)
In-Reply-To: <201104270402.10658.johan@herland.net> (Johan Herland's message
 of "Wed, 27 Apr 2011 04:02:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 945C9510-708A-11E0-ADA3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172166>

Johan Herland <johan@herland.net> writes:

> I have tried to consistently use "option" for referring to the entire
> "--dirstat=whatever" entity, and then use "argument" for referring to
> each comma-separated token following "--dirstat=".

Ok.

Your terminology is pretty much consistent with how POSIX calls these
things (Cf. *1*, *2*)

 * -X is an OPTION;
 * 3 in -X3 is an OPTION ARGUMENT; and
 * OPTION ARGUMENT is explained as "A parameter that follows certain options".

Between "--option=parameter" or "--option=option argument", the former is
easier to type and read, so it is slightly more preferable.


>> > +--
>> > +`changes`;;
>> > +	Compute the dirstat numbers by counting the lines that have been
>> > +	removed from the source, or added to the destination. This ignores
>> > +	the amount of pure code movements within a file.  In other words,
>> > +	rearranging lines in a file is not counted as much as other changes.
>> > +	This is the default `--dirstat` behavior.
>> 
>> "default behavior when no parameter is given"?

Right.  Thanks.

[References]

*1* 12.1 Utility Argument Syntax

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html#tag_12_01

*2* 3.256 Option, 3.257 Option-Argument

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_256.
