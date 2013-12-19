From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Feature Request] Did you mean `git ...`? should ask user for
 feedback, not return to the prompt
Date: Thu, 19 Dec 2013 15:17:59 -0800
Message-ID: <20131219231759.GF20443@google.com>
References: <CAMi+fEnVekrWYrG6sGiRPmOXxaJ1-Y9xd83W7Wvw3GwWz8DuBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Andrew Lewis <eric.andrew.lewis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 00:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtmr5-0001ih-H5
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab3LSXSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 18:18:07 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:62368 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3LSXSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 18:18:06 -0500
Received: by mail-gg0-f181.google.com with SMTP id y1so435177ggc.40
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WUdKwL7Tb70wXXCbqVgxhZZdMNypOCvsA9aIiLqXeiA=;
        b=vDjraVVldWxw2iYG6NpLQE50l6oAdpAQOlmJ5aO2d8li5VvFUa3WMoVwpe0QsEqzJP
         4m0v8WmKkfH4dpFpIEeeJSRgKKH+of/cPwZqYGrhCZj3SjT3ElDPy09Z0+b9vJwQjwmv
         YPMM+6fwBjrC1uoj6yMPBnDkYFqRCkHJOrhoHchedZmUnRCpurjAPGkC+yGIGiG4qM5/
         lFWZ79K/0ibIimsjTH6xXHJl33kbV2JOLJf3DoEtJQgPAxHBhyKRSuVM/LI7mUvItHyQ
         VmvQkVrlz60z6SmxWNwxkkln3DSSe0J0Vl3m22Qg1iCK/t7eadHRGlJiX4rD2wsAa7+O
         kaSw==
X-Received: by 10.236.149.176 with SMTP id x36mr3489353yhj.27.1387495083533;
        Thu, 19 Dec 2013 15:18:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm8338990yhg.8.2013.12.19.15.18.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 15:18:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMi+fEnVekrWYrG6sGiRPmOXxaJ1-Y9xd83W7Wvw3GwWz8DuBQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239554>

(cc-ing area experts)
Hi,

Eric Andrew Lewis wrote:

> Git is smart enough to realize when you make a spelling error and
> enter a non-existent git command. Since you probably do mean what it
> suggests, it follows that the user would want to immediately say =E2=80=
=9Cyes,
> I did want to do that,=E2=80=9D rather than return to the command lin=
e to
> enter the command again.

Yeah, it's a real tease. :/

> e.g.
>
> $ git psh
> git: 'psh' is not a git command. See 'git =E2=80=94help'.
> Did you mean 'push'[y/n]?

This is a natural extension to the existing "ticking time bomb"
feature that can be enabled with

	echo '[help] autocorrect =3D 50' >>~/.gitconfig

Some value like "autocorrect =3D ask" could mean to prompt, and the
default behavior could be not to prompt (to avoid breaking muscle
memory for people used to the usual "just succeed or fail, don't
interact" behavior) but to mention that configuration in the output to
make it easy to discover.

With that tiny tweak, it sounds good to me.  I stole this idea from
http://thread.gmane.org/gmane.comp.version-control.git/197151/focus=3D1=
97249
and the surrounding thread, which also has rough hints toward an
implementation.

Thanks and hope that helps,
Jonathan
