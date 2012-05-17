From: =?UTF-8?Q?Bartosz_G=C4=99za?= <bartoszgeza@gmail.com>
Subject: Re: Local cache for git objects
Date: Thu, 17 May 2012 23:11:47 +0200
Message-ID: <CALnNMuFtp0CoMkiP0W+6bOmd4Y6JD2b5HZuc3qfAuxiJjTcwEA@mail.gmail.com>
References: <CALnNMuHdNFktUkp+Vdc=ooTJ9ay_BJftAJ_toVaBDA5EOzt9ww@mail.gmail.com>
 <1337285744-ner-2739@calvin> <CALnNMuE=YQsXK-kiRUntNU_0s7s6ONgBk92dZN4UD0Va+qqF+Q@mail.gmail.com>
 <xmqqk40a7cwi.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 17 23:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV7zj-0003T2-NW
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145Ab2EQVMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 17:12:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36783 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2EQVMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 17:12:18 -0400
Received: by obbtb18 with SMTP id tb18so2994646obb.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YgV5JvBo7BCkDIU5ccGo3aS7u7g8hetMkcHmGA6yi+4=;
        b=qKrDOekqlWoIm3TkYvdn28qGrpwii40HJHh3/6RuFmhbf39k4ySNH8rHNg29sLtMa0
         /trGyb7lr94GR8VHaPyRisC3F1HdBzwhZKiCo34avUr7Ueji6suPeaxwPnE0vAG6zl0Q
         H0u0U8UWEx8Gps871paR0ASlYFjeFjnuxJRSI2+bk5TXvHKowBkxmAwWzMfF0Uez54PI
         7WN7RfNW8rJfJ5qqzvcxRiv+za6AqjakgbmCuW+l6nZn1FH/8Nk7aj1mFnHLczbt41AR
         eTYY3JlAAxNgxjnA8UP5AmDUkteZUNve/xY554O//q+Niysv4NOFBHsxEP58LeznrYSC
         J1XQ==
Received: by 10.182.113.71 with SMTP id iw7mr7995653obb.59.1337289137647; Thu,
 17 May 2012 14:12:17 -0700 (PDT)
Received: by 10.76.74.35 with HTTP; Thu, 17 May 2012 14:11:47 -0700 (PDT)
In-Reply-To: <xmqqk40a7cwi.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197930>

On Thu, May 17, 2012 at 10:47 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Bartosz G=C4=99za <bartoszgeza@gmail.com> writes:
>
> > Reference is read only (?)
> > I'd like to set up one global cache repository and forget.
> > Later as I fetch any objects they are stored there for fast future
> > access.
>
> Somebody needs to keep the "global cache" up to date, and that has to=
 be
> somebody who has access to cron(7) on your system, and you will be a
> good candidate to do so. =C2=A0So as part of the procedure to "set up=
 one
> global cache repository and forget (about it)", make a bare clone and
> then set up a scheduled task to periodically "git fetch" from its
> origin, and then you are pretty much done, no?

That would work. It's a good practice for a single project with stable
dependencies.

My only concern is that it requires effort from user of the cache to
keep the list of tracked remotes up to date. After time user would
have to recall how to update the list or bother somebody who
remembers. I suppose that in a few months since set up it would only
include repositories that take over 5-10 minutes to fetch.
