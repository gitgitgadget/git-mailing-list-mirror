From: skillzero@gmail.com
Subject: git show on bare repository?
Date: Sat, 1 Aug 2009 20:51:45 -0700
Message-ID: <2729632a0908012051i28654bb7m418ff2ed00138815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 05:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXS72-0003Fd-U2
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 05:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZHBDvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 23:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHBDvq
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 23:51:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:17909 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZHBDvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 23:51:46 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1457249qwh.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vwjUkfzkLpPAaZFSB2OVSdH2Ve2hs8mxYaHJWVPtKPs=;
        b=PO+3+/0Ktxa5Wo9K6LezOD8JFZzjCYWS74guhTuHS7J7oAZTOqCqeDeIeAQtQ1xdNp
         Q+03/lSxvnB7NX2be5txdMngoKcbV8cOPIVtRlQlzS+BMdyl6lNn9Q+O4n2M3ncaUQYg
         0AGrHpjTrBJtmtjvbGU5lWfzlcQwcB8XF5Lmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=KKMS9kQmXi2SdPh8UTdc3iBWrBAK9/b/p0LJU1Di4yDAMrsbPAPX2yp4RhvIxX/eV4
         LKeDRvuSeuk8dKYj4X3D++F8pfoc9LveuH0LO4y01DzUug8Qom0bDzdeJLCwlIwRIV7I
         x36y66sXLgs7PREBEPPxJ9IUfnd3nTW8yZwp4=
Received: by 10.224.29.8 with SMTP id o8mr3539300qac.31.1249185105840; Sat, 01 
	Aug 2009 20:51:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124660>

I could have sworn I used to be able to use git show to display the
contents of a file from the server, but now it always says this (if I
use -- then it doesn't show anything):

fatal: ambiguous argument 'master:file.txt': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions

What I'm trying to do is allow people to get a single file without
having to clone the entirely repository, like this:

ssh git.example.com "cd /MyRepo.git && git show master:File.txt"

If I do this with a non-bare repository, it works. The server is
running git version 1.6.3.2 (I'm running 1.6.4 locally where it
works).
