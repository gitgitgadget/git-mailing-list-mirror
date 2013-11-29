From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Re: gitk refresh keeps showing dangling commits
Date: Fri, 29 Nov 2013 16:27:22 +0100
Message-ID: <CAByu6UXXVRoQtFkU+A3E885pxVoiPdXXwXbozBP9gciD9BZMBQ@mail.gmail.com>
References: <CAByu6UVWWW+5QKfVD30_LR4UF3991PLMRHGo6WWgrxOPXws0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 16:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmPyZ-000060-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 16:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab3K2P1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 10:27:23 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:42355 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab3K2P1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 10:27:23 -0500
Received: by mail-ob0-f180.google.com with SMTP id wo20so9965191obc.25
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=c35WMqXcd9glvGgzT9+N/j1X0jXPZ1X1PsU0wlMdUj0=;
        b=Hko+xFksd4Dt39mIDRVKwI0xvAg1bK+lTpmJrn1cdJD3+3PuFpFL6RNKyt/fitUpgI
         ZDQu0iat3Nc1VLvXuynuk7neIP+K/+25zj+Is2UWoOUF64Df0NTp3AVlgvSegtxzyEcT
         8lu5ULjqv25nOkMyxEg8Xdr7jNepmhQFlhypWJi592zlnbmqH3nhpujocqc1Z+PADd2+
         AC8OsiJCCb3ELO5jYhUbmGJ9moPcta/3ODpVB8ACNbbHaZ84gqYvpppptuee+sarxZM6
         I8UnSC75bElUDyXgzQalbLncgc0fHnKpLj9y07vdpa6H/7IDseSaownlc//NMrfbabfE
         Vuow==
X-Received: by 10.182.65.36 with SMTP id u4mr43541691obs.31.1385738842443;
 Fri, 29 Nov 2013 07:27:22 -0800 (PST)
Received: by 10.182.65.71 with HTTP; Fri, 29 Nov 2013 07:27:22 -0800 (PST)
In-Reply-To: <CAByu6UVWWW+5QKfVD30_LR4UF3991PLMRHGo6WWgrxOPXws0mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238528>

Hi,

my Ubuntu saucy version of gitk is 1.8.3.2-1 I believe.
I want to report what I believe is a bug. I have been using gitk for 3
years, and I use it to verify what I am doing in the shell.
In the version I use now, the behavior has changed.

When I do
mkdir temp
cd temp
git init
touch foo
git add foo
git commit -m 'foo'
echo "bar" > foo
git add foo
git commit -m 'foo'

gitk &

then I see gitk showing the foo and bar commits, so far so good. Then,
leaving gitk open, I do:

git reset --hard HEAD~1

and in gitk, I select "Reload"(Ctrl-F5), and I still see both commits,
not just commit foo. This is very annoying for me for doing rebases,
as I don't care about all the dangling commits left by my rebases, and
now I have to restart gitk each time to see a "clean" history.
I believe "Refresh"(F5) may still display such commits, but a reload
should display what I would get if I restarted gitk, which is just
displaying one commit in the above case.

cheers,
  Thibault
