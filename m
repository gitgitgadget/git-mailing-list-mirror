From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: git rebase --interactive problems
Date: Mon, 7 Sep 2009 08:03:38 -0500
Message-ID: <20090907130338.GA11644@unpythonic.net>
References: <1252326716.7497.1333578429@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Rodgman <dav1dr@eml.cc>
X-From: git-owner@vger.kernel.org Mon Sep 07 15:03:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkdsx-0000gc-Bg
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZIGNDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 09:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbZIGNDp
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:03:45 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:53829 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751483AbZIGNDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 09:03:45 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 47317115402; Mon,  7 Sep 2009 08:03:38 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1252326716.7497.1333578429@webmail.messagingengine.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127926>

It looks like something is going wrong with the 'grep -c' in
    mark_action_done () {
            sed -e 1q < "$TODO" >> "$DONE"
            sed -e 1d < "$TODO" >> "$TODO".new
            mv -f "$TODO".new "$TODO"
            count=$(grep -c '^[^#]' < "$DONE")
            total=$(($count+$(grep -c '^[^#]' < "$TODO")))
            if test "$last_count" != "$count"
            then
                    last_count=$count
                    printf "Rebasing (%d/%d)\r" $count $total
                    test -z "$VERBOSE" || echo
            fi
    }
are you using an unusual platform or have an unusual /bin/grep or
/bin/sh?

Jeff
