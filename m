From: Sebastian Pipping <webmaster@hartwork.org>
Subject: git clone against firewall
Date: Fri, 15 Jan 2010 00:45:53 +0100
Message-ID: <4B4FACB1.2080902@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZYq-00016M-EF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042Ab0ANX5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802Ab0ANX5E
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:57:04 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:58706 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab0ANX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:57:03 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 18:57:03 EST
Received: from [78.52.96.143] (helo=[192.168.0.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1NVZNy-0000Sq-6u
	for git@vger.kernel.org; Fri, 15 Jan 2010 00:45:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100103 Thunderbird/3.0
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137042>

hello!


with a firewall blocking outgoing connections to port 9418 a

  git clone git://...

of git 1.6.6 seems to never return, i.e. loop forever.  in my rather
automated environment (gentoo's tool layman calling git) this behavior
is rather troublesome - i need some kind of abort-and-error instead:
what i'm trying to do is loop over a number of clone URL alternatives of
the same repository like ..

  git://git.overlays.gentoo.org/dev/dberkholz.git
  http://git.overlays.gentoo.org/gitroot/dev/dberkholz.git
  git+ssh://git@git.overlays.gentoo.org/dev/dberkholz.git

.. and stop at the first clone that returns without error.

are there means to make git fail in such a case or to apply a timout?
if not please consider adding a related commandline option to git-clone.

thank you.



sebastian
