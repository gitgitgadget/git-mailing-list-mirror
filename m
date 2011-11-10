From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 02/14] http: turn off curl signals
Date: Thu, 10 Nov 2011 09:43:40 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111100941380.27581@tvnag.unkk.fr>
References: <20111110074330.GA27925@sigill.intra.peff.net> <20111110074803.GB27950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQF0-00035K-2O
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab1KJIoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:44:05 -0500
Received: from giant.haxx.se ([80.67.6.50]:51853 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456Ab1KJIoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 03:44:04 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id pAA8hfWl020090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Nov 2011 09:43:41 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id pAA8he6Y020086;
	Thu, 10 Nov 2011 09:43:40 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20111110074803.GB27950@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185221>

On Thu, 10 Nov 2011, Jeff King wrote:

> I'm a little iffy on this one. If I understand correctly, depending on the 
> build and configuration, curl may not be able to timeout during DNS lookups. 
> But I'm not sure if it does, anyway, since we don't set any timeouts.

Right, without a timeout set libcurl won't try to timeout name resolves.

To clarify: when libcurl is built to use the standard synchronous name 
resolver functions it can only abort them after a specified time by using 
signals (on posix systems).

-- 

  / daniel.haxx.se
