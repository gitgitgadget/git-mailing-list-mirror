From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: "git ls-files -i" does not shows ignored files on Windows
Date: Tue, 26 May 2009 21:36:40 +0400
Message-ID: <85647ef50905261036u2d3c00c9lcf0df8f29de051ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 26 19:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M90Zx-0007UK-Tv
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 19:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbZEZRgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 13:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZEZRgl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 13:36:41 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:45607 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZEZRgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 13:36:40 -0400
Received: by fxm12 with SMTP id 12so2225738fxm.37
        for <git@vger.kernel.org>; Tue, 26 May 2009 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=iMfOvWvOjuTZTB+9hYQWFT6UPtX9UWAhJYNjNhhdz8k=;
        b=vfGJd/X5PYZWIytjGhawvRveWAdF/ptIODcgZGuclIB9SKmccXVVzZkfTwFHDZ4S4H
         TIt0kPK516zuy7rqPNqXVAPc5gdVV0C0aHggEgi6U851WT+y7ueXn766gbb0OQ9zZnfb
         mVM+MSs2xf32Km4UWKATd3ljXDcwQeBRPyvdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rxsSXfJ6KKOFSFNFsIT25QJShJj+KqlnHB9x6k84FTeU29Iar5/JuzCUJSavOm57kp
         2irUDcTpj9R05yPahDoyjeNbCu85wRC8+2RKn6Y/TTs9EiJj2vjyiU4pxeopcXgOyXkB
         g5z4DfzG+0leWo1gcOcz8O6+UN3U7ekNalq18=
Received: by 10.204.116.212 with SMTP id n20mr8275285bkq.138.1243359400819; 
	Tue, 26 May 2009 10:36:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120006>

I have encountered a strange problem on Windows (cygwin git 1.6.1.2
and msys git version 1.6.2.2.1669.g7eaf8).

Lets execute the following sequence of commands:

git init
echo a >.gitignore
echo test >a
git ls-files -i --exclude-standard

The last command in the sequence gives an empty output. But "git
status" and "git ls-files -o --exclude-standard" show only
".gitignore" file as untracked. So the file "a" is considered as
ignored by git, but it is not displayed in output "git ls-files -i
--exclude-standard".

Does the bug happen on other platforms and versions of git?

Regards,
Constantine
