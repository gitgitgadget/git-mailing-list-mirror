From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: problem building git 1.6.0 on SuSE
Date: Fri, 22 Aug 2008 13:47:30 +0200
Message-ID: <1KWV74-1aI9su0@fwd34.aul.t-online.de>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 13:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWV8H-0006Iv-N7
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 13:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYHVLrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 07:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYHVLrm
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 07:47:42 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:49358 "EHLO
	mailout04.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYHVLrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 07:47:41 -0400
Received: from fwd34.aul.t-online.de 
	by mailout04.sul.t-online.de with smtp 
	id 1KWV7D-0002vo-05; Fri, 22 Aug 2008 13:47:39 +0200
Received: from localhost (T5Alg0ZOwhRF+yRLOjise31kx8utu5rpIila6h0fx5nBs+pyLgle-wWUV3VFAdzZqr@[172.20.101.250]) by fwd34.aul.t-online.de
	with esmtp id 1KWV74-1aI9su0; Fri, 22 Aug 2008 13:47:30 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-2-10
X-ID: T5Alg0ZOwhRF+yRLOjise31kx8utu5rpIila6h0fx5nBs+pyLgle-wWUV3VFAdzZqr@t-dialin.net
X-TOI-MSGID: f01f01f7-2b43-4252-b3a1-ee7aa5211dd1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93284>

Hi,


I get the following errors when rpmbuild'ing git:

RPM build errors:
    File not found by glob:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/*svn*
    File not found by glob:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/*cvs*
    File not found:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/git-archimport
    File not found by glob:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/*email*
    File not found:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/git-gui
    File not found:
/var/tmp/git-1.6.0-1-root-michael/usr/lib64/git-core/git-citool

I have to replace %{_libexecdir} by /usr/libexec in git.spec to get
around this
problem. 

I guess the %{_libexecdir} macro's value is not respected 
everywhere in configure(.in) etc.

The reason may be that on my system rpm --eval %{_libexecdir} returns:
/usr/lib64
. 
While on others it may return /usr/libexec. And if /usr/libexec is used
somewhere
hard wired it won't show up that the value %{_libexecdir} is ignored.

Still I think this is potentially a general problem not only related to
SuSE.

I may take care of this problem at some later point when I have some
more time
to learn about the git's building and packaging internals. Maybe
somebody else
can do it quicker.

Cheers,
Michael
