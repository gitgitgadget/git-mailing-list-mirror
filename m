From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 20:59:16 -0500
Message-ID: <AANLkTikvbZwt0=Om98WZzPGCC71mLpXAz=N18x4ZQA2p@mail.gmail.com>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
	<4CEE2060.4020507@drmicha.warpmail.net>
	<AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
	<20101126214325.GC23462@burratino>
	<7vvd3jptch.fsf@alter.siamese.dyndns.org>
	<AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMA4b-0007rz-Mj
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0K0B7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 20:59:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63869 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab0K0B7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 20:59:18 -0500
Received: by wwa36 with SMTP id 36so2691341wwa.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 17:59:17 -0800 (PST)
Received: by 10.227.174.206 with SMTP id u14mr3131775wbz.40.1290823156399;
 Fri, 26 Nov 2010 17:59:16 -0800 (PST)
Received: by 10.227.154.10 with HTTP; Fri, 26 Nov 2010 17:59:16 -0800 (PST)
In-Reply-To: <AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162295>

On Fri, Nov 26, 2010 at 8:58 PM, Cory Fields
<FOSS@atlastechnologiesinc.com> wrote:
> On Fri, Nov 26, 2010 at 6:18 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> =C2=A0Real history
>>> =C2=A0------------
>>> =C2=A04' --- 5 --- 6
>>>
>>> =C2=A01 --- 2 --- 3 --- 4
>>>
>>> =C2=A0Fake history
>>> =C2=A0------------
>>> =C2=A01 --- 2 --- 3 --- 4 --- 5 --- 6
>>>
>>> =C2=A0Replacement ref
>>> =C2=A0---------------
>>> =C2=A04' --> 4
>>>
>>> This way, a person a person can fetch either piece of real history
>>> without trouble, and if they fetch the replacement ref, too, the
>>> history is pasted together.
>>>
>>> It is not possible in git to push a commit without its ancestors;
>>> replacement refs do not change that.
>>
>> True, but I suspect the above picture pretty much satisfies Cory's i=
nitial
>> wish, no? =C2=A0You can fetch recent 4'--5---6 history as if 4' were=
 the root
>> commit, and if you fetched replacement that tells us to pretend that=
 4'
>> has 3 as its parent (and the history leading to 3), you will get a d=
eeper
>> history.
>>
>
> Yes, both of these can be accomplished. I've managed to get that part
> working, where a
> default clone pulls in half history, and fetching refs/replace gives
> you the rest. The only
> problem is that it requires a filter-branch before pushing. Otherwise=
,
> 4 gets pushed rather
> than 4', meaning that clones will require all the objects. So it
> works, but I'll have to spend
> quite a while making it 'perfect' so that I only have to rewrite hist=
ory once.
>
> A shallow clone does not fit for us, because we want the default clon=
e
> to only pull half.
> Having a public 1gb repository that will be cloned quite often is
> bound to make our host
> unhappy, so we're doing everything we can to get the size down.
>
> Also, maybe I haven't made this clear... the "real" commit IDs need t=
o
> match the "fake"
> ones in order to prevent confusion. I think that's the part that make=
s
> this so difficult.
> Otherwise, something like this [1] would work just fine (probably
> exactly what Junio was
> suggesting)
>
> Any other suggestions? Or do I just have to face the fact that I'm
> going to have to break
> hashes?
>
> [1] http://progit.org/2010/03/17/replace.html
>
> Cory
>

Sorry for the stupid wrapping.. gmail and I are not getting along in
this thread!

Cory
