From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation/fast-import: put explanation of M 040000
 <dataref> "" in context
Date: Sat, 15 Jan 2011 20:22:35 -0600
Message-ID: <20110116022234.GA28452@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeIIY-00052n-Ap
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab1APCWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:22:48 -0500
Received: from mail-yi0-f42.google.com ([209.85.218.42]:64767 "EHLO
	mail-yi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab1APCWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:22:47 -0500
Received: by yia28 with SMTP id 28so2076265yia.1
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6+eMqWtaxEDb02ovyacZT8SNozeg5ZCqusz1toXHyyM=;
        b=vaA8j2RJ097Pkcx8RiClBDOSRacsZuykkQLhcSnHIOhoX7hZm7aoQOOTxr1Lwz6VDB
         Xp9fbfBTO3H451sIHE2Wee5RObV66W551jhFd+dAhK/TpTlPm2AN7R8qNyVyGg3ZTJAg
         HJoh+Pr9e88+P22D/M5VnifEohAT4SHOKOH3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WW1QQdmBFgk15d5aSvV+fq38//dsVt+AfRsTEvFe4/EofYKI/rQjXEQMBP1dQhouYw
         eUatWQ9KxxfmzlUdekNoBw1qjUAxlCpS6Ats6zbhxzYsqw/WNnhXdCgdzP/bWZJWZouD
         lwjhTS2bKr3/wR8Zt4djNsIDpqVjVEcq44HqA=
Received: by 10.150.53.11 with SMTP id b11mr2304850yba.157.1295144566810;
        Sat, 15 Jan 2011 18:22:46 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id v8sm1817506ybe.1.2011.01.15.18.22.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 18:22:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165156>

Omit needless words ("Additionally ... <path> may also" is redundant).
While at it, place the explanation of this special case after the
general rules for paths to provide the reader with some context.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A small language tweak.

 Documentation/git-fast-import.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f56dfca..e2a46a5 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -534,9 +534,6 @@ start with double quote (`"`).
 If an `LF` or double quote must be encoded into `<path>` shell-style
 quoting should be used, e.g. `"path/with\n and \" in it"`.
 
-Additionally, in `040000` mode, `<path>` may also be an empty string
-(`""`) to specify the root of the tree.
-
 The value of `<path>` must be in canonical form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),
@@ -545,6 +542,9 @@ The value of `<path>` must be in canonical form. That is it must not:
 * contain the special component `.` or `..` (e.g. `foo/./bar` and
   `foo/../bar` are invalid).
 
+In `040000` mode, `<path>` can be the empty string (`""`)
+to specify the root of the tree.
+
 It is recommended that `<path>` always be encoded using UTF-8.
 
 `filedelete`
-- 
1.7.4.rc2
