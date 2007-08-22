From: Jon Loeliger <jdl@freescale.com>
Subject: Re: "git pull REMOTE" question
Date: Wed, 22 Aug 2007 11:44:23 -0500
Message-ID: <1187801063.15321.4.camel@ld0161-tx32>
References: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
	 <7vy7g4jids.fsf@gitster.siamese.dyndns.org>
	 <buo8x84kwkq.fsf@dhapc248.dev.necel.com>
	 <7vtzqsjgq2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INtLi-00026a-0J
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763578AbXHVQqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763493AbXHVQqO
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:46:14 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:43035 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763429AbXHVQqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:46:13 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l7MGiOaF021256;
	Wed, 22 Aug 2007 09:44:24 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l7MGiOST020919;
	Wed, 22 Aug 2007 11:44:24 -0500 (CDT)
In-Reply-To: <7vtzqsjgq2.fsf@gitster.siamese.dyndns.org>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56398>

On Wed, 2007-08-22 at 00:11, Junio C Hamano wrote:

> So, how about extending the syntax for [branch $current_branch]
> section of the config like this?
> 
>  ;; traditional -- when on "master", use '[remote "origin"] url'
>  ;; and '[remote "origin"] fetch' to decide where to fetch from,
>  ;; and merge their refs/heads/master to our branch.
>  [branch "master"]
>  	remote = origin
>         merge = refs/heads/master
> 
>  ;; new -- when on "master', and the user says to pull from "usb"
>  ;; without saying which branch to merge, use '[remote "usb"] url'
>  ;; and '[remote "usb"] fetch' to decide where to fetch from,
>  ;; and merge their refs/heads/xprm to our branch.
>  [branch "master:usb"]
>  	merge = refs/heads/xprm
> 
> The trick in the new syntax is that you cannot have a colon in
> refname, so there is no way for existing [branch $name] section
> to crash with the new style definition.

Wasn't there was a brief alternate notion to add a "for <remote>"
clause and allowing something like this?:

    [branch "master"]
        merge = refs/heads/xprm for usb
        merge = refs/heads/stuff for otherremote

Thanks,
jdl
