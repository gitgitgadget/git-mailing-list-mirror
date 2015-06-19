From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 22:42:44 +0200
Organization: gmx
Message-ID: <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:43:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z637v-0005TS-HK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbbFSUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:43:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:53281 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667AbbFSUm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:42:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MZTP3-1ZOwUC4ALl-00LDvD; Fri, 19 Jun 2015 22:42:46
 +0200
In-Reply-To: <xmqq1th77829.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:WfHDSKs1u3TSkTvwgRtlgFmn5DQiuaZmc07Mrbav59C0mrLLd/S
 1hIjYSbz4NzxTsIInLEbWP87H1LGk15HUsbJmqYyEgDFGh/2UHJ6uUr0wjBIVNHBNARzC+L
 kk6bSfpn9/Qo+PQlIYgDI+A7/h4zE8R17TPGR4g9tbW/DHaeDZ4x9nxTijKK8WAdctlSnNK
 Zh9ZA4/xDJFiLhFHyFX6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u8Z4/KeYZ8Q=:a1OBDJh1RSLOZEsHbTbmrY
 B5k0kkI+OIr/LQ1EDTKYGA5fclOmCE78+/0rs1DK4s8pktFV/jRW+cmexPtUNlR5K1DrtevER
 OlXHlqVT4YKHgc9ZSxNrp+YIoNVQCUR7Qf0HRrr2Q8crdlqRO/KOVNC+2Ah28y2+u+3YIPSfk
 pDJWSWsSnwC33Ttkg4vQrC9XR5C4kp3Y3f5K+/NHPp83XvHFI6gsfkgwnLv3f7JDSxYhTXHeO
 3KIt6/VSDY45SBP9wtvncOKu0K0lKkexA8UrqscM+E+lp5VYe3BB27jhZuEQfG54l0EJR3haK
 lDhr/Vn3bb1FWbUt392ZP9hIsdG/pdsdnsevURXSJudNznvNJetWCi2fhspOfALcAWbhpynQn
 2Spvg6EL11n+E9Le3oHe9fWUr6/U5uZz5qfHmZ1YztGq1AA/ecXW4EWzCttVtSJpXzfrscRmM
 Zzs4lBjPTzMszjBQ074Q8i9fLQ9jOBlJPtbJsBf0+BcM4jjRzhDHNt2NvD23WMYCNnzpTdZiI
 g8onESqyhE581xUK9jLLD0ZU2fy9kgW/J9oTmfPGQZwimKCvMpSJMyZNXPyrrxUBpT4tZ6e4k
 gAgdAK4jjF7fpol1RQ+7z8mPiFvFkgk7HF++GBwq4IVJNfrmLqarZiEipIykBdXp1KmhoxBUx
 j9OigiEI7K6zZFmpKooIRDZ0NpAIa2p81gfLHXkgnxaFEpdOBdCb1zgOfX1L5oQCxjok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272201>

Hi Junio,

On 2015-06-19 22:32, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> This option avoids unpacking each and all objects, and just verifies the
>> connectivity.
> 
> That sounds like marketing ;-)
> 
> "Wow this does not unpack unnecessarily, wait, it needs to unpack
> and parse 3 out of 4 kinds of objects?"

Hah, you caught me there. I wanted to say "blob objects".

> Jokes aside, given that you should regularly repack your repository
> anyway, I do not think it is such a big downside that this mode
> misses a corrupt objects, and the 1 out of 4 kinds of objects,
> i.e. blobs, occupy major part of the repository storage, so this new
> mode probably makes sense.

It actually makes a ton of sense as a kind of light-weight check ;-) Try it, it is really much, much faster than a full fsck.

>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 922c346..2863a8a 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -431,4 +431,26 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
>>  	test_must_fail git -C missing fsck
>>  '
>>
>> +test_expect_success 'fsck --quick' '
>> +	rm -rf quick &&
>> +	git init quick &&
>> +	(
>> +		cd quick &&
>> +		touch empty &&
>> +		git add empty &&
>> +		test_commit empty &&
>> +		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
>> +		rm -f $empty &&
>> +		echo invalid >$empty &&
>> +		test_must_fail git fsck --strict &&
>> +		git fsck --strict --quick &&
>> +		tree=$(git rev-parse HEAD:) &&
>> +		suffix=${tree#??} &&
>> +		tree=.git/objects/${tree%$suffix}/$suffix &&
>> +		rm -f $tree &&
>> +		echo invalid >$tree &&
>> +		test_must_fail git fsck --strict --quick
>> +	)
>> +'
>> +
>>  test_done
> 
> I see a few impedance mismatch here.  For --quick, I would have
> expected that the addition would be in t/perf/, not here.
> 
> Also the fact that quickness comes by cheating on blobs is an
> implementation detail; in the future, perhaps somebody may come up
> with a way to do a quick fsck while making sure blob corruption is
> also detected.  The new test that expects "--quick" to ignore a
> corrupt blob forbids such a progress.
> 
> If the option name was "--ignore-corrupt-blob", then the above
> change is 100% justified, though.

The meaning of "quick" that I was thinking of was not the same as "fast", but more like "just a quick check". As in "quick & dirty" ;-)

The point is not to ignore corrupt blobs, by the way, it is to check the connectivity only, and save substantial amounts of time doing so.

Can you think of a name for the option that is as short as `--quick` but means the same as `--connectivity-only`?

Ciao,
Dscho
