From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git Server Repository Security?
Date: Tue, 19 May 2015 06:05:53 +0530
Message-ID: <555A8569.30607@gmail.com>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>	<20150518102633.GA15186@book.hvoigt.net>	<CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>	<20150518115749.GA16841@book.hvoigt.net> <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 19 02:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuVY8-0001Z3-PL
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbbESAf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 20:35:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35050 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbESAf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 20:35:58 -0400
Received: by pacwv17 with SMTP id wv17so173284372pac.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eiTZ3V2Gz/N7M3ax9E7l+2QRlOdJLCFlmK5lH/lqvcI=;
        b=ICmBop16d+vJ//Y31+GVUbRnASfmR2O9B2UNhAnc7By4kyPtD8Hpy7xIDXFqE3wOQb
         aWNgcbQovf+yp8ERgMJeyKHk7FZlzFUtnquQ+Bsz0+32N+tqPNLC6wh/+sXyFoO+y8zY
         w+HKrcMLF84xddB5+jht1e1ObLJRj9GZzE2jdOrDVcCvF7S452HDTXHP62tWHpBeVstP
         RTH+SHBcnMilPJSgSfhXW7uRNtS73rmy+//T/P1s87zsQjEageSUp4E3N850kQNoCsJH
         kov1mLkplxoYpy3c1jUrF+CdE0yQmZyFnVcBfKIVXNS3JsPujkyXv1WJrAbmOlirUIyT
         hbyg==
X-Received: by 10.68.198.101 with SMTP id jb5mr49412407pbc.84.1431995758407;
        Mon, 18 May 2015 17:35:58 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.171.56])
        by mx.google.com with ESMTPSA id og11sm11173451pdb.91.2015.05.18.17.35.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 17:35:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269334>

On 05/18/2015 06:02 PM, John McIntyre wrote:

> All right, so I'm a bit confused.  I followed the instructions to get
> gitolite, and put a public key, placing it on the server.  I then
> run..
> 
> ***
> gitolite setup -pk server-git01_rsa.pub
> Initialized empty Git repository in /home/git/repositories/gitolite-admin.git/
> Initialized empty Git repository in /home/git/repositories/testing.git/
> ***
> 
> Our repositories are under /opt/git/n where n is the name of the repo.

Just use a symlink.  Move ~/repositories to wherever you want and then
create a symlink at ~/repositories that points there.

Apologies for replying to some of your other message here, but
do not use /bin/nologin as the shell.  It needs to be something that can
take "-c" parameter, so not even git-shell will work.  Since all access
is controlled by the forced command in the authkeys file, this is not an
issue so just use bash or sh or whatever.

sitaram
