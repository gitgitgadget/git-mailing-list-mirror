From: Calvin Deutschbein <deutschbeinc@gmail.com>
Subject: GSOC on designing a faster index format
Date: Wed, 21 Mar 2012 15:39:45 -0600
Message-ID: <CAAQUJYbr+RbcpRzKqK+s+9sXezQuFR-S=OdSdnTYTtURDqKRhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 22:40:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SATGL-0008Gc-Al
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 22:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869Ab2CUVj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 17:39:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54906 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964864Ab2CUVjq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 17:39:46 -0400
Received: by yenl12 with SMTP id l12so1370031yen.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=zPjf2rU7rniGtkLAlIpYVbvROY/+LOwhCKDe3yFi2V4=;
        b=yUxCuwkpUyy8bV4bGlIUdHsW4ijBf9DH8PVuqH7dptutsJreKwqSdO9xLy+UNzRC2x
         sIQ3Kk9Ngmn4QnON54sD1hvKpgNg2fHidhmKlQuONepkdmt/N0tniORj4AxPjGyy8zKr
         Vc+RWE2LqWjntjAEzNX9sXCUWaL8LXE9nEYEOcSKDn13q0TLksQSpfgT/0/vwcZ+lYOt
         e8u4W7j3Yp7XlCgereqvGQmnxja421aTvx6MRKeJqvQIPpL0PENorV2qqzSAZboIBn/p
         OjFMGjWQxHpfHBJ1doTORdjkYigOPYuXGJyTs9yoSNtLBGAKzLxbMrs+zB+D1Z97IRZU
         I4Ng==
Received: by 10.236.80.4 with SMTP id j4mr5570969yhe.120.1332365985186; Wed,
 21 Mar 2012 14:39:45 -0700 (PDT)
Received: by 10.236.170.135 with HTTP; Wed, 21 Mar 2012 14:39:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193621>

Hi!

I'm a first year CS major (mostly proficient in C and Racket) at
UChicago looking at GSOC and GIT caught my interest, especially on the
idea of designing a faster index format. =A0As the GSOC page recommende=
d
starting a discussion in the mailing thread, I thought I would do so
on this particular topic.

"Git is pretty slow when managing huge repositories in terms of files
in any given tree, as it needs to rewrite the index (in full) on
pretty much every operation. For example, even though=A0logically=A0git
add already_tracked_file=A0only changes a single blob SHA-1 in the
index, Git will verify index correctness during loading and recompute
the new hash during writing=A0over the whole index. It thus ends up
spending a large amount of time simply on hashing the index."

Doing anything slowly is never fun, especially so as scale increases.
Dealing with version control for some of my course work, I appreciate
the speed possible with smaller projects and imagine on larger
projects the time saved would be quite lucrative. =A0That was what
initially attracted me to this idea, beyond the general desire to
maximize efficiency. =A0However, writing over the entire index with
every operation seems like a strange way spend resources. =A0Verifying
correctness, it would seem, can generally be done without a rewrite
and isn't necessarily exhaustively necessary with every index edit if
efficiency is becoming of utmost concern. =A0This then, would seem to
indicate that hashing the index wouldn't always be necessary. =A0Is it
done then just for 100% security in index correctness?

I also appreciate the later mention of the importance of being as easy
to parse as possible, as I tend to find such coding an intellectually
engaging exercise and this represents a valid reason to invest
resources in such a pursuit.  Unfortunately, I'm not entirely familiar
with other git-reading programs.  Is there a specific set of such
programs I should look into?

Thank you,
Calvin Deutschbein
