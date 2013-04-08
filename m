From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 22:34:26 +0530
Message-ID: <CALkWK0kJ=r6Lg1Z9kUexMtVnori5zNj9d2M=u5EAcdHOHNOCOw@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <CALkWK0kA86YgonuXv=h2hA_hV8RfWPsBjtrk6OnHXiP=qDBjwg@mail.gmail.com>
 <CAP8UFD3i2vc3OSAHRERpiPY7cRjqhkqcBN9hVW0QmMksnCPccw@mail.gmail.com>
 <CALkWK0=nGP2J_EQM83Pv--5orAMdAPmk-3t5uF2pkJYScpM2KQ@mail.gmail.com> <CAP8UFD16gwWjE7T75D7kUM-VOXhtZaSRGtEg8fW5kmuKDLTQHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFVP-0000ND-9H
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935177Ab3DHRFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:05:12 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:55166 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762634Ab3DHRFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:05:11 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so1310182iad.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7jyQ59TsL3usAXaUnwo0spJJwO8E+O0CtF6MYHCxMBg=;
        b=E8nYbMymIekx5Xgg8Fejw56PyzmtN6bCef6zw7e4F+ue44b6VZgRTymQDYzBj+442y
         LtPyrZw+1QNWlLL9ApKfhHjNhoORQ1XEgQR2EjUMTYtErnVPTHNBINBnj8BMp1qgD7C9
         sETOoRJ6d7XKZLIKqLyAuhFbPQlxjGLom4f0H9kOGa/n17yfh/Z3HOhjD6CPpnb+HnXw
         AwFSZukfCB37/3ejGYNIlMJUSfKyFQTLt88dEzR4kFxr/tLWzS/b+LwgXDoshLY4HZHR
         9X9govMZc5fxqOp0Mneeal5vShZ1NHQbNJeDYCSqv0jdmWtAOEyJyhW66E49poEXECR6
         1/MA==
X-Received: by 10.50.17.71 with SMTP id m7mr7770319igd.14.1365440706575; Mon,
 08 Apr 2013 10:05:06 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 10:04:26 -0700 (PDT)
In-Reply-To: <CAP8UFD16gwWjE7T75D7kUM-VOXhtZaSRGtEg8fW5kmuKDLTQHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220441>

Christian Couder wrote:
> What if instead of a git submodule I want to have an hg, or, God/Linus/deity
> forbid, an SVN submodule, inside my git worktree?
> What if I just want a very big movie or .tgz downloaded from somewhere else?

Since the link object is rooted to the tree, it's impossible to have
anything but a working copy in the link directory.  How can I have a
non-git-worktree link directory without breaking checkout?  I think
that making it too generic will make the entire submodule experience
suffer, because the implementation must be coded according to the
lowest-common-denominator.  This is the mistake that the tool mr
makes: since it's so generic, it can't provide very powerful
functionality specifically for git repositories.

I'll try to think of something else.
