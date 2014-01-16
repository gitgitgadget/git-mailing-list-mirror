From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Thu, 16 Jan 2014 14:43:34 -0800
Message-ID: <20140116224334.GS18964@google.com>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
 <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Berntsen <alexander@plaimi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:43:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3vf4-0004Eg-VR
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaAPWnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:43:39 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:63790 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaAPWni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 17:43:38 -0500
Received: by mail-yh0-f42.google.com with SMTP id z12so898602yhz.29
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kSYR/Jbrj36SrtMkOm9QqkT8WrL0Fh+osHtgYlh2n38=;
        b=BznYeSVcoh0andvCH+UXGpszIuknpkgGr711StZfo7ktbkQxA+99lQl4hvsQqmLcxR
         CU/PQqx1Gfi4P1Vo/nqP146GRds3SlYr5FwQK7ykTfA+BofU8Df5JlTgU0y9PhuetlBh
         tSkYe4ZBGctTo+aCDcbiUW3RMEj4jUA5qJ51lEjk/HLfXf5uQgRGpr8kVkf97JHbH1DS
         0G+RVh/JasHEdyKb846I9E8FP3gkVV+SPS0t3Orx00Mq04Rfkgl6jWQEQRScvwqJzorW
         6jasKf7b6RtXxxhZXZTttgpho3Pi/W7YKPOueZSR5njJG1k2AnellKBc6250z8t4Uk6V
         ttGg==
X-Received: by 10.236.222.231 with SMTP id t97mr4834904yhp.125.1389912217599;
        Thu, 16 Jan 2014 14:43:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d7sm14433949yhd.24.2014.01.16.14.43.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jan 2014 14:43:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240544>

Junio C Hamano wrote:

> These paths that depend on your choice of the editor and other tools
> can still be managed in your personal .git/info/exclude in the
> meantime.

Or $HOME/.config/git/ignore to not have to make the same setting
in every repository. :)

Maybe it would make sense to add a hint about that somewhere to
user-manual.txt.  Even better would be to automatically include some
common exclude patterns globally without requiring any manual
configuration, but that would take some care to make sure the patterns
and how to disable them are documented clearly.

-- >8 --
Subject: gitignore doc: add global gitignore to synopsis

The gitignore(5) manpage already documents $XDG_CONFIG_HOME/git/ignore
but it is easy to forget that it exists.  Add a reminder to the
synopsis.

Noticed while looking for a place to put a list of scratch filenames
in the cwd used by one's editor of choice.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f971960..37c9470 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$GIT_DIR/info/exclude, .gitignore
+$HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore
 
 DESCRIPTION
 -----------
-- 
1.8.5.2
