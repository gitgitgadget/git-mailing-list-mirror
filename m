From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] Documentation: clarify effect of '/' in gitignore(5) patterns
Date: Mon, 7 Nov 2011 17:05:15 +0700
Message-ID: <CACsJy8AnPD7NFeCbMG+vy5YvWWfb5CwaRX=qRkOE8_Hk_9zUNw@mail.gmail.com>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net> <20111107080842.GB30486@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>,
	Johannes Sixt <j6t@kdbg.org>, "Y.G." <yamomo1@hotmail.com>,
	Eli Barzilay <eli@barzilay.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 11:05:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNM5R-0003N0-5G
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 11:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab1KGKFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 05:05:48 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1KGKFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 05:05:48 -0500
Received: by bke11 with SMTP id 11so3430296bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 02:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k3u6yGTgvixJRrdkrWtJnhSleKDWGqKOKMQoyDte/Mo=;
        b=TIFwpJBPwaUa3Ue1IbZtiUJ+/bMhMbC8o1Gb1J2XoYAycHrAp2p5SJnNNs+a8iZ3qd
         vi277Zv7UTV5LP3LTMba8Bp3u3y0dWAWXq7MIclb0V6Iw2Z6ZLQ5U2/EG2AqJkSzMK6U
         c7AYHTwuHW9Z9xbcadT2BBabAA+5o5u1TIpPA=
Received: by 10.204.143.74 with SMTP id t10mr7954198bku.45.1320660346169; Mon,
 07 Nov 2011 02:05:46 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 02:05:15 -0800 (PST)
In-Reply-To: <20111107080842.GB30486@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184969>

2011/11/7 Jonathan Nieder <jrnieder@gmail.com>:
> The introduction of directory-only matches in v1.5.5-rc0~208^2~1
> (gitignore(5): Allow "foo/" in ignore list to match directory "foo",
> 2008-01-31) was a small, incremental change to gitignore syntax that
> did not affect the rest of the rules in any major way. =C2=A0A '/' at=
 the
> end of a pattern means "match directories only" and does not otherwis=
e
> affect the pattern. =C2=A0And that is how the gitignore(5) manpage ex=
plains
> the syntax.
>
> However, to a person parsing an unfamiliar gitignore entry like foo/,
> it is too easy to notice the later (old) rule that describes how
> patterns containing a slash are anchored and miss that the slash
> should have been stripped off before considering whether the rule
> applies.

I think I make this mistake too. Documenting it is one way. Another way=
 is t

>
> Let's just explicitly say that patterns are only anchored if they
> contain a slash that is not at the end of the pattern, avoiding this
> confusion. =C2=A0A more graceful presentation of this material may be
> possible, but for now the goal is to get the facts clear --- we can
> refactor the text to scan well without losing its meaning later.

I think the first slash in 'foo//' may function as the anchor and it's
not very clear to me if it's in the middle of pattern of at the end.
Of course we could just change the code to strip all trailing slashes.
--=20
Duy
