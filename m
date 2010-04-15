From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git fetch over http:// left my repo broken
Date: Thu, 15 Apr 2010 14:43:19 +0300
Message-ID: <20100415114319.GA28326@LK-Perkele-V2.elisa-laajakaista.fi>
References: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
 <4BC6E343.2030105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	git@vger.kernel.org, jan.sievers@sap.com,
	"Sohn, Matthias" <matthias.sohn@sap.com>,
	Shawn Pearce <spearce@spearce.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 13:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2NUl-0001Tm-Fs
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 13:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab0DOLo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 07:44:26 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:51829 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab0DOLo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 07:44:26 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id E5B568C37C;
	Thu, 15 Apr 2010 14:44:24 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A075CBBC32A; Thu, 15 Apr 2010 14:44:24 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 953C7E51A5;
	Thu, 15 Apr 2010 14:44:18 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4BC6E343.2030105@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144973>

On Thu, Apr 15, 2010 at 11:58:27AM +0200, Michael J Gruber wrote:
> Christian Halstrick venit, vidit, dixit 15.04.2010 11:51:
> 
> But still, Git should be able to deal with broken servers. The problem
> is: If the server does not report any problem but simply serves a broken
> pack (with correct header), how should Git notice? It would require a
> fsck before accepting any new pack.

Pack trailer hash. Apparently dumb HTTP fetch needs to bypass pack to index
conversion somehow since index-pack aborts if trailer hash check fails (not
to mention other failures corrupt pack may cause).

-Ilari
