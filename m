From: Roger Mendes <sproger1@gmail.com>
Subject: Please consider extending .gitignore to support setting of a file
 size limit
Date: Thu, 7 May 2015 17:14:26 -0400
Message-ID: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 23:14:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqT7p-0002pw-70
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 23:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbEGVO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 17:14:28 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34384 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbEGVO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 17:14:28 -0400
Received: by wgic8 with SMTP id c8so29087777wgi.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7hsM9nKEXC8wPcVtfUVfF9f83EiRAMRvxLYb/nDn/1M=;
        b=spy1450VZqccbehVS0TDo0qt7mtoSW4ay/mDzHK24gjkHLvjvdT8BuDTkUKcqjnt2v
         Wtoctz7Qm4jbFRmOSB/0B6Em1pG9YRtmjjbh0pflx3jT0Ux2YI9jpUkv9BrlLz8CqZa5
         M96BTM6pbFlP5dUg37U+58jweuNVMGJBj+IF3W1NjOUyLWTCW/lOv8xad1OSg8et0m4h
         Fzg6NYech/zCenKQIznwnuy15kc0ANvzxtuxtQXdOTinzJoC8EBCrslMXfCrHk2Ts93M
         kCWXRDLe7T4d4NJxvulafbDHvuaaVwh//RNStu0BuDdtkuB8ewfSX7cfrrCH/zHzFiAd
         jqDQ==
X-Received: by 10.180.19.134 with SMTP id f6mr259507wie.35.1431033267018; Thu,
 07 May 2015 14:14:27 -0700 (PDT)
Received: by 10.180.65.116 with HTTP; Thu, 7 May 2015 14:14:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268589>

Allow .gitignore to support setting a file size limit so that all
files over a certain size will by automatically ignored when
performing git add, commit -a...;
Exclusions to this size limit for files can be allowed by specifying
exceptions '!' syntax that already exists. It probably should be
considered to have a default limit already built into git of say 100MB
(used by github) which can be changed in the .gitignore file.

This would avoid accidental commits of large files which are known to
be poorly supported.

This seems like a fairly simple feature to add, I'm not sure why no
one has done this or thought of it given the number of complaints,
questions... with large file handling.

We can ignore by file name attribute, why not by file size?

Yes, I know I can add pre-commit scripts... to workaround this issue,
but there should be a better way (or maybe I'm missing something?).


Accidental commits of large files is a common mistake, and often
results in the commit taking an extremely long time to process and
sometimes if you kill the process, then you end up with corrupt git
repo (at least in jgit, which is used by Netbeans).

IMHO this would be a very useful feature.
