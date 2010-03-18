From: Yann Simon <yann.simon.fr@gmail.com>
Subject: help with git filter-branch
Date: Thu, 18 Mar 2010 15:43:18 +0100
Message-ID: <551f769b1003180743n2b2dde99laf00aa9bfe0141bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 15:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsH37-0003zO-4z
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0CROuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 10:50:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33282 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab0CROuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 10:50:02 -0400
Received: by gyg8 with SMTP id 8so1055692gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Ps6wbkOlSmjVLpnENpQOxb+KrK2vt/K31SVId/n9bak=;
        b=x48YsO33lgrH6nKunl/KNM88oW+N2M4CszNZbAYqJW+Tuig8HaepclBeXbW6XeA4yY
         7ZMXsAzfKk9rz3osuE4NBbfuMJ3c7mla2uOPJWyWYEdGzu1IIAzNC5vpa/vvj3CAli1Y
         JjQRIClErvyV14ZNRNE0sLx7leSzXpfrhxeFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Hg3lvXJ4BxsaM6QO2BSAjVFvHjSD4m40dKi55f8IydJRqaGiLLDJ1ZO3aeZFBZ4EsI
         9c7VoCjQMNScTBi3zAx/UurfsDtbW1iN6A5BwBFBdHTdHJi2jy8T4vbIA8NM1VIA8g0z
         1n+yr/x859KAe0yvnhP0qRykHGOA2KWg6hbIU=
Received: by 10.239.190.81 with SMTP id w17mr981518hbh.45.1268923398841; Thu, 
	18 Mar 2010 07:43:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142474>

Hi,

I am trying to use the script found on the following page:
http://ebixio.com/blog/2009/10/15/git-filter-branch-incantations/

The idea is to add a missing parent to a certain commit.
I wrote the following bash script:

#!/bin/sh
die () {
    echo >&2 "$@"
    exit 1
}
[ "$#" -eq 3 ] || die "usage: add_parent <commit_to_update>
<present_parent> <parent_to_add>"
git filter-branch --parent-filter \
    'test $GIT_COMMIT = $1 && \
    echo "-p $2 -p $3" \
    || cat' \
    --tag-name-filter 'cat' \
    $2..master

When I try to use it an a test repository, I get the following error:

./add_parent.sh ad12d20974cad91ddedd055f5335b7471e48dd1d
1541f3ae456556edc7e15cead1ae76f470961be0
88b5d6f190f9d7135148c67c4d949c0c06e179ff
Rewrite ad12d20974cad91ddedd055f5335b7471e48dd1d (1/1)test: 3: =:
argument expected

I am using git version 1.7.0.2.

Any help appreciated!
Thank you
Yann
