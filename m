Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fUrPdCsw"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A0AA
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702421676; x=1703026476; i=l.s.r@web.de;
	bh=NVXq3IKw6JYGTqbtuZLyROKa+w1oXWKOwjvoUATyrEs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fUrPdCsw47z8QB0v7j4ahRRDlXlI9K1QwlGxIMMTHlMu93cQLs2V2+KCjvFtUDar
	 u3bY/5LE3KXNnXKWq86iutc4gQwQjJgINSLW3s4bd5P70Aj9QDLeyNEd6Ic5j1NMN
	 0r5+hj4gMJWPfMwKvOhZPQoXUjRHxawathvEiF6hDKIa0KQ7sscNDPZKi/0uSMah+
	 jvWQhPNJcU/oOFN30ew4PbADj5bLMVaICjS/unGssi5Xc5ATVKKVKJbQQMRasqIMz
	 YcWW36w//a1THYvHUCfvddSsPnQJHSZIrNWQ98YlgYysUjcjvu83YTzDnPzmsxdPJ
	 gj2qxGBbmQ1RzB4SuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xaR-1rIBtw3yjr-014exi; Tue, 12
 Dec 2023 23:54:35 +0100
Message-ID: <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
Date: Tue, 12 Dec 2023 23:54:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test breakage with zlib-ng
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231212200153.GB1127366@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pbba54Wkt5EacqiwJtc4Q0Xhi5GXGzy5KnztZQLLgjvOrLmR8hN
 LOoEDgVhVKp4ZFPbIbPzvNKepT+EFn+GQXipmn8m+3aAD1wCC1QKSt30h9udXGEa3ZJUDNH
 cH2GwaszITaRmGWhXviTiFll/xFAd6ZcylZE4C1KdAi5S2yTOcRf7vCVgFl793ir/XgynzS
 mSDEhCLVCjgTWjiE/Q89Q==
UI-OutboundReport: notjunk:1;M01:P0:yqHtluq3qhU=;FUvf+u08n1edVViCtB7uRG3jB8v
 7Hr1onUKiw+ihYoMiPHkzP9L8/UDbDu2qDneKzLPd2kVdEf4XLinYxslCMloI5ZndI+emD4Ap
 3i9QNgpmx0jnj7r/xdoiWMp2rpgxhi+GBio+WhKe1g3KLfFQe/Aexl5fP3swndSaxEDzENzZ+
 wl9d4DxJ8pfbNJZLsurzwbXrOPcu+W4GfMCPelb0G+rc3Y6YTArY+16SY4n7PDrgbV+J/6f+9
 ATX1RQhWrrb7vNht5TYei3+VeZIsGsvSVzJyQsHYjc/hB3NdEqgipjZe8yr1zyq1B6CqGbMeA
 A0HCFWFlvx/+1LPTj9THz/gmSD15BqjfhflsaueOzG5fuHPYxuldOhEtwNhIVC3krBrhPPCtV
 TBfgGp1Ro6mgD3gM1wKHbNYCibz99LWV2gyBRdpRTh61iXC3jxVLK7jxKOKdK58lMK8YI1XV+
 xamO9nmL6mQknRkI3+vSmYQsjIfi4ywJ6tP+Ejd9YWRCd+c0m6N2m0kPRHA8wSwOJhAYVDQK6
 ldp/QpRbEl4hgF5U/UGPm3br1zKXqzY1Szv1Q2TBM5YBF1Kh6eC0tT5B+7W65k9yFLSYdWi7W
 EU0uzEJDM4s7Y6KdtGhehZYvL32FFA+RL/3OsrdsIDwJZhkFUgJ1S2O/yBBLUv+HLJlWUPquF
 pUNVHI1UzL8ITszSdyjkDShREzIr3toGo0MDUN7bCGmxPinFNiFH9LWJfdUOd08jVeL9iUq7W
 uKobcMUKuT7B996o4YJdN5Pzo/DlRVsxANwirubw0+swDFOAPzJ6Hc3JyYjWJF5QRAUTMPYyI
 H3QTdyI84/4eHRWJ8aNhpSdjDlCgyeTaWxIHfuZVkecfdhyKC9e1sLtXuNwt6xlHyjdIJT28r
 Cf+3Nt4hwFzH1zZbv8ojyq4wlTdo4dg0+6YOvMxtnbxLHBykhNfB793MYCYaA7fBnWbrfboHv
 /Lr6lP1jCkNhapwzmrc/oEkU3FQ=

