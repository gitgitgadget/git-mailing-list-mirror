From: Steve Bennett <stevage@gmail.com>
Subject: Bug (or inconsistency) in git add
Date: Mon, 30 Apr 2012 14:03:25 +1000
Message-ID: <CADJEhEVNPj_FrRatjD7Jmbd7i_FYg9BzNNP48_4VAr6fgqBT8Q@mail.gmail.com>
References: <CADJEhEWC=mMManxi9Q6W9EvVKmTV=i1ZxbdW4QS_ou_DrBEb+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 06:04:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOhqc-0003QB-ET
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 06:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab2D3EDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 00:03:47 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33649 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2D3EDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 00:03:46 -0400
Received: by vbbff1 with SMTP id ff1so1802300vbb.19
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 21:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=nq+IQXuZlnl3Jho/WPfPG5Jt79p/Ad1WO3UeqYHlG8U=;
        b=SW8yZi72VHb/aaYxoJKDihkB+LzIjwUUqdm2UYE46L4zNDh8heJINJapM1xCVB76sf
         vPYpoB5w3TpcUwe0ePZD+tOh79Kekyj6NXpKaTthw6QfvDvs4eyuR1KfQufpZg9dp2UM
         mhHesazf1/ZhTorM8IireGNarElZ/Fc1oIUDIA7i5XN71x1/LucXa73rFOswnsaZZu+2
         utOdQT9NJ0o06/bYCDvUx5YR0YnNn+nHTylWAWyjWgfI5uarpT/86iTZkX2lew+fQ34k
         q3j4MTcF4LbXY88rPQ8dSjDy1Ldi608y+dsebNtcdboN5UPEgYFhbrK2eRZLbM8ky3fB
         8U2w==
Received: by 10.52.28.200 with SMTP id d8mr16914563vdh.38.1335758625502; Sun,
 29 Apr 2012 21:03:45 -0700 (PDT)
Received: by 10.52.38.39 with HTTP; Sun, 29 Apr 2012 21:03:25 -0700 (PDT)
In-Reply-To: <CADJEhEWC=mMManxi9Q6W9EvVKmTV=i1ZxbdW4QS_ou_DrBEb+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196534>

I couldn't find a bug tracker for Git, so here's my bug report.

Given a directory containing foo/bar/baz/blah.py and
foo/bar/baz/blem.py, this command:
1)
git add foo/**/*.py

produces no output, and adds no files.

This command:
2)
git add /**.py

produces no output but adds all the files.

This command:
3)
git add foo/**.py

produces an error and adds no files.

IMHO, "git add" should always produce an error message if no files
matched the pathspec given. So case 1) should produce an error
message.

git version 1.7.9.4 on Snow Leopard. (There doesn't seem to be a
1.7.10 at=A0http://code.google.com/p/git-osx-installer/downloads/list?c=
an=3D3)

If this is some weird bash shell behaviour, my apologies.

Steve
