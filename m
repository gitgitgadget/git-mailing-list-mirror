From: Adam Mercer <ramercer@gmail.com>
Subject: error in rewriting author history with filter-branch --env-filter
Date: Sat, 4 Apr 2009 23:21:36 -0500
Message-ID: <799406d60904042121o27b4ac39m633354dcf0bcc84d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 06:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJtI-0002Pj-CS
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 06:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbZDEEVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 00:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZDEEVy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 00:21:54 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:64415 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbZDEEVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 00:21:53 -0400
Received: by gxk4 with SMTP id 4so3702139gxk.13
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:received:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=u69WL4dBoOvtKIHcRVZbekz1g8rXCRcDuQOg8j9iah8=;
        b=JtvKAMoMu31I7LpLQGWiyW4lS49uGBgMSeSbPrxfZHf7KSfBhqRD5zAGN3Ai8jQV2g
         YSut5SZexuacojN4a16rykL+x9kEH63EqY/NyKcHHMOt/1YO/p/fPgQ1ORBtgmLmJhBq
         Axg/pU6iRQPRMn6iXZor2+2+6KKs0C1yybMDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=jKq/DcDPBvJktZRq3O6UUj+49ls4GxWGtBtUEbYw7D41oYoix+YTw5YIBkJR0tHSxT
         qTrGcviHinNVO7QG1toEC8P/txLN+Yk8dIJ1UBLISBM59yyYTE+ar5lQRSw06FuJOyQZ
         9vieE0FpDhv0s+uBu91Mq3se3Sqw66kol58rQ=
Received: by 10.90.113.11 with SMTP id l11mr1907689agc.87.1238905311508; Sat, 
	04 Apr 2009 21:21:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115634>

Hi

I'm trying to use git filter-branch to rewrite the author information
on an repo that was imported from CVS a while ago, the commits I'm
trying to rewrite are as follows:

commit 2cdeb25148f02b35391bd80a2c4c1876d7b8b840
Author: <ram>
Date:   Wed Dec 22 13:36:01 2004 +0000

    modify style

I'm trying to modify <ram> to be replaced with my name and email
address. To do this I've been trying to use the following command

$ git filter-branch --env-filter '
an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
if [ "$GIT_AUTHOR_EMAIL" = "ram"]; then
an="Adam Mercer"
am="ramercer@gmail.com"
fi
export GIT_AUTHOR_NAME=$an
export GIT_AUTHOR_EMAIL=$am
'

however when I run this I get loads of errors of the form:

Rewrite 18242fa722ff393e7fce78e05f37fa7c3b3825e1
(1/216)/opt/local/libexec/git-core/git-filter-branch: line 307: [:
missing `]'

Any ideas what I'm doing wrong? I'm running git-1.6.2.2.

Cheers

Adam
