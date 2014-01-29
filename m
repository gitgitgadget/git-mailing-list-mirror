From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git
 interpret-trailers'
Date: Wed, 29 Jan 2014 21:01:02 +0100 (CET)
Message-ID: <20140129.210102.2157679962537036887.chriscool@tuxfamily.org>
References: <CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
	<20140127.213344.212708599170084659.chriscool@tuxfamily.org>
	<xmqqfvo9nmul.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 29 21:01:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8bJv-0006L9-MY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaA2UBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:01:07 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:37699 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbaA2UBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:01:06 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 05EED6B;
	Wed, 29 Jan 2014 21:01:02 +0100 (CET)
In-Reply-To: <xmqqfvo9nmul.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241221>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 27 Jan 2014 13:20:18 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>>>> +'git interpret-trailers' [--trim-empty] [--infile=file] [<token[=value]>...]
>>> 
>>> Would it be more consistent with existing documentation to format this as so?
>>> 
>>>   [--infile=<file>] [<token>[=<value>]]...
>>
>> No, it would be very inconsistent:
>>
>> $ grep '\.\.\.\]' *.txt | wc -l
>> 103
>> $ grep '\]\.\.\.' *.txt | wc -l
>> 0
> 
> I have a feeling that you are missing the point Eric is making.

Yeah I realize I missed some of his points. Sorry about that.

> The
> value given to the --infile option can be anything, i.e. 'file'
> there is a placeholder, hence "--infile=<file>" not "--infile=file"
> as you wrote.

Ok, I agree with that.

> Also I think "[<token>[=<value>]]..." is the correct way to spell
> that there can be 0 or more "<token>[=<value>]".

Perhaps but it is not very consistent with what there is in other
synopsis strings. For example the commands that accept a path have a
synopsis that ends with "[--] [<path>...]" and not "[--] [<path>]...".

Perhaps [(<token>[=<value>])...] is more correct, but not worth the
added complexity.

> "<token[=value]>"
> in the original does not make any sense, as <> is meant to say "this
> thing is a placeholder", and we do not try to say, with the string
> inside <>, what shape that placeholder takes.  In fact '=' part is
> _not_ a placeholder but is required syntactically when you want to
> supply a value to the token, so the original doubly is incorrect.

Yeah perhaps, except that in the code ':' is accepted instead of '=',
and the documention says that.

So perhaps [(<token>[(=|:)<value>])...] is even more correct.

> I find it a bad taste to allow unbound set of <token> on the LHS of
> '=' on the command line, but that is a separate issue in the design,
> not in the documentation of the design.

I don't understand this sentence, sorry.

Thanks,
Christian.
