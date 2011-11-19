From: Jay Soffian <jaysoffian@gmail.com>
Subject: clean bug on ignored subdirectories with no tracked files?
Date: Sat, 19 Nov 2011 00:38:24 -0500
Message-ID: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 06:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRddG-0004lG-O4
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 06:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab1KSFiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 00:38:25 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63507 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1KSFiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 00:38:25 -0500
Received: by ywt32 with SMTP id 32so3202720ywt.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 21:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DnzbYNmAhhxBU/YX7TzaJjz66nbnrZOE7MBWvJUFvt4=;
        b=pa3WnSj1DXfgpsLabZLqAMFpBB6PsW9TOv3Ie0TkTS0wZXGDdQliEeeuJMyH3dLXIK
         YDU4zXelTwCUvnpndu5WeQUlHiPV3md/oo4jHsWborJ++Wsd3fqwdEpuOzfA2Nt/xxTc
         A4d+gyth7qRBSk+q7cQoltYs0de30HF0qxqz8=
Received: by 10.236.170.72 with SMTP id o48mr9718315yhl.43.1321681104478; Fri,
 18 Nov 2011 21:38:24 -0800 (PST)
Received: by 10.147.125.14 with HTTP; Fri, 18 Nov 2011 21:38:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185689>

git init test_repo &&
cd test_repo &&
mkdir -p foo/bar &&
echo baz > foo/bar/baz &&
echo /foo/bar > .gitignore &&
git add .gitignore &&
git clean -n -d

Initialized empty Git repository in .../test_repo/.git/
Would remove foo/

Seems surprising. The work-around is either using '/foo' in the
top-level .gitignore or adding a tracked file to the 'foo' directory.

j.
