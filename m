From: Romain Geissler <romain.geissler@gmail.com>
Subject: Git global usage and tests
Date: Mon, 30 May 2011 16:58:14 +0200
Message-ID: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 16:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3vA-0000pw-Pn
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757161Ab1E3O6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 10:58:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34630 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1E3O6P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 10:58:15 -0400
Received: by wwa36 with SMTP id 36so3983682wwa.1
        for <git@vger.kernel.org>; Mon, 30 May 2011 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:cc:to:mime-version:x-mailer;
        bh=Huw/mNp4ZbvvnxYB66FNev3hSsKjTldRkn5NkcSDlJA=;
        b=XX51abyLYHVIch/+TlqwCYaf9PgRFlaHr6JOefCvGNM3bxLb92wE4yCiyfyARlZW+C
         hSgrNnkWTQEjbVjAvfvhN5vCMyaRCvZeC5NtQYzFTtTdgudqmzMP23vgEEwN1cRyjgAP
         oT0cy46iVFw/CnsJhg6QUDl2V8/fNg07p3Juo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=ERfi6uJZTgr1yoptD6X45u+C6n3sBUA2NW+idB+iKghW5KtOP2m+FBaM+zMYcFMa7E
         hAVxmKnC6Z4K052wRIVm6P4QQRRQlu8Zqr7AVXX8haOMK1uip8BelBbWKS5SqWmGf68O
         0tUGwnLsBogRIhOAR6VhjpDviJDBipehaY8jQ=
Received: by 10.216.141.1 with SMTP id f1mr4972042wej.35.1306767494196;
        Mon, 30 May 2011 07:58:14 -0700 (PDT)
Received: from ensi-vpn-107.imag.fr (ensi-vpn-107.imag.fr [129.88.57.107])
        by mx.google.com with ESMTPS id o75sm2542404weq.40.2011.05.30.07.58.13
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 07:58:13 -0700 (PDT)
X-Mailer: Apple Mail (2.1082.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174753>

Hello,

We are currently coding a minimal git client using libgit2, and as quoted by David Glesser in another mail, we use the git test base on our client to validate it. We found a test that tries to run git with a specified --git-dir but don't use the way it's described in the help.

Indeed the test t2050-git-dir-relative.sh run :

echo changed >top &&
git --git-dir subdir/.git add top &&
git --git-dir subdir/.git commit -m topcommit &&
test -r "${COMMIT_FILE}"

But according to the git help, it should have specified a git-dir with --git-dir=value ie
git --git-dir=subdir/.git add top

Am i wrong or the test must be rewritten ?

Romain Geissler