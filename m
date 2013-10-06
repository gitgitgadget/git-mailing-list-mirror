From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 17:00:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net> <20131006105013.GA24950@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Oct 06 17:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSpyX-0001OM-Uz
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 17:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab3JFPK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 11:10:26 -0400
Received: from giant.haxx.se ([80.67.6.50]:45816 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab3JFPKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 11:10:25 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2013 11:10:25 EDT
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r96F048E020704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Oct 2013 17:00:05 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r96F02MD020442;
	Sun, 6 Oct 2013 17:00:02 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131006105013.GA24950@LK-Perkele-VII>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235740>

On Sun, 6 Oct 2013, Ilari Liusvaara wrote:

>> GSS-Negotiate authentication always requires a rewind with CURL.

> Isn't 'Expect: 100-Continue' meant for stuff like this (not that it is 
> always supported properly)?

Yes it is and libcurl uses 100-Continue by default for that purpose. But the 
harsh reality is that lots of (most?) servers just don't care and aren't setup 
to respond properly and instead we end up having to send data multiple times 
in vain.

-- 

  / daniel.haxx.se
