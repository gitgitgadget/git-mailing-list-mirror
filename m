From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 13:01:30 +0200
Message-ID: <BANLkTimqVs+Bg+zz7xu1Fb=a_dJ65WOvQQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2Uz-0004N9-MW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab1D0LBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 07:01:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47986 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab1D0LBc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 07:01:32 -0400
Received: by fxm17 with SMTP id 17so1036299fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dXGQvW/b9eVIzLX441m7wKHt0FJH9x5Fx4SiLSZyacs=;
        b=Aj8PywE2TotXpSa5EaTIRJG6+I4uiQtLYDQzr4tuXl8f2XxU0TOeiOqrY3mu70ljXB
         GjG2Iwnu6J3wndkKRHszYRY6QNFPCdaT+CcrdQPfH3pa3GjOYG1GZdnHem24AmxJfSPx
         7yPlsYR7qxvT4Es4k1m7vVP54ihF1lmNdWmQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yDf33sXRNZahTd9c89QKYoOqdJAKUG039C6WuNUIkFn0gWuLzfQyg/Jdhfe6I21ybg
         vmYQ4rVMagtgEV002O+Y+Xz+rwCR5JPwFm3tOY0/bWUy3kyt30mFQr4m1wrB9g6W/Jq8
         E/TtsieevfRPhQCKk4eMYDyI1Q5nwCti8/Qgo=
Received: by 10.223.127.210 with SMTP id h18mr2185243fas.67.1303902090813;
 Wed, 27 Apr 2011 04:01:30 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Wed, 27 Apr 2011 04:01:30 -0700 (PDT)
In-Reply-To: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172218>

On Wed, Apr 27, 2011 at 05:36, Jon Seymour <jon.seymour@gmail.com> wrot=
e:

> What would be call is if I could package my extension in a standard
> way and then anyone who was interested could simply do something like=
:
>
> =C2=A0 =C2=A0git plugin install gitwork
>
> and then start using the commands as if they had built my fork of git
> themselves.

We already have a plugin system, you can drop "git-work" in your
$PATH, what you're talking about is a packaging system, and solving
that problem in a user facing application like Git is IMNSHO a
terrible idea.

Instead you could just make gitwork available somewhere and then
install it as:

    sudo aptitude install git-work

Or whatever incarnation of that your distro or OS provides.

Having our own "gpm" system would mean having to solve all these
issues of distribution, cross-platform & arch compatibility that real
packaging systems already deal with.

If you *really* wanted to go through with this I'd suggest just using
some existing package manager like apt, aliasing it to "gpm", then
configure it to download packages from your own custom repository, and
install them in ~/ somewhere.

You'd still be re-inventing the wheel, but at least minimally so.
