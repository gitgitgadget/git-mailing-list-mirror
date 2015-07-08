From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Wed, 08 Jul 2015 22:56:23 +0200
Message-ID: <559D8E77.60401@kdbg.org>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl> <20150707141305.GA629@peff.net> <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl> <20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org> <20150708180539.GA12353@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:56:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCwON-0000gR-3W
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759129AbbGHU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:56:26 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:23024 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759127AbbGHU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:56:25 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mRXx36D9bz5tlB;
	Wed,  8 Jul 2015 22:56:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8ABC2519D;
	Wed,  8 Jul 2015 22:56:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150708180539.GA12353@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273711>

Am 08.07.2015 um 20:05 schrieb Jeff King:
> We also don't write objects directly, of course; we write to a temporary
> file and try to link them into place. It really sounds more like the
> "objects/d9" directory is where the permission problems are. But, hmm...

Not on Windows: A read-only file cannot be overwritten or removed, 
regardless of the permissions of the directory. We do treat this case 
mingw_rename, but I have a slight suspicion that this does not work 
sufficiently reliably on networked file systems.

-- Hannes
