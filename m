From: "Ping Yin" <pkufranky@gmail.com>
Subject: Why 'git commit --amend' generates different HEAD sha1 each time when no content changes
Date: Sun, 30 Dec 2007 18:56:26 +0800
Message-ID: <46dff0320712300256g36e825a2g711d98b565e361f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vql-0006Oe-4b
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXL3K42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbXL3K42
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:56:28 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:25962 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXL3K41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:56:27 -0500
Received: by py-out-1112.google.com with SMTP id u52so8540993pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=N9FbY8smPPL7tR9d7Fcm3pV1R5138bEujlFbroAJMbc=;
        b=LJM7cEy2pt9tK5KP8wxSPU/3A5LEqYAxJ/Q6NztXR2VvH+jSZfcfkALuDwtDB7S4FWN0IohTIeTqAHtNUolyUbGwVad1NUz7W1gZyI2S7AnqMAH7I3uEjd1eErTPd3iOUvrArePfse9eNVByqlUNH7BUo1emxwnEw62dES01WIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SkDP/ty5fp1L49Tp7+tI8wuD0Etu83Zm1WP54nSD5rBJ4nErkMp8NbPlJtNHlIYFkRsfNUAiqORicZNkyTfw+zOhl+k/p6c/t28TmSy66HXMXWpNej3wzIan6VPoGdsPJ5QejHJGbwHRqygo9+3PcpBgO4ekrdnQFFwuARqJSOM=
Received: by 10.35.10.13 with SMTP id n13mr13556448pyi.29.1199012186778;
        Sun, 30 Dec 2007 02:56:26 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 02:56:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69349>

AFAIK, commit sha1 is only determined by commit object content (say
parent commit, tree sha1 and so on). So why 'git commit --amend'
changes the commit sha1 when no content changes as following shows.

$ mkdir A && cd A && echo foo >foo

$ git init && git add foo && git commit -m 'add file foo'

Created initial commit 8626800: add file foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

$ git commit --amend
Created commit 3591035: add file foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

$ git commit --amend
Created commit 3927d9a: add file foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

-- 
Ping Yin
