From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 11:45:22 +0200
Message-ID: <200706121145.22699.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org> <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy2wS-000749-5h
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 11:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXFLJp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 05:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXFLJp3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 05:45:29 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:41341 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbXFLJp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 05:45:29 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 12EEA217D;
	Tue, 12 Jun 2007 11:45:27 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49940>

On Tuesday 12 June 2007, Lars Hjemli wrote:
> This is somewhat intentional. I want to move the submodule repos into
> .git/submodules/$name/ (with working dir) and symlink this directory
> when 'checking out' the submodule. This would be a simple solution for
> the following problems:
>   -keeping submodule modifications between checkouts
>   -having submodules within submodules

Interesting idea.

How does this work
(1) if the submodule checkout changes with the supermodule checkout?
You still would have to store the modifications somewhere.
(2) on platforms which do not allow symlinks

A workaround for problem (1) would be to create multiple checkouts of the
same submodule if modified, e.g. in .git/submodule/$name/$sha1 .
 
Allowing people to work like that is nice, but it should not be forced.
It would also be nice to allow the user to specify another place where
submodule checkouts are to be stored, e.g. when multiple supermodules
share the same submodule.

Josef

> 
> Multiple checkout paths for a single submodule will bring havoc on
> this plan, so I need to ask: what is the use-case for multiple
> checkout paths?
> 
