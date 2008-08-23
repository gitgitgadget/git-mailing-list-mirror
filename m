From: "Mr. Meitar Moscovitz" <meitarm@gmail.com>
Subject: Archiving a git superproject and all of its submodules: git-archive-all.sh
Date: Sat, 23 Aug 2008 20:50:21 +1000
Message-ID: <07897A4C-B639-44AB-8E52-4873CA0D1136@gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 12:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWqjF-0007Sg-Kk
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYHWKua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 06:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYHWKu3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:50:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:17228 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYHWKu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 06:50:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1084594wfd.4
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=SHmqcWG8nfMopOlRu0l0V4YinUJ4AGU83dbW/5Rz3AQ=;
        b=sCBeNQgjV5f4oTj+9meCBOx6woKWQCVlFW/BT+lJUFpoifhzafEbozKSnfjR4assvF
         Up/lvhnJ7jX/1lSOAS+WyF99EIZhuhjAk0SMBPweOKiZKUn0NAoe7blHmS3O7A/eOCdU
         gMnSveBN5pM7j1xaJzko27/CZCOvCsilmTgbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=tvMI598+bvKorX1OQW0wshjcz+ZVqwwkm6rxXBxiMen6/MZNiZGoFDyXyBH5GXAv+o
         H0n7q681ZDQo5QAHbsq5JNNxzQQQ7UZwZq8BQZbCQx+YDDaep5BCTM/U//AtbowTo3gf
         5xt9fE+HEh9/jC5iePJ7uNQUSIBmdF/Jrwp78=
Received: by 10.142.215.5 with SMTP id n5mr777789wfg.131.1219488628102;
        Sat, 23 Aug 2008 03:50:28 -0700 (PDT)
Received: from ?10.1.1.16? ( [124.170.184.61])
        by mx.google.com with ESMTPS id 30sm4719458wfc.5.2008.08.23.03.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 03:50:25 -0700 (PDT)
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93458>

Hi all,

=46irst-time poster, relatively green git user (I switched from =20
Subversion about three months ago). So please don't bite=85yet. :)

A co-worker wanted an easy way to archive a git superproject and all =20
of its submodules (if any), so I created a shell script to do just =20
that after being inspired by a message that I think was posted to this =
=20
list and unfortunately can no longer find. The script is pretty simple =
=20
(by which I mean it's probably kind of stupid), but it is a generic =20
solution and it seems to do the job well. My team has been using it =20
internally to  create deployment-ready tarballs that includes all the =20
code of our (super)project and its dependent code in the git submodules=
=2E

If anyone is so inclined, I'd love some feedback on the script. I'm =20
hosting it under the name "git-archive-all.sh" on Github:

http://github.com/meitar/git-archive-all.sh/wikis

The script has a few things I think are at least a little interesting. =
=20
=46or instance, by default it creates a "super archive" of the project,=
 =20
but it can also be told to produce separate archives for each git repo =
=20
(by passing a --separate option), and you can pass the --prefix option =
=20
just as you can with git-archive, among other things.

Anyway, I hope someone finds this useful at some point.

Kind regards,
--
-Meitar Moscovitz
Personal: http://maymay.net
Professional: http://MeitarMoscovitz.com
