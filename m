From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Tue, 19 Feb 2008 07:55:00 +1300
Message-ID: <47B9D484.1020304@catalyst.net.nz>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802181627340.30505@racer.site> <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRB9l-0002od-SC
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYBRSzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYBRSzP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:55:15 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:38548 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYBRSzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 13:55:13 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JRB8r-0004GF-0q; Tue, 19 Feb 2008 07:55:05 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74331>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> The script uses File::Basename upfront so perhaps just simply...
>> I tried that.  But as the file need not exist, "basename" went on strike.
>>
>> So I'll keep the (ugly) version.

?! basename() never touches the disk. I just read it to confirm -
$VERSION is 2.74 and I'm somewhat disappointed to find it's not as
portable as I'd expect (perhaps it gets hardcoded during install?).

And my /usr/bin/basename doesn't care if the file exists either

  $ type basename
  basename is /usr/bin/basename
  $ basename /foo/bar/baz
  baz
  $ stat /foo/bar/baz
  stat: cannot stat `/foo/bar/baz': No such file or directory

So I am fairly confident that we can safely use File::Basename's
basename() on arbitrary strings that look like a path. We use basename()
quite a bit in our perl scripts in git.

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