Am 12.12.23 um 21:01 schrieb Jeff King:
> On Tue, Dec 12, 2023 at 06:04:55PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Subject: [PATCH] t6300: avoid hard-coding object sizes
>>
>> f4ee22b526 (ref-filter: add tests for objectsize:disk, 2018-12-24)
>> hard-coded the expected object sizes.  Coincidentally the size of commi=
t
>> and tag is the same with zlib at the default compression level.
>>
>> 1f5f8f3e85 (t6300: abstract away SHA-1-specific constants, 2020-02-22)
>> encoded the sizes as a single value, which coincidentally also works
>> with sha256.
>>
>> Different compression libraries like zlib-ng may arrive at different
>> values.  Get them from the file system instead of hard-coding them to
>> make switching the compression library (or changing the compression
>> level) easier.
>
> Yeah, this is definitely the right solution here. I'm surprised the
> hard-coded values didn't cause problems before now. ;)
>
> The patch looks good to me, but a few small comments:
>
>> +test_object_file_size () {
>> +	oid=3D$(git rev-parse "$1")
>> +	path=3D".git/objects/$(test_oid_to_path $oid)"
>> +	test_file_size "$path"
>> +}
>
> Here we're assuming the objects are loose. I think that's probably OK
> (and certainly the test will notice if that changes).
>
> We're covering the formatting code paths along with the underlying
> implementation that fills in object_info->disk_sizep for loose objects.
> Which I think is plenty for this particular script, which is about
> for-each-ref.
>
> It would be nice to have coverage of the packed_object_info() code path,
> though. Back when it was added in a4ac106178 (cat-file: add
> %(objectsize:disk) format atom, 2013-07-10), I cowardly punted on this,
> writing:
>
>   This patch does not include any tests, as the exact numbers
>   returned are volatile and subject to zlib and packing
>   decisions. We cannot even reliably guarantee that the
>   on-disk size is smaller than the object content (though in
>   general this should be the case for non-trivial objects).
>
> I don't think it's that big a deal, but I guess we could do something
> like:
>
>   prev=3D
>   git show-index <$pack_idx |
>   sort -n |
>   grep -A1 $oid |
>   while read ofs oid csum
>   do
>     test -n "$prev" && echo "$((ofs - prev))"
>     prev=3D$ofs
>   done
>
> It feels a little redundant with what Git is doing under the hood, but
> at least is exercising the code (and we're using the idx directly, so
> we're confirming that the revindex is right).

A generic object size function based on both methods could live in the
test lib and be used for e.g. cat-file tests as well.  Getting such a
function polished and library-worthy is probably more work than I
naively imagine, however -- due to our shunning of pipes alone.

> Anyway, that is all way beyond the scope of your patch, but I wonder if
> it's worth doing on top.
>
>> @@ -129,7 +129,7 @@ test_atom head push:strip=3D1 remotes/myfork/main
>>  test_atom head push:strip=3D-1 main
>>  test_atom head objecttype commit
>>  test_atom head objectsize $((131 + hexlen))
>> -test_atom head objectsize:disk $disklen
>> +test_atom head objectsize:disk $(test_object_file_size refs/heads/main=
)
>
> These test_object_file_size calls are happening outside of any
> test_expect_* block, so we'd miss failing exit codes (and also the
> helper is not &&-chained), and any stderr would leak to the output.
> That's probably OK in practice, though (if something goes wrong then the
> expected value output will be bogus and the test itself will fail).

Right.  We could also set variables during setup, though, to put
readers' minds at rest.

Ren=C3=A9
