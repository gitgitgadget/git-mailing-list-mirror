From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Odd "git diff" breakage
Date: Mon, 31 Mar 2014 11:05:06 -0700
Message-ID: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:05:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgaA-000337-SV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbaCaSFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:05:08 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:37172 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaCaSFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:05:07 -0400
Received: by mail-ve0-f177.google.com with SMTP id sa20so8223088veb.22
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=ECiRJX3DKN8lWjdjcZNXjdndhA7Xabut+V6US32xqrw=;
        b=0D5UQT485IOVJiQic8YMVHzLScZqyxrX4ELkOEsKe+mgD2xoAElxA9Z1F4qsVTsdw6
         ciJVwpSUunkRnTG+PVtnmtUX/UcQS7vxJPYqKLD6VWpcijEel1vO1WJJVIZPZw0ql5Ay
         YJOrMOZFl1eZLocgbsnik8nFCSJcPWzOqNY1fkmSVqSyNQtERXLqRAeN49kUoPBKxkBm
         MlQuksKYOyn7OxHKmBEScQj6aAaEmNKqa/IrwbbXGAedyEDJczs2QDkAOrqlXCPzz5aU
         g58FluA60r5cxq3DD/JmUxqr2v+GIOAFO0kOE5BRGz1kPuzzt9r/0mw3wVK3gMy1+4yh
         HJ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=ECiRJX3DKN8lWjdjcZNXjdndhA7Xabut+V6US32xqrw=;
        b=Ge0R7klxttJmHGSPgyJjkXN44GwPqqUW4/Wy2HdcnitYqDVQabZyBgz88FmaM5xAkX
         8GE6LKFKwuczEKBDABRRIbhUP9dDzju1Tyjw+1o5j82wRfR9P5iqKiCLRAURW4TqAasU
         IMORgE2ox1Gu5wk/UVvZ5Q9a2h+lNkSli5/MA=
X-Received: by 10.52.6.162 with SMTP id c2mr20458313vda.6.1396289106532; Mon,
 31 Mar 2014 11:05:06 -0700 (PDT)
Received: by 10.220.13.2 with HTTP; Mon, 31 Mar 2014 11:05:06 -0700 (PDT)
X-Google-Sender-Auth: 4m4RJdhQ3-bfv6ddVqLYtu5I9XU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245503>

I hit this oddity when not remembering the right syntax for --color-words..

Try this (outside of a git repository):

   touch a b
   git diff -u --color=words a b

and watch it scroll (infinitely) printing out

   error: option `color' expects "always", "auto", or "never"

forever.

I haven't tried to root-cause it, since I'm supposed to be merging stuff..

                Linus
