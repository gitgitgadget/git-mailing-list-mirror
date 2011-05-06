From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Fri, 6 May 2011 04:59:20 -0500
Message-ID: <20110506095920.GA1635@elie>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
 <20110505232503.GA7507@elie>
 <BANLkTikk1wfaC4Aic4iyJZXbZ5kkuEDxaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 11:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIHor-0007FE-W4
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 11:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab1EFJ72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 05:59:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48560 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1EFJ71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 05:59:27 -0400
Received: by iwn34 with SMTP id 34so2537356iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SesdEkYrp3d9cDaStrV7SbKb4s4qCIfiPm81ozqPQvE=;
        b=a12ndFxCwghfJK0/RCukOtITGQWRA5qFS/LfVkjgGJh8O+SfJZ9phBZHjnw9fnO7BM
         2Nmjggpy1BPu58vXZ6nNwZ6wpMGWFa29UVhVu8jb7Na1Gtuh9vH9gGuVULPINZFUMPiw
         J5gjh8BZyNXb3btl04wEDxhyR7+w6WXcdfzRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X+43WbyDVjNgoUsYa/JeJB5AJ1EpzZMLYUroTdWNa6Hdpc9itcPe6cqL5X2PHcmPp/
         CHF4HhqeR63og8XAUyUvnTXzycU/IcSt0ZKaDvnZc7wee9lfrRxvJZRFiN/6ftSSWAcv
         WYbsOCdfE/ZkVGKye2R8qZlU34Ug6pby1Rhec=
Received: by 10.42.142.3 with SMTP id q3mr2425387icu.243.1304675965839;
        Fri, 06 May 2011 02:59:25 -0700 (PDT)
Received: from elie ([76.206.232.100])
        by mx.google.com with ESMTPS id gx2sm1285511ibb.60.2011.05.06.02.59.23
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 02:59:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikk1wfaC4Aic4iyJZXbZ5kkuEDxaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172965>

=46elipe Contreras wrote:

> No, the scope remains local.

Is this local in the sense of typeset used in ksh functions declared
as "function f" or local in the sense of typeset used in ksh functions
declared as "f ()"?  If the latter, I think you misunderstood me --- I
never meant to suggest otherwise.

> In fact, if you follow the link I posted, that's precisely the fix th=
e
> zsh guys were pushing for. And the it is already merged:
> http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommitd=
iff;h=3De880604f029088f32fb1ecc39213d720ae526aaa

Now this changes things (since it amounts to a guarantee that the
bash completion emulation has already extracted all it needs from
$words before calling a completion function).  What happens if someone
calls "compgen -F" after words is hidden?

> Well, it's hosted on debian.org, and I haven't seen it used anywhere
> else. I just don't know how else to identify that project.

Here you go: http://pkgs.fedoraproject.org/gitweb/?p=3Dbash-completion.=
git;a=3Dtree

It's called bash-completion or bash_completion.  It really has
basically nothing to do with Debian; they just are using Debian
infrastructure.  But hey, call it what you want.  I don't like
arguing.

> I think the simplest fix is the one I'm proposing

I'm happy with it as long as the zsh people are committed to making
sure it continues to work (which it sounds like they are, luckily).
I suppose it is intended to obsolete the third patch from G=C3=A1bor's
series?  Could you provide an explanation for the commit log,
something to the effect that

 - the words array has special meaning
 - that produces such-and-such puzzling symptoms
 - zsh 4.3.12 (?) will fix it by using "typeset -h" to hide it when
   running completion functions designed for bash
 - we can make the same fix to work correctly with earlier versions of
   zsh, and that's what this patch does

?

Sorry I have been so dense --- hopefully I understand it roughly
now.

Regards,
Jonathan
