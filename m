From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v2 05/21] t6030: generalize test to not rely on current
 implementation
Date: Sun, 10 Apr 2016 21:37:38 +0200
Message-ID: <570AAB82.4060204@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
 <1460294354-7031-6-git-send-email-s-beyer@gmx.net> <570A596F.9080200@web.de>
 <xmqqy48ls29z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apLBg-0002CI-VC
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 21:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbcDJTiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2016 15:38:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:54280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbcDJTh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 15:37:58 -0400
Received: from [192.168.178.43] ([92.76.224.62]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LwW8p-1brrsC3PNX-018N5u; Sun, 10 Apr 2016 21:37:39
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <xmqqy48ls29z.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:S1XIOvJLbyjpDqqE12Vntcde9JYoS77MjipMepu4hQkUXCpA7cN
 dQiBvvsr541U0AO4XGV1VNh4H2TAUZKjTwUgfRnq/F5ihxFXj1ZFwi4NSUTaTLym7o6Giqj
 +MdoA0JPC2qwjbljpcmM+esMQyIquwnfrmHiXBZSACHzSuv9ZVnY3OJK1GyaOTVamWE2/ee
 FDC6tcAbxCAG81rNA3uEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vv1dTlsER2I=:kEaSnM/q5R79AqdkyhhbbC
 DZSinQ3JuXyfZYR1+ufMgsuuBn0H1IPa5B55OiJQQEVbjZqkfg2aL+iN7Uk9d/oiTlQZ9FLW/
 bfP2nWQYTJytPWDSO9Ni/mJ9PcXSr2lHjkSULS7Cb9KuAKRKsKNw0t7t9O85oTkOc4Aar9K3u
 w5cD903YOaIFKo8+zb7d//x0RTi3UiLXMFJWlRpLzDjTf6rdZ+/ufRwURo3uwuSMfk1iZmlwi
 wXK+ZHFjhOcoVsUIULUN/al2f83aiL42wShVnw1OGiiDTvfQlAw0oA39tKO5/tICqmpAg8Y0I
 oFJQIom2ajPFctQQ0Xje6C6O3MIiMdFOXogt5ZNN2S1ZkVh0V3S6Tv5vuUSxuw+50cbDehuVG
 AQA4kDxdajyUAPhPsJp6OLHnuq2RDULNegHksuA2wJnFIjFNeGt6kpyKyWQlJYt5lvd8omLil
 zeNgJogHJjVatTnaFe5106Il6C1cMdAeehKgbHWhoZughggyEyG8ihcgrkBQ1qSAv0l5nWjtT
 lTWoTgdB3T/m7DnVRMqPsi99PrMNPtl5uFyUHD4Sv2Q+EsJtP/qS0NU3LLL3gZB/70WJTTaB1
 F2YinTYTrBWvcKtOgQoIVWtFEnGKozHs398R9ODs0Gl42E9l8ZuKuXwdeXbjZTICvrHOa6sLb
 cycgvcezYrg4ZNrfubjASfBrgrYMxaDgsdHdgWOd5/dgOQYEv9RXphgrSauGbUkH6uZ6xvJLl
 ntDj7wS97JEZ9qbNkwSlJzn48Sv5SBMuF4he1aNTuEIeswVFlWz8FkpoSWcnORvizbOy0Q+6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291188>

On 04/10/2016 09:16 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Portabily:
>> Since yesterday/yesterweek the usage of hard-coded
>> #!/bin/sh had shown to be problematic
>=20
> That is not a new revelation, though ;-) It is just that these are
> problematic to those on minority platforms, and by definition they
> are noticed only when a very few people on minority platforms
> happened to have run tests.
>=20
> Thanks for keeping an eye on patches in flight to prevent new
> instances of this issue from getting added.

Although it's not getting added but only re-indented ;)
[I was not sure if this is a good idea at all to include a re-indent as
a while-at-it in a commit. Maybe it was a good idea so that I am now
obliged to "fix" it ;)]

Cheers,
Stephan
