From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/3] git stash branch fixes
Date: Tue, 3 Aug 2010 20:42:48 +1000
Message-ID: <AANLkTi=6k7HcUYWhSi8XDfF0GnAwFdfN6b-ebf87eGSC@mail.gmail.com>
References: <AANLkTik8Npy99jKqUan8wOTXNffBCGwS_WnPwbhXqJYK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 03 12:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgExS-0004PG-SH
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0HCKmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 06:42:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33989 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab0HCKmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 06:42:49 -0400
Received: by qyk7 with SMTP id 7so492121qyk.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=W7WERmbIAOz2LoQXZk5LWmjSv7JGHXu4yChSPfS9a0c=;
        b=Jenkc8RKVu/l10Apn2hSv4C6Wgw2fbjEKFijiomJ0bLRvLZGMmU44VgQ09r/F4cbzl
         PV8IBWr8+Fm1lWDKIuR7p67piXJpDVFQnnVXDBEls5w0aJCL8acfh7f1Qq3aQvY8oHGN
         jX8nbAAvSPjWD9Mnkt+I3C6BUcQsaFJLl4Afc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hcooWeW2B+utlJCBUuUpU4FtK+PUsh3QDRHS6ZDulT0285DCiXj0H9nmIzJgMfT6VP
         8ecIcs7s6j1maIya4Vmz/Czv7Rqon9Fx0cLRqyDi2xJtgaR0UZMMsFKDFtWKmre8SR+t
         EyPC7zuSfEUBwkYPpCqnQz6RRSZiyhnoMW3xc=
Received: by 10.229.11.40 with SMTP id r40mr946654qcr.291.1280832168553; Tue, 
	03 Aug 2010 03:42:48 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Tue, 3 Aug 2010 03:42:48 -0700 (PDT)
In-Reply-To: <AANLkTik8Npy99jKqUan8wOTXNffBCGwS_WnPwbhXqJYK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152504>

| fixed the subject line - sorry !

This series fixes git stash branch so that it is more tolerant of
stash-like commits created with git stash create.

It particular, it doesn't require there to be a stash stack if a
stash-like argument is specified and it doesn't attempt to drop
non-stash references after applying the stash.

This series replaces my previous patch that just included a test
that demonstrated the existance of the issue.

=C2=A0stash: It looks like a stash, but doesn't quack like a stash...
=C2=A0stash: Allow git stash branch to process commits that look like
=C2=A0 =C2=A0stashes but are not stash references.
=C2=A0stash: modify tests to reflect stash branch fixes.

=C2=A0git-stash.sh =C2=A0 =C2=A0 | =C2=A0 10 ++++++++--
=C2=A0t/t3903-stash.sh | =C2=A0 28 ++++++++++++++++++++++++++++
=C2=A02 files changed, 36 insertions(+), 2 deletions(-)

--
1.7.2.1.111.g8fc90
