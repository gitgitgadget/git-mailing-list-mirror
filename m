From: "Yin Ping" <pkufranky@gmail.com>
Subject: [BUG] git-mv submodule failure
Date: Sat, 20 Oct 2007 14:01:31 +0800
Message-ID: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 08:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7P6-00007M-To
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbXJTGBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbXJTGBd
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:01:33 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:12535 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbXJTGBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:01:32 -0400
Received: by py-out-1112.google.com with SMTP id u77so1372834pyb
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+y2i1pXabHJQAcoAJjR5VMd8uMFaWhrK2jBZVTb+aDs=;
        b=UnE/VJULvdWH5htHtvVVizfsWijH9+oDk2Fq4/L41wamVVXGn5aSdz2v3iX8MrJek14u2ZuOWSItJ1UpBMiSx+9rMLFC6aIwzEK3AqVfa+yJ4BxhtFZIp5pWkTZEuBWxiJqYzWeKDk4AuH36h+WZK6fc63/GByEKmiqydOEgHiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uU5464ITmy9+LMB+OOxmjfSxeYHPNzeppM6cDVIcyNUOz9UGQJZ5K4uhPMhiKv7JUTcxeVIbu50m2LQEo7yG4AyNKyoPaFNpL0IZHm8Z9XLZfrmKwvwX6ZKyFfdPYPON7dH1BGhGNg7QYZIsBy3GpAGxMu331PwYPV+IJHkx3WM=
Received: by 10.35.121.12 with SMTP id y12mr3022342pym.1192860091169;
        Fri, 19 Oct 2007 23:01:31 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Fri, 19 Oct 2007 23:01:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61789>

project
  .git
  file1
  submoudle
     .git
      file2

$ cd project
$ git-mv submodule submodule1
fatal: source directory is empty, source=submodule, destination=submodule1

However, the following is ok and rename is automatically detected
$ cd project
$ mv submodule submodule1
$ git-add submodule1
$ git-commit -a

which gives in vim:
# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   renamed:    submodule -> submodule1
#

-- 
franky
