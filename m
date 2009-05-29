From: Marco Costalba <mcostalba@gmail.com>
Subject: WISH: Extending git commit --amend
Date: Fri, 29 May 2009 08:48:46 +0200
Message-ID: <e5bfff550905282348gf29aa16o6eec88423bb5ce23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 08:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9vtr-0002pe-9h
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 08:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbZE2Gss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 02:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbZE2Gss
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 02:48:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:25819 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbZE2Gsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 02:48:47 -0400
Received: by ey-out-2122.google.com with SMTP id 22so22412eye.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vcS2vOuTouVSpNVWFfyUTtfkwxPfWBDE/a9UjCkAWY8=;
        b=ZDfBJ4JAHi484NIzF9e6pspahiqelTNXdSkQ2olEyNxXQ11SEWxvnR31NXkFl7Q3s1
         MiJYdzRZSb4PGkMAFwEcTWGoHhWDrVuDLQ3W/tS1oNfWvdiyOm5YBCts06L90Y85SyhX
         NtPY8HJvfVjuUtNOdZWqdSldv91ylIcFTxRL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Fj9UIELu/IVDoT7BixdzmPm6KMczGkUkNHR03pEKC8OfxMRv6wsC8WrAH7eHp17Fhq
         JIKiGQxhKmC4GQJuAGuSSgIchnXFsvI9GXCOSmRKKDKh4PiF/e0KrMwIJrZ3vhwbiilQ
         AsSOx6iGL9tKBan/0owWYT8OaLZPpals+XZvY=
Received: by 10.216.11.133 with SMTP id 5mr781381wex.217.1243579726650; Thu, 
	28 May 2009 23:48:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120250>

=46orm current documentation

--amend

    Used to amend the tip of the current branch. Prepare the tree
object you would want to replace the latest commit as usual (this
includes the usual -i/-o and explicit paths), and the commit log
editor is seeded with the commit message from the tip of the current
branch. The commit you create replaces the current tip =E2=80=94 if it =
was a
merge, it will have the parents of the current tip as parents =E2=80=94=
 so the
current top commit is discarded.

    It is a rough equivalent for:

            $ git reset --soft HEAD^
            $ ... do something else to come up with the right tree ...
            $ git commit -c ORIG_HEAD

    but can be used to amend a merge commit.





I find myself wanting to amend not tip of the branch, but an older
commit (typically to change log message). As example if I have this


D---E---F---G master

And I want to amend revision E currently I do

            $ git branch tmp
            $ git reset E
            $ git commit --amend
            $ git rebase tmp master
            $ git branch -d tmp


Would be possible to extend git commit --amend so to automate the
above sequence ? Or does perhaps exists a better sequence to change
(actually simulate the change of) log message of an inner revision?

Thanks in advance
Marco
