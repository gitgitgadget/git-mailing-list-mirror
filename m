From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: git-diff-index -C problem
Date: Sun, 17 Jun 2007 22:48:41 -0700
Message-ID: <69b0c0350706172248l6343e4c6yfd36ced8230a11ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 07:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0A6e-0008Ks-Ol
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 07:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXFRFsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 01:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbXFRFsr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 01:48:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:15112 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbXFRFsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 01:48:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2045558wah
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 22:48:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F2HS2KbU7NEpxo6kAmbnjP2stH3TX5yimEhJok8FdaKOst1sY0p/9FZBlllgwvK3ifJPMu/CAw0LeER8yRGTA9FGcTRIlGk2RRX0NG5IqL30rCtO/IrYx0EpBMfdDM/Zzu6DOjIfvWYghQOjYhHfwfWnPFY3gnji0Airwphun8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NTrcn1hVea50vgnsouBpvMplmcHnEG74luRvpgfaYb5AQzOiMa+4X3QeCsM4VR4u6SaAEnIk2eYEuwnQYqDq3lhIHbVxUrG7Dv6d88kwUKxC8mO5//Gnn7fPeqVJbhFmpY55U6XEaRyURz2BB/R0UgImSmRyNuTjb45Murwi5o4=
Received: by 10.114.36.1 with SMTP id j1mr5868494waj.1182145726101;
        Sun, 17 Jun 2007 22:48:46 -0700 (PDT)
Received: by 10.114.12.2 with HTTP; Sun, 17 Jun 2007 22:48:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50380>

I am writing a porcelain for git and I have been playing with
git-diff-index. I noticed that if i copy a file and git-add the copy
it shows the file added, as i expect...

But then if i then say git-add on the original file, i expect that -C
would check that file to see if it was copied, it does not.  If i
touch the file, then git detects the copy, so git-add is not forcing
git to consider the file modified.

I would be happy if there was a way that I could tell git that a file
was modified for this purpose.  Otherwise I will have to open/close a
file in which the user may be working, which I shouldn't do from my
app (windows problem modifying open docs).  Maybe make "git-add -f" do
that?

Thanks,
Govind.
