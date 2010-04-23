From: Ricky Clarkson <ricky.clarkson@gmail.com>
Subject: Case sensitivity on Windows for absolute paths.
Date: Fri, 23 Apr 2010 15:12:26 +0100
Message-ID: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 16:12:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Jcj-00063m-Tb
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 16:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561Ab0DWOMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 10:12:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:64536 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0DWOMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 10:12:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so209150fgg.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=QJXVWszgTn7wjtL3E0a0oaQR3xVdkKux+ij/yQ6MlNo=;
        b=MFA9ZKrGexa3WU/kmBUqg5KrseEezxP8/CLBLTKNmxr3PScTBJXLAO/LZnHQZzE+8C
         88R3X+n6iwx0SbwiYWOCNBFXavYSFMGd9kL8r1fUktEb/lDCFWDephKbbU3GsGSxk/Ig
         32bl3K4CC+uZautDh6UKRE82WB0yzwKmmjKEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=sUhQkQmuZRGSZPoOp5YfGaOltpsvgVhlDJJjhzT2fdJ5OiId0UUZIb7+SvEp3L57Ya
         2n72069K5bPIHdL6qUbHXY6t1wbLKGi9D01yTHFeJgENHNkWqrWYV18j/StyAUOG8DSk
         LZRlvFAkBMd/hSUyW26FNLU0xU2KdaoZCcj7E=
Received: by 10.87.61.22 with SMTP id o22mr466703fgk.50.1272031966209; Fri, 23 
	Apr 2010 07:12:46 -0700 (PDT)
Received: by 10.223.126.3 with HTTP; Fri, 23 Apr 2010 07:12:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145616>

Hi,

I noticed that if I have a git repository at C:\foo, and there is a
file in there named bar, git add bar works fine, git add C:\foo/bar
works fine but git add c:\foo/bar does not.  git reports that the file
'is outside repository'.  Looking at setup.c it seems that string
comparisons are being used to determine whether a file is within the
repository.

For my purposes I can probably make a Windows build that does it while
ignoring the case, but is there a more proper way that git should do
it?  I'm not familiar enough with the POSIX file routines to know.

A separate tool, maven, is what specifies it as lowercase, otherwise I
would obviously just write C: instead of c: myself.  I think I know
how to fix that so it uses relative paths, and will look into that,
but it would be good to have git do the right thing too.

Thanks,
Ricky.

--
Ricky Clarkson
Java and Scala Programmer, AD Holdings
+44 1928 706373
Skype: ricky_clarkson
Google Talk: ricky.clarkson@gmail.com
Google Wave: ricky.clarkson@googlewave.com
