From: "Jim MacBaine" <jmacbaine@gmail.com>
Subject: cg-status and empty directories
Date: Mon, 27 Feb 2006 15:43:32 +0100
Message-ID: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 15:44:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDjb6-0003io-US
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 15:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWB0One (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 09:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWB0One
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 09:43:34 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:22070 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751336AbWB0Ond convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 09:43:33 -0500
Received: by zproxy.gmail.com with SMTP id x3so901262nzd
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 06:43:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E3B2yEFirL5NVm2fS7k1bOF0TOiO2OoOAgjF5gHdl30lUmdJAVBqa/2Gk+Zb+HoPG6jvKlTh+Lv2F4+AS2+mtmiw3OX+0jThbdB8xBGTDUsDzTPNfocXbF3RhYcvwuVPTbkS4guVUrztH8GD9d7wIn5WhDVrfesw9iAWgVVfWMk=
Received: by 10.37.15.61 with SMTP id s61mr1669856nzi;
        Mon, 27 Feb 2006 06:43:32 -0800 (PST)
Received: by 10.36.17.8 with HTTP; Mon, 27 Feb 2006 06:43:32 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16849>

Hello,

Short story: Recently I noticed a change in the way, cogito handles
empty directories.  Before, empty directories have been silently
ignored. Now cg-status always lists the status of empty directories as
unknown, but it still refuses to add them. If there is a good reason
for this behaviour, can someone enlighten me?

Long story: I'm using cogito to track and distribute changes on the
/etc directories of a few (almost) identical machines.  Whenever I
install a package which modifies somthing in /etc, I commit those
changes.  But with cg-status reporting all the empty directories as
"unknown", my brain needs a long time to parse the list and find the
really unknown files which shall be put under version control.

Many packages put empty directories under /etc, and although only a
few of those directories are actually needed, the automatic removal of
those packages will fail if I remove the empty directories manually.  
Equally, the removal will fail, if I put a .placeholder file into
those direrectories and cg-add it.  Is there a simple way out?

Regards,
Jim
