From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] diff/diff-files: do not use --cc too aggressively
Date: Thu, 18 Sep 2008 11:30:26 +0200
Message-ID: <48D21FB2.50700@viscovery.net>
References: <48D0B907.7040903@viscovery.net> <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net> <7vy71qyo9d.fsf@gitster.siamese.dyndns.org> <48D1F426.4040208@viscovery.net> <7vskryym24.fsf@gitster.siamese.dyndns.org> <48D203B3.90807@viscovery.net> <7v7i99zuqh.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 11:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgFrW-00055L-GB
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 11:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbYIRJag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 05:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbYIRJag
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 05:30:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26243 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbYIRJaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 05:30:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgFqE-0000wY-IU; Thu, 18 Sep 2008 11:30:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 52E364FB; Thu, 18 Sep 2008 11:30:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v7i99zuqh.fsf_-_@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96188>

Junio C Hamano schrieb:
> Textual diff output for unmerged paths was too eager to give condensed
> combined diff.  This has two problems:
> 
>  (1) "diff --base/--ours/--theirs" (and "diff-files -p" with the same) is
>      a request to compare with the named stage.  We showed "-c -p" output
>      instead;

I cannot reproduce what you describe here. "diff --base/--ours/--theirs"
works as expected with and without this patch.

>  (2) "diff -c" (and "diff-files -c -p") is a request to view combined diff
>      without condensing (otherwise the user would have explicitly asked
>      for --cc, not -c).  We showed "--cc" output anyway.

The patch fixes this:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
