From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [mingw port] git plumbing piping with CR/NL
Date: Fri, 1 Jun 2007 14:23:24 -0400
Message-ID: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jun 01 20:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuBmh-0000oK-52
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 20:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653AbXFASX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 14:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760309AbXFASX0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 14:23:26 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:57853 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758653AbXFASXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 14:23:25 -0400
Received: by an-out-0708.google.com with SMTP id d31so195535and
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 11:23:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EqLzug06a1prPK57Dyv3sZRnjg0iom11wJH9Sp2RigfALFHWKZSgym6G9lPjhg+K63D6W38l4l/q2zFKqZp2qZphfsGN4uxd89bBukcTatWMxM01TJa7Dr58fx+qc4ctB1UeVwIhuW0BcPcxmwiPR66SztbccV35LZRj4FFSRgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oaFsjjp8pMV7Et+S3MeU6mM6MdkoBxURzOaHuQn5gpWGE/Xf6ci4TcQEv/BczWBX7/X9m62z9ugz4kop2ILpnQakAewMftzotsjbO6wkenlJnPBQ86dadrd8WEhO5HpaChJkl8/lKTyWyBsvS5S2tl74NAuVtfJVTpu5ca5RSSs=
Received: by 10.100.132.16 with SMTP id f16mr1163521and.1180722205009;
        Fri, 01 Jun 2007 11:23:25 -0700 (PDT)
Received: by 10.100.127.18 with HTTP; Fri, 1 Jun 2007 11:23:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48874>

Hi,

I haven't had time looking at the code yet. I report here so that I
can free my memory for other things. I made a command like this:

$ git ls-tree -r HEAD|grep blah.cc|git update-index --index-info

and the output of git-status was:

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   path/to/blah.cc\r
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#	deleted:    path/to/blah.cc\r
...
$ git version
git version 1.5.2.651.g80e39-dirty (if the commit isn't in the master
branch, it is based on master branch)

Apparently git should ignore \r at the end of the path. Will look at it later.
-- 
Duy
