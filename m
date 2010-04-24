From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: How to fork on repo.or.cz?
Date: Sat, 24 Apr 2010 20:33:56 +0100
Message-ID: <x2r86ecb3c71004241233h97e3cf08l89aa4e6ef2fc4425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 21:34:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5l7e-0001ns-Gc
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab0DXTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 15:34:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39234 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0DXTeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 15:34:19 -0400
Received: by wyg36 with SMTP id 36so503830wyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=H++0rKE3sYF+xUzdKmbpr+Hh7+kdJnpN9v2mA+hOT/k=;
        b=scesrJS9CWWsyWb6dfFb/DaHt5KoOqk5yD5Nq4SjUov9kpFCFugugsTaOqhwNsT2nj
         VXTSeJhYvzowpxVgWtswxx9+0giJw1rE+qGzoevGQVaP7MFK7q9RQm+CGmFGyMfzQfpk
         posU0MRvzzeji9vWazlOXAVeoZYTA3RAc8SXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=rZ3r8P2h/GGEXRzudBxA2V+cgdBqZ88CHt4AZYR21+LvF7mSfgTryv77cyAL8q2DPh
         Fgxv+USkoQZ8D4Z7go/WbfMB1ZHsuI5inf4Kd9Z5Lk49CkomPImBV9S9FO9NVMaSzpsk
         YxchLn4ClxHNfjZpcCm1Uw/tijLYazoBOgjBs=
Received: by 10.216.93.19 with SMTP id k19mr2390573wef.223.1272137656128; Sat, 
	24 Apr 2010 12:34:16 -0700 (PDT)
Received: by 10.216.51.77 with HTTP; Sat, 24 Apr 2010 12:33:56 -0700 (PDT)
X-Google-Sender-Auth: 709b13683583cfc9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145698>

Hi all,

I'm not sure if it is bug on repo.or.cz or I'm doing something wrong.

Here (gitweb url) http://repo.or.cz/w/binutils.git is a clone of
binutils git-cvsimport
I've made a fork of that repo (gitweb url) http://repo.or.cz/w/binutils/xnox.git

>From the fork website I'm folling the instructions:
"$ git clone --reference /path/to/your/binutils.git/incarnation mirror_URL"

So I do this:
$ git clone git://repo.or.cz/binutils.git --reference ~/src/cross/binutils.git/

And I get repo very quickly cause objects are reused. Then I try to do this:

$ cd binutils/
$ git push ssh://repo.or.cz/srv/git/binutils/xnox.git --all
Counting objects: 178357, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (36896/36896), done.
^Citing objects:   5% (8918/178357), 2.16 MiB | 483 KiB/s

I terminate that, because my expectation is that
repo:binutils/xnox.git has access to all objects in repo:binutils.git
and should IMHO nearly instantly creates refs for all branches cause
nothing changed. Looking at this output it doesn't seem like my fork
is reusing objects from the "fork parent" repo.

What wrong? How am I suppose to use forks on repo.or.cz such that I
upload just *my* commits and don't re-upload whole history again.

Please help

Thanks.
