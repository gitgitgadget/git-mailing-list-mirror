From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: MinGW port - initial work uploaded
Date: Mon, 22 Jan 2007 21:27:09 +0100
Message-ID: <200701222127.09601.johannes.sixt@telecom.at>
References: <200701192148.20206.johannes.sixt@telecom.at> <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 21:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95l7-0001lA-CL
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbXAVU1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAVU1O
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:27:14 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:47021 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbXAVU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:27:13 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id C119B3462A; Mon, 22 Jan 2007 21:27:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3518512248;
	Mon, 22 Jan 2007 21:27:10 +0100 (CET)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37445>

On Monday 22 January 2007 14:06, Christian MICHON wrote:
> One problem I haven't found a solution for though: the date
> of commit is wrong, always back to epoch (1970???).

I've pushed out a fix for this.

Also, t/t5500-fetch-pack.sh passes now all tests.

OTOH, git log, git diff, etc, which run the pager by default, are broken. It 
seems that the pipe is not correctly flushed by the writer, which the MinGW 
port closes in an atexit() routine, so that the last part of the piped data 
is missing. I have no clue how to fix this except by disabling the pager.

-- Hannes
