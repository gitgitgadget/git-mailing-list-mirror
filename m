From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] Revert "compat: add strtok_r()"
Date: Fri, 1 Feb 2013 11:37:48 +0100
Message-ID: <CABPQNSYZgvX+uutLjAiaDOurFSe0YVNGzUG1jOAMZw7JrETbLw@mail.gmail.com>
References: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 11:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1E1D-0001bI-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3BAKi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:38:29 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40587 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab3BAKi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:38:28 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so3244060iea.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=thBdjtBnt22Fad4tHQiZIKZFtV32kxqI587taJJx048=;
        b=MRhuhWtO6OCbnQNRiuGK/rRcprSqBxoHotgxViTMeuwuOLnJxNagfC3Go1Nhc3r2iJ
         L1V+uykGvb6fSaYVfaPW2PwwCLCKjuq1TFvDfZw8O7puqIP2xyEmyzDPms1rQtwffYF2
         pAYDE3oX0FlnudLuQGER6VcdSWWMScElGY3iJ4ubOZHVVw0Jb18unc613m3f++0/36CQ
         S4sZQv6mjIISwxE2yo3OWwveaytnZNU6DUpbxKyyWG8hUuDim5nWGqIC41RXIJRC9N63
         7l2vpZ4CVHgS62KFtm4LzwWMb+Roaxn1xjEyWCARDZTu8EI0tG0ZLIiaya2Hny+9xOAY
         3VYg==
X-Received: by 10.42.27.74 with SMTP id i10mr9144872icc.47.1359715108357; Fri,
 01 Feb 2013 02:38:28 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Fri, 1 Feb 2013 02:37:48 -0800 (PST)
In-Reply-To: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215231>

On Fri, Feb 1, 2013 at 11:33 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> This reverts commit 78457bc0ccc1af8b9eb776a0b17986ebd50442bc.
>
> commit 28c5d9e ("vcs-svn: drop string_pool") previously removed
> the only call-site for strtok_r. So let's get rid of the compat
> implementation as well.
>
> Conflicts:
>         Makefile
>         config.mak.in
>         configure.ac
> ---
>
> I just noticed that we have an unused compat-implementation of strtok_r,
> so here's a patch to get rid of it.
>

Ugh, I forgot this part:

diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..7f3018f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -321,7 +321,6 @@ ifeq ($(uname_S),Windows)
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_STRTOK_R = YesPlease
 	NO_FNMATCH = YesPlease
 	NO_MEMMEM = YesPlease
 	# NEEDS_LIBICONV = YesPlease
@@ -476,7 +475,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_STRTOK_R = YesPlease
 	NO_FNMATCH = YesPlease
 	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
