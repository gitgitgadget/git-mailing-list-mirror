From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] setup/rev-parse: allow HEAD to be spelled 'head'
Date: Sun, 07 Oct 2007 11:23:00 +1300
Message-ID: <47080AC4.3040902@catalyst.net.nz>
References: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz> <20071005065139.GA2623@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 00:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeIXM-0005Mt-RU
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 00:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763655AbXJFWyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763552AbXJFWyM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 18:54:12 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:34210 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762915AbXJFWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 18:54:12 -0400
X-Greylist: delayed 1864 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Oct 2007 18:54:11 EDT
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.104])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1IeI33-0000lg-SJ; Sun, 07 Oct 2007 11:23:01 +1300
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20071005065139.GA2623@steel.home>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60161>

Alex Riesen wrote:
> Sam Vilain, Fri, Oct 05, 2007 05:09:10 +0200:
>> If the repository got mangled by FAT capitalization rules, then a ref
>> such as "HEAD" will become "head" once it is back on a non-FAT FS.
>> Check for this condition in resolve_refs and in the setup code.
>>
>> Suggested-by: Francois Marier <francois@debian.org>
>> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
>> ---
>>   This should probably help people putting their git repos on
>>   FAT USB sticks.
> 
> Can the people just mount FAT partitions with shortname=mixed?

Of course, that is probably a solution to the problem, whereas my patch
is a workaround.

Now, I realise that this might open a can of worms ... would we also
want to go looking for files called "pack-ab~1.pac" ?  Almost certainly
not - but this solves the most immediate problem experienced by people
putting their git repositories onto FAT filesystems mounted with the
default options, which will say "FATAL: not a git repository" otherwise.

Sam.
