From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Fri, 21 May 2010 15:45:02 -0500
Message-ID: <Bo_XNJQjQnJja3BLqR-rv4YxKSSFpcSLegtSIJn8boisM3ilazwT7w@cipher.nrlssc.navy.mil>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com> <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil> <4BD1B5E5.6030307@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri May 21 23:09:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFZT3-0004bz-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 23:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633Ab0EUVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 17:09:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56968 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0EUVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 17:09:07 -0400
X-Greylist: delayed 1435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2010 17:09:07 EDT
Received: by mail.nrlssc.navy.mil id o4LKj30g024734; Fri, 21 May 2010 15:45:03 -0500
In-Reply-To: <4BD1B5E5.6030307@spacetec.no>
X-OriginalArrivalTime: 21 May 2010 20:45:03.0118 (UTC) FILETIME=[7CCA32E0:01CAF926]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147495>


Hi Tor, I've been out of town for a few weeks...

On 04/23/2010 09:59 AM, Tor Arntsen wrote:
> On 03/31/10 18:29, Brandon Casey wrote:
> 
>> Can you run the test suite with this ksh?  If it suffers from
>> the same exit status behavior of ksh on IRIX and SunOS, then
>> I have a patch which allows the test suite to run.
> 
> I've run a test (make test -k) on Tru64 V5.1 on today's version of Git (08641d02) plus 
> your  ksh test patch. I haven't done any analysis yet of the tests which failed, but I'll
> start looking at some of them later (particularly the first one that failed, a 'tar'
> test).
> 
> Below is a diff between the output from a run on Linux and the Tru64 one
> (instead of a full log), just to illustrate which ones failed.

I skimmed through the log and it looks like the failures are mostly
related to tar and iconv.  Possibly your tar is too old, or does not
support some option that git is using.  The iconv failures related
to ISO8859-1 are a little strange since that encoding is very
common.  Some implementations of iconv can produce a listing of the
encodings that are supported.  You could check for support for ISO
8859-1.

Many of the other differences are just because some tests were skipped
on the Tru64 run that were not skipped on Linux.  The tests were skipped
because some required binary was missing, like gpg or cvs.

Looks like you were able to run most of the test suite which is good.

> (Is this log too much to post inline? If yes, then I'll use an attachment for any 
> future logs)

I think it was fine.

-brandon
