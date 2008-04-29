From: Timur Tabi <timur@freescale.com>
Subject: Re: git-send-email: Skipping  - not found.
Date: Tue, 29 Apr 2008 15:09:35 -0500
Message-ID: <4817807F.9020508@freescale.com>
References: <48163E6C.60104@freescale.com> <20080429200619.GA20509@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:10:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqw9s-0003AJ-SC
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761481AbYD2UJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761457AbYD2UJt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:09:49 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:53016 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761415AbYD2UJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:09:48 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m3TK9akH028016;
	Tue, 29 Apr 2008 13:09:37 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3TK9aa7017002;
	Tue, 29 Apr 2008 15:09:36 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.13) Gecko/20080313 SeaMonkey/1.1.9
In-Reply-To: <20080429200619.GA20509@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80724>

Jeff King wrote:

>> git-send-email  --from Timur Tabi <timur@freescale.com> --suppress-cc=all --to
>> timur@tabi.org --smtp-server remotesmtp.freescale.net
>> 0001--PATCH-Update-CS4270-driver-to-ASoC-V2.patch
> 
> Surely that is not the command you issued, since it lacks shell quoting
> around your name and email address.

You're right.  It's the output from an "echo" command in a shell script, which
likes to remove quotation marks.  I keep forgetting that it does that.

> Yes, that is what is producing the error message. But that is the first
> time we ever look at @ARGV, let alone modify it. So the error is almost
> certainly caused by a blank argument being passed on the command line.

Right again!  I did a more through check of the command-line arguments, and I am
sending '' as one argument on the command line.

I just rewrote my script so that it doesn't ever send a null argument.  Thanks
for the help.

-- 
Timur Tabi
Linux kernel developer at Freescale
