From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Thu, 22 May 2014 08:12:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405220809370.10958@ds9.cixit.se>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103301.GG30464@sigill.intra.peff.net> <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 09:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnNBi-0003Ub-6R
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 09:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbaEVHNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 03:13:09 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39410 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750841AbaEVHNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 03:13:07 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s4M7Cxpt011762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 May 2014 09:12:59 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s4M7CwJn011759;
	Thu, 22 May 2014 09:12:58 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 22 May 2014 09:12:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249878>

Kyle J. McKay:

> I think that a strict reading of RFC 2616 allows "text/plain ; charset=utf-8" 
> as well as "text/plain;charset=utf-8" and "text/plain; charset=utf-8".

It does indeed, and I have seen servers send both variants, so they do 
need to be catered for.

The number of servers that would actually send the charset attribute 
here (for error messages) are probably not that many. It is probably a 
good idea to make the default user-configurable (I know the specs 
state that anything undeclared is iso-8859-1, but the real world 
doesn't agree to that).

-- 
\\// Peter - http://www.softwolves.pp.se/
