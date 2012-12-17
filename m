From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Mon, 17 Dec 2012 09:44:46 +0000
Message-ID: <20121217094446.GA24036@river.lan>
References: <20121215150314.GC2725@river.lan>
 <7vobhtnt57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkXG3-0001cJ-OT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 10:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab2LQJov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 04:44:51 -0500
Received: from anakin.london.02.net ([87.194.255.134]:45532 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2LQJov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 04:44:51 -0500
Received: from river.lan (188.222.177.116) by anakin.london.02.net (8.5.140)
        id 4FED9D1503CBC97A; Mon, 17 Dec 2012 09:44:46 +0000
Content-Disposition: inline
In-Reply-To: <7vobhtnt57.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211669>

On Sun, Dec 16, 2012 at 09:29:24PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>>  Here `<name>` is the person's display name (for example
>>  ``Com M Itter'') and `<email>` is the person's email address
>> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
>> +(``$$cm@example.com$$'').  `LT` and `GT` are the literal less-than (\x3c)
>>  and greater-than (\x3e) symbols.  These are required to delimit
>>  the email address from the other fields in the line.  Note that
>>  `<name>` and `<email>` are free-form and may contain any sequence
> 
> AsciiDoc 8.5.2 gives this:   
> 
>     asciidoc: WARNING: git-fast-import.txt: line 434: nested inline passthrough
> 
> Also in git-fast-import.1, there is this line:
> 
>     ... person\(cqs display name (for example `Com M Itter\(aq\(aq) and `<ema...
> 
> (notice two leftover `s); not that this is a new issue with this patch.
> 
> Which is puzzling, because the next input line formats better:
> 
>     ...  email address (\(lqcm@example\&.com\(rq)\&. ...

I wonder if you're hitting this bug, which is listed as fixed in
AsciiDoc 8.6.0 [1]:

    FIXED: Sometimes multiple double quoted text elements in the same
    paragraph were mistakenly seen as starting with an inline literal.

As you said in your other message, it may be better to avoid using the
pretty quotes, although I don't think just changing them to `monospace
output` is sufficient as monospace output is not distinguished in the
default man page output.  IMHO that's necessary for any examples that
contain whitespace.  Perhaps a patch series turning MAN_BOLD_LITERAL on
by default and then changing these examples to `monospace output`?


John

[1] http://www.methods.co.nz/asciidoc/CHANGELOG.html#_version_8_6_0_2010_08_16
