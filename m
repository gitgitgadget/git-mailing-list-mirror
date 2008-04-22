From: "Ping Yin" <pkufranky@gmail.com>
Subject: [regression?] "git status -a" reports modified for empty submodule directory
Date: Tue, 22 Apr 2008 19:01:40 +0800
Message-ID: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:02:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGGa-0006xE-LL
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 13:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbYDVLBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 07:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYDVLBm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 07:01:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:4340 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbYDVLBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 07:01:41 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1740904wxd.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=MhJuzftdZ6YmySjthebpTU1RotNKa/jtbxHln4c6C6g=;
        b=qimw261Bb4ZV/Ip3V1xLDYl6YIVYQ8+BZm7WGoxBLM08icO3Phc/QRDesNe1A6MZBQMgEcCCkZd2yvo1lWYPXNWD6oDvrWphqrasV17hBetaSIDt/V+RG2xI76GhKv1A6dCnOj/vcBR0r42j81rJ0odp47VastCBLDBcGSZyGdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=chX9Mh6QktL5nntW/LvuzT+1fw829MjaltjFAvP5wX4l0fNHK9RkfLyLV/c2vUlTAlGW0Q441+F+wSD/RcbSoW3ufpC2gWvuFkC1AmaP8Go/HlCpUEUb73i62YcEosnsk+X/XJxEWodlvhJqd7LBJxUFxDS+WV5mhEZKDXiRd8w=
Received: by 10.101.68.19 with SMTP id v19mr93896ank.75.1208862100879;
        Tue, 22 Apr 2008 04:01:40 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 04:01:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80100>

# create a super project super
$ mkdir super && cd super && git init
$ touch foo && git add foo && git commit -m "add foo"

# create a sub project sub
$ mkdir sub && cd sub && git init
$ touch bar && git add bar && git commit -m "add bar"

# add sub project to super project
$ cd ..
$ git add sub && git commit -m 'add sub'

# remote contents of subproject
$ rm -rf sub/* sub/.git

# git status -a regression
$ git status
# On branch master
nothing to commit (working directory clean)
$ git status -a
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    sub
#


-- 
Ping Yin
