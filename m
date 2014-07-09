From: Eric Wong <normalperson@yhbt.net>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule
 test harness
Date: Wed, 9 Jul 2014 20:00:46 +0000
Message-ID: <20140709200046.GB17454@dcvr.yhbt.net>
References: <539DD029.4030506@web.de>
 <53B41D42.2090805@web.de>
 <53B46425.3030000@web.de>
 <53B4F0AA.10809@web.de>
 <53B5C7AC.4040701@web.de>
 <xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
 <53BAF7AF.4020901@web.de>
 <53BC47BD.1000705@web.de>
 <53BC53C3.1010304@ramsay1.demon.co.uk>
 <53BCE3A7.8070600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4yBN-0001ye-HH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 22:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbaGIUJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 16:09:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36957 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaGIUJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 16:09:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0CB44C1B7;
	Wed,  9 Jul 2014 20:00:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <53BCE3A7.8070600@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253146>

Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> (And why is it  "& 07777" and not  "& 0777")

This is to preserve the uncommon sticky/sgid/suid bits.  Probably not
needed, but better to keep as much intact as possible.

> Can we avoid the fchmod()  all together ?

=46or single-user systems, sure.

=46or multi-user systems with git-imap-send users and passwords in
$GIT_CONFIG, I suggest not.
