From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [msysGit] Re: Weird filename encoding issue
Date: Mon, 27 Oct 2008 09:08:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0810270904490.18631@ds9.cixit.se>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
 <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
 <48F852FC.2070506@viscovery.net> <200810180458.53853.robin.rosenberg@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Gladysh <agladysh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:10:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuNAo-0000pd-U4
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 09:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYJ0IIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 04:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYJ0IIr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 04:08:47 -0400
Received: from ds9.cixit.se ([193.15.169.228]:56068 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbYJ0IIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 04:08:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9R88eY1022394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Oct 2008 09:08:40 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9R88dbi022389;
	Mon, 27 Oct 2008 09:08:39 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <200810180458.53853.robin.rosenberg@gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 27 Oct 2008 09:08:40 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99214>

Robin Rosenberg:

> Git (or msys) under windows is somewhat stupid here as it involves
> the eight-bit locale despite running in a unicode OS. To get UTF-8 on
> XP you can set the codepage to UTF-8 (called 65001 in windows).

That presents itself with a lot of other issues, however, as the
char-based file APIs were only designed to handle up to double-byte
characters. To implement proper Unicode file name support on Windows,
one need to use the "wide" APIs (using wchar_t).

Using those APIs, it does not matter what locale the system is set to.
Everything is then UTF-16, which is trivially converted to and from
UTF-8 (and there are even native APIs to do it if one can't be bothered
to write code for it).

I have been meaning to check out a copy of the Msysgit source tree and
see how difficult it would be to replace the file API layer with proper
Unicode support, but time keeps fleeing from me, so I never seem to get
around to :-/

-- 
\\// Peter - http://www.softwolves.pp.se/
