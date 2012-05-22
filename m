From: Samuel John <mail@samueljohn.de>
Subject: contrib/credential/osxkeychain: Makefile should allow to set CFLAGS
Date: Tue, 22 May 2012 22:25:51 +0200
Message-ID: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 22:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWveb-0001at-RA
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab2EVUZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:25:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59843 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab2EVUZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:25:56 -0400
Received: by bkcji2 with SMTP id ji2so5357088bkc.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=sender:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=YpbB9h5ni8WpWPB7a43G+AxMYmyQeDNwfCRx+6Ep9oE=;
        b=aieiSGq1s0OzToU8dAHUpQr25y+lxRmPEms/G73gLBW+zEClwgc26NLqs0geSR4ky/
         3NGaiJvChhTn0j040jFx80J2OAp7FFUzJIE7F1YN1FS+DhYLBa1AhJWEuLdrdNe0WFka
         HwtyQy0e7aJo32GrZCLWEMYzNyIh/o0aWEFxXEGLmXjdeg/MvKT42fvSfwr6L4QP/vVc
         m8M4el+OOQNmV8HCfgNGL80D8BONFx/GxkfDEoKwRPDx+CkmRDFAiRZtTowZcF5+Ck4l
         iP35v9K1k9pA50i/1qDtklfW/zmyrlI/N94uwK6dtwPVd8qtJyalxlRxb9zD2qPAUrQ4
         TgQg==
Received: by 10.204.129.196 with SMTP id p4mr10564673bks.28.1337718354734;
        Tue, 22 May 2012 13:25:54 -0700 (PDT)
Received: from samuels-macbookpro.speedport_w723_v_typ_a_1_00_092 (p4FEF53A1.dip.t-dialin.net. [79.239.83.161])
        by mx.google.com with ESMTPS id ig1sm33987431bkc.4.2012.05.22.13.25.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 13:25:53 -0700 (PDT)
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198242>

Hi there,

the contrib/credential/osxkeychain/Makefile goes like this

> CC = gcc
> RM = rm -f
> CFLAGS = -g -Wall
> 
> git-credential-osxkeychain: git-credential-osxkeychain.o
> 	$(CC) -o $@ $< -Wl,-framework -Wl,Security
> 


and does not allow me to pass CFLAGS to build git-credential-osxkeychain.o.
My hack is to call: make CC="$CC $CFLAGS"
That is ugly.

Would you mind to add the CFLAGS to that CC call?

bests,
 Samuel
