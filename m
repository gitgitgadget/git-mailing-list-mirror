From: Leo Razoumov <slonik.az@gmail.com>
Subject: very slow "git gc --aggressive" in GIT-1.6.4.4
Date: Fri, 18 Sep 2009 15:23:59 -0400
Message-ID: <ee2a733e0909181223j1ffc99edkdb3700adb37fa147@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Moj3u-0007iq-F6
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbZIRTX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbZIRTX5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:23:57 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37021 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbZIRTX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 15:23:56 -0400
Received: by ewy2 with SMTP id 2so1601645ewy.17
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=JHKyZMLxXkmrZBakvnGL0hkfML2d5JEx/ZwPIigudEM=;
        b=izVCBiJyQUvMYk03IEjwI9J9CTuBTN+3lo/ihgAxv4hB5iDqOczD55Y41CCYL84nRo
         Mm7ah6WqLZNtdGsMt8IYRp9f3bdawBEIBsOmLSvsmUkLbq5d0n/cHW9JUgw0kfrg4Evp
         q9vx0n8mOrS+bMYU70YpISDLmj08/U+9/ncZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=ce/kK7Uw13VBQ8G1ooboBiIMt2Mk2uw5P0y/5Fzzb4vQFT+LU+AS5Q/hhcaSA7p4BI
         wpMI7AVhHtiF+Sr6gnGwo14apZVaWhNt1fTTa766ti/9nUEBK3hdJuhngjaCRY98aAQj
         uZ7pv9/HSyIgasbnpn0czQIBSJySeQPKWKmSk=
Received: by 10.216.21.138 with SMTP id r10mr697092wer.3.1253301839172; Fri, 
	18 Sep 2009 12:23:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128808>

I noticed that "git gc --agressive" takes 5 times longer with
git-1.6.4.4 than with git-1.6.2.5.

Below are benchmarks on my Linux Ubuntu-9.04 laptop (Core2 Duo 2.54GHz).
As a test repo I use a mirror of the official GIT upstream.

GIT-v1.6.4.4
-----------------
git.upstream> time git gc --agressive
Counting objects: 105217, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (103507/103507), done.
Writing objects: 100% (105217/105217), done.
Total 105217 (delta 77228), reused 0 (delta 0)
git gc --aggressive  168.31s user 0.58s system 180% cpu 1:33.52 total

GIT-1.6.2.5.LR1
---------------------
git.upstream> time git gc --aggressive
Counting objects: 105217, done.
Delta compression using 2 threads.
Compressing objects: 100% (103507/103507), done.
Writing objects: 100% (105217/105217), done.
Total 105217 (delta 76235), reused 0 (delta 0)
git gc --aggressive  30.97s user 0.48s system 141% cpu 22.177 total
==========================================

168 seconds for git-1.6.4.4 versus 22 seconds for git-1.6.2.5.

What gives?

--Leo--
