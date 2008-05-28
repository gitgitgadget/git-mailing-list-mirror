From: Teemu Likonen <tlikonen@iki.fi>
Subject: log --graph: extra space with --pretty=oneline
Date: Wed, 28 May 2008 14:24:05 +0300
Message-ID: <20080528112405.GA12065@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Wed May 28 13:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1JmQ-0002gY-Nz
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 13:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYE1LYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 07:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYE1LYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 07:24:09 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:46867 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751595AbYE1LYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 07:24:09 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483BB47A0011C05C; Wed, 28 May 2008 14:24:06 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K1JlF-0003B7-IE; Wed, 28 May 2008 14:24:05 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83086>

Sometimes "log --graph --pretty=oneline" prints a sort of broken graph
line. In the git repository try this:

$ git log --graph --pretty=oneline --abbrev-commit -4 8366b7b


M   8366b7b... Merge branch 'maint'
|\  
| M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into maint
| |\  
| M  \  93c7b9c... Merge branch 'hb/maint-send-email-quote-recipients' into maint
| |\  | 
| M  \ \  6abf189... Merge branch 'maint-1.5.4' into maint
| |\  | |
    ^

Extra spaces there. I don't mind that myself but to some users it may
look like a bug. Maybe one would expect output like this:


M   8366b7b... Merge branch 'maint'
|\  
| M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into maint
| |\  
| | \
| M  \  93c7b9c... Merge branch 'hb/maint-send-email-quote-recipients' into maint
| |\  \ 
| | \  \
| M  \  |  6abf189... Merge branch 'maint-1.5.4' into maint
| |\  | |


It requires more lines though.
