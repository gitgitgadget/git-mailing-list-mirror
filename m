From: Hamilton Turner <hamiltont@gmail.com>
Subject: Potential bug in ls-files (version 1.7.9.5)
Date: Mon, 7 Jul 2014 17:46:02 -0400
Message-ID: <CAFow3A_f+nPCR1zqS9WdH1V9pNdSP=zRNt2UxbHpOz1d6miQEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 23:46:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Gjh-0007qM-Lt
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 23:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaGGVqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2014 17:46:05 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62068 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaGGVqE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2014 17:46:04 -0400
Received: by mail-qa0-f53.google.com with SMTP id j15so4130528qaq.12
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=DeiVq1h134IqadnEyxYHE25q4xthoggkUpAX4Tkjs38=;
        b=cb9XKLrOnon+VphY5l5EOPE3fd3yNR3OBnk/9m5Pg8ZKqG0NTmBkAkxYIFzggZD2TH
         IyA3XsUT7r6PnOjMp3DMhN/FlmC8RVCVfD6SSBlw4UaFxMB3nkEyUAztQCxY9AAqj6dj
         ANIbtRUVdx6CNnnrcMlzRGIgo/Qmh0vOflvta9CPGRIXOo8CJj6NPy0TnXPM4WnAKew7
         4nIAbJeneJGRvvIeSnb1nlsggOKTjo9NHKdJjXI8f8Z5ZlvejZXJ0aLm5XZpWq4dFKVX
         00NQkkVwy7frA2fy9BvS410OtuYVnwuEK8Za/tudBPUsla1/1LXJ1oThAMyylJMeQgl+
         lkww==
X-Received: by 10.140.37.9 with SMTP id q9mr43463529qgq.32.1404769562645; Mon,
 07 Jul 2014 14:46:02 -0700 (PDT)
Received: by 10.140.32.7 with HTTP; Mon, 7 Jul 2014 14:46:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252989>

I'd appreciate if someone could confirm that this is a bug in git, as t=
his works
as expected with git 1.8.5.2.

I'm not sure if this 1.7.X is still supported, but I think it's still
the latest git-core available
in Ubuntu 12.04 repositories.

I'm having problems with git ls-files --others --ignored
--exclude-standard not listing some ignored files.

My project has this directory structure

=2E
=E2=94=9C=E2=94=80=E2=94=80 aspnet
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 .gitignore
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 __init__.py
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 lib
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 <lots of big stuff>

My aspnet/.gitignore lists lib/*, and git add aspnet/lib/foo reports
that this path is ignored.

But git ls-files --others --ignored --exclude-standard does not list
the files under lib. These are untracked files, they do show up in
output if I do git ls-files --others, but not if I provide the ignored
flag.

With 1.8.5.2, all of the files under lib are listed if I ls-files
--ignored --others --exclude-standard

Tracks http://stackoverflow.com/questions/24620108/show-all-ignored-fil=
es-in-git

Thanks,
