From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Mon, 1 Mar 2010 20:49:08 -0500
Message-ID: <ca433831003011749h43293f80kd4ec18bd796dea7c@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B890572.5040604@lsrfire.ath.cx> 
	<ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com> 
	<b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 02:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmHEt-0005Yn-Kj
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 02:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0CBBta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 20:49:30 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:60735 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab0CBBt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 20:49:29 -0500
Received: by ywh35 with SMTP id 35so1504469ywh.4
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=X3JNWzejNenEkN+odK8D+UGdviymIQgsTe9M6W/rzK0=;
        b=AyDIfmGG+5+CpJopb8mQDNHD15pUCNw5k0lSEUO78vpGCgiQthKeyu+c1TA/ueJR7e
         dU0w/WeSDew3J7mrUe98xLw3jFQd1MQBL0x8ytqEJ/xOhooRgYheOKOhmPoYQfMwNX1Q
         tNskjczCFnDWY56dfq8tcNOO1oaE7RaQBVpNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZEEglnDVv1FA+E5Yhsnel44oD8tueBXeMhEMffE0MJCFnCospSJqemh88NmtueaWvI
         2rZQ6JFclhgQPFizN/jA/Bqmybimor0E21zNs4x/kcxNmFuamoO8iMg3ahCK2dJ8ppjC
         LrqQzujNhGtnenHkVr7/KXIcI2Dw/KvcpECaA=
Received: by 10.91.85.9 with SMTP id n9mr4485419agl.73.1267494568161; Mon, 01 
	Mar 2010 17:49:28 -0800 (PST)
In-Reply-To: <b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141373>

On Sun, Feb 28, 2010 at 5:26 PM, Michael Witten <mfwitten@gmail.com> wrote:
> Of course, I bet you find colorizing the filenames a nuisance because
> you don't care to pipe the relevant escape sequences to other
> commands.

I'm not quite sure what you mean here, but my reason has nothing to do
with piping.  If the output is entirely in a single color, I would
prefer that color to be my terminal's default.  The color adds no
value.

> On that note, it would be nice to have something like GNU's
> --color=(auto|yes|no) with `auto' as the default for a plain --color.

Something like [1]?  By the way, the default should be 'always', not
'auto', to be consistent with GNU tools, and to be backwards
compatible with the old --color behavior.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/139864

> As a compromise (and perhaps as an improvement), perhaps only the
> basename of the filename should be colorized when --name-only is used;
> that way, colorization is still being used to differentiate different
> data, and the rest of the path is usually not that interesting anyway.
> However, for consistency, I would still think it wise to colorize the
> dirname portion with `color.grep.filename', but color the basename
> portion with `color.grep.match' (as though the basename portion is the
> text being matched).

Personally, I am not a fan of this, but if it is implemented, it
should be an option, and should be turned off by default.  Instead of
highlighting the name, it may be better to simply highlight the
slashes so the reader can more easily parse the path.  But still, I
don't think this is worth the trouble.
