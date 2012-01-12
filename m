From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 14:31:30 +0100
Message-ID: <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 14:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlKkx-0004dk-Va
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 14:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2ALNbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 08:31:31 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44952 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab2ALNba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 08:31:30 -0500
Received: by dajs34 with SMTP id s34so1073387daj.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PygLlOvB+Mq3jF9iJ/8ZgseGm93s1rWtMd+4yx1zdFQ=;
        b=U8dDtaCv2Zpdl3h9Gfkoi49B5rLaKBVvJUTbutXKu13Low6uRKbFQK0IASfS0jIsqz
         7oKUjMrO6tArOtSwxbvXBE2bVOWhe8aO96neJ6/w/vjyTOCPzDxKwVJazgKaQeYUMHhI
         2jDyYdzDazS27l+pZ6O9a1IHRoOSUrbf3m2ko=
Received: by 10.68.191.3 with SMTP id gu3mr8109693pbc.112.1326375090354; Thu,
 12 Jan 2012 05:31:30 -0800 (PST)
Received: by 10.143.141.8 with HTTP; Thu, 12 Jan 2012 05:31:30 -0800 (PST)
In-Reply-To: <20120111173101.GQ30469@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188444>

Hi all,

2012/1/11 SZEDER G=E1bor <szeder@ira.uka.de>:
>
> As far as I can tell, this buggy behavior is as old as multi-commit
> cherry-pick itself, i.e. 7e2bfd3f (revert: allow cherry-picking more
> than one commit, 2010-06-02).

Thanks for the very detailed report!

I didn't test nor even compiled anything but maybe this can be fixed
by adding something like:

opts->revs->topo_order =3D 1;

in parse_args() or in prepare_revs()

I will try to have a look tonight.

Thanks again,
Christian.
