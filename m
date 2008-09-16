From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 17:25:46 -0600
Message-ID: <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:27:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfjwc-0008IS-Km
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbYIPXZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYIPXZs
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:25:48 -0400
Received: from suse104.zenez.com ([198.60.105.164]:27130 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYIPXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:25:47 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id EA7A1A7C8E3; Tue, 16 Sep 2008 17:25:46 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id DC5B3A7C8E1;
	Tue, 16 Sep 2008 17:25:46 -0600 (MDT)
In-Reply-To: <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96045>

Hello,

On Tue, 16 Sep 2008, Brandon Casey wrote:
> Arjen Laarhoven wrote:
>> The standard libc regex library on OSX does not support alternation
>> in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
>> functionality on OSX.
>>
>> To fix this, we use the GNU regex library which is already present in
>> the compat/ diretory for the MinGW port.  However, simply adding compat/
>> to the COMPAT_CFLAGS variable causes a conflict between the system
>> fnmatch.h and the one present in compat/.  To remedy this, move the
>> regex and fnmatch functionality to their own subdirectories in compat/
>> so they can be included seperately.
>
> I wonder if this is the right fix? Right now the GNU regex library is
> necessary for Darwin, FreeBSD and AIX. I can add IRIX6.5 and Solaris 7
> to that list. Have newer Solaris's been tested yet? (Jeff?) I wonder if
> the new test which triggers this flaw has been tested on the other
> non-GNU platforms in the Makefile which have not been updated. Boyd
> Lynn Gerber and his 12 platforms comes to mind.
>
> It seems POSIX only mentions alternation under Extended Regular Expressions.
> Likewise for the vertical-line character '|'.

Someone forwarded me this email and asked if I had tested it.  I have not. 
Where is the easiest place to get it to test with the various platforms? 
I will check it out on 3-5 of them.  I now have 1.6.0.2 on 5 platforms 
running and working.  I have not had the time to get it on the other's 
yet.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
