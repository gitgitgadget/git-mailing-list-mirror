From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/4] fix hang in git push when pack-objects fails
Date: Thu, 31 Mar 2011 22:45:38 +0200
Message-ID: <201103312245.38987.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5OkZ-0007rl-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 22:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab1CaUpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 16:45:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:37496 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753303Ab1CaUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 16:45:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5D151CDF82;
	Thu, 31 Mar 2011 22:45:32 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 16B8519F5F5;
	Thu, 31 Mar 2011 22:45:39 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170528>

On Donnerstag, 31. M=C3=A4rz 2011, Jeff King wrote:
> =C2=A0 1. do nothing. I'm not 100% sure why, but the bug does not man=
ifest
> =C2=A0 =C2=A0 =C2=A0itself with pthreads. I don't know how it behaves=
 on win32.

The reason might be that with threads we carefully close file descripto=
rs, so=20
that the other end sees EOF or broken pipe and terminates, while with a=
=20
forked sideband demux one of the channels remains open in the forked pr=
ocess?

-- Hannes
