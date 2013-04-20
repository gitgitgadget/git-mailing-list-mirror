From: John Szakmeister <john@szakmeister.net>
Subject: Is there a way to speed up remote-hg?
Date: Sat, 20 Apr 2013 07:07:54 -0400
Message-ID: <CAEBDL5XO4oU9QL1=kQ_f8_MM9jHAKQojMQr_6VSZsEYNY7PLpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, felipe.contreras@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 20 13:08:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTVeO-0002IM-EZ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab3DTLH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:07:56 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:42786 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3DTLHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:07:55 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so2243766wiv.2
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=gBA15HEOekpzFJaj+rq6FdkbxyWacQ66jCDBUm8b7qE=;
        b=YTsRjq/7TRVGnC63/kDaU6jRxVjjieYHOo+p7vfKO3im93eyQhLqQWJaUji7an8gr1
         +uDGy3wntz+3IBGU3hqoLEERP7HETsRXBvK5lIHARC/HkqJTSd+D0J583meSCwCXY2le
         7WPgDUVJZvlbfvGnS4S1uNqtMa/u+hQTsIvDdSs3JnV7CFpcLbvkQo7BABDUc2dK9w1R
         CGoSPuptgBPoAfNwBZc5is8Yp5WR7X0TPQyWNnA6VYfh94xhyg9LjqoWY99qnwgQilGx
         oIbfQVhN6PeIw6KlYvYuVS4iy8z3iVVZXyF8g/Gn30YHxMYnZ+A6JsTlOvdYdOXUMbQm
         ncpA==
X-Received: by 10.181.11.196 with SMTP id ek4mr33227887wid.30.1366456074370;
 Sat, 20 Apr 2013 04:07:54 -0700 (PDT)
Received: by 10.180.187.240 with HTTP; Sat, 20 Apr 2013 04:07:54 -0700 (PDT)
X-Google-Sender-Auth: 3vgPKDQLEDQVlz15-wWbQiW6O6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221845>

I really like the idea of remote-hg, but it appears to be awfully slow
on the clone step:

    ...
    progress revision 81499 'master' (81500/81664)
    progress revision 81599 'master' (81600/81664)
    Checking out files: 100% (3744/3744), done.
    git clone hg::https://bitbucket.org/python_mirrors/cpython
4484.61s user 41510.05s system 102% cpu 12:29:45.73 total

That seems like an awfully high price to pay.  It there a way to speed
this up at all?  I realize the Python hg repo has more history than
others, but even a smaller project like Sphinx takes a while:

    git clone hg::https://bitbucket.org/birkenfeld/sphinx  56.41s user
90.86s system 98% cpu 2:28.87 total

I was just curious if something more could be done here.  I don't go
around cloning Python all the time, so it's not a big issue, but it'd
be nice if it was more performant.

Thanks!

-John
