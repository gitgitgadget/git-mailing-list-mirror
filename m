From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] New strbuf APIs: splice and attach.
Date: Sun, 16 Sep 2007 22:20:06 +0200
Message-ID: <874phugy6h.fsf@mid.deneb.enyo.de>
References: <20070916172134.GA26457@artemis.corp>
	<20070916172233.8B8AD1835F@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 22:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX0bJ-0002e0-Fi
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXIPUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXIPUUN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 16:20:13 -0400
Received: from mail.enyo.de ([212.9.189.167]:3206 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXIPUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 16:20:10 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IX0bA-0000oe-5i
	for git@vger.kernel.org; Sun, 16 Sep 2007 22:20:08 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IX0b8-0004zx-TR
	for git@vger.kernel.org; Sun, 16 Sep 2007 22:20:06 +0200
In-Reply-To: <20070916172233.8B8AD1835F@madism.org> (Pierre Habouzit's message
	of "Sat, 15 Sep 2007 15:56:50 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58341>

* Pierre Habouzit:

> +void strbuf_grow(struct strbuf *sb, size_t extra)
> +{
>  	if (sb->len + extra + 1 <= sb->len)
>  		die("you want to use way too much memory");

By the way, this comparison is always false because sb->len is signed.
