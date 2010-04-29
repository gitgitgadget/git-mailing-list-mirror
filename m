From: Jay Soffian <jaysoffian@gmail.com>
Subject: How to efficiently blame an entire repo?
Date: Thu, 29 Apr 2010 19:12:27 -0400
Message-ID: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 30 20:36:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7v4o-0006Nh-5w
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 20:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091Ab0D3SfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 14:35:20 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:62076 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934081Ab0D3SfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 14:35:10 -0400
Received: by iwn12 with SMTP id 12so586154iwn.15
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BeVJ4Ci2dWHEmDrteRdvKG3o5itTgIJECDp9EuKDbj0=;
        b=bmGvtQfBHYfQhc5Gi46VUidCaxJrh+CxoXM1GcZ7Ied/uBJjJqSWYemmyWNuw/gQAz
         j1WAfZzaN/r2h9Nc/WNE+3T4Nm4lz1eNPqH6C5PXOJo7bKmQ79XrdupGhnSnneQG22Z/
         nSx9cV0ATRCmuzBwEz2I8msYwUTAU3JIDmFPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jzXpEQWutudWYSiP4hWJ4CSgaTHy/i0aYOS46HhvePdwOecBIDxBWoLM27dzXO8cyA
         3ssIW4KHvd4jcyaCDztbkTLFS2Qtvz7UZ811EUXsLE+ESIWitsh41z/ZQ7TddvUPYgzo
         5GNE4Worx6EsWacmQtJhDghuETQU6W/ro+US4=
Received: by 10.231.144.145 with SMTP id z17mr963441ibu.92.1272582747795; Thu, 
	29 Apr 2010 16:12:27 -0700 (PDT)
Received: by 10.231.17.141 with HTTP; Thu, 29 Apr 2010 16:12:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146043>

Let's say you've got a repo with ~ 40K files and 35K commits.
Well-packed .git is about 800MB.

You want to find out how many lines of code a particular group of
individuals has contributed to HEAD.

The naive solution is to run git blame on all 40K files grep'ing for
the just the authors you want.

Possibly a step up from that is first using log --name-status
--author=... to find just the files which have been touched by those
authors and then blaming only those files.

I guess the next step up would be parsing the diff hunks output by log
-p, but then you're basically re-implementing blame I think.

Am I missing a clever solution?

j.
