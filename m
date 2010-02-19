From: Laine Walker-Avina <lwalkera@pasco.com>
Subject: Git has bad performance when traversing change-sets with large PPM 
	files
Date: Fri, 19 Feb 2010 13:24:05 -0800
Message-ID: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 22:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiaKf-0008UD-1v
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 22:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0BSVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 16:24:10 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:7524 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab0BSVYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 16:24:05 -0500
Received: by qw-out-2122.google.com with SMTP id 8so97739qwh.37
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=/gjl9hnDdm/UsYLUUp8ei9ygQElDmklhgYClkgXncTY=;
        b=culbOzKs2H3uEi4jPoQW/iyZj8C8YxUVkR5UXUTXAPD6qYYdaCmFqylYCww6VfNOka
         2cKYoHxiDQHzm1mJMlx7UlqLn6BbRK2vvX2tRPlIbFoGZAbUeEuSVmmZl2uqNv0CKGZ6
         fm6/flvpkEUZ3zICsnjf6eXGP5TzhtZWd0R9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=jJbEr9aqAbyOD7nr7gyp5gf9xZzuDdxjkcNrTDIFpdztiMao0eV1UJaS9Pf6tdkPbn
         ZcNHdp0RuyOyBRarICYuSZ8944bQNJ8Q12Pb5S33WQxL0d1EU2WAn62MZtmeDUBLvdG4
         kjZ+PDPh4MzaLI4Nqj7nO8Y4sp7wpK+ory9Z8=
Received: by 10.224.27.37 with SMTP id g37mr536797qac.124.1266614645301; Fri, 
	19 Feb 2010 13:24:05 -0800 (PST)
X-Google-Sender-Auth: 4673548d940e4ae8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140483>

Steps to reproduce:

1. Create a new git repo and add a 640x480 PPM image in ASCII format
2. Add a .gitattributes file with the line "*.ppm binary"
3. Commit the PPM file
4. Change the PPM image's contents
5. Add and commit
6. Try to do a git rebase -i to the initial commit
7. Watch the CPU peg at 100%

I'm using git version 1.6.3.3

Please CC me, I'm not on the list.

Thanks,
-- 
Laine Walker-Avina
Firmware Engineer
PASCO scientific
