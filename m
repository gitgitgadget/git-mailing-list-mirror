From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Fwd: cherry picking and merge
Date: Fri, 1 Aug 2014 21:01:31 +0200
Message-ID: <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com>
 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDI5o-0005mX-QT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbaHATCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 15:02:13 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45320 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbaHATCM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 15:02:12 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so2895515obc.34
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pdmeHe7sDcLrezwYW5/a/eIVOsT4dj9k8p6R0LO506o=;
        b=qaQfRqVwClzqQMM35aVzIrU3HCR6UcoNwVvgspmpqH/R5o2vW9/hFzTKWNW0E9OyLj
         J0vsK1aK9NZcjSNfhrmZwyzl1/xJHwd1f+cSuYPMljFzKTHyhg/QgellvREuQ58VPG+X
         IkQ26Q/tkxjXTQbmduiP91LH+e676N8Z7gwXClZsIWJgheOkwxZTE+mcocyWqfyPAV0o
         6RqpC4sfRTKeN7F4NVJOBQxJ26RTJ7afBh73kCAT1levKUVC7xw/bdozdG1DhuIz9SRW
         4ZX1C3QNB8dOFF0eK8PDhEAnqNc26cf8ac09Q05xqNEfyYCfr2lTjmPIxQkJwmZhUCDf
         IcaQ==
X-Received: by 10.60.52.178 with SMTP id u18mr11459871oeo.68.1406919731914;
 Fri, 01 Aug 2014 12:02:11 -0700 (PDT)
Received: by 10.76.103.146 with HTTP; Fri, 1 Aug 2014 12:01:31 -0700 (PDT)
In-Reply-To: <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254649>

[sorry for duplicate sent as private mail; I forgot to turn off HTML
when sending to the git mailing list]

On Fri, Aug 1, 2014 at 7:48 PM, Mike Stump <mikestump@comcast.net> wrot=
e:
[...]
>
> I was curious if svn handles this better the same or worse, and it di=
d it just fine.  I know that a while ago, svn could not handle this, it=
 would do what git does currently.  Apparently they figured out it was =
a bug and fixed it.  Have you guys figured out it is a bug yet?  The fi=
rst step in solving a problem, is admitting you have a problem.


It can work in Subversion because Subversion stores information about
what was merged in (and this includes cherry-picks, or whatever it is
named in svn) in svn:mergeinfo property. Git does not track what was
merged in, instead it represent the history as the graph of revisions,
and tracks merges (by storing that it came from two or more commits)
and not merged-in information.

When merging Git uses only what is being merged and its common
ancestor (3-point merge). It is simple, and simple works!!!
Unfortunately, it does not see cherry-picked commits - it is invisible
to merge as being on the chain from one of merged commits to the
common ancestor.

The rebase command handles cherry-picked commits by detecting that the
change was already applied. I think that git-imerge does the same (but
I have not used it myself).

Have you tried git-imerge?

--=20
Jakub Nar=C4=99bski



--=20
Jakub Narebski
