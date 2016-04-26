From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 17:09:25 -0400
Message-ID: <571FD905.6010705@xiplink.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
 <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
 <571F6FB5.2000305@xiplink.com>
 <CACBZZX6CRBQ5qOBdwamqJMz+_QU-cmVfA7iLTyjOCYentjx-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:09:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avAEf-0005wE-Um
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 23:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbcDZVJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 17:09:28 -0400
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:60083 "EHLO
	smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753198AbcDZVJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 17:09:27 -0400
Received: from smtp18.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp18.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 6D929280551;
	Tue, 26 Apr 2016 17:09:26 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 32E2B28055E;
	Tue, 26 Apr 2016 17:09:26 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [192.168.222.13] ([UNAVAILABLE]. [96.127.235.50])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Tue, 26 Apr 2016 17:09:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CACBZZX6CRBQ5qOBdwamqJMz+_QU-cmVfA7iLTyjOCYentjx-mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292682>

On 2016-04-26 12:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> Basically you can look at patches to a project on a spectrum of:
>
>   1. You hacked something up locally
>   2. It's in someone's *.git repo as a POC
>   3. It's a third-party patch series used by a bunch of people
>   4. In an official release but documented as experimental
>   5. In an official release as a first-rate feature
>
> Something like an experimental.WHATEVER=3Dbool flag provides #4.

But the git project already does #4 without needing a special=20
configuration tree.  In fact, you ignored the git project's "pu" branch=
=20
entirely.  Once a feature gets onto the "next" branch, it's already muc=
h=20
less experimental.  If it needs to put the word "experimental" in its=20
config settings, then maybe shouldn't leave the "pu" branch in the firs=
t=20
place.

> I think aside from this feature just leaving these things undocumente=
d
> really provides the worst of both worlds.

Yes, I apologize.  I did not mean that things should remain=20
undocumented, only that if you're afraid of users harming themselves=20
then you're better off not documenting settings than labelling them as=20
experimental.

> Now you have some feature that's undocumented *because* you're not
> sure about it, but you can't ever be sure about it unless people
> actually use it, and if it's not documented at all effectively it's a=
s
> visible as some third-party patch series. I.e. only people really
> involved in the project will ever use it.

Slapping "experimental" on the configuration only serves to muddy the=20
waters.  Either the feature is good enough to be tried by normal users,=
=20
or it isn't.  If it isn't ready for normal users, let it cook in pu (or=
=20
next) for a while longer.

Git has got on just fine without having some special designation for=20
not-ready-for-prime-time features, mostly because the development=20
process lends itself naturally to gradually exposing things as they=20
mature: topics move from the list to pu to next to master.  (The string=
=20
"experiment" only appears 16 times in all the release notes, which I=20
think is something the git project can be proud of.)

To me, designating part of the config tree as "experimental" enables=20
sloppier practices, where a feature can be released with a bit less=20
effort than might otherwise be acceptable, because it's clearly marked=20
as experimental, and so anyone trying it out surely has the requisite=20
bulletproof footwear.  (I don't mean to imply that you or any other git=
=20
contributor might slack off on any work you do for the project. It's=20
more that the ability to easily designate something as experimental=20
lowers the bar a bit, and makes it more tempting to release=20
not-quite-ready features.)

=46ar better to instead work on the feature until it's as ready as can =
be,=20
and release it properly.

In this particular case, for example, I think your proposed approach is=
=20
perfectly fine and does not need to be designated as "experimental" in=20
any way.  With a reasonable "hooks.something" config variable to turn o=
n=20
directory support, what you've described sounds like a great feature.=20
Sure, it may have bugs, it may have unintended consequences, it may not=
=20
fulfill some odd corner cases.  But that's true for almost everything.=20
As with every other git feature, it'll be developed to the best of the=20
project's abilities and released.  Future patches are welcome.

		M.
