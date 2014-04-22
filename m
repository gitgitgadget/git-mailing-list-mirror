From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 00:10:25 -0500
Message-ID: <5355f9c16b665_15b012f3310d5@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <20140422021256.GC86681@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcT8b-0005VE-EE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 07:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbaDVFUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 01:20:52 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44605 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaDVFUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 01:20:50 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so5115830obc.7
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=jztHXtmaKH3kP8KH/IaxSnUlsjOnfUrDOHMzpAm+eys=;
        b=cqaKUr6LRDbulFhVg3zhMDLLVj+rsU+NK1XfTsr7UCoL31y7UjLx3luZtaxdbqyNFi
         SzmibXghw5L+o3f5GEB4f3NdrrafJHtuCHqkBevUvnXWwCe61lr6INqn0ThP1XhWD9tU
         n6sl/ft7p2ZpiKFetLY6kwB6YCzCL/234WY3fSI+xOIx89OnZxpZ1ceWWGBlP2Kpu/UK
         ZC8rV4+Kn1NX5B1TLMLN1J5SJbT3sHs2pUY2uyVsIvv90ST8/+1TwWq0WwzhwQ1utqYA
         BL/K3DS8arTEJ+2tT3bUaTDiIYwgF3hh/+v3KZQ5WMbh/0Y1HadPA30EFbV7nuKL9D4s
         ymBg==
X-Received: by 10.60.133.81 with SMTP id pa17mr30836546oeb.35.1398144050234;
        Mon, 21 Apr 2014 22:20:50 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm173502096oen.3.2014.04.21.22.20.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 22:20:49 -0700 (PDT)
In-Reply-To: <20140422021256.GC86681@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246694>

brian m. carlson wrote:
> On Mon, Apr 21, 2014 at 09:24:33PM +0200, Sebastian Schuberth wrote:
> > BTW, in my experience people tend to stick to predefined aliases instead of
> > redefining them to something (completely) different. This means that having
> > default aliases will very likely enable one to use the same short commands
> > on one's colleague's PC (instead of you running into issues because the same
> > alias was defined to a different command).
> > 
> > If we don't standardize this now people will come up with their own
> > definitions [1] [2] (and many others if you just search GitHub) which are
> > again likely to differ (slightly), hindering interoperability.
> 
> Unfortunately, that's already happened.  Some people alias ci to commit,
> and some people alias it to commit -a.  There is literally no choice you
> can make there that will make everyone happy.

Of course we can:
a) The people that have 'alias.co = git commit' will keep their alias
b) The people that have 'alias.co = git commit -a' will keep their alias
c) The people that haven't set alias.co, will get the default

> If you provide default aliases, people will expect them to work
> everywhere, and then be confused when they don't.

This argument was already brought up, and already proved to be false.

Mercurial allows not only to override the default alias, but to override the
core commands, so you can alias 'hg push' to 'hg push --force'. According to
your hypothesis people using Mercurial would get confused when basic commands
work on certain machines and not others. This is not the case. I challenge you
to find a single instance when people got confused because of the configured
aliases.

> It's much better to let people alias what they want on their own.  I
> understand the frustration of having to work on others' machines when they
> don't have your aliases, because every time I type "git pff"[0] and it fails,
> it drives me crazy, but there's just no sane defaults.

Yes there are sane defaults.

  co = checkout
  ci = commit
  rb = rebase
  st = status
  br = branch
  dt = difftool
  mt = mergetool

-- 
Felipe Contreras
