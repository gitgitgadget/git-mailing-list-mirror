From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 22:49:10 +0200
Message-ID: <85y7h6dewp.fsf@lola.goethe.zz>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4qK-0001gx-P4
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXGWUtU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762124AbXGWUtT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:49:19 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:53702 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759459AbXGWUtS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:49:18 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 1718927B3D4;
	Mon, 23 Jul 2007 22:49:17 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 04C9C28EC28;
	Mon, 23 Jul 2007 22:49:17 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-048-096.pools.arcor-ip.net [84.61.48.96])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id D60CB1CB762;
	Mon, 23 Jul 2007 22:49:16 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E8D0B1C002B7; Mon, 23 Jul 2007 22:49:10 +0200 (CEST)
In-Reply-To: <87ps2inab5.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "Mon\, 23 Jul 2007 21\:18\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53482>

Nix <nix@esperi.org.uk> writes:

> On 19 Jul 2007, David Kastrup stated:
>> Tomash Brechko <tomash.brechko@gmail.com> writes:
>>> Please consider this: I myself use Git to track my own local
>>> projects, and for this usage you proposal have no value for me,
>>> i.e. as a _Source_ Code Management system Git is rather complete.
>>> But I also track /etc and ~/ in Git, and for this I'd love to have
>>> directories, permissions, ownership, other attributes, to be
>>> tracked.  I have Perl script wrapping Git that allows me to filter
>>> tracked paths by full regexps instead of Git's file globs, and also
>>> to filter out too big files assuming that they are binary anyway.
>>
>> Look, git _tracks_ contents.  Your permissions managements needs to
>> be told explicitly when and how things change.  So you end up with
>> git _tracking_ material and your permissions/directory management
>> needing the level of manual handholding Subversion demands.
>
> Actually, if we had a post-checkout hook, we could use a pre-commit
> hook to keep track of directory existence, permissions, et seq, and
> a post- checkout hook to restore them.

Actually, tracking permissions would be cheap: one just needs to
replace the permission-munging macros in git with identity.  Ownership
-- well, that's harder.

But my sentiment remains: git _tracks_ stuff: it notices when things
move around and follows them.  Statically snapshotting permissions
creates a layer that is quite less flexible.  The information gets
detached.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
