From: Ludvig Strigeus <ludde@strigeus.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 08:56:08 +0000 (UTC)
Message-ID: <loom.20101015T105350-205@post.gmane.org>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org> <20101015051750.GA21830@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 11:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6g9I-0001vD-3i
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 11:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0JOJAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 05:00:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:49256 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab0JOJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 05:00:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6g8x-0001nk-V1
	for git@vger.kernel.org; Fri, 15 Oct 2010 11:00:03 +0200
Received: from static-212.214.122.232.addr.tdcsong.se ([212.214.122.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 11:00:03 +0200
Received: from ludde by static-212.214.122.232.addr.tdcsong.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 11:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.214.122.232 (Mozilla/5.0 (Windows; U; Windows NT 5.1; sv-SE; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159107>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> 
> Reimplement another handy convenience function from glibc.  memrchr()
> searches from the end of a memory area for a particular character.  It
> is similar to strrchr() but takes a length argument and is
> binary-safe.

System memrchr uses a byte comparison rather than an int comparison.

"The memchr() function scans the first n bytes of the memory area pointed to by
s for the character c. The first byte to match c (interpreted as an unsigned
character) stops the operation. "

See: http://linux.die.net/man/3/memrchr

It's a good idea to do the same thing for compatibility reasons.

/Ludde
