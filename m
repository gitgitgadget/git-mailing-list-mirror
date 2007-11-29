From: Romain Francoise <romain@orebokech.com>
Subject: git-fetch ansi control sequences
Date: Thu, 29 Nov 2007 21:10:19 +0100
Organization: orebokech dot com
Message-ID: <87prxs6ces.fsf@elegiac.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 21:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxpsY-0008UA-C6
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 21:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934030AbXK2UUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 15:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934024AbXK2UUK
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 15:20:10 -0500
Received: from main.gmane.org ([80.91.229.2]:58825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934019AbXK2UUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 15:20:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ixpre-0004pr-7R
	for git@vger.kernel.org; Thu, 29 Nov 2007 20:20:02 +0000
Received: from home.orebokech.com ([82.67.41.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 20:20:02 +0000
Received: from romain by home.orebokech.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 20:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: home.orebokech.com
X-Face: }9mYu,e_@+e!`Z-P5kVXa3\_b:hdJ"B)ww[&=b<2=awG:GOIM</2q'*t@MNa)R`k0h1KbUu "Ek%gXCQA(?k=Uf9}qgF_x#7/+Ql\R!NJ9[Z[ky\CTYI<H(kc][?[m%*rsf!OG11|f&H[VgX;),"!N JG6IziY\~""3M
Cancel-Lock: sha1:ofN03TSmFljv70wNKLR+bL5uwuU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66560>

Running 'git fetch' in a dumb terminal (like an Emacs shell buffer)
now outputs raw control sequences, which isn't particularly pretty:

| remote: Generating pack...^[[K
| remote: Done counting 4044 objects.^[[K
| remote: Result has 2577 objects.^[[K
| remote: Deltifying 2577 objects...^[[K
| remote:
| remote: Total 2577 (delta 2150), reused 2457 (delta 2044)^[[K

It would be easy to make recv_sideband() check if the terminal is
dumb, but I have a feeling that the sideband code shouldn't have to
know about such things, being rather generic.

What do people think?
