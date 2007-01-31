From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Fail softly if file system does not like test data.
Date: Wed, 31 Jan 2007 00:39:36 -0500
Message-ID: <873A97D5-C343-435F-B51B-55F599AC46D0@silverinsanity.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa> <20070130224446.28311.31828.stgit@lathund.dewire.com> <64949F2D-6A6D-4373-8B7F-C8F75529CD2E@silverinsanity.com> <200701310114.38258.robin.rosenberg@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 06:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC8C7-0001rr-Kc
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 06:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbXAaFjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 00:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbXAaFjk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 00:39:40 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36152 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823AbXAaFjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jan 2007 00:39:39 -0500
Received: from [192.168.1.4] (cpe-66-66-74-194.rochester.res.rr.com [66.66.74.194])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B48B61FFC02B;
	Wed, 31 Jan 2007 05:39:38 +0000 (UTC)
In-Reply-To: <200701310114.38258.robin.rosenberg@dewire.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38230>


On Jan 30, 2007, at 7:14 PM, Robin Rosenberg wrote:

> onsdag 31 januari 2007 00:28 skrev Brian Gernhardt:
>> Doesn't work, but it's closer.  I can't see where a .gitignore is
>> getting set, though.
>
> I did not create any .gitignore files, so I have no explanation at =20
> this time.

=46irst off, I couldn't get your patch to apply (atop master and next) =
=20
and I don't know why.  I did the change manually though, and still =20
got the same error.  I'm not seeing a .gitignore either, so I have no =20
idea why the error is showing up.  Anyone else have a guess?

* expecting success: (mkdir -p "=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p=
/=20
q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6" ||
          echo "Local filesystem does not permit this test" ) &&
          echo Foo >"=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/=
=20
v/w/x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.txt" &&
          git add "=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/=
=20
w/x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.txt" &&
          cp ../test9200a.png "=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/=
=20
q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.png" &&
          git add "=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/=
=20
w/x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.png" &&
          git commit -a -m "G=E5r det s=E5 g=E5r det" && \
          id=3D$(git rev-list --max-count=3D1 HEAD) &&
          (cd "$CVSWORK" &&
          git-cvsexportcommit -v -c $id &&
          test "$(echo $(sort "=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/=
=20
q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6/CVS/Entries"|cut -d/ -f2,3,5))" =3D =20
"g=E5rdets=E5g=E5rdet.png/1.1/-kb g=E5rdets=E5g=E5rdet.txt/1.1/"
          )
The following paths are ignored by one of your .gitignore files:
=E5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/=20
g=E5rdets=E5g=E5rdet.txt
Use -f if you really want to add them.

~~ Brian
