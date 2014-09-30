From: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JzQsNC60LDRgNC+0LI=?= 
	<einmalfel@gmail.com>
Subject: Strange behavior of git rev-list --first-parent --ancesty-path
Date: Tue, 30 Sep 2014 09:25:12 +0400
Message-ID: <CABEtfDGwtMTSP5xxme-p60iU1gMXBwCXA0cGHxLuZS+j-KwhGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 07:25:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYpw9-0004xJ-L2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 07:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbaI3FZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 01:25:15 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56919 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaI3FZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 01:25:14 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so1500243wib.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=H5LWXkOx6o8BlxymLK/XYZZ4mnumLt7fO/csGZ33fas=;
        b=adzOwAvvh11KnWriTwob4Hcbj5gv77dG8IMxkejBPvNT106Z1vsyzd/OTdAEkwPvwI
         7aA2gs7KUouSaaHcFGeXlBvqgxjvv+1+m1COz6TcYoZ6eYmIG3TiJ2rfNwtylJfua332
         gZtEW9X1HaMd0iMrBcdT8FHN0uucDmxQQDKDRPHeuW8dk7b4k2G7hGlBQYfCQsLB1030
         cz580qF2jM3uUdeRpZGQD8ShS5Lk9VA4GsnuIV5rk/s12/L/PoOfSBFW3hjIkppn6lQG
         YV+9LvF9UHGjWtw/lt8Jfr9bolrz5NQPgUxz+n2G4CrIqY0FEk1v3kJEPJ+TnG74dDf8
         mt2Q==
X-Received: by 10.180.84.98 with SMTP id x2mr2884823wiy.18.1412054712829; Mon,
 29 Sep 2014 22:25:12 -0700 (PDT)
Received: by 10.194.242.71 with HTTP; Mon, 29 Sep 2014 22:25:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257645>

Hello!

Imagine following tree:
A--B--C
 \      /
  D--E
B is parent #1 of C.

git rev-list --first-parent --ancestry-path D..C returns zero commits.
This is correct, since one cannot find any commits between D and C
traversing tree by first parent.
git rev-list --first-parent --ancestry-path E..C returns SHA of C.
This is strange, because --ancestry-path should restrict output to
commits being both ancestors of C and descendants of E.

Git did not return me any errors or warnings so I'm assuming that
--first-parent and --ancestry-path are OK to be used together.

So, is it a git bug or I'm doing smth wrong?
