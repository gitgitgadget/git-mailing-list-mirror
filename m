From: Patrick Sabin <patrick.just4fun@gmail.com>
Subject: How to git diff files in renamed directories
Date: Thu, 15 Mar 2012 09:32:54 +0100
Message-ID: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 09:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S868U-0001Fx-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab2COIdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 04:33:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36340 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab2COIcy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 04:32:54 -0400
Received: by gghe5 with SMTP id e5so2766220ggh.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AmpKvnNKBecjwhFFxU5+zWATDQWx1CnN4bb+nuQGEEY=;
        b=epx1cJlbVJeU0NCLjqKq6uCmlpR52tAptqCWsHYjggbrscFN8ZvJFBo5mSxD1e4IwK
         r3DleROU0icbyklomehj6ZMbmIdLTrGZFTxY1FMW3WRV/m72hRfL39qyHcSAdhlzylNA
         G4B1eJtKtl8vfbZADr1pMzA4EW8EmZbruFz5bAQPF2ef5EBfaZBp+BIl+n2mSlrOUlV+
         LOyj7+qJiHHbwXh0zvBghRUX9aWncq4Lrk7Q1vcn01t1TNVRUfmvIENUVuIdeMJD0QVF
         9XI5N7SHQAmMJz2/qRKwdZ/PkbBNmpOyr4lHI1okY7JgFZVWMDPsm8wj/ziTK03jHj3n
         BxjA==
Received: by 10.229.75.215 with SMTP id z23mr1926089qcj.111.1331800374253;
 Thu, 15 Mar 2012 01:32:54 -0700 (PDT)
Received: by 10.229.142.65 with HTTP; Thu, 15 Mar 2012 01:32:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193199>

Hi,

I want to diff a renamed file (to a different directory) in different c=
ommits.

=46ile a was moved to the file subdir/c

I tried:

$ git diff b616d 0aa0 -- subdir/c a

but git seems to always diff against /dev/null:

diff --git a/a b/a
new file mode 100644
index 0000000..2e5ada8
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+File a
diff --git a/subdir/c b/subdir/c
deleted file mode 100644
index 24c846c..0000000
--- a/subdir/c
+++ /dev/null
@@ -1,2 +0,0 @@
-File b
-Another b change.

git log --follow subdir/c=A0=A0 recognizes that the file has been renam=
ed
and moved to subdirectory.

Is there any way to get such a diff in git?

Regards,
Patrick
