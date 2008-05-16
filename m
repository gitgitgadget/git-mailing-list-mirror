From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 16:05:57 +0200
Message-ID: <861w42wdh6.fsf@lola.quinscape.zz>
References: <482BE5F7.2050108@thorn.ws>
	<alpine.DEB.1.00.0805161139530.30431@racer>
	<alpine.DEB.1.00.0805161148010.30431@racer>
	<alpine.DEB.1.00.0805161403130.30431@racer>
	<32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 16:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0aM-0000Eo-Vu
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbYEPOGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbYEPOGN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:06:13 -0400
Received: from main.gmane.org ([80.91.229.2]:45868 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbYEPOGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:06:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jx0ZR-0005Aw-CW
	for git@vger.kernel.org; Fri, 16 May 2008 14:06:05 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:06:05 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:06:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:kOnBI2Q2sDXWmfK/NbXzEsyKCqc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82290>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>         BTW I do not know how much fgetc() instead of fgets() slows
>>         down things, but I expect both to be equally fast because
>>         they are both buffered, right?
>
> In my experience, fgetc() is pretty fantastically slow because you
> have a function call for every byte (and, I gather, modern libc does
> thread locking for every fgetc).  It's usually much faster to fread()
> into a buffer and then access the buffer.  I don't know if that's
> appropriate (or matters) here, though.

Is getc an option?

-- 
David Kastrup
