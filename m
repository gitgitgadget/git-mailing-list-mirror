From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Test failure when spaces in git root
Date: Thu, 24 Mar 2011 21:46:02 +0100
Message-ID: <201103242146.02728.trast@student.ethz.ch>
References: <1300925506-20378-1-git-send-email-cmskog@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Carl Michael Skog <cmskog@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:46:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2rQ5-0005ux-Im
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 21:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934188Ab1CXUqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 16:46:07 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:21951 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184Ab1CXUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 16:46:05 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 24 Mar
 2011 21:46:02 +0100
Received: from thomas.inf.ethz.ch (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 24 Mar
 2011 21:46:03 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.37.4-17-desktop; KDE/4.6.0; x86_64; ; )
In-Reply-To: <1300925506-20378-1-git-send-email-cmskog@gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169943>

Carl Michael Skog wrote:
> Some of the svn related tests would break when the git root path had
> spaces in it.
[...]
> -quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
> +quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/g')"

If you're already fixing this, shouldn't it be

  $(echo "$svnrepo" | ...)

to stop the expansion process from converting arbitrary series of
whitespace into a single space?

However, any other (than space) character that needs %-quoting would
probably also break the test.  Maybe some more complicated mangling
would be in order.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
