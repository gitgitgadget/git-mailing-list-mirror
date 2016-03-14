From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Mon, 14 Mar 2016 22:47:53 +0800
Message-ID: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 15:48:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afTmp-0002GF-SF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 15:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934374AbcCNOrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 10:47:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35704 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbcCNOry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 10:47:54 -0400
Received: by mail-ob0-f174.google.com with SMTP id fp4so178063265obb.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=saKeXbRmqfmPBooeF2z85NvbhX6iu2UCRgWReYe8SQo=;
        b=UngtJ3ICj20PcP5HfHeILVJK7FjP94PxlzbuVY9LPlahrqWgn/OheTK9fXA1gtmn6D
         CtvuybaOqSGmVjAtVQ2m/h5rk7n0rdBAj5RloRnEtf3cAjOEp5Qxw3WYBq7aydf0xcaT
         xIvkq0jKnt/cEtfokAytYIfY7k70YJm9K2aVQfiXOPYEjHbJPR03V5ndn0lXz3PhWv/k
         pI0OhWtTZgVBZ6y7ak6wtaWZKW62dC7nmLiqOcbVfw6lYNbGqu//KW8nanYzrUVMDBMK
         /vRIS+9iDVyQNCd/2R2PaAIOyRgcrD1uzJEgV7CUBe6Tx9HXUFGLz3OAsC92nUNfpInE
         cSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=saKeXbRmqfmPBooeF2z85NvbhX6iu2UCRgWReYe8SQo=;
        b=atQZQJDj6f5D2JWVc2CUpvTB1cat0cNzrQM90Kqhb8zbxlBOuDGMG3+kliGlU8GEdi
         cqfgZo9YyB7PFI8mFNAFfYDWwQc4/B8fy1EwUCPiHS0v5pFLae3+7R8+WH/2MtDzN/yi
         ZWMngsCMEt+cOFHrSNl+FupFY+YK9rT8Q0/AgZg2qtb30CHYOUVFLe+8NJZAmUwlD83e
         MVUyFVsn93dcmOllSwHTFPT1VqimKYSJoDBpyGkt4B7+bZ7e9+9e8hymFcMp8BpS6F5X
         gXCku7bkZEdjVWvC1YOcuB0lHfx7DfkJb/BSCdQ63S0wRteo7u40dKYNKXHCYsE8r332
         a/SQ==
X-Gm-Message-State: AD7BkJJrJOU8jrzYdAUuk/S68otMhGSuqgXBix0cBnOzGQl0ucE3jBWY1l4UIzzzZ1gK+P7LX0CA5QDikrZhpg==
X-Received: by 10.182.158.42 with SMTP id wr10mr13676107obb.37.1457966873564;
 Mon, 14 Mar 2016 07:47:53 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Mon, 14 Mar 2016 07:47:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288781>

I'm Hui Yiqun, a master degress candidate of Tsinghua University. I'd
like to participate GSOC 2016 as an developer of git.

I have basic knowledge about several programming languages (namely C,
python, go and etc.), compilers and cmake which may help my
development.

My github page is at [here](https://github.com/huiyiqun/). There are
some tiny programs.

I took part in a CDN project last year and learnt much about TCP/IP,
web service and, most importantly, cooperation. However, I really want
to learn how members of an opensource project work together.

I have covered most of the available materials, such as list of ideas
and micro-projects, `README.md`, `INSTALL` and
`Documentation/CodingGuidelines`. So I decide to start my contribution
with the microproject "Move ~/.git-credential-cache to ~/.config/git"
found [here](http://git.github.io/SoC-2016-Microprojects/), which
seems easy for me.

I greped the source code and found out that there are two places where
"git-credential-cache" are hard-coded:

1. credential-cache.c
2. contrib/persistent-https/socket.go

At first sight, there are following tasks to do:

1. implement a function `xdg_cache_home` similar to `xdg_config_home`
in `path.c`.
2. replace the hard-coded path with an call to `xdg_cache_home`.

I'm still confused about following:

1. should `~/.git-credential-cache` been moved to
`~/.cache/git/credential`(as the descreption of the micropject says)
or `~/.config/git/credential`(as the title of the microproject says)?
2. If `~/.cache/git/credential` is the desired target, there seems
nothing to do with `XDG_CONFIG_HOME`.
3. Does "without breaking compatibility with the old behavior." mean
that I should still try to connect to the unix socket placed at the
old place? If yes, which order is prefered?

Thanks for your patience. I hope that my English didn't affect the
communication.
