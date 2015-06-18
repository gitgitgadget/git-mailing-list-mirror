From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t3404: demonstrate =?UTF-8?Q?CHERRY=5FPICK=5FHEAD?=
 =?UTF-8?Q?=20bug?=
Date: Thu, 18 Jun 2015 13:22:04 +0200
Organization: gmx
Message-ID: <c2b427850cc6f298bee017123639c4df@www.dscho.org>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
 <f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
 <xmqqtwu66xzg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xtg-0000lv-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbbFRLWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:22:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:63137 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbFRLWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:22:11 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ltqb7-1Yy1Ky3Nm1-0117kn; Thu, 18 Jun 2015 13:22:05
 +0200
In-Reply-To: <xmqqtwu66xzg.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:/ntC7RkSea4IKkFiIKaNNUBKmlaZdP8pv0965t3twsXCcouSfvd
 whceR/IwXBMNf8nHR1ZpQL4NdokWlARiLde8fS8Y0VxidNBe6QoPY+pGgQkS4SLRAymP/O7
 2gs4YGMgiUES2rt863Hc9t0jd770wp2brTSoF/jTxXi+rp+6zC3TFKg8MjOU/NiD2TQyfgd
 uW6UD7j3B5q7wYT/cgAfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:51kKFZQkKK8=:zAv0m/NW1CduiwuimccflK
 OUVbtcHYuA3BAlt4HMcZY5+e7pBQkfjk8oRUF9qfwXOLNcx9YETCHztG+ICGFW33cNWNLcRda
 e3D3xnYXKLhNF5b3LQABpeFUDiutFWFrHMXGRgmoyMi1TqHxtgPpO/NomzA76w7i4JTCk3x0d
 5v+tZk3lV+pZBnj43ZbjHvrn9xo1vROOxaodOvD9fqPPaZhl5cgmQSHdLeqzzCrr7elGnh3pZ
 Hcy6VvgJA7gEa1n+UBH/Lx55cNx/jwcPqjcZXqyHUD3Z+fyQ0LsQTVs3I40N/3ZL9NL3eVm8h
 /BQ1nTybN6qJE3FNeReWngIXQsLuzZSpibvCE+HEEviqQeFywo389r+ZARjclcBqbsMtypq0M
 sF26MXH03mbedwL6snK8ZcKCuVpCnDwlTwGv7B0jFj0BUrWmFXPMLwIz59SJbOoAQtag7laWb
 VVeN6NsGovTOBa3eaGSw4L5wGvtIkPVqz4Z1bDMzBlw1hCXXQcBvXJFsu8reIV57dzjuAbvpA
 Sj/SsKOrvpC/JVvMO54Iq5hyn7IvVQ1J0CAazt2obY7eaDT/6mYOTzxmF6rerV96+TtKN4KEg
 3W/IH4jOxadUhLF+nLjmHaQMJkXinHfEKtZYpjckm+5gAYhWAgt0xPkyb6CG/MeSmTwXFE/pM
 xyi8yy8TZKJBgUM8KCHPKF68PshXM57DnGvFBru1bfauAMLavX8UETufJgZdE6iMSBEg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271964>

Hi Junio,

On 2015-06-17 19:33, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
>> +	git checkout -b commit-to-skip &&
>> +	for double in X 3 1
>> +	do
>> +		seq 5 | sed "s/$double/&&/" >seq &&
>> +		git add seq &&
>> +		test_tick &&
>> +		git commit -m seq-$double
>> +	done &&
>> +	git tag seq-onto &&
>> +	git reset --hard HEAD~2 &&
>> +	git cherry-pick seq-onto &&
>> +	test_must_fail git rebase -i seq-onto &&
> 
> Shouldn't this explicitly specify what fake editor is to be used,
> instead of relying on whatever the last test happened to have used?
> 
> I thought this deserved to go to older maintenance track, but the
> fake editor that was used last are different between branches, so
> "rebase -i" fails for a wrong reason (i.e. cannot spawn the editor)
> when queued on say maint-2.2.

True. Thanks for pointing that out. Will be fixed in v2.

>> +	test -d .git/rebase-merge &&
>> +	git rebase --continue &&
>> +	git diff seq-onto &&
> 
> I am puzzled with this "diff"; what is this about?  Is it a remnant
> from an earlier debugging session, or is it making sure seq-onto is
> a valid tree-ish?

The idea is to verify that we end up with the same tree even if we exchanged the latest two patches. I can remove it if you want as it is not strictly necessary, but I would like to keep it just to make sure that we did not end up with an incomplete rebase.

Ciao,
Dscho
