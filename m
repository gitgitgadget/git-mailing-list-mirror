From: Colin Smith <colin.webdev@gmail.com>
Subject: Bug: git log showing nothing when using --since and --until flags
 with specific dates
Date: Thu, 13 Nov 2014 11:27:06 +1100
Message-ID: <CAPLyDLo+-SebLvHxVKT7RAiER2c8HdeZQUg7_DGrpER1h-BPQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 01:27:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoiFk-0002sO-Lg
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 01:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbaKMA1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 19:27:09 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38090 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbaKMA1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 19:27:08 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so2729487wiw.4
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qQzkN1+MpJVLClnMkjthB+HuFiGl5RRp5acKNw2yQxg=;
        b=QLEz8K7DQO4BRrqS+96kX8N6C+F9NK0WnmhFHFZOMVWMgbYBL/Q/lU9T3Ht1xyRnHx
         0XBtoNuMel19PA7/9C1AEVZfoHpx4oCKqcxnimvU8czN6hWxyYM5ojnqqcmgwq4XGO1l
         hDT2mxKVYNpBlukqJbzJAdBHEMBp0FCMOT/8hRUH+mCTWtzD5nNPeMaVPEoyDjzsxqNq
         uuWx/+W/9p3TCmpTWBMY7L5dyvAK0HJ2SJAJTqGclqwzQneTnfYqEldQQkWqv6F0Bhy8
         OFYxg53gPB4aCYwxPxjNBbZGiyvriNJKzzxEOT6YopLycRXtDDH5ZRTZEgwcyHNBa3nF
         ESfQ==
X-Received: by 10.180.73.45 with SMTP id i13mr54696329wiv.32.1415838426418;
 Wed, 12 Nov 2014 16:27:06 -0800 (PST)
Received: by 10.194.85.227 with HTTP; Wed, 12 Nov 2014 16:27:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Apologies if this has already been raised or PEBCAK, but I've noticed
a bug where git log with certain date ranges breaks things. It appears
to be any --since date with a --until date in the future between
2014-12-01 and 2014-12-09. Dates from 2014-12-10 appear to work, and
so does the date 2015-12-01.

Tested with the following versions:

git version 2.2.0.rc1.18.gf6f61cb on Ubuntu

git version 2.0.1 on whatever the latest version of OS X is.

To reproduce, on a git repo with a recent enough change to view a
checkin after October 1 2014, run 'git log --since=2014-10-01
--until=2014-12-02' - no errors or anything to indicate the command
failed are shown, now run 'git log --since=2014-10-01
--until=2014-12-10'.

Btw, the mail daemon appears to reject emails with '550 5.7.1
Content-Policy reject msg: The message contains HTML subpart,
therefore we consider it SPAM or Outlook Virus.  TEXT/PLAIN is
accepted.! BF:<U 0.499737>; S1752168AbaKMAGd' - makes reporting bugs a
bit of a hassle...


Cheers,



Colin Smith
