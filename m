From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 23:34:36 +0200
Message-ID: <200807202334.36506.johannes.sixt@telecom.at>
References: <200807202111.48332.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgZF-0000wC-KW
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbYGTVel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYGTVel
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:34:41 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39884 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYGTVek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:34:40 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 880E310A6F9;
	Sun, 20 Jul 2008 23:34:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 984201D3F6;
	Sun, 20 Jul 2008 23:34:36 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807202111.48332.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89236>

On Sonntag, 20. Juli 2008, Johannes Sixt wrote:
> -git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o
> strbuf.o usage.o wrapper.o shell.o
> +git-shell$X: abspath.o ctype.o 
> exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_OBJS)

Unfortunately, that's only half the deal. If we compile with NO_PREAD=1, this 
needs read_in_full(), which is in write_or_die.o. I don't know how to fix 
this without insulting your good taste except for reverting the recent 
commits that touch this line...

-- Hannes
