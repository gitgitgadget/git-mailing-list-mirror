X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: git-svn: follow parent after the fact?
Date: Mon, 18 Dec 2006 17:14:50 -0800
Message-ID: <45873D0A.1040804@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 01:16:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=osEB0vYNJLWeXJ/1XTd7+on+c5/psjk88MMKDzMRVEzUcsxcno4ka4lpkq4hDkD2  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34780>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTZB-0007sk-Jn for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932598AbWLSBOk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWLSBOk
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:14:40 -0500
Received: from tater.midwinter.com ([216.32.86.90]:54976 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932598AbWLSBOk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 20:14:40 -0500
Received: (qmail 20400 invoked from network); 19 Dec 2006 01:14:38 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 19 Dec 2006 01:14:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

One of the other git users here just noticed that his git-svn clone of a 
particular svn repo has an inconsistent set of files compared to the svn 
client. Turns out the repo has had its trunk moved around in the past. A 
fresh clone with --follow-parent (which he didn't use) produces the 
correct results.

Obviously he can blow away his current repo and make a new one, but it'd 
be nicer if he could preserve his local change history. Is there any way 
to retroactively apply the additional changes --follow-parent would have 
applied if it had been used on the initial fetch?

It would be better, IMO, if you didn't have to figure out whether or not 
a given remote svn repository has had branch renames in the past in 
order to figure out if you need to provide an extra option to git-svn 
fetch. Maybe --follow-parent should be the default behavior and there 
should be an option to turn it off? Or is there a good reason to not 
want that behavior most of the time? My assumption is that it's not the 
default simply because it's a recent addition.

By the way, I'm completely in favor of renaming commit to set-tree. +1 
for that change.

