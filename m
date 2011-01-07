From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 20:52:18 +0200
Message-ID: <20110107185218.GA16645@LK-Perkele-VI.localdomain>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:52:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHQB-0003DP-ER
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab1AGSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:52:13 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42416 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1AGSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:52:12 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 3980BC7C49;
	Fri,  7 Jan 2011 20:52:11 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05262F3152; Fri, 07 Jan 2011 20:52:10 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 4D50127D84;
	Fri,  7 Jan 2011 20:52:05 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20110107053119.GA23177@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164740>

On Fri, Jan 07, 2011 at 12:31:19AM -0500, Jeff King wrote:
> 
>   3. people on low-bandwidth servers who fork major projects; if I write
>      three kernel patches and host a git server, I would really like
>      people to only fetch my patches from me and get the rest of it from
>      kernel.org

One client-side-only feature that could be useful:

Ability to contact multiple servers in sequence, each time advertising
everything obtained so far. Then treat the new repo as clone of the last
address.

This would e.g. be very handy if you happen to have local mirror of say, Linux
kernel and want to fetch some related project without messing with alternates
or downloading everything again:

git clone --use-mirror=~/repositories/linux-2.6 git://foo.example/linux-foo

This would first fetch everything from local source and then update that
from remote, likely being vastly faster.

-Ilari
