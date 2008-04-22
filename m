From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Don't force imap.host to be set when imap.tunnel is set
Date: Tue, 22 Apr 2008 10:11:59 +0100
Message-ID: <fuka50$pce$1@ger.gmane.org>
References: <200804211459.07527.andyparkins@gmail.com> <7vbq424c8f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 11:12:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEYc-0006k7-HI
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbYDVJMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbYDVJMM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:12:12 -0400
Received: from main.gmane.org ([80.91.229.2]:36975 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbYDVJMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:12:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoEXn-0002BU-EV
	for git@vger.kernel.org; Tue, 22 Apr 2008 09:12:07 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 09:12:07 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 09:12:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80085>

Junio C Hamano wrote:

> I am not an imap-send user myself, but is it the case that the use of
> imap.tunnel always makes imap.host useless/unnecessary and safe to be left
> as NULL?

You're right that it isn't guaranteed to be unnecessary, but equally it's
not guaranteed to be necessary - which is just the situation that an
optional configuration setting describes.

> Driving imapd standalone like the "tunnel" example you quoted above would
> trigger preauth behaviour, so that should be safe, but I suspect there are
> other ways to use tunnel to just relay the connection over the firewall,
> while still requiring the client to authenticate the same way as usual.

I'm sure you are correct, but as I say - it's not guaranteed.  Since
git-imap-send can't know what this particular tunnel requires it shouldn't
force the creation of a dummy option.  If the tunnel does require a
hostname then there is a place to put it, and the person writing the tunnel
line can decide that.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
