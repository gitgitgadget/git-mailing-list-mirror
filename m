From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 21:06:00 +0530
Message-ID: <CALkWK0nQD7sw506D7shE8TYe5xGLNJkzS5_6L-oOR7gT54PbAA@mail.gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com> <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net> <4E9FE061.3080601@gmail.com>
 <20111020090912.GA21471@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 17:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGufS-00010f-0z
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 17:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1JTPgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 11:36:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38824 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab1JTPgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 11:36:21 -0400
Received: by wyg36 with SMTP id 36so3008990wyg.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ajU9skcCyK0Rl2A7viDMhuERqUVgVSjobXU2X+HkKFA=;
        b=rp2C99sgdxj/CRXnBUYRjZZ0gDHuiT9jR8j9c/JqSBUWSlStKAnJSPhfOF09GnPnyi
         +qxBwdjA9WLb7aAtBgxdTOsbdj9uWZ860xmYKIjdDm8/sP2mk/hGcFsiyWT19L650z6z
         T7YiUIDOKhvlh7qhbZMtXWWQ4pmqCvn5YmA7Y=
Received: by 10.216.137.130 with SMTP id y2mr7866830wei.0.1319124980213; Thu,
 20 Oct 2011 08:36:20 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Thu, 20 Oct 2011 08:36:00 -0700 (PDT)
In-Reply-To: <20111020090912.GA21471@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184025>

Hi Jonathan,

Jonathan Nieder writes:
> [...]
> Looks good, except I would explain it differently, to avoid referring
> to hypothetical implementation details ("What buffer overflow?"):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test: git cherry-pick --continue should co=
pe with long object names
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A naive implementation that uses a commit-=
id-shaped buffer
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to store the word after "pick" in .git/seq=
uencer/todo lines
> =C2=A0 =C2=A0 =C2=A0 =C2=A0would crash often. =C2=A0Our implementatio=
n is not so naive, but
> =C2=A0 =C2=A0 =C2=A0 =C2=A0add a test anyway to futureproof it.
> [...]

I picked this one.

> Though the implementation is actually better than that --- it can eve=
n
> cope with a valid object name (e.g., a long name of a branch, or
> something like "HEAD^{/refs.c: ensure struct whose member}") that is
> that long, without truncating it. =C2=A0So if you have time for it, I=
 think
> it would be worth a test where the "git cherry-pick --continue"
> succeeds, too.

Good idea.  Will re-roll shortly.

Thanks.

-- Ram
