From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v3 20/23] Added the class NoGitRepositoryFoundException.
Date: Sun, 08 Jun 2008 18:14:00 +0200
Message-ID: <484C0548.8090309@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-21-git-send-email-florianskarten@web.de> <200806060223.09332.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5NXq-0006Zl-Bm
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbYFHQOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 12:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbYFHQOI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:14:08 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33405 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbYFHQOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:14:07 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id E21F6DF128C9;
	Sun,  8 Jun 2008 18:14:04 +0200 (CEST)
Received: from [84.150.87.27] (helo=[192.168.1.50])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K5NWu-00030y-00; Sun, 08 Jun 2008 18:14:04 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <200806060223.09332.robin.rosenberg.lists@dewire.com>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX18oNvx8up2CrJxtXmz++KUu2GQnHuvA+so7kSUL
	sMH6aNg2zj60gy1gC8K4y0YHG3mBitIefIzyotYSGM8Jh7cs55
	ybePOhAqf9DelfmgaQRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84289>

Robin Rosenberg wrote:
 >> +		super(String.format("No repository found for file '%s'",
 >> +				fileWeSearchedRepositoryFor));
 >
 > This is any odd patterrn. Usually we use + to concatenate strimgs.

Hi Robin,

I know two good reason why you should use formating functions over 
string concatenation via the plus sign:

1.) formated strings are better translatable. e.g.
"The string '%s' is more then %s characters long"
is easier to translate then the three strings:
"The string '"
"' is more then "
" characters long"

2.) Whitespace mistakes are easier to see. e.g.
(i + "coins") and ("%scoins", i)

Sure you can make the mistake to provide not enough arguments, but 
that's not so worse:
a.) Some IDEs, like Intellij IDEA warn you if you call a formating 
function with to few arguments.
b.) A exception will be thrown at the time the function is called, if 
there are not enough arguments. Thus you will notice your mistake very soon.

Best regards,
Florian
