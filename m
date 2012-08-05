From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 0/2] allow recovery from command name typos
Date: Mon,  6 Aug 2012 02:45:38 +0800
Message-ID: <1344192340-19415-1-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5px-0003Dx-OU
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab2HESp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:45:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2HESp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:45:56 -0400
Received: by pbbrr13 with SMTP id rr13so1357511pbb.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+21iMhadP3GQkkAOqhA4KuAU5DX/SwUqemHAqLd1pKY=;
        b=fPKK0LsClvZUwA5/OxPEx3x0rMvDMWI+9zlHH8sjPgfIy1ISLUny0+bupiPm92GTeg
         2FB2BGWDGfU2rcqa+q0BazqXZpLGTxhHpv8498aam7Kz/PwqtUOrpgjck2YJCDP/Zfx8
         z6luK8A9+6zOK06DjD8RoSsIdxmRlfjo64rI/DLQbYsKy1al7c+hOlSGHYNeCj6dWwuZ
         kH0fq5Tyvbtnx32K/yfT7E8zQG61jHp1vZ3TvfEJytKLQQ5+zfrgbMAJ9pPMkdBPHNjU
         J81ulvkr+D3j0sZi8/XXlfX/R5B4jbvnGTkbb6Fh1MkZMmvDUpArea0di4dDVDQTQ5vl
         JyLQ==
Received: by 10.68.222.103 with SMTP id ql7mr13319273pbc.48.1344192356147;
        Sun, 05 Aug 2012 11:45:56 -0700 (PDT)
Received: from ubu-01-asus.gateway.2wire.net (cm83.beta238.maxonline.com.sg. [116.86.238.83])
        by mx.google.com with ESMTPS id sf2sm4151691pbc.57.2012.08.05.11.45.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 11:45:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.187.g6dd9156
In-Reply-To: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202913>

As discussed in the previous iteration, testing for prompt-availabilty
has been reworked (patch #2).

This is done with the aid of patch #1, which extracts the opening of
/dev/tty from git_terminal_prompt() into a terminal_open(). Its return
value indicates if a terminal is available for prompting. On systems
with HAVE_DEV_TTY unset, terminal_prompt() falls back to checking the
tty-ness of stdin and stderr (as getpass() uses both).

Contents:
[PATCH v3 1/2] add interface for /dev/tty interaction
[PATCH v3 2/2] allow recovery from command name typos

-- 
1.7.12.rc1.187.g6dd9156
