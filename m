From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 09:54:54 +0200
Message-ID: <87r6mpj9dd.fsf@mid.deneb.enyo.de>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	<20070730222028.GE64467@nowhere>
	<alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
	<85odht3xd1.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 09:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFmZI-0002jt-Kq
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXGaHy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 03:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbXGaHy6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 03:54:58 -0400
Received: from mail.enyo.de ([212.9.189.167]:4055 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbXGaHy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 03:54:57 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IFmZE-0001x5-4u
	for git@vger.kernel.org; Tue, 31 Jul 2007 09:54:56 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IFmZC-0002dp-TS
	for git@vger.kernel.org; Tue, 31 Jul 2007 09:54:54 +0200
In-Reply-To: <85odht3xd1.fsf@lola.goethe.zz> (David Kastrup's message of "Tue,
	31 Jul 2007 08:23:22 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54326>

* David Kastrup:

> a) one thread for opendir/readdir at every directory level
> b) one thread for stating the files in readdir order (more likely to
>    correspond to the disk layout than sorted order)

Not true for ext3.  You need to sort by the d_ino field.  This also
tends to be benefit other file systems more than readdir order.
