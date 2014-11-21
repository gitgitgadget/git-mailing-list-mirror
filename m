From: Fahad Ashfaque <fahadash@gmail.com>
Subject: Cannot set the commit-message editor
Date: Fri, 21 Nov 2014 10:57:17 -0500
Message-ID: <CAOmRNZ4uJEoxroyCRUSDwSC3OAMKTSO0s91_uFDaUit3k8eJLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 16:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrqaO-0006FW-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 16:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835AbaKUP5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 10:57:18 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:37343 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbaKUP5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 10:57:17 -0500
Received: by mail-oi0-f41.google.com with SMTP id a3so3861325oib.28
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 07:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/kyRtDPuTNuyhe9FJ49ub7m55htlBaPAESl8RFZEFJc=;
        b=MmwgRAoAhbgqrdBcN5/jdCMnp+FqcpoPxGSJITpZB9RPIJE03GYH768fXV4yBDJ1V6
         QM2RvQW6cvQ+gb9+qu6IT0zy8qH136iZbsxLjJ/2XXFVgD91RkW4sAvNt3+FQh7Rwkft
         Yg+CkWkXb+TEg7mPbKKAOL5cfebrTvPFhkDDdksjubJDKo/aslltVBlduo3nEvd+9R68
         1Kj0gYakLiecgvAEmXRSwFHxRjBQGHcsyrTA7G86uy1ORCUsl0tV0wHnnY132jDkYAv+
         JfA0FrkCVCYrTUzS9Vu2jIIpmISLdBHOIhEdjrLyJODjatJ7FToeuMW7SLs8HT7wLzBK
         2wEw==
X-Received: by 10.60.52.177 with SMTP id u17mr3510755oeo.14.1416585437054;
 Fri, 21 Nov 2014 07:57:17 -0800 (PST)
Received: by 10.202.75.5 with HTTP; Fri, 21 Nov 2014 07:57:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have downloaded the latest git from git-scm on my windows machine.

I am using git on windows, I am having trouble trying to get notepad++
as my commit message editor.

I have created a shell script called npp.sh which has the following content

/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst
-nosession -noPlugin $1


I figured this is how paths are accepted in git-bash

Now I configured core.editor this way

git config --global core.editor /c/path/to/npp.sh


when I try to commit, using the following command

git commit

I get the following error
$ git commit
error: cannot spawn c:/path/to/npp.sh: No such file or directory
error: unable to start editor 'c:/dev/tools/cmd/npp.sh'
Please supply the message using either -m or -F option.

when I run the following command

ls c:/

I get the directory for my repository's root, not C drive's root

When I run the following command through git-bash

/c/path/to/npp.sh

It works

but when git commit invokes, it does not.

Here is more of what I found

when 'git commit' launches npp.sh, it changes /c/path/to/npp.sh to
c:/path/to/npp.sh

c:/ is not the root of my C drive according to git-bash, c:/ is root
of my repository because when I run 'ls c:/' I get files from root of
my repository.

so may be if 'git commit' does not change /c/path/to/npp.sh to
c:/path/to/npp.sh, it would work... Or if git-bash does not mount c:/
to /c/path/to/myrepository and keep it to /c it would work too.

Please let me know if you need more info on this

Thanks

Fahad
