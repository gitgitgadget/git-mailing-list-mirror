From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 10:17:17 +0200
Message-ID: <485B678D.3090800@viscovery.net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <485B595B.80608@viscovery.net> <20080620080153.GC7369@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9bp5-0006Qe-7F
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYFTIRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYFTIRV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:17:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55448 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYFTIRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:17:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9bo5-0006u2-Qa; Fri, 20 Jun 2008 10:17:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 93C294FB; Fri, 20 Jun 2008 10:17:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080620080153.GC7369@leksak.fem-net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85605>

Stephan Beyer schrieb:
> Looks like *portable* shell programming is no fun :\

> On Fri, Jun 20, 2008 at 09:16:43AM +0200, Johannes Sixt wrote:
>> others write the file name in front of the count,
> 
> I did not really change anything that's related to the count, btw.

You changed:

-	count=$(grep -c '^[^#]' < "$DONE")
+	count="$(grep -c '^[^#]' "$DONE")"

It turns out that GNU grep and AIX 4.3's grep don't write the file name if
only one name was given. Nevertheless, by passing the data on stdin we are
on the safe side. And, btw, the outer quotes are not needed in this
assignment.

-- Hannes
