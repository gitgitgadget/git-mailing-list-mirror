From: "/#!/JoePea" <trusktr@gmail.com>
Subject: Relative paths don't work in .gitignore as would be expected.
Date: Sun, 1 Feb 2015 14:51:17 -0800
Message-ID: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 23:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI3N5-0007yb-J2
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 23:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbbBAWv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 17:51:58 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:42625 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbbBAWv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 17:51:58 -0500
Received: by mail-qc0-f180.google.com with SMTP id r5so27710078qcx.11
        for <git@vger.kernel.org>; Sun, 01 Feb 2015 14:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qIcyQluSZvS6EkZNycnkPhTVjAZrqgd646kq6gmxAQ0=;
        b=NvyR0rGMYv3waarbB9N2GPdMbP9kGslL+7Lx1UahB6nsDX/4Tgl0y3Da6Fvuc058VB
         ffCM9imWwmwGGOh57yaXlnxrNUqpZYeKyuYFUov3RXW7Rb/bmHp71WT/yIU9WLdHi7E3
         5kMWmisxT9EvzVZlazTmRxG2FoPsJNxMUZvsLWfnH0xehY8rDHN7JYJPLwlWWyPmSCmS
         b4ZVAyib/SaBBhywIeEkfh191hQsh2BxP6sIs3RDXWQL24zZ7Dib3bCuHFd8DfHBZiHm
         GoW2yU0Q6bve0axt7sLdZT2QniALhl0pGPminDfWPBgkoRgv2v7T7WNkc9xsbZqHX8L/
         zr4w==
X-Received: by 10.140.28.54 with SMTP id 51mr31018117qgy.6.1422831117402; Sun,
 01 Feb 2015 14:51:57 -0800 (PST)
Received: by 10.140.102.197 with HTTP; Sun, 1 Feb 2015 14:51:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263245>

I have this in my .gitignore:

  ./*.js

I would expect that to cause git to ignore .js files in the same
folder as .gitignore, but it doesn't do anything. However, this works:

  /*.js

I'm not sure what this actually means because a leading slash is the
root of some filesystem, and we're not in the root, nor do gitignore
files always exist in the root of a git repo. Being able to have

  ./*.js

in .gitignore would make much sense.

/#!/JoePea
