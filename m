From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: upps.. problem when rebasing (and subsequent nasties)
Date: Thu, 10 Apr 2008 17:57:20 +0100
Message-ID: <320075ff0804100957t1901f78dhf528eef52140f5a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 18:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk06S-0003gz-0M
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 18:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbYDJQ5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 12:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbYDJQ5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 12:57:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:45719 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbYDJQ5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 12:57:23 -0400
Received: by nf-out-0910.google.com with SMTP id g13so54899nfb.21
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=lgRHWiccnhdmNXHoqd+gcnTn/HWceF0jhiV63gLWoGk=;
        b=Aa3jz/59c5LBKu1cXpyI49rQRlI4KXmTSBkmn1Qh2wcPBnYDBFIQJm40FWuhCKE+v0SmOfu1vC17bjg+JUm7J+0S0LTxd7d0XiuXC94ZrDHigR18A9/jPEJ5oQk2Y8Wbggr++idOIyBhTbJF9WH59c/Q59pWUkcfEHSWsYpFuDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cruRWpv+MHmUQEmAPKwvWuR9m1plny7N1NJMgvvzOhI+vasotB9arixey6u3oaNTrNwFuN5q9f4nvRWUBvoYU6hVlAoKJwi0ZDyuLJoocs9/cGfCEq3UiLYIPZbWTdn/YPeuNnL4Wn26lvtTiOA1Hu7XCex3WHuW6V4OHvCbF7s=
Received: by 10.82.163.13 with SMTP id l13mr1552008bue.46.1207846640957;
        Thu, 10 Apr 2008 09:57:20 -0700 (PDT)
Received: by 10.82.169.1 with HTTP; Thu, 10 Apr 2008 09:57:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79238>

I'm still n00bing around with git, but I've got it into a state which
has me confused..

In doing a git-rebase, I got a number of errors like

error: modules/realtime-app-ui/src/main/webapp/WEB-INF/faces-config.xml:
does not match index
...
Using index info to reconstruct a base tree...

What does this mean? I made matters significantly worse, but managed
to save my bacon with git-fsck --lost-found, but now my working copy
seems really unhappy. If I want to get back to my branch I try

git checkout thing

fatal: Entry 'modules/realtime-app-ui/src/main/webapp/WEB-INF/faces-config-core.xml'
not uptodate. Cannot merge.

I just want to get back to the start, so I
git reset --hard
git checkout foo
fatal: Entry 'modules/realtime-app-ui/src/main/webapp/WEB-INF/faces-config-core.xml'
not uptodate. Cannot merge.

I can probably recover it by blatting everything and starting over,
but I'd like to know what the mess is that I've managed to get into so
I can avoid it in the future!
