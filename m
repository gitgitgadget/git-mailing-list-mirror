From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git pull with "no common commits" : danger?
Date: Thu, 8 Apr 2010 00:44:05 -0500
Message-ID: <20100408054349.GA6067@progeny.tock>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzkX9-0002bB-6f
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab0DHFoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 01:44:01 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:6594 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab0DHFoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:44:00 -0400
Received: by qw-out-2122.google.com with SMTP id 8so674337qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 22:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2dfeDZFvqeBjYHMAiinGZDeohbRQAj2oo79gZEauya8=;
        b=Qtma8NFR/jtG8NguKUZX5CQd8LIKHXT67OhAWj2WMReyaQ37QIMOSzSVj2W4COLgck
         o6r7VQhgXLzmUOHOKZ+Hxb4OhY7otB2belzcvSc7P19SdaxdASv9/xQ/Sw1tCrU8KWNg
         argRZjq8qVxKn2t/bZwPtuLUNMvVxK09iUslw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pEZ+93cVJKK4azFJ27Wsp5sW5xXNJQHwECu3d3vByy4Hu5QvJRgboV1ZcTFDm0U8im
         ImvQe1V2Vy2SToveAKejYTRwQFHK7ie6qF+hZLcYzxfMrvKu1EOLxkafUgJglD8rlLZ3
         cQ1Rlxp3k+X2d/+FhcDrNJo8r0t7f+u6YiIbY=
Received: by 10.224.65.199 with SMTP id k7mr1702181qai.257.1270705439378;
        Wed, 07 Apr 2010 22:43:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4106936iwn.11.2010.04.07.22.43.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 22:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144319>

Hi,

Aghiles wrote:

> I mistakenly pulled a project into another project. I had the
> "warning: no common commits" but the pull did proceed.

=46irst: you are aware that interrupting the pull will have no bad
side-effects, right?  So if the worry is lost time, then git is not
advertising its features well enough.

Because of this, if =E2=80=98git fetch=E2=80=99 starts refusing to fetc=
h when there
are no common commits, I will be unhappy, because it imposes hassle on
the user for basically no benefit.

On the other hand, =E2=80=98git pull=E2=80=99 is a little different.  T=
he fetch has
very little cost because it=E2=80=99s interruptible, but the merge coul=
d
result in two unrelated pieces of history being merged, requiring
the user to use =E2=80=98git reset --keep HEAD^=E2=80=99 to get back to=
 the
previous state.  A more likely outcome is a merge conflict, requiring
=E2=80=98git reset --merge=E2=80=99 to recover.

Can we make this less painful?  Is it worth adding yet another option
to =E2=80=98git pull=E2=80=99 to avoid this pain?  I don=E2=80=99t know=
=2E

Regards,
Jonathan
