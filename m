From: Jari Aalto <jari.aalto@cante.net>
Subject: git 1.5.4 push/pull failure (1.5.3.8 works ok)
Date: Thu, 07 Feb 2008 11:54:55 +0200
Organization: Private
Message-ID: <fxw5w0pc.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 10:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3Uc-0007gw-Rw
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYBGJz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbYBGJzz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:55:55 -0500
Received: from main.gmane.org ([80.91.229.2]:58562 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbYBGJzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:55:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JN3Tv-0000ho-GO
	for git@vger.kernel.org; Thu, 07 Feb 2008 09:55:47 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 09:55:47 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 09:55:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:1YY2o8li1BU//qqcx0xdqRL9BiQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72918>


I just upgraded Git in SunOS/Debian/Cygwin and the 1.5.4 version causes
constant pull/push failures over ssh:

    $ git pull
    ...
    Resolving deltas: 100% (141/141), completed with 11 local objects.
    fatal: Fetch failure: jaalto@host:srv/git/repo

I downgraded all back to 1.5.3.8 in all hosts, and the pull/push failure
problem disappeared.

Jari

-----------------------------------------------------------------------
SunOS:

 $ uname -a
 SunOS host 5.9 Generic_118558-35 sun4u sparc SUNW,Serverblade1

 $ ldd /usr/local/bin/git
        libz.so =>       /opt/csw/lib/libz.so
        libiconv.so.2 =>         /opt/csw/lib/libiconv.so.2
        libsocket.so.1 =>        /usr/lib/libsocket.so.1
        libnsl.so.1 =>   /usr/lib/libnsl.so.1
        libcrypto.so.0.9.8 =>    /opt/csw/lib/libcrypto.so.0.9.8
        libc.so.1 =>     /usr/lib/libc.so.1
        libdl.so.1 =>    /usr/lib/libdl.so.1
        libmp.so.2 =>    /usr/lib/libmp.so.2
        /usr/platform/SUNW,Serverblade1/lib/libc_psr.so.1

Cygwin:

  $uname -a
  CYGWIN_NT-5.0 host 1.5.25(0.156/4/2) 2007-12-09 09:47 i686 Cygwin

    D:\cygwin\bin\git.exe
      D:\cygwin\bin\cygcrypto-0.9.8.dll
        D:\cygwin\bin\cygwin1.dll
          C:\WINNT\system32\ADVAPI32.DLL
            C:\WINNT\system32\NTDLL.DLL
            C:\WINNT\system32\KERNEL32.DLL
            C:\WINNT\system32\RPCRT4.DLL
      D:\cygwin\bin\cygiconv-2.dll
      D:\cygwin\bin\cygz.dll

Debian/unstable (hand compiled deb-src 1.5.3.8):

  $ ldd /usr/bin/git
        linux-gate.so.1 =>  (0xffffe000)
        libz.so.1 => /usr/lib/libz.so.1 (0xb7f0f000)
        libc.so.6 => /lib/i686/cmov/libc.so.6 (0xb7dc2000)
        /lib/ld-linux.so.2 (0xb7f3a000)

-- 
Welcome to FOSS revolution: we fix and modify until it shines
