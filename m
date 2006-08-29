From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Starting to think about sha-256?
Date: Tue, 29 Aug 2006 08:17:02 +0200
Message-ID: <87fyfg83s1.fsf@mid.deneb.enyo.de>
References: <44F1DCB7.6020804@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 29 14:44:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI2wh-000310-Ub
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 14:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWH2Mnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWH2Mnz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 08:43:55 -0400
Received: from mail.enyo.de ([212.9.189.167]:23563 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932104AbWH2Mnz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 08:43:55 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1GI2we-0001o9-Cu
	for git@vger.kernel.org; Tue, 29 Aug 2006 14:43:56 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1GHwuE-0006WE-Qj
	for git@vger.kernel.org; Tue, 29 Aug 2006 08:17:02 +0200
To: git@vger.kernel.org
In-Reply-To: <44F1DCB7.6020804@garzik.org> (Jeff Garzik's message of "Sun, 27
	Aug 2006 13:56:07 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26204>

* Jeff Garzik:

> * likely more CPU cycles per hash, though I haven't measured.

According to a quick test using "openssl speed", it's a factor of two
to four, depending on the input size (the difference is less
pronounced for small input sizes).

> Maybe sha-256 could be considered for the next major-rev of git?

And in 2008, you'd have to rewrite history again, to use the next
"stronger" hash function?  Do you think that's really necessary or
desirable?  Most users will have good control over what data enters
their repositories, so they can spot the evil twins thanks to their
high-entropy contents.  Obviously, a second preimage attack would
mattr, but even for MD5, we aren't close to that one AFAIK.
