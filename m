From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Sat, 20 Jan 2007 01:08:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200100530.12889@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701191310.32417.jnareb@gmail.com>
 <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701192344.11972.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83mN-0008Pq-U1
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbXATAIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbXATAIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:08:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:42448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932869AbXATAIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:08:15 -0500
Received: (qmail invoked by alias); 20 Jan 2007 00:08:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 20 Jan 2007 01:08:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701192344.11972.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37225>

Hi,

On Fri, 19 Jan 2007, Jakub Narebski wrote:

> +Sections can be further divided into subsections.  To begin a subsection
> +put it name in double quotes, separated by space from the section name,

       ^ "its"

> +in the section header, like in example below
> +
> +	[section "subsection"]

I wonder if we should also mention the (case insensitive) alternative 
"[section.subsection]", to give a better idea to people why we actually 
check for "section.subsection" in the code.

> +All the other lines are recognized as setting variables, in the form
> +'name = value'. If there is no equal sign on the line, the entire line
> +is taken as 'name' and the variable is recognized as boolean "true".
> +Variable names are case insensitive.

They cannot contain anything else than alphanumeric characters, in 
particular no whitespace.

>					 There can be more than one value
> +for a given variable; we say then that variable is multivalued.

Maybe give the example of "remote.<name>.fetch" to explain why? Or maybe 
not.

> +The following escape sequences (beside `\"` and `\\`) are recognized:
> +`\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
> +and `\b` for backspace (BS).  No other character escape codes, nor octal
> +char sequences are valid.

I did not even know about BS! Does it make sense to allow it, really?

> +Some variables may require special value format.

I think you can safely skip that; it should be evident that the format of 
the variables depends on the purpose.

Ciao,
Dscho
