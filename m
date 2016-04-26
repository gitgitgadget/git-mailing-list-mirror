From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 0/4] githooks.txt improvements + core.hooksDirectory
Date: Tue, 26 Apr 2016 18:13:18 +0000
Message-ID: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7UZ-0006dN-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbcDZSNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 14:13:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35520 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbcDZSNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:13:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so6506780wme.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS4QsApHe4VnCMvNq9p4qXF6kfbVPKMswnS4oFuY+hk=;
        b=d/YGeF36wRsQ+8qoYr6Q6WLnq5udzF2EiVch2TGKIASL726VdMn6N13tWtzyioNwwZ
         dkc8RMgzd/G8BB5ix8nMZYxqgTpFLpfpd2WElarsWSxJCete09AyllH0EdHRfnTfCn3o
         mmDp4/Z9CHMG3WuUmfv2Qdu3lpnGOpQ1lK21oEE5OarTcOuvo5KRYEItkE7/TcWiZUog
         PL/+nR+5I+corMgGzqVuQrhii67FKUNcHKGiaGkVWhKKbulossP93hcZfvbovtLCxsda
         h9OYlcxePLw1PxigoE1fqOjgliO9HKoKmhBi5JPkZAhG6WEGgmYzKBelJeu7tDerbMjJ
         ZrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS4QsApHe4VnCMvNq9p4qXF6kfbVPKMswnS4oFuY+hk=;
        b=GTM8UtuWksYnfy7jP2+pV84+4JklrxDE4AyJd+hesG/IKqlgwtcPARZ+Lp5FbF9je9
         MEP61Nt5huronZFZI5rxyqhSpyJq9foGbzBrK4B/GY4yIo95Sa5SbQZ5MPaBWxfrVD6q
         vLwvWmafWvniuIj1gsayxkeGuOIPaKJL/Hv2y+KBUYVBtdzxKc/FPEslabdR4U5RBpGv
         tbq1pPzIWVFn8zaUUUCDUn0MwCsTK54ePyhYHHCuECuCj4Y3qmWfMQ9C2gqhbHNsWQVy
         9qTuV8/3rSy6III6pMSZlolIhKylCnxlWdviD2LFJAINwEko7UPZahix1gzf1o04YH+N
         FWJg==
X-Gm-Message-State: AOPr4FXiGy1dj89+2d2ogCWds0RUYKlZmCWmzFVrOI3wnRaNE05qWU0KczB6dp6KguGXOA==
X-Received: by 10.194.248.135 with SMTP id ym7mr4704796wjc.174.1461694421048;
        Tue, 26 Apr 2016 11:13:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h8sm4392371wmd.2.2016.04.26.11.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 11:13:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292635>

In this version of the series I've hopefully addressed all the
comments that came up on the list after the last one, and a few fixes
I noticed myself, e.g. a couple of grammar errors and a broken
asciidoc syntax.

I've combined both the githooks.txt documentation improvements and the
core.hooksDirectory patch into one series. Although they're logically
different things I think it makes more sense to combine them for ease
of reading, since the core.hooksDirectory documentation refers to some
documentation I fixed earlier in the series.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  githooks.txt: Improve the intro section
  githooks.txt: Amend dangerous advice about 'update' hook ACL
  githooks.txt: Minor improvements to the grammar & phrasing
  hooks: Add ability to specify where the hook directory is

 Documentation/config.txt     | 18 +++++++++++
 Documentation/git-init.txt   |  7 ++++-
 Documentation/githooks.txt   | 74 ++++++++++++++++++++++++++----------=
--------
 cache.h                      |  1 +
 config.c                     |  3 ++
 environment.c                |  1 +
 run-command.c                |  5 ++-
 t/t1350-config-hooks-path.sh | 31 +++++++++++++++++++
 8 files changed, 108 insertions(+), 32 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

--=20
2.1.3
