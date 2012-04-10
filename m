From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Wed, 11 Apr 2012 05:51:44 +0700
Message-ID: <CACsJy8Dc9xi=z7x4OfeAWHSeuUOFFVFf93GFOfauVB7c=_cZ1Q@mail.gmail.com>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com> <20120410173616.GA4300@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 00:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHjvC-0004Zu-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 00:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573Ab2DJWwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 18:52:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53058 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013Ab2DJWwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 18:52:17 -0400
Received: by wejx9 with SMTP id x9so192337wej.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RoLHwm/VlyKugB+ZUdTeWUHcInKZalLM9xrCObNVXi0=;
        b=r9oO0Xb8KVJ/UnJzLhZmBQpqj4MNuNMk7szPbmDeWNCXNAeFRZT3IzLl2PY1hD2MQ8
         8vRe5cF7HbI7ZM07QWPQMl6dH5z8mxVEkucYXbyMWt/AoiyMoBUzcAuhuLL09gOCmREG
         EjYld8Wdh+LWTjFZY6FeUIaBMfgEW4jTAkLhZUOGMV4aNJukTkEah1lqcM4fGaSj979b
         GzV8bodT2LBOr/hgDKGImSnsWiojZ8k+L/L8djM+qfMFPdzZMMV95vPllABVxV/3/7WG
         Cu/cukl2Ujk6xC22Wsv4Vy/sgRdhPWZo4NpJkRfvyOMB8DOuPuAUU9tV3UCfrPvv4lux
         pHKQ==
Received: by 10.180.102.3 with SMTP id fk3mr10894862wib.9.1334098335812; Tue,
 10 Apr 2012 15:52:15 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 10 Apr 2012 15:51:44 -0700 (PDT)
In-Reply-To: <20120410173616.GA4300@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195135>

2012/4/11 Jonathan Nieder <jrnieder@gmail.com>:
> (cc-ing Duy)
> Hi,
>
> Ross Lagerwall wrote:
>
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -634,6 +634,8 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!strcmp(arg, "--show-prefix")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(pr=
efix);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 putchar('\n=
');
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>
> This makes the output more consistent but it is a little puzzling how
> it does that. =C2=A0Why is prefix NULL instead of "" when we are at t=
he
> toplevel of the worktree?

It dates back to the first version of setup_git_directory() in d288a70
([PATCH] Make "git diff" work inside relative subdirectories -
2005-08-16). If we get "", setup_git_.. converts it to NULL. Although
I think Linus made a mistake in the first version of "rev-parse
--git-dir" doing "puts(prefix);" unconditionally in the same commit.
Junio fixed --git-dir in 4866ccf (Rationalize output selection in
rev-parse. - 2005-08-24) with the "if (prefix)" clause and should have
added the "else putchar('\n');" there too, I think.
--=20
Duy
