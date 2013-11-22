From: =?UTF-8?Q?Odin=20H=C3=B8rthe=20Omdal?= <odinho@opera.com>
Subject: git submodule update needs to be at the toplevel of working tree, why?
Date: Fri, 22 Nov 2013 14:22:30 +0100
Message-ID: <1385126550.10973.50760825.6B70B959@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 22 14:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjqpy-000659-4I
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 14:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666Ab3KVNby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 08:31:54 -0500
Received: from smtp.opera.com ([213.236.208.81]:54117 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505Ab3KVNbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Nov 2013 08:31:53 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2013 08:31:53 EST
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com [66.111.4.228])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id rAMDMVtv007841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 22 Nov 2013 13:22:33 GMT
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 32BFF20A5F
	for <git@vger.kernel.org>; Fri, 22 Nov 2013 08:22:31 -0500 (EST)
Received: from web2 ([10.202.2.212])
  by compute6.internal (MEProxy); Fri, 22 Nov 2013 08:22:31 -0500
Received: by web2.nyi.mail.srv.osa (Postfix, from userid 99)
	id 03E4B54006F; Fri, 22 Nov 2013 08:22:30 -0500 (EST)
X-Sasl-Enc: u1ZcX8ko9xOJqfKFSF1dtVtrsMcGat8wrxCzXvXmMIaQ 1385126550
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3f1150ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238186>

Hi,

I'm usually in a subfolder doing actual work. A very common problem I
have is wanting to do a submodule update, but git really hates that. An=
d
I wonder why?

It wouldn't be hard to cd to the toplevel working directory, do the
update, and cd back. It's what I have to do manually every time now
already:


  $ git submodule update
  You need to run this command from the toplevel of the working tree.

  $ cd ../..

  $ git submodule update
  Submodule path 'myproject/libs/external-module': checked out
  '434fdf32a7add62...

  $ cd -


I see that it comes from git-sh-setup, so no rationale for this rather
weird and surprising behavior is given in the git-submodule file. :)

--=20
  Odin H=C3=B8rthe Omdal
  odinho@opera.com
