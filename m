From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] New strbuf APIs: splice and attach.
Date: Mon, 17 Sep 2007 07:43:30 +0200
Message-ID: <87myvlzw1p.fsf@mid.deneb.enyo.de>
References: <20070916172134.GA26457@artemis.corp>
	<20070916172233.8B8AD1835F@madism.org>
	<874phugy6h.fsf@mid.deneb.enyo.de>
	<20070916205136.GE26457@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX9OU-0007PA-SG
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 07:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXIQFnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbXIQFne
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 01:43:34 -0400
Received: from mail.enyo.de ([212.9.189.167]:4077 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbXIQFne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 01:43:34 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IX9OO-0004cW-IY; Mon, 17 Sep 2007 07:43:32 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IX9OM-00029F-16; Mon, 17 Sep 2007 07:43:30 +0200
In-Reply-To: <20070916205136.GE26457@artemis.corp> (Pierre Habouzit's message
	of "Sun, 16 Sep 2007 22:51:36 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58390>

* Pierre Habouzit:

> On Sun, Sep 16, 2007 at 08:20:06PM +0000, Florian Weimer wrote:
>> * Pierre Habouzit:
>> 
>> > +void strbuf_grow(struct strbuf *sb, size_t extra)
>> > +{
>> >  	if (sb->len + extra + 1 <= sb->len)
>> >  		die("you want to use way too much memory");
>> 
>> By the way, this comparison is always false because sb->len is signed.
>
>   News to me. Actually it's not, it's a size_t :)

Ah, then this has changed somewhere.  It used to be int.  Good.
