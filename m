From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] Unify appending signoff in format-patch, commit and sequencer
Date: Thu, 15 Nov 2012 12:42:41 -0800
Message-ID: <CA+sFfMcfGbGDeXKZD1o4pmhbrJ1E5WgV3qrQBPT3eH=W54tNGw@mail.gmail.com>
References: <1352982778-28631-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:37:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ77Q-0005bE-81
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 22:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab2KOVgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 16:36:45 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59147 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KOVgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2012 16:36:43 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2180050vcb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nR3GmjlT1wOg875LyTTOQyv6Ubij2ii2s7WAMK5JsfU=;
        b=CVr+G92RFubXXiXiVtHDnI9yjbsGQf6qaZMicNKkJQ5NA5AONgEchWQX1+mFkuhDEr
         P04Qqjz1yHh0Kht1fb3iadSEhH4hefyr8NsuIkiMZhoPtCu8lRg6Jw7GQ99LgKdTY/J0
         21kDVQJ2FGZg8CTBUxukcGivt6DTMU3vbLa4xB7hUbNKy54M3kcrIjPokSVTk++mkTlW
         RIaVnWzm6c9t3R4REMCd3S4TMeLaFHVCpKujG4GSUf9HO608nVy+seCr88SWxbzpeQUL
         cM6EOh/7MIcq9WLHjd/bWkvdSgr4g1XHvI9DzvRung8vqZ3TixAyypLmWraXnX/Iendo
         Gs7w==
Received: by 10.220.152.11 with SMTP id e11mr3087391vcw.61.1353012162107; Thu,
 15 Nov 2012 12:42:42 -0800 (PST)
Received: by 10.58.220.9 with HTTP; Thu, 15 Nov 2012 12:42:41 -0800 (PST)
In-Reply-To: <1352982778-28631-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209847>

On Thu, Nov 15, 2012 at 4:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> There are two implementations of append_signoff in log-tree.c and
> sequencer.c, which do more or less the same thing. This patch
>
>  - teaches sequencer.c's append_signoff() not to append the signoff i=
f
>    it's already there but not at the bottom
>
>  - removes log-tree.c's
>
>  - make sure "Signed-off-by: foo" in the middle of a line is not
>    counted as a sign off
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Interestingly this patch triggers the fault that it fixes.
>  I was surprised that there was no blank line before my S-o-b
>  and thought I broke something. It turns out I used unmodified
>  format-patch and it mistook the S-o-b quote as true S-o-b line.
>  The modified one puts the blank line back.

Heh, yeah I noticed this bug yesterday when I submitted my changes
affecting the same area of code (sequence.c).  Glad I didn't waste too
much time fixing it.

Have you looked at this:

   http://thread.gmane.org/gmane.comp.version-control.git/209781

That series doesn't duplicate your work, but the two series's should
be resolved.

-Brandon
