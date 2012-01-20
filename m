From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Sat, 21 Jan 2012 04:20:23 +0530
Message-ID: <CAMK1S_gkZYpK3nrNMsnmFzi=tzjyEjVwOo_j4Z=d0hqjdF7r_w@mail.gmail.com>
References: <201201201433.30267.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 23:50:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoNHx-000854-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 23:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab2ATWuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 17:50:24 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:40425 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755646Ab2ATWuX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 17:50:23 -0500
Received: by obcva7 with SMTP id va7so1296469obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 14:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kUBB2jWgqQDiLRSeVxmRC6Fz3dA2ds2rLO4LhrfJ2kM=;
        b=J9pvxMBD53+yvtFiX1uQQJ2uEQ8z5dFzPJ94iGE7KZLzu0QVuB1dKcEw+dMRZauBz8
         TvRqAX5mop9fxHs3CS8ohBVdwyAOJmo0K/Cgep+wj2ihqy22TJaqtZqfiQgYrnx0wOH0
         VutxGsEWwmXKR8PCqFuap/QHJPup24ro+E5qE=
Received: by 10.182.43.10 with SMTP id s10mr28322069obl.43.1327099823294; Fri,
 20 Jan 2012 14:50:23 -0800 (PST)
Received: by 10.182.51.170 with HTTP; Fri, 20 Jan 2012 14:50:23 -0800 (PST)
In-Reply-To: <201201201433.30267.brian.foster@maxim-ic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188906>

On Fri, Jan 20, 2012 at 7:03 PM, Brian Foster <brian.foster@maxim-ic.co=
m> wrote:
>
> Hello,
>
> =C2=A0Whilst I have found answers to my question on the Web,
> =C2=A0only one seems to do exactly what I want ....
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 x---Y---y---y---y =C2=A0HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/
> =C2=A0...--o---o---C---o---S
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 n---n---N---*---* =C2=A0other
>
> =C2=A0In a script, how can I determine commit Y is reachable
> =C2=A0from the current HEAD ? =C2=A0 And, much more importantly

I've been using 'git rev-list HEAD..Y'.  If it produces any output, Y
is not reachable from HEAD (there is something in Y that is not in
HEAD).
