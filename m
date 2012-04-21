From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing gitfiles
Date: Sat, 21 Apr 2012 12:51:14 -0700
Message-ID: <xmqq397wzwwd.fsf@junio.mtv.corp.google.com>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
	<4F930043.1080506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antonin Hildebrand <antonin@hildebrand.cz>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 21 21:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLgLO-0004BS-RA
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 21:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2DUTvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 15:51:16 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:40319 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2DUTvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 15:51:15 -0400
Received: by yenq2 with SMTP id q2so1212642yen.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=gJldEyjL8g8yjO9Vdef/IHfKN7JX4TQHz/n7YZKrodU=;
        b=am5qeCKfyd2ecT0fANvjlp3HbBn386V/1XpxHaeQUdp27amN/TEHUf2ct3PhfvKoXx
         Y9PHNYa0pC80HVzMPqbJTyn3dhmoDXx7HO1ZOVbnlawUjaIWBEeP31a2kESSOi/lcy0g
         yec6UdkeVzdmSFNCDFXZTtXd89KruAIhR5I09FZvxBMQ9+Il8Ww56H9ITDNeV2pDRTlv
         Zx6LHv/00TPx6OBe7YLjKs95W4ksXqnLsdCZojtQE/m9tl37JoxTtyYOUxQO8Pxp528Q
         zEQOjehcElbp0zs6j/tThS9DIbDk6IY7Ab3clwsVB+3XrmI7Q7NyXEsW67h/0Tn4iYyJ
         9UoQ==
Received: by 10.101.179.5 with SMTP id g5mr3912357anp.12.1335037874856;
        Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
Received: by 10.101.179.5 with SMTP id g5mr3912338anp.12.1335037874705;
        Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d65si8255545yhn.3.2012.04.21.12.51.14
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 979ED10004D;
	Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 42D8CE120A; Sat, 21 Apr 2012 12:51:14 -0700 (PDT)
In-Reply-To: <4F930043.1080506@web.de> (Jens Lehmann's message of "Sat, 21 Apr
	2012 20:45:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQknlB5nI0VRdzS/IA7v4XP9wb28qoZnYsW44Xt0VX3Z5M110vRIlpVL0OE5IUe48q48zOo5XtBJDAxbPHUED+WhEy3w3kjRAMJKkj8dafkbU4oGtdki1lYZdAknPyeWA10NVwMoICgneXpgiO889iXYWYu+lr8XuUoMaVlejvUl/8mo45I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196058>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Opinions?
>
> ----8<-----
> Subject: [PATCH] git-new-workdir: Suggest unsetting the core.worktree setting
>
> Linking to a repository that has the core.worktree option set can only
> work when that core.worktree setting already points to the new-workdir.
> In all other cases strange things will happen, as new-workdir will be
> overridden by that setting.

As you analyzed correctly, core.worktree lets a GIT_DIR to declare that
there is a single working tree associated with it. It fundamentally is
incompatible with new-workdir, which is a hack to let more than one
working tree associated with a single GIT_DIR.

I however do not think a simplistic "unset core.worktree" is a good
suggestion, though, as we do not know why the original repository has
that variable set pointing at somewhere.  Blindly removing it will break
the use of the original repository.  If somebody _really_ wants to use
new-workdir for whatever reason in such a setting, I would imagine that
doing something like this:

 - Create a new repository somewhere that is an identical copy of the
   original repository's GIT_DIR, except for core.worktree dropped;

 - Turn the working tree original repository pointed with core.worktree
   into a "new-workdir" off of that new repository; and

 - When you want more "new-workdir"s, create them off of that new copy.

may work.  But honestly speaking, "Do not use this hack---having more
than one working tree is fundamentally incompatible with it", may be a
more sensible message.
