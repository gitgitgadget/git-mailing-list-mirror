From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Mon, 1 Jul 2013 08:12:40 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1307010811090.21709@ds9.cixit.se>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jul 01 09:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtYIU-0003Wk-9G
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 09:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab3GAHNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 03:13:10 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:33164 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752457Ab3GAHNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 03:13:09 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r617CfJb022449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Jul 2013 09:12:41 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r617CeXA022446;
	Mon, 1 Jul 2013 09:12:41 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 01 Jul 2013 09:12:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229294>

brian m. carlson:

> +		/* Check the value here */
> +		if (codepoint >= 0xd800 && codepoint <= 0xdfff)
> +			return bad_offset;

if ((x & 0xFFFFF800) == 0xD800)

is slightly shorter, albeit a bit more difficult to read.

Please also consider adding some commentary as to what you are 
checking here, as it is not obvious unless you know Unicode well.

-- 
\\// Peter - http://www.softwolves.pp.se/
