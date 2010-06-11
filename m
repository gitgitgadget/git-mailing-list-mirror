From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* 
	configurations ignored for known tools
Date: Fri, 11 Jun 2010 12:06:57 +0200
Message-ID: <AANLkTim3UWlP7N2ucI3ncN2jzc4lSEyiJcQhYNElQVXl@mail.gmail.com>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
	<1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
	<4C0FEA7B.9030409@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 12:07:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON18p-00078J-GP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 12:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760082Ab0FKKHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 06:07:00 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58221 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab0FKKG7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 06:06:59 -0400
Received: by wwb18 with SMTP id 18so590262wwb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 03:06:58 -0700 (PDT)
Received: by 10.227.138.148 with SMTP id a20mr1584760wbu.91.1276250817862; 
	Fri, 11 Jun 2010 03:06:57 -0700 (PDT)
Received: by 10.216.229.12 with HTTP; Fri, 11 Jun 2010 03:06:57 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <4C0FEA7B.9030409@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148935>

On Wed, Jun 9, 2010 at 21:24, Charles Bailey <charles@hashpling.org> wr=
ote:
> On 05/06/2010 03:31, Sylvain Rabot wrote:
>>
>> At this time when you define merge.tool with a known tool,
>> such as meld, p4merge, diffuse ... etc, mergetool.<tool>.*
>> configurations are ignored and git mergetool will use its
>> own templates.
>>
>> This patch adds a detection for mergetool.<tool>.cmd configuration
>> in the run_merge_tool function. If the configuration is set, it will
>> try to run the tool with mergetool.<tool>.path if its set. It also
>> consider the mergetool.<tool>.trustExitCode configuration.
>>
>> Signed-off-by: Sylvain Rabot<sylvain@abstraction.fr>
>> ---
>> =A0git-mergetool--lib.sh | =A0 60
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>> =A01 files changed, 60 insertions(+), 0 deletions(-)
>>
>
> First, my apologies for only having had the time to skim this so far.

No worries ;)

>
> Can I just ask some basic questions about the purpose of this patch. =
Is it
> the intention that if mergetool.<tool>.cmd is set then you want to me=
rgetool
> to behave 'as if' the merge tool wasn't a 'known' tool and just perfo=
rmed
> the "*)" case ?

yes

>
> If so, it seems like a lot of extra boiler-plate and error handling t=
hat
> doesn't exist in the normal "*)" case. Should we have have this in th=
e "*)"
> case as well? If so, we should look to rework it so that we can re-us=
e the
> code rather than duplicating it.

I did not modify the "*)" being afraid to break it all, but that would
be the right thing to do.

>
> From a user perspective, if they want to run a "known" tool but in a =
way
> that is different from the default behaviour can't they just give it =
a
> different name, e.g. merge.tool=3Dmy_kdiff3 , mergetool.my_kdiff3.cmd=
=3D... ?

That's the workaround, yes, but, if you are the user and you are not
aware of this bahavior, you will do exactly like a did, i.e., lose
your time to torture your git configuration because it is not working
the way you was expecting it would.

>
> Thanks,

Thanks for your time.

>
> Charles.
>
> --
> Almost dormant mergetool maintainer.
>



--=20
Sylvain
