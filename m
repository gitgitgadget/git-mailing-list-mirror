From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter
 configuration
Date: Sun, 07 Apr 2013 10:22:28 -0700
Message-ID: <7v38v25k8b.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
 <7v4nfi92q1.fsf@alter.siamese.dyndns.org>
 <CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
 <7vmwta7lx3.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
 <vpqwqsefl9b.fsf@grenoble-inp.fr>
 <CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
 <vpqbo9qfh1y.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtIZ-0000Qx-G4
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934125Ab3DGRWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:22:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762043Ab3DGRWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:22:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217C313101;
	Sun,  7 Apr 2013 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EGZd9esHUXufEukYFKBJWb20aug=; b=hCoD5IG3rirQA/eU5YHv
	U+Lm6WZV4nhYPedeEo9g0niSogTGS8gFFt/gbCLXjN/dT0sTvsygmQvw7Z3rIiah
	WMkL8WS5unpH3BbbFWIU3aggFCFUQtLJdBLXKqhM2UP7DqzzTaz9YBki+VJcy6Hj
	sPmQKKuJBZWZI0FWJ2ztqXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jQuoETvsIOy1V3mulBdIWbY0feXBRqfx6dnwsDn2QtgwRq
	6yXlQiv72dDDdd76iNlRbF2RYXs5Rk1EfqYSuxj3VOFrFKeb4omBsMaK13OmeM8T
	/5aYsWJaIBAlFYA+MeKISeXpMC9JQblCjUCamr6EF9jfS9qkWH8bVKXVrcEuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1652D13100;
	Sun,  7 Apr 2013 17:22:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B77F130FF; Sun,  7 Apr
 2013 17:22:29 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B984AA1E-9FA7-11E2-B638-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220332>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Wouldn't this work for both cases?
>>
>> % git -c format.coverletter=auto format-patch
>
> Then, what's the point in having a --cover-letter option?
>
> "git -c" is a good last-chance solution, but when we provide the same
> feature as a command-line option and as a configuration option, I can
> see no reason to add subtle difference between them.

I do not see a good reason to resist consistency by suggesting a
workaround.  We may do so ourselves when responding to an end user
bug report "I cannot countermand X from the command line" as a first
response "In the meantime you can work it around like so", but that
is as you said a last-resort workaround and does not justify why the
command line interface is lacking an obvious override.

But I think --cover-letter=auto I made was a bad suggestion.  An
optional parameter to a command line option is generally bad, as it
makes the parsing ambiguous [*1*], and turning what traditionally
was a boolean without any parameter into one that takes an optional
parameter is even worse.

We should instead add this as a new feature, --auto-cover-letter, or
something, i.e. the synopsis will have these as the choices

    [--[no-]cover-letter|--auto-cover-letter]

and the last one would win (e.g. "--cover-letter --auto-cover-letter" 
would mean "auto").


[Footnote]

*1* Does "--cover-letter yes" mean "--cover-letter=yes" aka "please
use cover letter" or is it "--cover-letter" (please use cover
letter) followed by an unrelated command line argument "yes"?
