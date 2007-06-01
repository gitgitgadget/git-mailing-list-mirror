From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] catch asciidoc failures
Date: Fri, 1 Jun 2007 02:46:04 -0700
Message-ID: <FA77F6B4-2BC0-4714-9A82-749F70291BD0@slamb.org>
References: <11806790373908-git-send-email-slamb@slamb.org> <20070601083621.GB3521@admingilde.org> <20070601091030.GA2215@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	jonas.fonseca@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3i2-0006TH-F1
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbXFAJqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757351AbXFAJqK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:46:10 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:36822 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396AbXFAJqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:46:09 -0400
Received: from [172.16.1.4] (ppp-71-139-179-187.dsl.snfc21.pacbell.net [71.139.179.187])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 97ABD980AA;
	Fri,  1 Jun 2007 02:46:06 -0700 (PDT)
In-Reply-To: <20070601091030.GA2215@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48863>


On Jun 1, 2007, at 2:10 AM, Jeff King wrote:

>  %.html : %.txt
>  	rm -f $@+ $@
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
> -		$(ASCIIDOC_EXTRA) -o - $< | \
> -		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
> +		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
>  	mv $@+ $@

Hmm, now the $@+ intermediary shouldn't be necessary anymore - with "- 
o" it's asciidoc's responsibility to handle the output file correctly.

I think there's a lightbulb joke here somewhere. ;)

-- 
Scott Lamb <http://www.slamb.org/>
