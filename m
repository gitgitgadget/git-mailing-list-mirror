From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Wed, 02 May 2012 15:21:29 -0000
Message-ID: <947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com>
References: <4F9F128C.5020304@palm.com>
            <201204302331.q3UNVo7o032303@no.baka.org>
            <4F9F3919.6060805@palm.com>
            <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
            <20120501111415.GD5769@thunk.org>
            <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
            <4FA02830.3040407@palm.com>
            <86havzoi8h.fsf@red.stonehenge.com>
            <4FA04D02.6090702@palm.com>
            <86mx5rmx32.fsf@red.stonehenge.com>
            <4FA055D0.7040102@palm.com>
            <86aa1rmvhb.fsf@red.stonehenge.com>
            <4FA05E9F.9090709@palm.com>
            <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Wed May 02 17:23:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPbP8-0007YO-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 17:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab2EBPXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 11:23:42 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46023 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab2EBPXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 11:23:41 -0400
Received: by wibhj6 with SMTP id hj6so4857563wib.1
        for <git@vger.kernel.org>; Wed, 02 May 2012 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=pXoPPHMSk+VSTZyFbDiCEP6TbVGyZZjINde0VIjzZhY=;
        b=0/t8rVs9hoI1ln2vz8Ji6sD804yoO0cw93oGmXVrl6XWaE0G3kakca6u683ILQ4qzw
         7Q5SidVX/FGMPpN58EPeSn7UWo+BiiTyUTJgUFZzpPWe89/88QSrHZvy3oTyplw1iBeD
         QLUaleWAd/RqWboMHXDNj6ZgOx3x4BoQw+w3eidSYq9oZcwfxlq5iI2y2eMqTfBgh3Zf
         uob/3ic45UY9b+HuZDJo/d6rbevyjoZDsgEEeAPK7NNgnLdRuI016kxQDdalisix0Yts
         JY3ImqzwWCgwZcwmfqKBTVEsE9L0lCObBPAUcn7J4K91SQrC4jU551DD/KT3Ul4bW+JL
         ihog==
Received: by 10.216.143.146 with SMTP id l18mr1103228wej.56.1335972220839;
        Wed, 02 May 2012 08:23:40 -0700 (PDT)
Received: from gmail.com (tor18.anonymizer.ccc.de. [31.172.30.1])
        by mx.google.com with ESMTPS id w10sm7587562wiy.3.2012.05.02.08.23.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 08:23:39 -0700 (PDT)
In-Reply-To: <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196834>

On Wed, 02 May 2012 16:21:07 +0200, Hallvard Breien Furuseth wrote:

> And in a bare repository:
>
>     git init --bare foo.git
>     cd              foo.git
>     git remote add bar ../bar.git
>     git fetch      bar
>         --> adds bar/master etc.
>
> For some reason, 'git clone --bare' does not treat the cloned
> repository the same way - it just copies it under refs/heads/
> instead of refs/remotes/, without even adding it as a remote.

What do you mean?

  $ git init bar.git; cd bar.git
  $ echo a > a; git add a; git commit -m a; cd ..
  $ git clone        bar.git baz.git
  $ git clone --bare baz.git foo.git; cd foo.git
  $ git remote add bar ../bar.git
  $ git fetch bar
  $ git branch -a
  * master
    remotes/bar/master

Also, removing the `baz' intermediate repository doesn't matter:

  $ git init bar.git; cd bar.git
  $ echo a > a; git add a; git commit -m a; cd ..
  $ git clone --bare bar.git foo.git; cd foo.git
  $ git remote add bar ../bar.git
  $ git fetch bar
  $ git branch -a
  * master
    remotes/bar/master

For completenes, your example again:

  $ git init bar.git; cd bar.git
  $ echo a > a; git add a; git commit -m a; cd ..
  $ git init --bare foo.git
  $ cd              foo.git
  $ git remote add bar ../bar.git
  $ git fetch      bar
  $ git branch -a
    remotes/bar/master
