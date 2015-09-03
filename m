From: Kirill Likhodedov <kirill.likhodedov@gmail.com>
Subject: Default ordering of git log output
Date: Thu, 3 Sep 2015 16:50:23 +0300
Message-ID: <494BA1BD-150F-45A2-BF5D-9A933D9C1344@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0JrRg9C00LXQu9C10LLRgdC60LjQuQ==?= 
	<Eugene.Kudelevsky@jetbrains.com>,
	=?utf-8?B?0KHRgtCw0YEg0JXRgNC+0YXQuNC9?= 
	<Stanislav.Erokhin@jetbrains.com>,
	=?utf-8?B?0K7Qu9C40Y8g0JHQtdC70Y/QtdCy0LA=?= 
	<julia.beliaeva@jetbrains.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUuP-0002m5-9M
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbbICNu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 09:50:27 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:33669 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbbICNuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 09:50:25 -0400
Received: by lamp12 with SMTP id p12so27419183lam.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=DeOkPeSFsMWkMm/yRZ6JxSIkMGkecbwlByYWW2tl7zw=;
        b=bMySzZcL6eAmepSq79eqoFJK0I3z4RJzQZB1CccCUEIezoZHVTw4CcHYKytF5+vnrJ
         iUqOMbZ7wJ7oqSe9zgxT80d2rc6x+gn5KLEuuFtAdr8GoGZs353kRX1zYTbNoDW8/PA4
         MYMuWRm6h9FB27U52ARrCes2EgxWKJNJsZbaULqPqXKWuBwJifNqUBtyDLSyjYKdgLbA
         NGnYTadTsez5kLCBdFla6SVly0zorDkUD3khBNiIKTuNG2SXhc8SarhowcOW+1bu3AWy
         WzXYtwDr9c9EPlVxx4cwJ+mnIUOl610HVhjfNEvRyzZoAFZfgd4jzgl1lJrOkfxonmgE
         RUzA==
X-Received: by 10.112.161.40 with SMTP id xp8mr21378038lbb.71.1441288224019;
        Thu, 03 Sep 2015 06:50:24 -0700 (PDT)
Received: from loki.labs.intellij.net ([80.76.244.114])
        by smtp.gmail.com with ESMTPSA id f1sm6432646laf.15.2015.09.03.06.50.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 06:50:23 -0700 (PDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277204>

Is it intended behavior that the default git log output (without orderi=
ng parameters) can show parents before children?=20

The man says:
    Commit Ordering
       By default, the commits are shown in reverse chronological order=
=2E
so it tells nothing about parent-to-child relationship.

I=E2=80=98ve just faced an example in an open source repository, where =
I reproduced this behavior: a parent is shown before its child. (so if =
this behavior is not intended I can give the project URL for debugging)

So could you please clarify:
1. Is it true that the rule "no parents before all of its children are =
shown=E2=80=9D is not guaranteed for default ordering?

2. What does "reverse chronological order=E2=80=9D mean? How commits ar=
e actually sorted in git log?=20

// I was always under impression that git log lists commit in the order=
 in which they are =E2=80=9Crecorded" to the repository (e.g. pulled), =
since this seems to be both the fastest way, and also pretty acceptable=
 from the ordering point of view. =20

Thanks a lot!
-- Kirill.
