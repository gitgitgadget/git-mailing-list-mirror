From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 9/9] remote-curl: reencode http error messages
Date: Thu, 22 May 2014 08:26:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405220816050.10958@ds9.cixit.se>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103353.GI30464@sigill.intra.peff.net> <EF689296-BB9E-4734-A044-25DEF1874884@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 09:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnNPZ-0007di-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 09:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbaEVH02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 03:26:28 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51695 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752190AbaEVH02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 03:26:28 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s4M7QHib012278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 May 2014 09:26:17 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s4M7QHKc012275;
	Thu, 22 May 2014 09:26:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <EF689296-BB9E-4734-A044-25DEF1874884@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 22 May 2014 09:26:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249879>

Kyle J. McKay:

>> +	if (!*charset)
>> +		*charset = xstrdup("iso8859-1");
>
> Actually the name should be "ISO-8859-1".  See RFC 2616 section 3.7.1.  Since 
> it's case insensitive "iso-8859-1" would be fine too.

You'd be amazed at what you see in the wild... I'd recommend going 
with the recommended algorithm from WHATWG's Encoding Standard, if you 
want to make this robust: 
<http://encoding.spec.whatwg.org/#names-and-labels>.

The spec is partly based on a lot of research I made in my previous 
$DAYJOB, with a lot of research added by the spec writer.

There is also Unicode's attempt at it, but it does unfortunately 
produce too many false positives: <http://www.unicode.org/reports/tr22/tr22-7.html#Charset_Alias_Matching>

-- 
\\// Peter - http://www.softwolves.pp.se/
