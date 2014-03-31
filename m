From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Mon, 31 Mar 2014 21:31:39 +0200
Message-ID: <5339C29B.5030301@web.de>
References: <20140328030556.GD25485@odin.tremily.us> <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us> <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com> <20140328035255.GF25485@odin.tremily.us> <20140328035827.GG25485@odin.tremily.us> <5335AA0E.7000001@web.de> <20140328171059.GJ25485@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhwE-0007nY-El
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbaCaTcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2014 15:32:00 -0400
Received: from mout.web.de ([212.227.17.12]:56739 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaCaTb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:31:58 -0400
Received: from [192.168.178.41] ([79.193.64.198]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MKr7w-1WUhvo4AWu-0002AL; Mon, 31 Mar 2014 21:31:41
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140328171059.GJ25485@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:LDumr6fLMKwC6zTolqQ+EPn7Dfb85x4nEDMLwQeUU1ZHddDyVov
 CP4AuByg2dif6kxGnxRkXR0zSbOsUdVPQaLYXLPLxPWBn7oogPMNZT1gsPPbHtMgyI4IHkQ
 /skeS0JcIoJwLs9MjbtI2vfxsvC4oepl+54n+wAQCAS1j0ScQcNOZGRSucZEmEf8w4lS5Hf
 wXNBWhbme4f9NsfnmQOQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245516>

Am 28.03.2014 18:10, schrieb W. Trevor King:
> On Fri, Mar 28, 2014 at 05:57:50PM +0100, Jens Lehmann wrote:
>> Am 28.03.2014 04:58, schrieb W. Trevor King:
>>> On Thu, Mar 27, 2014 at 08:52:55PM -0700, W. Trevor King wrote:
>>>> No the remote branch is in the upstream subproject.  I suppose I m=
eant
>>>> =E2=80=9Cthe submodule's remote-tracking branch following the upst=
ream
>>>> subproject's HEAD which we just fetched so it's fairly current=E2=80=
=9D ;).
>>>
>>> Hmm, maybe we should change the existing =E2=80=9Cupstream submodul=
e=E2=80=9D to
>>> =E2=80=9Cupstream subproject=E2=80=9D for consistency?
>>
>> For me it's still an "upstream submodule" ...
>=20
> We have a few existing =E2=80=9C[upstream] subproject=E2=80=9D refere=
nces though.  I
> prefer subproject, because the submodule's upstream repository is
> likely a bare repo and not a submodule itself.  It's also possible
> (likely?) that the upstream repository is a stand-alone project, and
> not designed to always be a submodule.  However, =E2=80=9Cupstream su=
bmodule=E2=80=9D
> and =E2=80=9Csubmodule's upstream=E2=80=9D are both clear enough, and=
 if they're the
> consensus phrasing, I'd rather standardize on them than jump back and
> forth between phrasings in the docs.  I can write up a patch that
> shifts us to consistently use one form, once we decide what that
> should be (although I'm happy to let someone else write the patch too
> ;).

Apart from the RelNotes there are only seven places in the
Documentation directory where the term "subproject" is used:

- Two in git-submodule.txt (which are those you recently added in
  the series that introduced the regression and would be gone if
  we revert that)

- One in git-write-tree.txt (but as I understand it the --prefix
  option can be used to record tree objects for other tools too,
  so the more generic term subproject looks OK to me there)

- Four occurrences in user-manual.txt describing the diff format
  for submodules (which I assume will always stay "[+-]Subproject"
  for backwards compatibility reasons)

If we do not revert your series I'll be happy to write up a patch
replacing the two usages of subproject in git-submodule.txt ;-)
