From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v4] grep: Add the option '--exclude'
Date: Thu, 2 Feb 2012 21:35:25 +0700
Message-ID: <CACsJy8CC+cwV+DEWPZVJqEtMq1Rd_RZtUTpMCeSmem5B_7vDMA@mail.gmail.com>
References: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsxlZ-00063e-JB
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab2BBOf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 09:35:57 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab2BBOf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 09:35:56 -0500
Received: by bkcjm19 with SMTP id jm19so2159001bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 06:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Rmyu2DHTBH5xpkgZtsTe7lpP1jdzIJiBfpsVsaqHHoM=;
        b=q37NjAF0bIo+QUYb6ECLP/uFxJi4AD3uWRfe0xRWpKdWVtSKqhzYTIsKhDbTbQ5uz+
         C6Q+SA9zCnLiHyhZJgQ72sEd9v9Zp4FrhzZpHixx8kv1GNf8hGfdab2sqQafavUCv7hl
         kGmObRLt/bt4Vv5kvzd4QaIebckRb772LXm68=
Received: by 10.204.155.145 with SMTP id s17mr1491035bkw.19.1328193355148;
 Thu, 02 Feb 2012 06:35:55 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 2 Feb 2012 06:35:25 -0800 (PST)
In-Reply-To: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189646>

On Thu, Feb 2, 2012 at 9:25 PM, Albert Yale <surfingalbert@gmail.com> w=
rote:
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 6a8b1e3..b45706a 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -22,6 +22,7 @@ SYNOPSIS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--color[=3D<when>] | --no-color]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-A <post-context>] [-B <pre-conte=
xt>] [-C <context>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-f <file>] [-e] <pattern>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[-x <pattern>|--exclude <pattern>=
]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--and|--or|--not|(|)|-e <pattern>=
=2E..]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ [--exclude-standard] [--cached |=
 --no-index | --untracked] | <tree>...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--] [<pathspec>...]

I'd like to have a careful look at this but haven't found time/energy
yet. So just a minor comment. Please use the term <pathspec> instead
of <pattern>. Exclude pattern has complete different syntax than
pathspec and --exclude followed by "pattern" may give wrong
impression.

I'd also avoid reuse "-x" if it's common for exclude patterns, but
finding a new letter may be difficult. Keep in mind this feature in
the long run benefits more commands than just git-grep and ideally
they should all use the same letter for short option name.
--=20
Duy
