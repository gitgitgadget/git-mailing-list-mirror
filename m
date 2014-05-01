From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 14:04:33 -0400
Message-ID: <53628CB1.8010302@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch> <536173F5.7010905@xiplink.com> <53617877b41a9_41a872f308ef@nysa.notmuch> <20140501094610.GB75770@vauxhall.crustytoothpaste.net> <5362664C.8040907@xiplink.com> <20140501175623.GY6227@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu May 01 20:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfvLB-0008JO-3n
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaEASEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2014 14:04:08 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:54776 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaEASEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:04:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 840AE1C016C;
	Thu,  1 May 2014 14:04:05 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BF0F51C05C6;
	Thu,  1 May 2014 14:04:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140501175623.GY6227@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247820>

On 14-05-01 01:56 PM, W. Trevor King wrote:
> On Thu, May 01, 2014 at 11:20:44AM -0400, Marc Branchaud wrote:
>> On 14-05-01 05:46 AM, brian m. carlson wrote:
>>>   git checkout maintenance-branch
>>>   # Update our maintenance branch to the latest from the main repo.
>>>   git pull --ff-only
>>>   git pull --no-ff developer-remote topic-branch
>>>   git push main-repo HEAD
>>
>> =E2=80=A6
>> What's more, it seems to me that the only real advantage "git pull" =
provides
>> here is a less typing compared to the non-pull equivalent:
>>
>>   git fetch main-repo
>>   git checkout main-repo/maintenance-branch
>>   git fetch developer-remote
>>   git merge --no-ff developer-remote/topic-branch
>>   git push main-repo HEAD
>=20
> You're missing Brian's fast-forward merge here.  It should be:
>=20
>   git checkout maintenance-branch
>   git fetch main-repo
>   git merge --ff-only main-repo/maintenance-branch
>   git fetch developer-remote
>   =E2=80=A6

I think you're mistaken -- I checked out "main-repo/maintenance-branch"
directly, so there's no need to fast-forward a local branch.

>> Sure, the non-pull approach makes use of Scary Branch Stuff (remotes
>> and namespaces and detached HEADs -- oh my!).
>=20
> No need for detached heads with Brian's local maintenance-branch.

Yes.  OTOH, no need to bother keeping a local maintenance-branch up to =
date
if you use a detached HEAD.

> If
> you're teaching and just need folks merging the remote's HEAD, you
> can avoid namespaces and remotes entirely:
>=20
>   git fetch git://example.net/main-repo.git
>   git merge --ff-only FETCH_HEAD
>=20
> although I doubt =E2=80=9Cthe remote's HEAD=E2=80=9D will be easier t=
o explain than
> the namespaced, remote-tracking branches it replaces.  It's certainly
> not worth the hassle of un-training FETCH_HEAD-merges later on ;).

Agreed.  I wouldn't advocate teaching people about FETCH_HEAD as if it =
were
something they should use regularly.

		M.
