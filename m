From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/3] git-gui: new config to control staging of untracked files
Date: Tue, 18 Oct 2011 08:34:31 +0200
Message-ID: <CAKPyHN2g2aVTB_Q7ZmpjfdznmUmkf=aodDmFEWgq6_KCMQe62w@mail.gmail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
	<03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
	<20111017183430.GA2540@sandbox-rc>
	<CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
	<20111017192706.GB3168@sandbox-rc>
	<87r52bgrky.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 08:34:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG3G1-0005ih-AV
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 08:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab1JRGec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 02:34:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60566 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1JRGec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 02:34:32 -0400
Received: by vws1 with SMTP id 1so83929vws.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=submmjAG1+srCs4IEfE2+32ZgRrrdp+ZTUG59kbt0lg=;
        b=b2PMfFr6lVs/WrtGPSR4FeHh6LX3RwVhNypcKrFCwlHMCPqWgyEeC4NK5ET1qKIHlh
         3yd4gYvkP4f00VFTPVeq0c4m7zswnj5EjXLQ1m3aCTPT95WgZ98WTpaW37dK6n73YjmM
         NLhHegT8gpy4ZIBI5MLYfaY9Wyrvl2Ja/HPpc=
Received: by 10.52.92.212 with SMTP id co20mr910826vdb.119.1318919671286; Mon,
 17 Oct 2011 23:34:31 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Mon, 17 Oct 2011 23:34:31 -0700 (PDT)
In-Reply-To: <87r52bgrky.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183863>

On Tue, Oct 18, 2011 at 00:51, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>>Hi,
>>
>>On Mon, Oct 17, 2011 at 08:47:50PM +0200, Bert Wesarg wrote:
>>> On Mon, Oct 17, 2011 at 20:34, Heiko Voigt <hvoigt@hvoigt.net> wrot=
e:
>>> > Here I am wondering whether we have a similar mechanism in git gu=
i like
>>> > in core git that makes yes,true,1 equivalents (and similar with o=
ther
>>> > values) ?
>>>
>>> But it is not only yes,true,1 or no,false,0 its a tristate with the
>>> third state 'ask'. For booleans, there is such functionality in git
>>> gui. See is_config_true and is_config_false. Reusing these for this
>>> tristate wouldn't work. The current check here is indeed very stric=
t
>>> and should be loosen by at least ignoring the case, surrounding
>>> spaces, and allow also true/false. But also note, that this variabl=
e
>>> can be set via the Options menu, so you can't mistype it.
>>
>>Well if using git config you can ;-). I just wanted to ask whether we
>>may already have machinery which supports such tristate.
>>If we do not I think the current "strict" configuration is fine. In m=
ost
>>cases the user will use the gui itself to configure such behavior so
>>thats no big deal.
>>If someone needs that it can be added later on.
>>
>>Thanks, Heiko
>>
>
> This set of 3 patches looks fine. I was a bit dubious of the new
> phrasing for the ask condition but it is growing on me. I wonder it i=
t
> might be worth including the number of untracked files to be staged t=
oo
> eg: "Stage 15 untracked files?"
>
> =C2=A0 set reply [ask_popup [mc "Stage %d untracked files?" \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [llength $untracked_paths]]]

I thought about to list the untracked files in the dialog, but
couldn't find a good template dialog for this. But the number is
definitely worth I think.

>
> Loosening the check we can do using
> =C2=A0switch -glob -- [get_config gui.stageuntracked] {
> =C2=A0 =C2=A0[Nn]* { set reply 0}
> =C2=A0 =C2=A0[Yy]* { set reply 1}
> =C2=A0 =C2=A0default { ... }
> =C2=A0}

I think this is too loose ;-)

Bert

>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
