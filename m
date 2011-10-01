From: Albert Zeyer <albzey@googlemail.com>
Subject: Git, Mac OS X and German special characters
Date: Sat, 1 Oct 2011 14:44:14 +0200
Message-ID: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 14:44:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9yvb-0005If-NA
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 14:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab1JAMoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 08:44:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39918 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab1JAMoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 08:44:15 -0400
Received: by vcbfk10 with SMTP id fk10so1851931vcb.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=bjBhWKivVsJe6OvGIgEMIb7CwEpVM6LXBhpJDNuoSII=;
        b=t8h49c1ZjPVGoJ8G3u9j/fSF6tu0XaNnjjQPgL7gzBff/YhKgTzWz2IuDmGMN4xsW4
         yEoO5jW7R65wKUIg2rqVZtXa+St6DNLHjY46T357q1htPwfB0+W0keQUfrJxMReCH8Wj
         6qn0PydBJBUjyJZbojirn/VGCEpqDl9D3dKe8=
Received: by 10.52.174.113 with SMTP id br17mr1781589vdc.508.1317473054429;
 Sat, 01 Oct 2011 05:44:14 -0700 (PDT)
Received: by 10.52.112.10 with HTTP; Sat, 1 Oct 2011 05:44:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182548>

Hi,

There are problems on MacOSX with different UTF8 encodings of
filenames. A unicode string has multiple ways to be represented as
UTF8 and Git treats them as different filenames. This is the actual
bug. It should treat them all as the same filename. In some cases (as
on MacOSX), the underlying operating system may use a normalized UTF8
representation in some sort, i.e. change the actual UTF8 filename
representation.

Similar problems also exists in SVN, for example. This was reported
[here](http://subversion.tigris.org/issues/show_bug.cgi?id=2464).
There you can find also lengthy discussions about the topic. And also
[here](http://svn.apache.org/repos/asf/subversion/trunk/notes/unicode-composition-for-filenames).

This was already reported for Git earlier and there is also a patch
for Git [here](http://lists-archives.org/git/719832-git-mac-os-x-and-german-special-characters.html).

I wonder about the state of this. This hasn't been applied yet. Why?

Regards,
Albert
