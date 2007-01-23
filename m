From: Bill Lear <rael@zopyra.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 14:12:30 -0600
Message-ID: <17846.27694.845530.663964@lisa.zopyra.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
	<Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.20498.635623.173653@lisa.zopyra.com>
	<Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 21:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9S0j-0008Ov-I0
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbXAWUMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933141AbXAWUMq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:12:46 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61744 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932954AbXAWUMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 15:12:45 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0NKCg732497;
	Tue, 23 Jan 2007 14:12:42 -0600
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37564>

On Tuesday, January 23, 2007 at 20:12:36 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Tue, 23 Jan 2007, Bill Lear wrote:
>
>> I can't seem to get this to work, no matter what I do, using the latest 
>> 1.5.0-rc2 code.  I have the environment variables LESS, PAGER, 
>> PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through my 
>> screen each time it is run, no matter the combinations...  Could someone 
>> post the magic?
>
>Try this:
>
>	PAGER=less LESS=-FRS git diff

Replied to Johannes off-line and thought this was working --- sorry
for the false positive.  It is in one regard: it completely suppresses
output if there is less than a full screen of output.

If I do this:

% export PAGER=less
% unset LESS
% git diff

I get 30 lines of output in my current repository, as I should.

If I then do this:

% LESS=-FRS git diff

I get nothing --- I do see a brief blink of output, but it's as if
less swallows it whole and I see nothing but the next prompt.

Hmmm ... I do seem to be using a rather old version of less:

% less --version
less 382
Copyright (C) 2002 Mark Nudelman

Could this be the culprit?  Will try and see...  Nope, downloaded,
built, and installed less-394 and I still see the same problem.  I also
see this problem when I do 'man git-gc', for example --- the manpage
just disappears.

If I set LESS to '-F' it fails.  If set to '-RS', output is seen but
then I see the screen blanked when there is no output from git diff.

This is on Centos 4.3.  I have not yet tried this on my Fedora Core 6
laptop, at home...



Bill
