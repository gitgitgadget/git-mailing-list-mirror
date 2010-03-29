From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: git-am: Please don't be in "some state" when it fails early
Date: Mon, 29 Mar 2010 02:14:24 +0200
Message-ID: <a1b6cb1b1003281714u50dbcc2bh58c38b50a7b837cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 02:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw2ci-0005qi-4p
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0C2AO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 20:14:27 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52603 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab0C2AO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 20:14:26 -0400
Received: by wwe15 with SMTP id 15so7930237wwe.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=SQOi66ojMl4Hxc90RD1nwSVEuJj0VEdboBldG8UWZ/Y=;
        b=f39ylzUMIF0q46bFpEP3jhEp+xWcvQgy0j7B6jJcv+aKRlKm+Uml0tIoVxZ10derk5
         Vcv2+fvKnzoFwJx72bYdKwu2Skw+83ttrr2cVylSP/8QYfgaxsrrjQ/8QEygwfqQLSVp
         EmuAZi4ePt5J8F65qUxJcG9KXPD74pZIUMu4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fi4huDIaSBVD7Py0gHtuCiha8ybvbhA1e0nhDUFQ5ObFcePXkDSqh56fAO5hBaobQ/
         2LW62GrmnIbwBLktsP0GpM5i16RuJzwn9QzVR3Qa0hlD8Z5k4F20ZaUyqMle/yApni5g
         rNyMyDF7pePQlK2oD0sV8KwM2gfLPTIN9hQdg=
Received: by 10.216.22.194 with HTTP; Sun, 28 Mar 2010 17:14:24 -0700 (PDT)
Received: by 10.216.91.16 with SMTP id g16mr2662188wef.102.1269821664840; Sun, 
	28 Mar 2010 17:14:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143423>

If git am fails early, before even trying to apply the first patch, it
would be great if am did not leave some state that has to be manually
cleaned up (git am --abort). Even if I have a small 'AM' marker in my
prompt, it is often missed. And why write state files to .git/ at all,
if all it did was to tell me that the index is dirty?

This fixes an inconvenience, and I don't have to wonder (look up)
every time if git am --abort will delete all the WIP I had in the way
or not.

Ulrik
