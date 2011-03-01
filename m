From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 10:51:39 -0500
Message-ID: <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com> <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 16:52:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuRrq-0003Pj-8g
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 16:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab1CAPwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 10:52:00 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36247 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab1CAPv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 10:51:59 -0500
Received: by vxi39 with SMTP id 39so4279376vxi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=azHEQB/3/dzy2/lF8qgW0Qdoyq8iRTTJQlyJa+9JeDc=;
        b=noUwwqqTqyOFppfHKb4qo8eFWNfT+Sqwt4sp7dTKWvRRJd6s1MzymlTNEupKQYLatU
         BfWVgoPVYj5qbpp7MhlSY8VLdgLEOUAjioUnPEGH1X4VknfuFz8fUoUaNSxMMQf7TosG
         rIkK2aDL+iWXkZP/F0Auzm6Cv8Kw+3GWf2bGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=jaXhorzuv3YyVII9W1AMqGWDa3R60LuliGSCsMMPUBfEzcwzD/qWH0YhAYK5colESL
         gI8tdI03QCA37sZb+e1PBcU/klstIIm0joangOzEyCx+M5hGCB8J11rhiT35w4LNNxCe
         cyHgGyUi7cT1Yi9JjZdleG0eFcyKCjX9T1bOs=
Received: by 10.52.68.65 with SMTP id u1mr4532261vdt.176.1298994719093; Tue,
 01 Mar 2011 07:51:59 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Tue, 1 Mar 2011 07:51:39 -0800 (PST)
In-Reply-To: <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168227>

More info:

$ mkdir foo
$ mkdir foo/bar
$ echo "test" > foo/bar/baz.txt
$ echo "somestuff" > foo/bar/somefile.txt
$ git add foo/bar/*
$ ls -dl foo
drwxr-x--x 1 cjoan cjoan 0 Mar  1 10:46 foo
$ ls -dl foo/bar
drwxr-x--x 1 cjoan cjoan 0 Mar  1 10:46 foo/bar
$ git rm -f foo/bar/somefile.txt
rm 'foo/bar/somefile.txt'
$ ls -dl foo
drwxr-x--x 1 cjoan cjoan 0 Mar  1 10:46 foo
$ ls -dl foo/bar
drw------- 1 cjoan cjoan 0 Mar  1 10:47 foo/bar
$ git rm -f foo/bar/baz.txt
rm 'foo/bar/baz.txt'
fatal: git rm: 'foo/bar/baz.txt': Permission denied



This time I tried it with git 1.7.4.
