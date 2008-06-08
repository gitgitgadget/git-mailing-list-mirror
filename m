From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v3 0/23] Implementation of a file tree iteration
 using ignore rules.
Date: Sun, 08 Jun 2008 18:37:30 +0200
Message-ID: <484C0ACA.8080702@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <200806060222.40654.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5NuU-0004UW-3J
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbYFHQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbYFHQhd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:37:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53048 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbYFHQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:37:32 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5926EE0DFE88;
	Sun,  8 Jun 2008 18:37:31 +0200 (CEST)
Received: from [84.150.87.27] (helo=[192.168.1.50])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K5Ntb-000179-00; Sun, 08 Jun 2008 18:37:31 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <200806060222.40654.robin.rosenberg.lists@dewire.com>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1/b+QZh4/hRAvKx2aPV/sTJe/NTsAsLuT9MZuSy
	i2rfTy9w+cWibtt4SjdP3dKbxx8IQVgl72Yii1MzYdUu6/jh1Q
	AL51C1CFWpR4Go/gfcBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84292>

>> Unsupported are colon expressions like ":alpha:". I didn't expect git-add to support it, but as I just noticed git does.
> Maybe we should anticipate it and throw an exception if one tries the pattern and not treat it as [alph:] .
> 
> Well we noted they were broken in Git so (separate thread) so we may as well try something sane. 
Just did some tests and noted that the shell and git does not support 
them. I guess I thought that they work because [:alpha:] matched "a".

Hi Robin

The bash shell doesn't support [:alpha:] too:
$ mkdir test
$ cd test
$ touch a
$ touch b
$ touch :
$ ls [:alpha:]
:  a

The fnmatch function of the python module fnmatch 
(http://docs.python.org/lib/module-fnmatch.html) does not support 
:alpha: too.

example:
$python
 >>> from fnmatch import fnmatch
 >>> fnmatch("a","[:alpha:]")
False

So I see no reason for displaying a warning.

Best regards,
Florian
