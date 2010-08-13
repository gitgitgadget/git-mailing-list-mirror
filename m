From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 17:37:25 -0500
Message-ID: <20100813223725.GA2153@burratino>
References: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2uQ-0001yY-Qh
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab0HMWjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 18:39:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43954 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab0HMWjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 18:39:25 -0400
Received: by vws3 with SMTP id 3so1620120vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3qSkNWsRaxJv3JZLA9VrE7tanuHXu82moeaDzlTJneM=;
        b=iE1BdFOjKst7sZYFtFNhuBbhQmhEfxDsPDWOMzlrkbLLUCmEuHO1Tpq9RaknlkpaOA
         +9hsl7b36vsXbrjKceWB0tFxHgcOgn5SethfXZfnOjDxFWkOUr3p9zATDX8yPMOcSeT4
         HYktxUO1z89WM+clgsK83HyqH2jMN+UWlJnng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ofe2HFpkUDwTDXVOvcY4CBMrQ47CS36Qkx18iTEKnKjede29en/aYlJHG8c9rzjJK5
         ergQResCQ74hDksypEi8qfFAchAkYvneZgMh4YqblD0LNygnGYVK5cV/aWmA3W7YAT7d
         WWjoDYRphU593z62F6oPgdJoFspq+TTySxRwQ=
Received: by 10.220.122.151 with SMTP id l23mr1235228vcr.22.1281739164453;
        Fri, 13 Aug 2010 15:39:24 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id m4sm1998746vbp.6.2010.08.13.15.39.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 15:39:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153521>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This is just an interesting datapoint, but Git's test suite currently
> crashes and burns if you don't have a perl in your $PATH, no matter i=
f
> you've compiled with NO_PERL=3DYesPlease or not.

Yes, I think this was known.  Development machines (which is where
people tend to run tests most) tend to have perl but some weird
production machines did not.

> I have a WIP patch series to tackle this issue:
>=20
>     http://github.com/avar/git/compare/git:pu...in-progress-dont-depe=
nd-on-perl
>=20
> It adds a PERL dependency to things

Reasonable.

> and changes perl to
> "$PERL_PATH".

Is that necessary?  As you mentioned before, a lot of uses of perl are
for run-of-the-mill one-liners and do not care much which version they
get.

On the other hand, even if it is not necessary, it might still be a
good idea to just stick to one perl version for simplicity.
