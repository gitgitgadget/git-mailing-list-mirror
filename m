From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 03:32:02 +0100
Message-ID: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 03:32:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY2lp-000687-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 03:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbcBWCcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 21:32:09 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:60984 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835AbcBWCcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 21:32:08 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f4668b8a
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 02:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:date:message-id:subject:from:to:content-type; s=mail; bh=QoTdn2
	mOkJh/b+tlXfK3QlNqqq8=; b=Rhw0eBCTfTZchDl1qa5HnOnWI5QWpCGtacY6cV
	Vw1JO71HxPIW9obKwqiY715v92I1tYhRpKl9Lat4Y+Aoc1TNjfPqBmRHEszMZb0i
	8FVCXyIVCzgatZIRCE7NBy+IGlVHk6i2BUCg+1VPnk3M4cncpUirGqmdBcJ4oBjR
	zhG7W7hUEkl+9oPBfKCaEduLoarBO19/KzjqilJS9PVfbT5ilhluBo2gwBRg36pp
	YXsHiiqyRMBcyCC44YgE4osWZXJIaWN8FM4xxY5fFgSCjjCj+ceTVDLiOOyxZf1p
	N/lv5daXj6MoT3LMn5gtgcxIpmr5qFA/+JFQ3wqdf+zl9Gkw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 938ab4b7
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=YES
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 02:31:50 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id a4so189271339wme.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 18:32:04 -0800 (PST)
X-Gm-Message-State: AG10YOQ3zQXsbozty2OBXO2VtGgO0SSKEnnBxiREIIdnmaG1RnqqFEpWH1hTPPLGAvUgdeGha0uMepi5qbWtvg==
X-Received: by 10.194.83.134 with SMTP id q6mr17408444wjy.131.1456194722412;
 Mon, 22 Feb 2016 18:32:02 -0800 (PST)
Received: by 10.28.180.6 with HTTP; Mon, 22 Feb 2016 18:32:02 -0800 (PST)
X-Gmail-Original-Message-ID: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287007>

Hi folks,

In case anyone else finds this useful, I wrote this:

https://git.zx2c4.com/git-daemon-dummy/about/

It's an epoll-based responder for git:// that simply returns an error
telling users of a new URI. The purpose is to phase out git-daemon in
favor of more secure TLS/HTTPS endpoints. With HTTPS certificates now
being free, seems like this could be useful.

My personal motivation is that I'd like to just totally kill the
git-daemon service, but somebody hard coded a URI of mine into a real
printed textbook [1], so I don't want it to go stale suddenly. So, I
need some way of informing users of the new URI.

Let me know what you think.

Jason



[1] https://books.google.fr/books?id=kJsQAwAAQBAJ&pg=PA314&lpg=PA314&dq=git://git.zx2c4.com&source=bl&ots=W6M9TlYzCY&sig=g-PY0glN2ddWygtFDLiHgbiC69I&hl=en&sa=X&redir_esc=y#v=onepage&q=git%3A%2F%2Fgit.zx2c4.com&f=false
