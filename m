From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] show-branch: color the commit status signs
Date: Wed, 22 Apr 2009 12:26:55 -0700
Message-ID: <780e0a6b0904221226s43a40a12k8bf83de12fa7815d@mail.gmail.com>
References: <1240350779-9686-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwi87-000837-5b
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbZDVT05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 15:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZDVT05
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:26:57 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:22324 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZDVT04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 15:26:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so95907and.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1De4WjnY0GoNDx4VJzFsSCTD0f0fDh6GGJDP6DoizxI=;
        b=Sg80BHskkNSeySahWzRdi5bb6Ux94VUE8P3KdwR5d81P+70MUv4lKUpyHh3QDUIsUt
         iIkTmd4aXBT1CMvYhD8OFf6k6gU7nEwrHghO84xSRseFkz9p1lRWRs/Bnv0Ji85CQe1/
         4WVnSGDcrnNw2NzirTB7/M3bUo2WmZLEuOrq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AMXrPQqMzpkvNPGyDHHEg8mG77XhqUi62SazM+3miiPgb7OhMyQp7W6BA0clBVEem1
         43Z1DzmJDNQHq3aFJj1Ke/HqgQ3eg/XDxFdWLz3qutBlJST7ViGXG5m+koDk7Dk3nwrB
         IWAaG7eJlJAuFGBb31CzK61/Xk3HR1Rxm7d20=
Received: by 10.100.202.8 with SMTP id z8mr155229anf.74.1240428415306; Wed, 22 
	Apr 2009 12:26:55 -0700 (PDT)
In-Reply-To: <1240350779-9686-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117237>

On Tue, Apr 21, 2009, Markus Heidelberg <markus.heidelberg@web.de> wrot=
e:
> +--color::
> + =C2=A0 =C2=A0 =C2=A0 Color the status sign of the commits. Each bra=
nch uses a single color.

I don't know what the status sign of a commit is without reading your c=
ommit
message. Maybe reword this to be:

Color the status sign ('*' '!' '+' '-') of each commit corresponding
to the branch
it's in.

> +static char column_colors[][COLOR_MAXLEN] =3D {
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_RED,
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_GREEN,
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_YELLOW,
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_BLUE,
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_MAGENTA,
> + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_CYAN,
> +};
> +
> +#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))

This looks like a copy/paste (with a small edit) from graph.c so maybe =
you
want to refactor the original code from graph.c to color.h?
