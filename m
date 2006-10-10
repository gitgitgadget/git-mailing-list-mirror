From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 11:00:41 +0200
Organization: At home
Message-ID: <egfndo$lg6$1@sea.gmane.org>
References: <20061010025627.19317.70511.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 10 11:01:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXDTW-0004Ny-Oz
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 11:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWJJJAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWJJJAW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 05:00:22 -0400
Received: from main.gmane.org ([80.91.229.2]:34541 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965113AbWJJJAV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 05:00:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXDT5-0004Gm-Be
	for git@vger.kernel.org; Tue, 10 Oct 2006 11:00:08 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 11:00:07 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 11:00:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28620>

Petr Baudis wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
print $_ while (<$fd>);

Wouldn't it be better to do it in slurp mode, i.e.

        {
                local $/
                print <$fd>;
        }

instead?

Do you assume that README is HTML fragment? If not, you should esc_html=
 it.
Besides, we have similar (if assumed to have one line only) file, namel=
y
description.

Besides, README for a project can be huge. Git README has 589 lines!
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
