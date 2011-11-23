From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Wed, 23 Nov 2011 09:28:19 +0100
Message-ID: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 09:29:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8CV-0003cd-KO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab1KWI2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:28:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41715 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab1KWI2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:28:49 -0500
Received: by ggnr5 with SMTP id r5so1151216ggn.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=v9HOe113RYO8enFdhf1rtzwxzN8Ys2vc/Nado477LHs=;
        b=uct+WwBKlhk1fFNOOaGOPGRDYINFpXSecSd0OIhDFy8tOwlkBuc7zKN0depRWEOl3V
         bVG11MYUXUP+b/frVaQHux4sZJMIY1e9duGdcVJ51718rnA4WjujUzdKAlfpQnOI2KBR
         s2uYC6NRx7AcmMB/p4sG8nHUp/4ZCdATdN2z4=
Received: by 10.50.85.129 with SMTP id h1mr26830564igz.47.1322036929064; Wed,
 23 Nov 2011 00:28:49 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Wed, 23 Nov 2011 00:28:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185825>

Hello,

A lot of time when I want to use reset for smth else than "--hard" I
have to go and look the documentation.
I think the modes could be improved by creating new aliases like this:

Optional: a new mode would be introduced for consistency:
--worktree (or maybe --tree): only updates the worktree but not the index

Then the existing mode could be aliased like this:
--mixed would be aliased as --index
--hard would be aliased as --all
--soft could be aliased as --no-changes

Additionally:
--merge could be removed in favor of an additional --preserve-staged flag
--keep could be removed in favor of an additional --safe flag

So if I recap my ideas:

"I want to discard my changes" --> git reset --all HEAD^
"I want to discard the last commit" --> git reset --index HEAD^
"I want to discard the last commit, but let's be safe in case I forgot
about a modified file" --> git reset --all --safe HEAD^
"I want to discard the last commit, keep my current staged changes"
--> git reset --all --preserve-staged HEAD^

Philippe
