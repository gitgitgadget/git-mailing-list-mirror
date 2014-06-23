From: Noel Grandin <noelgrandin@gmail.com>
Subject: bug: git grep -P and multiline mode
Date: Mon, 23 Jun 2014 08:54:29 +0200
Message-ID: <53A7CF25.7060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 08:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyy9J-0007fj-L9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 08:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaFWGyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 02:54:37 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:62773 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaFWGyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 02:54:36 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so6416587wes.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=dQzHjO7uZpW3aoe/2/DDh71B8AtLHs2CnehGR12HkGo=;
        b=BzNE6+WgqxmIDMV7at3U9ZYz/BzbAmwUIMn8JnWwW6gSWgJW+yZJppB86FAHha+OCJ
         o2UEC79kkALgCmUKJEUAd6+KaQ/I5oEBKIKQ0r+UGXcxkyNYVoQtIEygCyd/sHDL6Mwc
         FqFWV4GcjIG2FH+V7xJgfF9xjIlSmi3jMAWTafZ8YCTJbiBI2vyPU/NDGxyOYVkszL2C
         ImSCKq6y7C4YtozJ+BeZ3JtGi+Z+3Gnss3y8GPnEuJGftdAbTbdMYbi/pG3dUx7QSnzp
         HkJwRMmXB7/rfc/hT1+adWu3gGgM4BM1WE/1t6Ajx3ZMK2sSiAvar3ioywJu3mrz7Xjp
         MmGA==
X-Received: by 10.194.120.103 with SMTP id lb7mr23955359wjb.40.1403506475422;
        Sun, 22 Jun 2014 23:54:35 -0700 (PDT)
Received: from [192.168.1.212] ([41.164.8.42])
        by mx.google.com with ESMTPSA id ja9sm30524049wic.8.2014.06.22.23.54.33
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 22 Jun 2014 23:54:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252318>

Hi

It looks like the perl regular expression multiline mode does not work with 'git grep'

for example, something like

    git grep -P '(?s)foo.*?bar"

will not match a file in the repo where it has something like

    foo
    bar

ie. split across two lines

Regards, Noel Grandin
