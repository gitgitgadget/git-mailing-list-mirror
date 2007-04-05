From: John Gateley <gateley@jriver.com>
Subject: cg-admin-setuprepo
Date: Thu, 5 Apr 2007 11:56:53 -0500
Organization: J. River, Inc.
Message-ID: <20070405115653.b028db2c.gateley@jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 19:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZVNX-0007Ls-8W
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 19:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbXDERDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbXDERDk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 13:03:40 -0400
Received: from nm.jriver.com ([204.29.156.98]:43108 "HELO linux.jriver.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753317AbXDERDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 13:03:39 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2007 13:03:38 EDT
Received: (qmail 26666 invoked from network); 5 Apr 2007 16:56:57 -0000
Received: from unknown (HELO gateley.jriver.com) (199.242.131.137)
  by 0 with SMTP; 5 Apr 2007 16:56:57 -0000
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43842>

Hi,

I'm trying to do a cg-admin-setuprepo directory, and I'm getting
an error:

bash: line 12: syntax error near unexpected token `&&'
bash: line 12: `[[  --ee "/home/gateley/git/firewall.git""  ]]  &&&&  ddiiee "/home/gateley/git/firewall.gitt  aallrreeaaddyy  eexxiisstts""'

Looking at the source, the duplicated character problems happen here:

# Careful here, no cg-Xlib functions! Also, mind that the variables
# are substituted _before_ executing the script, not as we go. Which
# is somewhat unfortunate in case the user passed us a path containing
# quotes or backslashes, but only sick people do that and they receive
# what they deserve. ;-)
_git="$uri"
cat <<_SCRIPT_EOF_ | $shell $shellarg

die() { echo "$*" >&2; exit 1; }


The "$*" is where the doubled characters begin.
I'm not enough of a shell programmer to know what's happening.
Any ideas?

Thanks and please cc me on replies - I'm not on the mailing list yet...

j
