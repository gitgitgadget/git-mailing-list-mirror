From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 3 Jun 2016 11:45:44 +0200
Message-ID: <20160603094544.GA3865@Messiaen>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
 <57511B2D.7040501@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:46:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8lfy-0006Nl-LS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbcFCJpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:45:50 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:41757 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932133AbcFCJpt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 05:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 122E520D9;
	Fri,  3 Jun 2016 11:45:46 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2liqUBJMxwk; Fri,  3 Jun 2016 11:45:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F19A320D3;
	Fri,  3 Jun 2016 11:45:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EAA842077;
	Fri,  3 Jun 2016 11:45:45 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0AXiBw948XP; Fri,  3 Jun 2016 11:45:45 +0200 (CEST)
Received: from Messiaen (eduroam-033123.grenet.fr [130.190.33.123])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8CE522066;
	Fri,  3 Jun 2016 11:45:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57511B2D.7040501@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296295>

On Fri, Jun 03, 2016 at 07:52:45AM +0200, Johannes Sixt wrote:
> Am 03.06.2016 um 00:48 schrieb William Duclot:
>>Logic behind the "pattern" regex is:
> 
> The name of the macro parameter is "pattern", but the actual meaning
> is "function name" regex.
> 
>>diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>>index e3b1de8..81f60ad 100644
>>--- a/Documentation/gitattributes.txt
>>+++ b/Documentation/gitattributes.txt
>>@@ -525,6 +525,8 @@ patterns are available:
>>
>>  - `csharp` suitable for source code in the C# language.
>>
>>+- `css` suitable for source code in the CSS language.
> 
> CSS is not so much source code. How about "suitable for cascaded
> style sheets"?

Technically correct yes
 
>>diff --git a/t/t4018/css-common b/t/t4018/css-common
>>new file mode 100644
>>index 0000000..84ed754
>>--- /dev/null
>>+++ b/t/t4018/css-common
>>@@ -0,0 +1,4 @@
>>+RIGHT label.control-label {
>>+    margin-top: 10px!important;
>>+    border : 10px ChangeMe #C6C6C6;
>>+}
> 
>>diff --git a/t/t4018/css-rule b/t/t4018/css-rule
>>new file mode 100644
>>index 0000000..84ed754
>>--- /dev/null
>>+++ b/t/t4018/css-rule
>>@@ -0,0 +1,4 @@
>>+RIGHT label.control-label {
>>+    margin-top: 10px!important;
>>+    border : 10px ChangeMe #C6C6C6;
>>+}
> 
> These two are the same. Please pick only one. I propose the name
> "common" because it is how CSS rules are written most commonly.

Right, I was distracted

>>+IPATTERN("css",
>>+	 "!^.*;\n"
> 
> Is there a difference between this and "!;\n"? Is it necessary to
> anchor the pattern at the beginning of the line?
> 
> In the commit message you talk about colon (':'), but you actually
> use a semicolon (';'). Thinking a bit more about it, rejecting lines
> with either one would be even better. Consider this case (without
> the indentation):
> 
>    h1 {
>    color:
>    red;
>    }
> 
> (New test case, hint, hint!) Therefore, it could be: "![:;]\n".

You're right! (plus the potential trailing spaces)

>>+	 "^[_a-z0-9].*$",
>>+	 /* -- */
>>+	 /*
>>+	  * This regex comes from W3C CSS specs. Should theoretically also
>>+	  * allow ISO 10646 characters U+00A0 and higher,
>>+	  * but they are not handled in this regex.
>>+	  */
>>+	 "-?[_a-zA-F][-_a-zA-F0-9]*" /* identifiers */
> 
> Drop A-F.
> 
>>+	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
> 
> Here, too: it is an IPATTERN.

Here I have to disagree (with you and Junio): the IPATTERN is
case-insensitive only on the "pattern" regex, not the "word_regex"
regex. It can be seen in the macro definition, and a quick test confirm
that (and we can see that the fortran word_regex, for example, bother
with uppercase and lowercase even thought it use IPATTERN).
On the identifier line, I have "A-F" instead of "A-Z" though
