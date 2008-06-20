From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: git svn: how to recover from checksum mismatch?
Date: Fri, 20 Jun 2008 14:56:28 +0400
Message-ID: <c6c947f60806200356s285ac4s7a4affc108c7f311@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 12:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9eJ8-00067D-75
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYFTK4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYFTK4a
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:56:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:56330 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYFTK43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:56:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5618659rvb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ExQ9K3Z++XHf4WrY6pVcJINDXyq2AcwVxKG0la2KZns=;
        b=afZGzFzdDdHh+cstlHmFNFe7sviyR2mU1aTHrSaKOeFR06R0NNIax4FutJLdpiMGwS
         m0Tsg2SmbeLX+L7DqHNyOyuShH/oLd8kfMiF0voWNzN6xT7ECcL5KbfrRZ4KCj6/D6U7
         2wRn2kNSUm8eEm0WVvq8RHeZkdtFievUT8jf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BX08omWQlStQ3b6j5iz+IC0xX+DDeSuezZ4hZlKy0EW6rsMsiGNvGQt6igskGOTqJJ
         l58MHgytskcgZUC/452sstclN+veF4mqMfBSqB7jhExX3y1/v5rodg9kxYKvoKUlFk/a
         vax3sqcU3twr1l/50/LWdBj3A32DewmCqEqLM=
Received: by 10.140.172.19 with SMTP id u19mr7408177rve.133.1213959388494;
        Fri, 20 Jun 2008 03:56:28 -0700 (PDT)
Received: by 10.141.48.15 with HTTP; Fri, 20 Jun 2008 03:56:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85618>

Hi, list!

Today I've upgraded to git 1.5.6 from 1.5.5.something (probably 1).
When I've run git svn rebase on my repo, it complained about "checksum
mismatch: trunk/path/myfile HASH".

BTW, Before that failing commit there were one more (successful) with
some strange complains about whitespace errors:

    warning: CRLF will be replaced by LF in
/var/folders/8u/8uiW+GhrGka2OlIHiT1fsU+++TI/-Tmp-/hoizGwiM2P

I'm on OS X 10.5.3 and my repo is not in /var/folders tree (trailing
part of path is different for each file).

The same errors are on my second copy of that repo (independent git
repo made by the same git svn init as first).

When I run git svn init + git svn fetch on a fresh folder, it bails
out with checksum error after a few first commits (on 20th commit
actually) while giving the same odd CRLF warnings.

When I run git svn rebase on another machine (Ubuntu Hardy, git
1.5.5.1), it run smoothly without errors, so this, probably, is not an
SVN repo corruption.

I have reverted back to git 1.5.5.1, but I still get that checksum
error. I'm fetching a fresh git svn init+fetch from svn, but it takes
a few hours, and I have to do it twice (for each of my two repos). Any
advice on how can I recover less painlessly?

Thank you in advance,
Alexander.
