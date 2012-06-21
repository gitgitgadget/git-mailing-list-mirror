From: Petr Onderka <gsvick@gmail.com>
Subject: gitk --follow doesn't show changes correctly
Date: Thu, 21 Jun 2012 14:56:01 +0200
Message-ID: <CAPyqok3Nh7jzwDS31xnFQm1h9=ttxmqoYt_tsLLUqpmi_4NWcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 14:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShgwK-0002kc-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 14:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759558Ab2FUM4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 08:56:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42213 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759555Ab2FUM4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 08:56:43 -0400
Received: by eaak11 with SMTP id k11so190692eaa.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Tl/e8I5+wNq0Hg3vN+xIzDJr6s6akjp4ukgOK5jZlNg=;
        b=wXYafkjNKGM6LSfLX+qPRLldx0j7rPV3uuW9lPNlpU6H5TcOJTz6jijwMaIqZ1UKjy
         Bsg5iy0v0igDfhxO1qNU1MkbhUORkp+6kWOiTG29ParibZGxPAaTjIde334F+8/KN6Y/
         Xf5y2f1O/sZMTLQhDHyE+PLTt4mnJ37bPSWbDgYUJlJW8MhRJrdpSVIrjUw41wGXGGYY
         IKfjr4bHicrp4cD5DeNOp/9fKskrpcKn2EnC5QxMHgSOWmr83Ii/r85FQmvOSh1WPUVl
         RkhiSCxAvmCpnGzeGmtke481l8UjBiMVCsHCxhXudRZGxr30++viHk0fG8+qG6gFJ4H7
         TKxw==
Received: by 10.14.127.130 with SMTP id d2mr5842750eei.216.1340283402254; Thu,
 21 Jun 2012 05:56:42 -0700 (PDT)
Received: by 10.14.50.76 with HTTP; Thu, 21 Jun 2012 05:56:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200400>

Hi,

if I try to see the history of a file across copies by "gitk --follow file",
it seems it shows the correct revisions (although disconnected),
but for revisions that modify the file under some older name,
the diff of those changes is not shown.

For example, I have a file f1, modify it in revision A,
then copy it to f2 and modify it in revision B,
and finally modify f2 in revision C.

If I execute "gitk --follow f2", I can see revisions A, B and C.
But in revision B, the diff shown contains the whole of f2 (as a new file)
and the diff for revision A is completely empty.

What I'd like to see in revision B is the diff between f2 and f1 at that point
and in revision A the diff for f1.

I don't think gitk can do this currently (I'm using v1.7.11.msysgit.0),
so, unless I'm mistaken, consider this as a feature request (or a bug report).

Petr Onderka
