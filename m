From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add matchings for csharp
Date: Mon, 22 Jun 2009 08:24:11 +0200
Message-ID: <4A3F238B.1020107@viscovery.net>
References: <1245628369.15870.1.camel@belthazor>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Petaccia <adam@tpetaccia.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 08:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIcxM-0001QB-TD
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 08:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbZFVGYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 02:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZFVGYP
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 02:24:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45001 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbZFVGYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 02:24:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MIcws-0005Mr-RQ; Mon, 22 Jun 2009 08:24:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8B420C6C1; Mon, 22 Jun 2009 08:24:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1245628369.15870.1.camel@belthazor>
X-Spam-Score: -0.7 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122011>

Thank you for you contribution.

Adam Petaccia schrieb:
> I'm not sure if this is the correct place to send patches, please direct 
> me if I've addressed the wrong list.

This part of a patch submission should contain a description *why* this
patch is an improvement (and must include a Signed-off-by statement; see
Documentation/SubmittingPatches). Perhaps you are aware of msysgit issue
281[1], that you are addressing here, and you could mention it.
Considering the complaint in that issue (that hunk headers always only
mention the containing namespace), an example in the commit message would
be useful.

To answer you question: This is the right place.

[1] http://code.google.com/p/msysgit/issues/detail?id=281

> @@ -79,6 +79,16 @@ PATTERNS("cpp",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
>  	 "|[^[:space:]]|[\x80-\xff]+"),
> +PATTERNS("csharp",
> +	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> +	 "^([ \t]*(static|public|internal|private|protected|new|unsafe|readonly|volatile)[ \t]+(class|enum|interface|struct).*)$\n"
> +	 "^([ \t]*(namespace)[ \t]+.*)$"

I think the placement of parentheses could be improved in these two
expressions (but I don't know for sure because I don't know the code well
enough). Looking at the other examples in userdiff.c, I infer that the
*first* opening parentheses defines which part is copied to the hunk
header. Since you placed everything into parentheses (unnecessarily, I
think), the complete line would be copied to the hunk header, including
leading whitespace.

Disclaimer: I don't have C# source code to test this.

-- Hannes
