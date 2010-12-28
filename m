From: "George V. Reilly" <george@reilly.org>
Subject: git-svn bug: Could not unmemoize function `lookup_svn_merge' ...
Date: Mon, 27 Dec 2010 21:37:27 -0800
Message-ID: <AANLkTi=14DKGzotpZT66dG93uWHhpCa526C8F7Zk_REa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 06:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXSGF-0005Bs-75
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 06:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab0L1Fh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Dec 2010 00:37:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37686 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0L1Fh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Dec 2010 00:37:28 -0500
Received: by ywl5 with SMTP id 5so3776482ywl.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 21:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=DiIbGtMtu/SleY7QgK262PSvx0r22ZYmKZOQi0YJWZk=;
        b=FTkRr8TfWZwepmJYYiUwRn4AFYdMx2kTSNkbcNHuMAEar/Doprj9U2iK25FAbjXX9I
         qTuAzOfbXuVdvkpl8c8zz6nNfdyzsKr5CuhisruJMAPJlvr3aBGeBSuw/f0H0feuFSID
         EwGpc2zSKcRfAWFbPrzYBPrkjbTT89maqSIWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=uOrnyM5TFwitu3XeuiO3Prenmc8QCEvyHL5W3lAVF08iBNlJ7IvIBs7c3OsqA+UGH8
         M0TTMES5SJNfysEUivdFcWIGalYOnTeNVIWRtCVTrAHpmi+AAOwTrqlAsCEVy8qMBpt7
         /L97QiTlYs77urwcZfUJUy3d2dLIlNCtlGDV0=
Received: by 10.100.242.16 with SMTP id p16mr7565523anh.181.1293514647498;
 Mon, 27 Dec 2010 21:37:27 -0800 (PST)
Received: by 10.100.12.10 with HTTP; Mon, 27 Dec 2010 21:37:27 -0800 (PST)
X-Google-Sender-Auth: qhtfeX9KAx1faSanoeYUOyyDVDE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164231>

Using git version 1.7.3.2 on OS X 10.6.5 against the Subversion
repository at work, I got

    georger@George-Reillys-MacBook-Pro-17:~/src/wc-git$ git svn rebase
        M	CoBranding/Resources/USA7/Resources.resx
        M	CoBranding/Resources/Resources.csproj
    Byte order is not compatible at ../../lib/Storable.pm (autosplit
into ../../lib/auto/Storable/_retrieve.al) line 380, at
/System/Library/Perl/5.10.0/Memoize/Storable.pm line 21

    Could not unmemoize function `lookup_svn_merge', because it was
not memoized to begin with at /usr/local/git/libexec/git-core/git-svn
line 3194
    END failed--call queue aborted at
/usr/local/git/libexec/git-core/git-svn line 39.

The error was repeatable.

I managed to get past it by using the git-svn Perl script from Git 1.6.=
5.7,
per http://kerneltrap.org/mailarchive/git/2010/1/13/20137, and invoking=
 it thus:

    $ perl -I /usr/local/git/lib/perl5/site_perl/ ~/temp/git-svn.pl reb=
ase
--
/George V. Reilly=C2=A0 george@reilly.org=C2=A0 Twitter: @georgevreilly
http://www.georgevreilly.com/blog=C2=A0 http://blogs.cozi.com/tech
