From: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
Subject: git diff: add option for omitting the contents of deletes
Date: Sat, 26 Feb 2011 15:16:46 +0200
Message-ID: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 14:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtK0z-0002OJ-FB
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 14:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab1BZNQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 08:16:48 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40111 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1BZNQr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 08:16:47 -0500
Received: by qyg14 with SMTP id 14so2193481qyg.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=tlL8LP/NCLCSPRVQexEuf8eYmXYUQ1H3Kk1V6NyNcRs=;
        b=LOsNpUjCLUeOI8oFuRzWkCj/xaGwwa2fuVW9gTMj9EY166lgDfMLeeXHJrSa8dni9M
         VIRd6w4rvWZi/mw6OKQyBhSv5ZsYihOdOgguW2bvG9t84lGPjjPtxv7Fj6uKa9cxkS3F
         Bgp5zs8MQLpkAwuKszDhasagp1B0uHns1aKns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QsF27tSrtkOjcVU+owUkI4w36+lmoHtlIsay090U662ckHOfUXPCVYcwXr7LkabQvM
         qWdEJf1I8Yd81dfyLxBsJZqkkGpSkFuqeEa9XLxfBsf6R3vOn+eNwpCjzn59FgK14kbI
         a5kE6SToqOyD2Ahl9lV3ur5Hty8Zh5z4VEInw=
Received: by 10.224.20.5 with SMTP id d5mr3106034qab.187.1298726206880; Sat,
 26 Feb 2011 05:16:46 -0800 (PST)
Received: by 10.229.192.14 with HTTP; Sat, 26 Feb 2011 05:16:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167983>

Paging through deletes adds a cognitive burden when reviewing code.
Thus we have

    git config --global alias.deleteless-diff 'diff -M --diff-filter=3D=
ACMRTUXB'

and using `git deleteless-diff` is standard practice during code review=
s.

However, the filter leaves out delete information altogether, which is
error-prone.

Therefore I'd like to propose adding the -D (or
--omit-delete-contents) option to git diff
that would behave as follows:

$ git rm foo
$ git diff -D
diff --git a/foo b/foo
delete foo

I.e. instead of displaying the contents of the file as a diff minus, a
descriptive message
is displayed -- like with renames.

Thoughts, suggestions?
Can 'diff -M --diff-filter=3DACMRTUXB' be improved?

Best regards,
Mart S=F5mermaa
