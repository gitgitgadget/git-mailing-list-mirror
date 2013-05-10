From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of
 auto-merges
Date: Fri, 10 May 2013 06:41:30 +0100
Message-ID: <20130510054130.GA29215@hashpling.org>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
 <1368090810-40596-2-git-send-email-davvid@gmail.com>
 <7vli7ob0c4.fsf@alter.siamese.dyndns.org>
 <20130509172334.GK25912@serenity.lan>
 <7v38tw9d7r.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4S6=U1d1fWixaiAzf46KLBDNsi85fgvXy0Uu_aRJyoyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 07:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UagBN-0003ep-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 07:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab3EJFri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 01:47:38 -0400
Received: from avasout06.plus.net ([212.159.14.18]:53584 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3EJFrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 01:47:37 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2013 01:47:36 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id a5hW1l0072iA9hg015hXKA; Fri, 10 May 2013 06:41:32 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=YbCEuWhf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=43sm8_qVhh4A:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=Ew9TdX-QAAAA:8 a=QYcJVrp4qakA:10
 a=YJRR7J0FMZm6UIha44AA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1Uag5C-0007nP-LS; Fri, 10 May 2013 06:41:30 +0100
Content-Disposition: inline
In-Reply-To: <CAJDDKr4S6=U1d1fWixaiAzf46KLBDNsi85fgvXy0Uu_aRJyoyw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223814>

On Thu, May 09, 2013 at 03:17:30PM -0700, David Aguilar wrote:
> Generally, "mergetool.<tool>.cmd" is not general enough since we've
> always special cased the base vs. no-base code paths and we run
> different commands depending on whether a base is available.

Then this is a deficiency of the ".cmd" mechanism which should provide
an "if all else fails" way to do things, even if ugly. We could simply
add a BASELESS variable to the eval environment of the custom command.
(Do we always create an empty file for $BASE, now?)

> We could drop --auto altogether, which maybe is a better course of
> action since it makes the behavior predictable and un-surprising, but
> I do not know if anyone has come to rely on kdiff3's "auto-merge"
> feature (hence the extended Cc: list).

I disagree, I think that a mergetool should be allowed to be as
helpful as possible and if it can resolve the merge unaided then this
is no bad thing. I've worked with a number of people who were very
happy with the current kdiff3 behaviour. Nothing prevents you from
verifying the merge and fixing it up if it wasn't done perfectly by
the tool, although I haven't ever encountered this with git+kdiff3.

Charles.
