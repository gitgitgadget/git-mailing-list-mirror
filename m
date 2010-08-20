From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/17] Documentation: clarify quoting in gitignore docs
Date: Fri, 20 Aug 2010 05:30:56 -0500
Message-ID: <20100820103056.GG10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:33:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOuD-000355-Uz
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab0HTKc4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:32:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56196 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0HTKcz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:32:55 -0400
Received: by gyd8 with SMTP id 8so1164974gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YD53Wco6YANqpTUbEQZJIprVO6h4Srk/68H9yY3A9W8=;
        b=eMW0fQkWgznfIdSkU9ohYSTmRka81swjrKcXP4UWK9BxAXdfwz5lu8UfmfNITJS4TM
         f0uBl0OJVV+Z97bm1vVD7EiyRKptoJv9pi7vQu25YpL4JBGr62ZxdixEOxmUEjb/aGWu
         KBg5QnI3zDBVl/rzCnGzxOL8y86Lfr1b+MF0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Q/HkgYND0Z1Vs/TM6KNusD3/ZyT2Mo74R+FDA2AFuJsdVDTKPMs3y8hqU+8fqvhtjr
         Sj5l44uLBMMs3cs79c6wksk6kgTQOAuvZ7b0SfdaFxVW7NQVprnTTTkmowXwlSzaVyrB
         kYkSBh9EFxlMEf144aU0w7T8SExPwVB5hYOc8=
Received: by 10.151.78.6 with SMTP id f6mr1409074ybl.240.1282300371091;
        Fri, 20 Aug 2010 03:32:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm3708759ybk.13.2010.08.20.03.32.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:32:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154002>

An asterisk in "Documentation/*.txt" quoted with \ to avoid bold text
is being output as \* because asciidoc does not consider it a
candidate for escaping (there is no matching * to pair it with).

So the manual looks like it is saying that one should write
"Documentation/\*.txt" in the .gitignore file.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e10fa88..7dc2e8b 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -90,12 +90,12 @@ Patterns have the following format:
  - Otherwise, git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
    wildcards in the pattern will not match a / in the pathname.
-   For example, "Documentation/\*.html" matches
+   For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
=20
  - A leading slash matches the beginning of the pathname.
-   For example, "/*.c" matches "cat-file.c" but not
+   For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
=20
 An example:
--=20
1.7.2.2.536.g42dab.dirty
