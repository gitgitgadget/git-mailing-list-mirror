From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 08:24:10 +0300
Message-ID: <200804070824.10764.tlikonen@iki.fi>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness> <20080406224724.GC5822@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 07:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jijqm-0003nZ-0I
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 07:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbYDGFYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 01:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbYDGFYQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 01:24:16 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:58615 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419AbYDGFYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 01:24:16 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A7885700374C26; Mon, 7 Apr 2008 07:24:14 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080406224724.GC5822@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78948>

Adam Simpkins kirjoitti:

> Actually, going back and testing this, it looks like I have a bug
> when handling --graph together with --pretty=format.  There's a
> missing newline after the user's format message and the next graph
> line.  I'll try to fix this and submit a patch later this evening.

Also, the output is not indented for options that display some 
additional information to commit message. Those include:

--raw
--stat
--numstat
--shortstat
--summary
--name-only
--name-status

I'm not sure if the diff output of -p, -u etc. should be 
indented--probably not--but for different stat and summary options it 
would be nice to not have their output displayed over the graph area. 
Especially --name-status is funny since it displays "M" to column 1 to 
indicate modified file while "M" also means merge commit in the graph.
