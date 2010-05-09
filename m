From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Sun, 9 May 2010 07:14:12 -0400
Message-ID: <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 13:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB4Sn-0001vC-Gx
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 13:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0EILOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 07:14:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36133 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab0EILOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 07:14:14 -0400
Received: by wwa36 with SMTP id 36so932072wwa.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9l3pSHvOmbKxIyCoMGKGl0WWuWI8qLY2GrlinjZHahk=;
        b=Lf5jDuwJwJk04+S1TsMOluwvx3bAmLwk1x73BSL9pOR2JteL5FX/KMlGiNF1sHiXbW
         5YxYUR1d5Vby7UdBPngOh4walRiNzXhMmh1O6bJKjWdVg15CYme1Jn1myOx1reU+J8OP
         MqPtkEiwSfAkz26uhb8Ifo+3P3bXu2d8FECh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hSJCtBvJBD4BPARuAkN5Vy4Y7Nl6KoVrv3RSnXshWgqVpZedhb2sTJyWEDlLoqzO8l
         bIJh0VWbQxkz8xUlUQ2T9y6h0igEAbvSK370vCGyROrara0pAL1w/1DR+Gj26gOcBvM8
         magKHycTStqRR+kaUFRXMqhXcMSemhbC17gDw=
Received: by 10.216.155.143 with SMTP id j15mr1514784wek.46.1273403652754; 
	Sun, 09 May 2010 04:14:12 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Sun, 9 May 2010 04:14:12 -0700 (PDT)
In-Reply-To: <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146721>

> My user interface would have been:
>
> - an attribute "eolconv" that enables or disables line ending conversion
> - a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
> - a config variable "core.localeol" that decides whether LF or CRLF is preferred
>

[...]

> My current thinking on how to change my series now runs along these lines:
>
> - keep the current "crlf=auto" change
> - rename "core.eolStyle" to "core.localcrlf"
> - add a "core.crlf" that sets the "crlf" attribute on paths where it isn't explicitly configured
> - keep "core.autocrlf" for backwards compatibility, but make "core.autocrlf=input" and "core.autocrlf=true" complain if they are in conflict with the other config settings.

So, the meanings of these would become...

core.crlf [ auto | input | false ] : 'auto' means to enable
bidirectional normalization, and 'false' would mean do not
normalization, and 'input' would mean normalize on input only,
otherwise output lf. Is this true?
core.localcrlf [ crlf | lf ] : this is obvious, and use-friendly

For the above case have you considered using 'core.crlflocal' instead?
Usability-wise the related properties start with the same name prefix.

>From a usability standpoint, I personally prefer something similar to
what you (see "my user interface would have been") specified, slight
adjustment to the names only:

core.eolconv [ true | false ] - whether or not to turn on conversions
core.eoltype [ lf | crlf ] - by default what to convert to for text files

I like this purely because, from the users standpoint, saying
something like "localcrlf crlf" is strange; meaning the term "crlf" is
on both sides of the assignment. I do prefer "eol... crlf", where eol
refers to the applicability of the property and crlf is only one such
value.
