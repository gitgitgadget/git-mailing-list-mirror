From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 15:10:40 -0600
Message-ID: <505CD7D0.2000505@workspacewhiz.com>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org> <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org> <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAUy-0002mX-0m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab2IUVKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:10:47 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:40556 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab2IUVKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:10:47 -0400
Received: (qmail 4573 invoked by uid 399); 21 Sep 2012 15:10:15 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 15:10:15 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <505CD2FA.80200@kdbg.org>
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206168>

----- Original Message -----
From: Johannes Sixt
Date: 9/21/2012 2:50 PM
> The trick is to pipe 'git log' output into another process that reads no
> more than it needs and exits. Then 'git log' dies from SIGPIPE before it
> processed all 1000 commits because its down-stream has gone away.
>
> For example:
>
>    git log --show-notes=p4notes -1000 |
>    sed -n -e '/^commit /h' -e '/P4@/{H;g;p;q}'
>
> (The pipeline keeps track of the most recent 'commit' line, and when it
> finds the 'P4@' it prints the most recent 'commit' line followed by the
> 'P4@' line.)
>
Got it.  I'll try that out now.

-Josh
