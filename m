From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [BUG] gitk: clicking on a connecting line produces can't read "cflist_top"
Date: Mon, 01 Oct 2012 10:40:01 +0200
Message-ID: <506956E1.1080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 10:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIbY3-00054v-9M
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 10:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2JAIkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 04:40:08 -0400
Received: from so.liwest.at ([212.33.55.24]:34259 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab2JAIkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 04:40:06 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TIbXl-0000pe-LR; Mon, 01 Oct 2012 10:40:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6416B1660F;
	Mon,  1 Oct 2012 10:40:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206726>

Clicking on a line that connects commit nodes produces this error:

can't read "cflist_top": no such variable
can't read "cflist_top": no such variable
    while executing
"$cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend""
    (procedure "highlightfile" line 4)
    invoked from within
"highlightfile 0"
    (procedure "highlightfile_for_scrollpos" line 8)
    invoked from within
"highlightfile_for_scrollpos $topidx"
    (procedure "scrolltext" line 9)
    invoked from within
"scrolltext 0.0 1.0"
    (vertical scrolling command executed by text)


Bisection points to b967135d (Synchronize highlighting in file view when
scrolling diff).

gitk remains responsive after the error window is closed, so it is not
urgent. A fix would be appreciated nevertheless.

-- Hannes
