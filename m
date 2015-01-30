From: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>
Subject: [git-gui] bug report: "Open existing repository" dialog fails on submodules
Date: Fri, 30 Jan 2015 16:46:08 -0500
Message-ID: <CAMto89Dvz-u+at4CPLGQRak4niOJk1trSCn2wQugLUnD1h=Fjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 22:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHJOc-0005i0-0w
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 22:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763155AbbA3Vq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2015 16:46:29 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36004 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbA3Vq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 16:46:29 -0500
Received: by mail-oi0-f46.google.com with SMTP id a141so36864686oig.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 13:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=DT+wia7Ypx971g3gi1aL+MDaXkYG5tObiIAkJPG+7EI=;
        b=rSqwUlzsyER1HfaxOE0VrAVu0Gi1dlVcOwa7qul6rzipV2kU7pcVndrcxuViGBbSwU
         ALdIK+vaiH+BaLxCyIphbF1ma17LVQqwtI6Qv5OQB9oQ47kPMSW5Jgm9TuTyiqzVR8OV
         Ve+7DlVE9IWzZ65/IogZd0r41cTnxDaiR+EPZBGCCCn8ybJUwcGGgFBRA+rLeFs3+Q40
         wQG0oGEfsl2eyGcua8QVXh+CUrKqkb9GeSZ4fgVtrXqKBWfO51d+5f6CU3OFc2ZZrvt7
         odUDTLdYQwUibBSys1h5Wk12edUL+Q8x+7EfaliIAPzCw4TFWbwzA4o/eibD02aXJ8tb
         aF3w==
X-Received: by 10.202.168.141 with SMTP id r135mr4913648oie.92.1422654388395;
 Fri, 30 Jan 2015 13:46:28 -0800 (PST)
Received: by 10.182.112.166 with HTTP; Fri, 30 Jan 2015 13:46:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263199>

Hi,

This bug report concerns git-gui. Apologies if this is not the right
mailing-list.

By submodule I mean a repository for which .git is not a regular Git
directory, but rather a "gitdir: ..." file.
While running "git gui" from such a directory will work fine, trying
to open it from the choose_repository window will fail with "Not a Git
repository". This is because of the simplistic implementation of proc
_is_git in lib/choose_repository.tcl.

I suggest fixing that function, or using Git directly to perform that
check, for instance checking "git rev-parse --show-toplevel". I'd
attempt a patch but my tcl-fu is weak.

Best
--=20
R=C3=A9mi Rampin
