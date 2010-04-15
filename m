From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git fetch over http:// left my repo broken
Date: Thu, 15 Apr 2010 14:33:11 +0300
Message-ID: <20100415113310.GA24305@LK-Perkele-V2.elisa-laajakaista.fi>
References: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jan.sievers@sap.com,
	"Sohn, Matthias" <matthias.sohn@sap.com>,
	Shawn Pearce <spearce@spearce.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 13:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2NKx-0004G7-3I
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 13:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0DOLeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 07:34:17 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:42676 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0DOLeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 07:34:16 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 17CF9EBFA6;
	Thu, 15 Apr 2010 14:34:15 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05B490A78A; Thu, 15 Apr 2010 14:34:15 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id E1FA927D97;
	Thu, 15 Apr 2010 14:34:09 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144972>

On Thu, Apr 15, 2010 at 11:51:25AM +0200, Christian Halstrick wrote:
> Hi,
> 
> some days back I fetched from a github repo with http protocol and
> afterwards my local repo was broken. Since the fetch was done by a
> cronjob I don't know whether the fetch reported an error. Problem is
> that one pack file was corrupted because the github servers put the
> repo I wanted to clone into some maintenance mode while I was
> fetching. The pack file includes at the end the html source code -
> which makes these files clearly corrupted.
> 
> Git should detect this error and let the fetch fail, right?

At least with smart transports do verify pack hash (since 
git-index-pack does check it).

Maybe dumb HTTP transport grabs the index and pack and installs
the downloaded versions (FAIL) instead of generating index from
the pack (which would noitice the corruption)...

-Ilari
