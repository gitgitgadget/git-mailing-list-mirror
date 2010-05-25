From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: (Mosty harmless) protocol error when pushing
Date: Tue, 25 May 2010 08:51:34 +0200
Message-ID: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org\"" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 08:51:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGnzL-0007cE-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295Ab0EYGvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 02:51:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52254 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab0EYGvg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 02:51:36 -0400
Received: by wyb29 with SMTP id 29so2102937wyb.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=iYOaOIDwvb/diE/pVuQBiWpuXLL24hbQwbGnhtZ+k5I=;
        b=MuEu34Al2pA9wBBdlDhmhDCHI/E7448DN1kSSVzl3lARo1HkCiHI3zYVE8msf7ZtWQ
         gVccPq/G7pl6C5f4d0b3ZF9oLVNWF7Lu+etS6kd1J2Cyu5iZZsrRBcnYu/eg10/rH15E
         2SyyPdRRTUtrXQ0sWp1yGBbOcp1eYj46LRxTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vArdEUTdwusyKVf9dRyr1S68Qw0IRthHUQ/Fv45aoVN1LomQRntJYHyrMt+mswwrUZ
         egH4uFdYiOlftsffjvVGQ9uNESpd59+QrRfBV9ztV4rfG+ucH0n3NrPNv4E6ddIuR01y
         QXt0RUV9idt21MGDAPInt9WtQyn6zW++A+rfE=
Received: by 10.216.156.193 with SMTP id m43mr4234675wek.11.1274770294130; 
	Mon, 24 May 2010 23:51:34 -0700 (PDT)
Received: by 10.216.183.204 with HTTP; Mon, 24 May 2010 23:51:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147670>

I am not sure whether this has been reported before.
I follow this mailing list, but I don't read all emails in
detail, so I could have missed a bug report or a fix
for the problem.

Anyway, what seems to happen is that some protocol
error happens when an automatic GC is triggered
during a push. The push succeeded, despite the
error messages.

My version of git is 1.7.1.86.g0e460. Here is
what happened (I force-pushed a single branch):

Counting objects: 270, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (71/71), done.
Writing objects: 100% (184/184), 151.33 KiB, done.
Total 184 (delta 157), reused 134 (delta 113)
Auto packing the repository for optimum performance.
fatal: protocol error: bad line length character: Remo
error: error in sideband demultiplexer
To git@github.com:bjorng/otp.git
 + 7651a63...874192d bg/nif_error -> bg/nif_error (forced update)
error: failed to push some refs to 'git@github.com:bjorng/otp.git'

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
