From: Michael Wookey <michaelwookey@gmail.com>
Subject: build warnings
Date: Fri, 29 Jan 2010 20:03:37 +1100
Message-ID: <d2e97e801001290103r5b9cfc2aq8daec90c8c88f2ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 10:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Namlr-0001Ui-MM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 10:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab0A2JD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532Ab0A2JD7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 04:03:59 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:39423 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab0A2JD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 04:03:57 -0500
Received: by pxi12 with SMTP id 12so1351936pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=AqUMruoX7AB4pcDHEdYbtloctDlxfvNI0eyUwwWxpjA=;
        b=IsQJ0rAoFy8/VwQ6/GF8Q17YINESYD+zdFAAowO3GWrEdkuNGAYirnPXBcoS9NvpFw
         ssjO/2hWVBlYfyyrikM2wML6t+WYDiXg22ZGI/A9ri/NiDcvtBItD2VvuwwdvZYY7so9
         t1PqSu1506C5Tk8EWbMbR4FMPQt7FguFjEHlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=WKcci4unMQ5NcmJhQRuWdYEgjGyvMehbJmzD+Gs7lkA27cYKCAfvemhuP0GE8xZdX0
         eIWI1gByXW92Y3UfuPmmbqGUOpuAdJJHYNmehNdWSkNzyNgS2FxKsA1tglduzZ5tZTT1
         4wZNviwdYOQ61sHHxeGt4cU1FYGHejL+XNvrI=
Received: by 10.115.85.10 with SMTP id n10mr406446wal.13.1264755837108; Fri, 
	29 Jan 2010 01:03:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138303>

=46YI,

With current master (dace5dd1), the following build warnings appear on
Ubuntu 9.10 (x86):

  run-command.c: In function =E2=80=98notify_parent=E2=80=99:
  run-command.c:70: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
declared with attribute warn_unused_result
  run-command.c: In function =E2=80=98die_child=E2=80=99:
  run-command.c:80: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
declared with attribute warn_unused_result
  run-command.c:81: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
declared with attribute warn_unused_result
  run-command.c:82: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
declared with attribute warn_unused_result

These warnings were introduced by the following commits:

  2b541bf8 ("start_command: detect execvp failures early")
  a5487ddf ("start_command: report child process setup errors to the
parent's stderr")

The GCC details are:

  ~$ gcc --version
  gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
