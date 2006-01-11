From: Pavel Roskin <proski@gnu.org>
Subject: qgit shows wrong popup
Date: Wed, 11 Jan 2006 18:21:30 -0500
Message-ID: <1137021690.10975.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:21:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwpHf-0006iJ-HD
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 00:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWAKXVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 18:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWAKXVf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 18:21:35 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:29893 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932526AbWAKXVe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 18:21:34 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EwpFN-00084w-JI
	for git@vger.kernel.org; Wed, 11 Jan 2006 18:19:17 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EwpHW-0003Uz-R4; Wed, 11 Jan 2006 18:21:30 -0500
To: Marco Costalba <mcostalba@yahoo.it>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14524>

Hello, Marco!

Current qgit has a bug that manifests itself on stgit repositories.
Suppose I have two patches known to stgit, one is applied and the other
is not.

If the unapplied patch is selected and I right-click on the applied
patch below, I get a popup with "Push patch" disabled.  If I select the
applied patch by the left click, then "Pop patch" appears in that place,
and it's enabled.  Also, "Make Tag" appears in the menu.

Going from the applied patch to the unapplied one by the right click
results in having disabled "Pop patch" instead of the correct enabled
"Push patch".

Screenshots can be found at
http://red-bean.com/proski/qgit/

I found this comment in mainimpl.cpp:
  // call an async context popup, DO NOT filter out event
  // we append the event to main event loop queue so Qt can send
  // currentChanged() signal to listViewLog before our popup is
populated

I guess the code doesn't work the way the comment says.

-- 
Regards,
Pavel Roskin
