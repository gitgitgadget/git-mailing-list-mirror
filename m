From: Steve Heyns <notzippy@gmail.com>
Subject: "git checkout" resets modified files
Date: Fri, 28 Aug 2015 23:15:52 -0700
Message-ID: <CANDob0LdQpoSfsedPK_yhNunXBvNTc9L1zKOM9h8dBUDePs0kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 08:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVZRK-00058r-Qi
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 08:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbbH2GQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 02:16:13 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36565 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbbH2GQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 02:16:12 -0400
Received: by oibi18 with SMTP id i18so35865267oib.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PrUUZpxIDOJNog/yptuFs+ydJ8Lo9zVrTrdwDe6aP20=;
        b=OFWCOG1rdMtNH/bHvh6/0i2amQQ7CRXucwKiJMzU/fqSVhRbJbJ6QEdPrgnJWPgUGW
         yeo1yzZf5QtLQT5+iEjTwIaFNovbdtqHJ1aOxwT7RPM9LUZlH3Z0BGfXVjkr3xNmyZ6u
         9DRKUn5AQuvh5b4a9lw555IZIEZQWIUHJkF8zbdvihK2gmy9Wd/0exiaeEsDjABCbMiD
         qUGCTck0pen5nLgbT90SE4qbtkRg+B8HMLz2UmD4Gg2wjKGWIHy/bJ8pQFD99+8pWkNT
         NvmOj6KPdUVUho9Ewp4I+wlwxfZYQFHLkgKtaSfqxdkA+Ex1IH1Kl+41O87QEmYWN4E9
         5LJQ==
X-Received: by 10.202.215.8 with SMTP id o8mr7544441oig.47.1440828972145; Fri,
 28 Aug 2015 23:16:12 -0700 (PDT)
Received: by 10.182.158.134 with HTTP; Fri, 28 Aug 2015 23:15:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276768>

"git checkout" resets modified files

Version git  2.5.0,

Description:
I was automating a process that would pull and switch to another
branch when I stumbled across this. I have not been able to emulate
this from command line but using go (or I imagine other languages are
similar) if you execute a command like

exec.Command("git","checkout","")

A checkout with the branch parameter but the branch parameter is empty.

The result is git resets the the repository, modified files are reset
back to original state without warning.

I would expect the behavior should be the same as a "git checkout" command

Has anyone else seen something like this ? For myself the solution was
to simply suppress passing in the revision as a third argument if the
revision was empty. But this does appear to be an off behavior.

Thanks
Nz
