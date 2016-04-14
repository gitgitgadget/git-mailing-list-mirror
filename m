From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Default authentication over https?
Date: Thu, 14 Apr 2016 11:46:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com> <20160413223613.GB10011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Isaac Levy <isaac.r.levy@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 11:46:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqdqw-0007Xs-9G
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 11:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcDNJqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 05:46:16 -0400
Received: from giant.haxx.se ([80.67.6.50]:58924 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbcDNJqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 05:46:15 -0400
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.15.2/8.15.2/Debian-3) with ESMTPS id u3E9k91e013231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Apr 2016 11:46:09 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id u3E9k9i4013226;
	Thu, 14 Apr 2016 11:46:09 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20160413223613.GB10011@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291519>

On Wed, 13 Apr 2016, Jeff King wrote:

> However, I don't think even that would give you what you want. Because I
> think that even if we provide a credential, curl will make an initial
> request (presumably to find out which auth type it should use, but that
> is just a guess). I don't know if there is a way to convince curl to
> stick the credential in the first request

curl supports this. but then you must do exactly that: tell libcurl to use 
that single auth method only. It will of course make it fail if you select the 
wrong method etc.

The unauthenticated first request is both to probe for which methods the 
server wants, but also works for the case when users provide credentials 
without the server actually ending up asking for them...

-- 

  / daniel.haxx.se
