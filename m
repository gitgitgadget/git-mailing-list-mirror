From: Sascha Ziemann <ceving@gmail.com>
Subject: How to compile without iconv?
Date: Tue, 9 Jun 2015 16:07:25 +0200
Message-ID: <CAGUt3y4RgtkP35XstHGQ=T3zkb_akZSRS=q227wMehVzmu9MDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 16:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2KBf-0004Dt-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbbFIOH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 10:07:27 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38624 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbFIOH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 10:07:26 -0400
Received: by igblz2 with SMTP id lz2so12152292igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/H/ydrzb8z8JoAIuKcy+f9cMQ3lFv6yVxsk8KGLk7RQ=;
        b=kmI/Hp+E8aojJy1zoOCilOsgW274NRMJ1smS8S/g7xZG8Sz7fZWIIbLJgfhkjEy2Jg
         wHTlcg6hPf8ccXgeSqNWFZbyc/kvktr+Un/I75AtkbJ3QhIrrCRmVUjz5AjKmAiDr0Iq
         Ghdz37qHo7T2MIuc3cIb6j1DOdQNLb0EqzfvXwcBZAmJ8E9BMuvyjOj4RNmPgDqL6YDx
         L5lWXuG8ivX4dqXsfyFl60iZpom6TOPKiuG1Ev/6eNDo7bx5fIz0O9fhy3SuYow+6wEb
         ye1Y0g03ABXAK31k3T0JLCy3RWr0/2e+1/h+8iK0ikaIxyY9v5D5ObnbuSZqwcxJqdbp
         S6sw==
X-Received: by 10.107.18.92 with SMTP id a89mr26433176ioj.14.1433858845996;
 Tue, 09 Jun 2015 07:07:25 -0700 (PDT)
Received: by 10.79.92.6 with HTTP; Tue, 9 Jun 2015 07:07:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271181>

I tried to compile git 2.4.3 on Solaris 10. I used the following configuration:

$ ./configure --without-iconv

$ grep -i iconv config.status
ac_cs_config="'--without-iconv'"
  set X /bin/bash './configure'  '--without-iconv'
$ac_configure_extra_args --no-create --no-recursion
OLD_ICONV=UnfortunatelyYes

But when I try to compile it, I get an error that libiconv is missing:

    LINK git-credential-store
Undefined                       first referenced
 symbol                             in file
libintl_gettext                     libgit.a(lockfile.o)
libiconv_close                      libgit.a(utf8.o)
libiconv_open                       libgit.a(utf8.o)
libintl_ngettext                    libgit.a(date.o)
libiconv                            libgit.a(utf8.o)
ld: fatal: symbol referencing errors. No output written to git-credential-store
collect2: ld returned 1 exit status
gmake: *** [git-credential-store] Error 1

How can I work around this?
