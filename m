From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] nd/resolve-ref v2
Date: Tue, 6 Dec 2011 21:07:09 +0700
Message-ID: <CACsJy8A6KqjOjMQQXEdHWeAUqB5np-_myXdQzQe1+oMfXFzv7Q@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com> <20111117103924.GA5277@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 15:08:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXvgm-000384-Ge
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 15:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411Ab1LFOHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 09:07:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58725 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233Ab1LFOHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 09:07:41 -0500
Received: by eeaq14 with SMTP id q14so2908766eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HlAJDksfPgCxUx3KgNTVcM48epvQ6aNjs5oCf45YYAw=;
        b=bXLrGZcMyevsiiz5OBaoA7CkYQwRpfaME0KRRJLBY/hOysrNz/r9dzHHlB9+TI04wH
         neSc0f7Tk6d6JOz0+1gpzyfMyrU5/mg41Tsqo3niH5gav1XT/08NT1QNPme+zqlNw3ci
         +XgAAorvYxJcnaK//Mgae95wmHahw5kQ34fCw=
Received: by 10.14.15.221 with SMTP id f69mr2421795eef.163.1323180460250; Tue,
 06 Dec 2011 06:07:40 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 06:07:09 -0800 (PST)
In-Reply-To: <20111117103924.GA5277@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186349>

2011/11/17 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
>
> Here are some comments from a quick glance over the series, to avoid
> too much noise that would distract from reports about the upcoming
> release.

Sorry for the late reply. Somehow I managed to miss your mail.

>> =C2=A0 Re-add resolve_ref() that always returns an allocated buffer
>
> Makes me nervous, since it would introduce memory leaks if some other
> patch in flight calls resolve_ref(). =C2=A0Why not call it ref_resolv=
e() or
> something?

Yeah, I made the same mistake before and made it again.

>> =C2=A0 Enable GIT_DEBUG_MEMCHECK on git_pathname()
>
> __VA_ARGS__ was introduced in C99. =C2=A0I suspect some compilers tha=
t
> currently can compile git don't support it. =C2=A0But if you need to =
use
> it, that wouldn't rule out doing so in some corner guarded with an
> #ifdef.
>
> Looks pleasant overall. =C2=A0I look forward to looking more closely =
at
> this later.

This patch is bonus anyway and I think I'll drop it. Keeping a bunch
of ifdefs looks really ugly. I think having git_pathname()'s static
buffer per callsite file would be a good thing to do instead.
--=20
Duy
