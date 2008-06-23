From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [PATCH 1/2] Create a fnmatch-style pattern TreeFilter
Date: Mon, 23 Jun 2008 19:32:50 +0200
Message-ID: <485FDE42.1060106@web.de>
References: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApvQ-0004J4-Ie
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759565AbYFWRc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759037AbYFWRc7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:32:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42225 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748AbYFWRc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:32:57 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id BBF95E10A05B;
	Mon, 23 Jun 2008 19:32:55 +0200 (CEST)
Received: from [84.150.93.234] (helo=[192.168.1.50])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KApuQ-0002D0-00; Mon, 23 Jun 2008 19:32:54 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX190BDW9mF8dXSuomZZzc1IETTv3bEyg40mjTp2i
	H4ST36su3nTtrgi6kWWgVjTCVfiiZ0PKMUHrZIl/3v4YnwHt3j
	rCRRcmQL7ZMgvbYwYtdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85892>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Robin,

thank you for accepting my first patch :D.

| +/**
| + * This class implements a TreeeFilter that uses the wildcard style
pattern
| + * matching like of Posix fnmatch function.
| + */
Typo: One 'e' to much in TreeeFilter.

It would be more efficient to
| +	@Override
| +	public TreeFilter clone() {
| +		return new WildCardTreeFilter(pattern);
| +	}

One way to create a clone of the FileNameMatcher is to call:
originalMatcher.reset()
FileNameMatcher clone = originalMatcher.createMatcherForSuffix()

I will send a patch which implements a copy constructor for FileNameMatcher.

First I wanted to implement a clone() method, but found this page and
decided then to implement a copy constructor:
http://www.javapractices.com/topic/TopicAction.do?Id=71

A Implementor of a super class could imply that clone() of object gets
called, as stated in the javadoc of clone():

quote (javadoc ob Object#clone()):
- -----------
By convention, the returned object should be obtained by calling super.clone
- -----------

I think this is a bad convention, as one should not rely on
Object#clone() to do the copy job for one. If you really need a clone
method then I would do it the same way you did, by calling a constructor
which does the job.

Best regards,
Florian

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIX94k59ca4mzhfxMRAgDjAJ9S76L8I5Lqed4lKfgTf+2cp2IQ9gCfQNVh
z72+NGvmIy3H0gwveKRfn+w=
=wnpy
-----END PGP SIGNATURE-----
