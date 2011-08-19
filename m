From: Sorin Sbarnea <sorin.sbarnea@gmail.com>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header files
Date: Fri, 19 Aug 2011 23:27:22 +0100
Message-ID: <CAGDPfJpSVknybUjUsHkb1Mb8_SqQxJB2idRTxxfsT8eRSA91CQ@mail.gmail.com>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com>
 <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com>
 <201108200012.17580.trast@student.ethz.ch> <6LbwaepC5kIygT8uWl1Wf2A7S_AD1YkTya7FLCpDK4LOS7CNxjOveFLpzZtHv0dg_JJ8l78oW6XVugLUDAHkvBFItwH2yzYH6BgRAAZkFuM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXXc-00088X-Tz
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab1HSW1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 18:27:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47046 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab1HSW1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 18:27:43 -0400
Received: by bke11 with SMTP id 11so2527447bke.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FrZsXURNN3BYaJP2p0CuyadijXrUB/4Zpqwo++SSeXQ=;
        b=Lny0ROZgMQt+zHG7sE5Tpm8jXUybcadrELOPxfSFd+ktorVmxZ9KZyUKmf2hgar1u+
         uGAe7fG+LQzdE1iYmfBX1AYp+PWBHxGSMuHUR4sNCKEg18DiSQGvpLrktHn4O9xt9pqi
         B+QBoIeUVjlClgLNm1Buclmbf4I3q+WUr7Ugk=
Received: by 10.204.7.214 with SMTP id e22mr89870bke.102.1313792862116; Fri,
 19 Aug 2011 15:27:42 -0700 (PDT)
Received: by 10.204.104.7 with HTTP; Fri, 19 Aug 2011 15:27:22 -0700 (PDT)
In-Reply-To: <6LbwaepC5kIygT8uWl1Wf2A7S_AD1YkTya7FLCpDK4LOS7CNxjOveFLpzZtHv0dg_JJ8l78oW6XVugLUDAHkvBFItwH2yzYH6BgRAAZkFuM@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179736>

I confirm that this workaround solved the problem. Now the question is
what should be changed so git will be installed (and build) without
problems by homebrew?

Thanks
Sorin Sbarnea


On Fri, Aug 19, 2011 at 23:19, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 08/19/2011 05:12 PM, Thomas Rast wrote:
>> Sorin Sbarnea wrote:
>>> This was a clean-new Lion install, not an upgrade. I just installed
>>> Xcode on alternate location /Developer41 instead of /Developer
>>>
>>> Yes, I did a `make clean` but it has no effect.
>>>
>>> The problem is that on Lion there is no config.h in the perl
>>> directory, only a perl.h file.
>>
>> Color me puzzled, but where is it getting the config.h idea from?
>>
>> =C2=A0 $ git grep config\\.h
>> =C2=A0 compat/fnmatch/fnmatch.c:# include <config.h>
>> =C2=A0 compat/regex/regex.c:#include "config.h"
>> =C2=A0 t/t4014-format-patch.sh:test_expect_success '--no-add-headers=
 overrides config.headers' '
>>
>> Similarly, 'git grep config perl' only turns up matches in perl code=
=2E
>> So what tells it to use config.h?
>
> Probably MakeMaker.
>
> Setting NO_PERL_MAKEMAKER may help:
>
> =C2=A0 rm perl/perl.mak
> =C2=A0 make NO_PERL_MAKEMAKER=3D1
>
> -Brandon
>
