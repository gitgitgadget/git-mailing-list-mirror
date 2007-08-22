From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fixed non portable use of expr, and incorrect use of test -eq for string comparison.
Date: Wed, 22 Aug 2007 14:21:40 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070822122140.GB11926@informatik.uni-freiburg.de>
References: <11877841633473-git-send-email-david@olrik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Jack Olrik <david@olrik.dk>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INpDZ-0007oD-RB
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbXHVMVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 08:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757866AbXHVMVq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:21:46 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44115 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757679AbXHVMVq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 08:21:46 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1INpDV-00059G-1Y; Wed, 22 Aug 2007 14:21:45 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7MCLer4012165;
	Wed, 22 Aug 2007 14:21:40 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7MCLeKe012164;
	Wed, 22 Aug 2007 14:21:40 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11877841633473-git-send-email-david@olrik.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56373>

Hello,

David Jack Olrik wrote:
> -	if test "`expr index $httpd_only /`" -eq '1' || \
> +	if test "`echo $httpd_only | cut -c 1`" =3D '/' || \
>  				which $httpd_only >/dev/null

I wonder why not use:

	if expr "z$httpd_only" : "z/" >/dev/null

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
