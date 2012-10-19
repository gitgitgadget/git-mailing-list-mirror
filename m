From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 19:08:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1210191907020.17638@tvnag.unkk.fr>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com> <7vd30fl736.fsf@alter.siamese.dyndns.org> <20121019103627.GA29366@sigill.intra.peff.net> <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	szager@google.com, git@vger.kernel.org, sop@google.com
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPGFY-0000F1-48
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 19:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233Ab2JSRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 13:20:26 -0400
Received: from giant.haxx.se ([80.67.6.50]:59716 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab2JSRU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 13:20:26 -0400
X-Greylist: delayed 728 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2012 13:20:25 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q9JH82QA002873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Oct 2012 19:08:02 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q9JH82El002869;
	Fri, 19 Oct 2012 19:08:02 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208053>

On Fri, 19 Oct 2012, Shawn Pearce wrote:

> The issue with the current code is sometimes when libcurl is opening a 
> CONNECT style connection through an HTTP proxy it returns a crazy high 
> timeout (>240 seconds) and no fds. In this case Git waits forever.

Is this repeatable with a recent libcurl? It certainly sounds like a bug to 
me, and I might be interested in giving a try at tracking it down...

-- 

  / daniel.haxx.se
