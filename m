From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Fri, 23 Oct 2009 23:45:20 -0700
Message-ID: <7vpr8d8f3z.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <m3ljj3es02.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Stephen Boyd <bebarino@gmail.com>,
	Nick Edelen <sirnot@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 08:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1aNp-0001vm-16
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 08:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbZJXGpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 02:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbZJXGpg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 02:45:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZJXGpf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 02:45:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 093E283D63;
	Sat, 24 Oct 2009 02:45:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BwedqtnO0wQH
	7slnuoVlpJ39/NA=; b=oL/SeM/5w4vCkBpIcXOU6jebJHxUGcsZbOF2V+bI5uNm
	+534wnlzVJcgPPcjFWr6ANpHHr/BRD7ryoUhhDB2u3UoHM/paq3T9+gJ7X7tgyLv
	ZuXxuKekEwLaMkaIopET2u6X9nRid0ULDuwciofkam+ZKlAS50JKlx9aNtzqBlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yGPxOp
	t6RdIHXLoc0Fn+QUlfFMMVqlFwhiU7N+Fs863UelpHWpZOX6qAGBDsCbbxHFFKDe
	UaG1O4abiLriqNe/6jogy3EATwmsKw0z5YTpPqTf7LyrraDtAMsz6s0IfcITi2BK
	BoPOkRzrAmy3M6IrOn88eRFN5OfZyEzRepKLo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9985583D62;
	Sat, 24 Oct 2009 02:45:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4EB483D60; Sat, 24 Oct 2009
 02:45:21 -0400 (EDT)
In-Reply-To: <m3ljj3es02.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 22 Oct 2009 01\:46\:50 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D389ECAC-C068-11DE-BBC6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131145>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * rs/pretty-wrap (2009-10-17) 1 commit
>>  - Implement wrap format %w() as if it is a mode switch
>>  (this branch uses js/log-rewrap; is related to jc/strbuf-nested-exp=
and.)
>>=20
>> When it comes to design issues to keep unnecessary complexity out, I=
 tend
>> to trust Rene (and Nico) a lot more than I trust myself.  Tonight's =
'pu'
>> queues this series instead of my "nested" one.
>
>> * jc/strbuf-nested-expand (2009-10-18) 3 commits
>>  . Teach --wrap to only indent without wrapping
>>  . Add %[wrap(width,in1,in2)<<any-string>>%] implementation
>>  . strbuf_nested_expand(): allow expansion to interrupt in the middl=
e
>>  (this branch uses js/log-rewrap; is related to rs/pretty-wrap.)
>>=20
>> Ejected from 'pu' to let rs/pretty-wrap in as described above.
>
> I think nested expand is easier to use than a mode switch: using
> scoping (well, kind of) like in high-level programming languages is
> IMVHO easier than programming a state machine like in assembler (or
> e.g. OpenGL).
>
> On the other hand this makes pretty format into a mini-language; also
> we already have and use mode switches in the form of color codes.
> Perhaps if color also used wrapping / nested expand, so one doesn't
> have to track where to turn off and on which toggle...

Indeed, the "mini-language"-ness was what made R=C3=A9ne worried and re=
minded
me that I should be worried, too.  We need to get the design right if w=
e
do so---there may come a time that we are better off biting the bullet
when we discover needs (notice, it is not "wants, because we can") for
many useful string functions, but I do not think we have reached that
point yet.

>> * jc/pretty-lf (2009-10-04) 1 commit.
>>  - Pretty-format: %[+-]x to tweak inter-item newlines
>
> I understand that %a%+b expands to %a%n%b if %b has non-empty
> expansion, and to %a if %b is empty, but what %-b is used for?

I know you can read the commit log message.
