From: "Benjamin Collins" <ben.collins@acm.org>
Subject: git-gui hangs on read
Date: Mon, 21 Apr 2008 09:23:03 -0500
Message-ID: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 16:24:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnwvz-0004Jh-Db
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 16:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbYDUOXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 10:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbYDUOXG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 10:23:06 -0400
Received: from rv-out-0708.google.com ([209.85.198.248]:46698 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757742AbYDUOXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 10:23:04 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1024363rvb.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=84PeYJvo3kwsk47hviIlBmhfwwezRNXxju939wHXxQ8=;
        b=iloXjdBGrFIE4+E+gQ58SkgJOBprw7eYxhwSZI35L3E+oWnTGH62/hSTTzEzVm64YkAdPSflDo3kPii9jW+tjgMCNqE01N95pj40IAUGOThTxPCfv3s6vdHkdiY2ehBp7jhE6pmvaKUbMhtley+r72r+b8rQ3VDHf3ALXXk57RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=U1MGAihphK/9431ND6GUpWpY4PJPm54yKXSLVoQUag4W8fgC9jWHaYwdctjFc42JSsZdY1GWsW/Tm5+yyKAwAkSu2hxhXN1Qk5tZg9a+K0x7GDg8u/+xYau0TSNyRvO0X+/nvvlf6YA5YL9fMMSf9LQehynoOP027tDyTptg12Q=
Received: by 10.141.164.13 with SMTP id r13mr3279394rvo.65.1208787783425;
        Mon, 21 Apr 2008 07:23:03 -0700 (PDT)
Received: by 10.141.75.14 with HTTP; Mon, 21 Apr 2008 07:23:03 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: e072e560aedac3a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80027>

I just upgraded a few machines (RHEL 4.4) to the latest stable, and
git-gui stopped working.  It just hangs forever if it's in a git
repository.  If it's not in a repository, it will open up the dialog
that lets you create or open a repository.  I'm not sure what's going
on, but here's the tail end of the strace -f:

[pid 16903] open("/usr/share/aspell/standard.kbd", O_RDONLY) = 3
[pid 16903] fstat(3, {st_mode=S_IFREG|0644, st_size=100, ...}) = 0
[pid 16903] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a983ce000
[pid 16903] read(3, "# Standard keyboard data file\n\nq"..., 4096) = 100
[pid 16903] read(3, "", 4096)           = 0
[pid 16903] close(3)                    = 0
[pid 16903] munmap(0x2a983ce000, 4096)  = 0
[pid 16903] fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 16903] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a983ce000
[pid 16903] write(1, "@(#) International Ispell Versio"..., 68 <unfinished ...>
[pid 16897] <... read resumed> "@(#) International Ispell Versio"..., 4096) = 68
[pid 16903] <... write resumed> )       = 68
[pid 16903] fstat(0, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 16903] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a983cf000
[pid 16903] read(0,  <unfinished ...>
[pid 16897] write(5, "!\n$$cr master\n", 14) = 14
[pid 16903] <... read resumed> "!\n$$cr master\n", 4096) = 14
[pid 16897] read(6,  <unfinished ...>
[pid 16903] read(0,

Has anyone seen this before?  I wanted to get some other eyeballs on
this before I dive into this rabbit hole.

-- 
Benjamin A. Collins <ben.collins@acm.org>
