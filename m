From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] git-p4: import the ctypes module
Date: Tue, 20 Oct 2015 21:31:46 +0200
Message-ID: <1445369506.8543.10.camel@kaarsemaker.net>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	 <CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	 <xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:32:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zocdw-0002nd-3y
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 21:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbbJTTcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 15:32:08 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37934 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJTTbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 15:31:50 -0400
Received: by wicll6 with SMTP id ll6so43971873wic.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 12:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=MwSDi9rGny2Cu2C/XsYFRkBP/aU6m7AlTm6fDJZt3sc=;
        b=Hvrpxm7IqnGjiY+cUNIv273i00bkJhsURVzgUKIS6FFzmwWILSf3QANVrlgFsCCtI9
         3mX7TRpM6LB/d6gJoPfMIMqAJzurfxEh31O7JDt8CByWRR4DHmZxcP1wOiguUJk4PZm3
         1PdeDaRD0C6rBB9alZfIkqBv0Wh60W6ze0055r3RUULcUA/tDUUB+f5vlrtjDpY7Iroh
         5ulIrf71uPb57omKdc0R+/2kPu1iDJYbArbNEFY2jrI1sEmFADht21Oww+BSHjEcKuFb
         rKv2nxvKNWA3Q+lOyaws89mOHMzHBEFIQe1RPV9u6kAnW+cSDJYu7YYwFRgccW45dS97
         WPFw==
X-Gm-Message-State: ALoCoQn8fN4yEVUaZF8FfGb6mUwYVIzGJlLetzLEdTHocRvkksZWNIpiltHYI3HOkveuxz69wtBA
X-Received: by 10.194.171.69 with SMTP id as5mr6143030wjc.137.1445369509174;
        Tue, 20 Oct 2015 12:31:49 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id i3sm20533555wij.9.2015.10.20.12.31.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2015 12:31:48 -0700 (PDT)
In-Reply-To: <xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279936>

The ctypes module is used on windows to calculate free disk space, so it
must be imported.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

On di, 2015-10-20 at 09:00 -0700, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
> 
> > On 20 October 2015 at 11:34, Etienne Girard <
> > etienne.g.girard@gmail.com> wrote:
> > > Hello,
> > > 
> > > Git-p4 fail when I try to rebase with the error: "NameError:
> > > global
> > > name 'ctypes' is not defined". The error occurs when I use python
> > > 2.7.2 that is installed by default on my company's computers (it
> > > goes
> > > without saying that everything works fine with python 2.7.10).
> > > 
> > > I'm a beginner in python, but simply importing ctypes at the
> > > beginning
> > > of the script does the trick. I was wondering if submitting a
> > > patch
> > > for this issue is worth the trouble, when a satisfying solution
> > > is not
> > > using a 4 years old version of python.
> > 
> > If you're able to submit a patch that would be great!
> 
> Lars's  (git-p4: check free space during streaming,
> 2015-09-26) introduced two references to ctypes.* and there is no
> 'import ctypes' anywhere in the script.
> 
> I do not follow Python development, but does the above mean that
> with recent 2.x you can say ctypes without first saying "import
> ctypes"?  It feels somewhat non-pythonesque that identifiers like
> this is given to you without you asking with an explicit 'import',
> so I am puzzled.

No, you cannot do that. The reason others may not have noticed this bug is that
in git-p4.py, ctypes is only used on windows.

 111     if platform.system() == 'Windows':
 112         free_bytes = ctypes.c_ulonglong(0)
 113         ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()), None, None, ctypes.pointer(free_bytes))

The fact that it works for the OP with 2.7.10 is puzzling (assuming that it's
on the same system). But this patch should help.

diff --git a/git-p4.py b/git-p4.py
index daa60c6..212ef2b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -24,6 +24,7 @@ import shutil
 import stat
 import zipfile
 import zlib
+import ctypes
 
 try:
     from subprocess import CalledProcessError
-- 
2.6.2-323-g60bd420
