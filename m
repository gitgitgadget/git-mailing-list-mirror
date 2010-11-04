From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] docs: clarify git diff modes of operation
Date: Thu, 4 Nov 2010 16:50:56 -0500
Message-ID: <20101104215056.GA18475@burratino>
References: <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net>
 <20101104183851.GA16865@burratino>
 <20101104185545.GB31016@sigill.intra.peff.net>
 <87d3qkhm3d.fsf@gmail.com>
 <20101104204304.GA4641@sigill.intra.peff.net>
 <20101104211729.GA5551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7iQ-00011w-AC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab0KDVvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:51:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45497 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab0KDVvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:51:21 -0400
Received: by qwf7 with SMTP id 7so1734584qwf.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QLkaPI+NyxWtPuI5HsFGUIw6OXw3jkLSS4a/xz+SX1M=;
        b=sfVYXbVwZod6jKDZrFEh++K01yYsauVO4xP91ztj+9KzIWX1xBUnMHIuMctpZFgvKk
         HhWuQHluHPlOhSl70Wmev+0dPdL41Rl+i1YK6wr0iQrImnXH791s39o81tr9SU27ZQAa
         oSpmwb83H770TjOy8sRxaKrJfAuU7jlw408Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k6935AcSK4yXDfpU0Vv83VaPVoZ4jsrIq7XfUHsbofrzeNTXUPOKnqfQ9R8iCsdKKS
         Ic65YIDk1ZZQRMxLlEBpevv+QAY1tPe9Pgik1zDz0DIpeYg68rBJzjMWbJ5Q7civnL3t
         LpMGIRkmMDHgAoPoFCHDxxStxI8FWX29fXetA=
Received: by 10.224.200.195 with SMTP id ex3mr285359qab.74.1288907480590;
        Thu, 04 Nov 2010 14:51:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm451375qcp.8.2010.11.04.14.51.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 14:51:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101104211729.GA5551@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160778>

Jeff King wrote:

> Jonathan, does this look ok based on our earlier discussion?

Yep, it's way better than the current state.

The list of operation modes still seems wrong: in addition to
the meaning of

	git diff --cached

from an unborn branch not fitting the model of implicit HEAD
as mentioned before, there is also

	git diff

not meaning the same thing as

	git diff HEAD

.  So I guess technically the separate operation modes are

	git diff [--cached]
	git diff [--cached] <tree>
	git diff <tree> <tree>
	git diff --no-index <path> <path>
	git diff <blob> <blob>

where --cached means "use the version of the work tree stored
in the index in place of the real thing".
