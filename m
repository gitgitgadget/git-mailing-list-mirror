From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Moving a directory into another fails
Date: Wed, 26 Jul 2006 19:03:30 -0400
Message-ID: <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
	 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 01:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5sPg-0007hd-MY
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 01:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWGZXDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 26 Jul 2006 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWGZXDd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 19:03:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:44485 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWGZXDc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 19:03:32 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3398644ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 16:03:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AsALn8G9OkkqZxc7PsCFzY2M2yhsDtKa/If7EhvsieEBa7dz0qUgFBADSWd/MhFvVwNKI0k26I8h/KuMKNq0x52vOUbzsDukDE+CRQtUrpHkIgIAsOEB60xxqtUUc/zQbZrAt0bqVGaJh7jhK6Q7tLVhGhvH+hWQgM0ICSwMs2A=
Received: by 10.78.140.17 with SMTP id n17mr3498753hud;
        Wed, 26 Jul 2006 16:03:30 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 16:03:30 -0700 (PDT)
To: "Nicolas Vilz" <niv@iaglans.de>
In-Reply-To: <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24259>

This is a simpler sequence

cg clone git foo
cg clone git foo1
cd foo
mkdir zzz
git mv gitweb zzz
cg diff >patch
cg ../foo1
cg patch <../foo/patch

=46ails with these errors. We have determined that git apply patch is o=
k
and this is a bug in cg patch.

[jonsmirl@jonsmirl foo1]$ cg patch <../foo/patch
mv: cannot move `gitweb/README' to `zzz/gitweb/README': No such file
or directory
mv: cannot move `gitweb/gitweb.cgi' to `zzz/gitweb/gitweb.cgi': No
such file or directory
mv: cannot move `gitweb/gitweb.css' to `zzz/gitweb/gitweb.css': No
such file or directory
mv: cannot stat `"gitweb/test/M\\303\\244rchen"': No such file or direc=
tory
mv: cannot move `gitweb/test/file with spaces' to
`zzz/gitweb/test/file with spaces': No such file or directory
mv: cannot move `gitweb/test/file+plus+sign' to
`zzz/gitweb/test/file+plus+sign': No such file or directory
patch: **** Only garbage was found in the patch input.
Removing file gitweb/README
Adding file zzz/gitweb/README
error: zzz/gitweb/README: does not exist and --remove not passed
fatal: Unable to process file zzz/gitweb/README
cg-add: warning: not all items could have been added
Removing file gitweb/gitweb.cgi
Adding file zzz/gitweb/gitweb.cgi
error: zzz/gitweb/gitweb.cgi: does not exist and --remove not passed
fatal: Unable to process file zzz/gitweb/gitweb.cgi
cg-add: warning: not all items could have been added
Removing file gitweb/gitweb.css
Adding file zzz/gitweb/gitweb.css
error: zzz/gitweb/gitweb.css: does not exist and --remove not passed
fatal: Unable to process file zzz/gitweb/gitweb.css
cg-add: warning: not all items could have been added
Removing file "gitweb/test/M=E4rchen"
Adding file "zzz/gitweb/test/M=E4rchen"
error: "zzz/gitweb/test/M=E4rchen": does not exist and --remove not pas=
sed
fatal: Unable to process file "zzz/gitweb/test/M=E4rchen"
cg-add: warning: not all items could have been added
Removing file gitweb/test/file with spaces
Adding file zzz/gitweb/test/file with spaces
error: zzz/gitweb/test/file with spaces: does not exist and --remove no=
t passed
fatal: Unable to process file zzz/gitweb/test/file with spaces
cg-add: warning: not all items could have been added
Removing file gitweb/test/file+plus+sign
Adding file zzz/gitweb/test/file+plus+sign
error: zzz/gitweb/test/file+plus+sign: does not exist and --remove not =
passed
fatal: Unable to process file zzz/gitweb/test/file+plus+sign
cg-add: warning: not all items could have been added
[jonsmirl@jonsmirl foo1]$



--=20
Jon Smirl
jonsmirl@gmail.com
