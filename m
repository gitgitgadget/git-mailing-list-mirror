From: "Joe Ratterman" <jratt0@gmail.com>
Subject: Inconsistency in use of "--bare" between init & clone
Date: Thu, 13 Dec 2007 09:37:50 -0600
Message-ID: <331aa8280712130737h7300c739n59ee2fce6c4e4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 16:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2q9Z-0006Kj-El
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 16:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbXLMPhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 10:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758466AbXLMPhw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 10:37:52 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:60439 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbXLMPhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 10:37:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1143480wah.23
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=S8aofnf03HhR5n5vybSkggyURdDX1+972gluBA3q5yg=;
        b=OYRqNUxIAIDtfl7RgIYP7Eo45bA9zb8lcRHGXXBkRA5KwKm5OTQyVHIrlWaYCvLmUs1qTd1SUiABxhYR64GZrbdA/Kr+nIQ6UcTgQ1XHW6yaSXavVoUWF6s8EnL/3/1WP1PgKaHizgOgx30E98rbr4bQEdus0UAMI+I0xzQt9y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dQmGfe+Qn1OSNlWj4/7Rl9WzEeYbNNMnRfSemfIzEmQYVb9kJTwizQkcY5stpWyK1zU2fwteYY6gExJAe5+K6oyFvLXNQtVNePXdyOtTENe6cMYpyDe9MMo1tY8qEcqmTne5XCbd+qkBa3M/WHfm5MshpG2almGOFeh/5TnrYU8=
Received: by 10.114.181.1 with SMTP id d1mr2412057waf.10.1197560270969;
        Thu, 13 Dec 2007 07:37:50 -0800 (PST)
Received: by 10.114.80.7 with HTTP; Thu, 13 Dec 2007 07:37:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68164>

I've been getting ready to support my organization in a change-over to
git from cvs, and I've found a strange issue when creating bare
repositories.  The placement of the "--bare" option changes:

git --bare clone <url>  ==  "--bare" is silently ignored
git --bare init  ==  Creates an empty bare repo

git clone --bare  ==  Clones the url into a new bare repo
git init --bare  ==  Error:
        usage: git-init [-q | --quiet]
[--template=<template-directory>] [--shared]

I assume there a reason for the lack of symmetry, but I don't understand it.

Thanks,
Joe

$ git version
git version 1.5.3.7.1157.gbf82a
