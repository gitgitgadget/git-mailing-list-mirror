From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 4 May 2012 17:12:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1205041710490.12158@tvnag.unkk.fr>
References: <4FA2B4D3.90809@seap.minhap.es> <20120504070802.GA21895@sigill.intra.peff.net> <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr> <20120504073913.GA22388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 17:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKBN-0000w7-JP
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716Ab2EDPM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 11:12:29 -0400
Received: from giant.haxx.se ([80.67.6.50]:44944 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758696Ab2EDPM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:12:28 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q44FC2Kr001748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2012 17:12:02 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q44FC0YO001621;
	Fri, 4 May 2012 17:12:01 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20120504073913.GA22388@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197027>

On Fri, 4 May 2012, Jeff King wrote:

> The absolute simplest way for us would be to stop using
> CURLOPT_PROXYUSERNAME/PASSWORD to set it ahead of time, and instead
> provide a callback that curl would call on a 407. That callback would
> just need the URL of the proxy, and would return the username/password
> (or even just set them on the curl object via
> CURLOPT_PROXYUSERNAME/PASSWORD).
>
> For that matter, it would simplify our code to do the same for regular http 
> auth, too. And though we usually know our URL in that case, we might not if 
> we got a 302 with FOLLOWLOCATION set.

Thanks a lot. That is in fact almost exactly the solution we're discussing 
right now.

-- 

  / daniel.haxx.se
