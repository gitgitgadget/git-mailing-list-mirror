From: fREW Schmidt <frioux@gmail.com>
Subject: weird performance bug
Date: Mon, 25 Jul 2011 18:03:52 -0500
Message-ID: <CADVrmKQ5YU9qBVT_Xi1GcGr8PRzyLzHCsA2bHqzmrvtCXw9JEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 01:04:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlUCA-0002GB-Gk
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 01:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab1GYXEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 19:04:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36093 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1GYXEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 19:04:13 -0400
Received: by gwaa18 with SMTP id a18so2919510gwa.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=COJKCpUMIgk+923CdWJXrr49lYscNT0VtwrRvcEx4zE=;
        b=qi48sLBFSZXPe2wpZ+iUq3SFYQ+JxzddvRRg5FApGpl2A3D86rcEx9Ln7jJPYJsYIj
         yzSCC8rFsWbMJXjsm0pbSjo7GHLkMfUpecnokSgoTTWrYQawY8c1GTjVMSsDKa5yH4ys
         /j5LcDrF005oDZ29bV2d18SFpwgTffqTVM6+g=
Received: by 10.142.248.12 with SMTP id v12mr3177592wfh.134.1311635052069;
 Mon, 25 Jul 2011 16:04:12 -0700 (PDT)
Received: by 10.142.44.16 with HTTP; Mon, 25 Jul 2011 16:03:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177832>

I'm not really sure how to reproduce this without sharing my whole
repo so I'll explain it first.

I did a fairly large merge today at work and in the process, so that I
could skim some stuff, I set gitk to have zero lines of context.
After finally committing the merge, if I ran gitk, it would consume an
entire core trying to (I'm guessing) render the diff for gitk.=A0 It
never completed, and even after closing gitk, there was still a git
process in the background pegging a core.=A0 If I fix the lines of
context to be 3 again and restart gitk the problem goes away.

This occurred on ubuntu with git 1.7.6.

--
fREW Schmidt
http://blog.afoolishmanifesto.com
