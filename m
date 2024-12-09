Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357C1B4250
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755617; cv=none; b=NKPQ9faRRZG/CAzpzRFo+0KtiltgLvBG9+DcykfsmnXL/KKhr+ll9QF6EqRo0wi8oCMCT3/NxZPLMKa5tjODrEtiS8tk7C9hNwqg52y+WhWZ52670D2uy+OO/dqMq0B+CgQd2Vfw0cw0sVWAdVWqsIhyzvJDN9AZw/O7XKZLjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755617; c=relaxed/simple;
	bh=/tCZ9U3XpyitWAKzBvbATri/pqmPOqc9iDVpSrYQk00=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=hccTvXiwjbG7xUaWWncncekhBnqAVCAznHsMz+w0i95+B0Y47KEZo0tUJiLKNLhqXyopfokYYZC4z1Z05H0GGPaChvgvl5iG7Y3KKSaCAZPrcMEIPDdfCH+1krAZWMycru9v0YohqAU2j2F4kgwCqCiNXURJOEs5odQRzixu1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=oHx71Ztw; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="oHx71Ztw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=kVLBjzBwJqm0Bj7aO2bq7370u18em6jUfb+vPnjGCys=;
 b=oHx71ZtwNRwUl22UjIhj8n4h2aC43m/1aclkT9XXyaKRdQaI5ErNFgKOuOUPdSAs+WLbErsXd5QH
   pdu5j6JnV/mRZAeo0KZygmEMuZxwXe6WzMCotqO7fCPfh54mstDcZ7/9I61qqnCq0qMXCVYaNFMi
   fgbUJqkDL2zfa/XY1ci8hkUaX53AiExtXV6pjAvvS8qzPpDF0sCBtpzVJEER9MWmfJAOLIuWp6qo
   YzBoWWnNRpmNnhBt9gASMbiD8NU/tGr50RAl5Zy/9fQeV18QhzAjUgqbCq30S97sWSTlH1mC9s96
   sjFSyODz9NSqHmdzDjP5dcgYdLAQeTJEcVPUOA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO800L1JEE36ZC0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 09 Dec 2024 14:46:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 09 Dec 2024 15:46:04 +0100
Message-id: <D6791Z2QPSUW.1LP269FO886XF@ferdinandy.com>
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
Cc: "Justin Tobler" <jltobler@gmail.com>, "Heba Waly" <heba.waly@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
To: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
 <D674P6875UXA.LXGHCJ9EFE0N@ferdinandy.com>
In-reply-to: <D674P6875UXA.LXGHCJ9EFE0N@ferdinandy.com>
Reporting-Meta:
 AAFpjjYI9s0LUKgwsInsZJ//YG8gN147zxAoXHgTcy3byYwZ3UKXnzJETwjct/0+
 S5p6BN0iV+vBfYSpLOvA9NKXB/wmpiqZ21Jp4k3RdW9GvLU+ag4/iqQaBj8IS7Vd
 La1JXwysJDLmmqzSwlblLCmHLkHkGFvjpnl+uf2G2Oh/8qsWQE01qEY/lEaqLRHj
 kxMwyKY6v0BVc+8NoInoPR6MQzzBie9qdn9u+cD72NU/lhT3eURb5H0CCBCYvThM
 okfh1bB9/kBjefZt0LgdLMrjNrTmuLz2FVrkmD6zUfmjzflSfNbBmnOefOCrvvNa
 a4H4eWjrPUHrCMWV5oVgvU2S/nY1f7uOnHnD2Vdbpvz2cMZoMdG1FSAREsAe1Fwh
 cIRU/Yf4Qf10clwQxBnSGpOrbnuc7MTlI31bzLSBsNpxEX+yKRHhzZR3jpLjcgv6
 88NYkE2WzTVM06HFab5s7MxtR9mSFJsxdXEZuhWgB6Ffj8euECwbNmM=


On Mon Dec 09, 2024 at 12:21, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> Thanks for taking a looking and the follow-up patches!
>
> On Sun Dec 08, 2024 at 09:08, Rub=C3=A9n Justo <rjusto@gmail.com> wrote:
>> On Thu, Dec 05, 2024 at 01:21:58PM +0100, Bence Ferdinandy wrote:
>>
>>> The advice message currently suggests using "git config advice..." to
>>> disable advice messages, but since
>>>=20
>>> 00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)
>>>=20
>>> we have the "set" subcommand for config. Since using the subcommand is
>>> more in-line with the modern interface, any advice should be promoting
>>> its usage. Change the disable advice message to use the subcommand
>>> instead.
>>
>> It's very consistent to keep our messages updated with respect to
>> changes in the user interface.  So this patch is a step in the right
>> direction.  Thanks for working on this.
>>
>>> Change all uses of "git config advice" in the tests to use the
>>> subcommand.
>>
>> Maybe this should be done in a separate patch.
>
> So I was a bit lazy here, since sed changed both the expected test output=
s and
> the usage, so that could certainly be split into two patches to be pruden=
t.
>
>>
>>>=20
>>> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>>> ---
>>>=20
>>> Notes:
>>>     For the tests I just indiscriminately ran:
>>>     sed -i "s/git config advice\./git config set advice./" t[0-9]*.sh
>>>    =20
>>>     v2: - fixed 3 hardcoded "git config advice" type messages
>>>         - made the motiviation more explicit
>>>=20
>>>  advice.c                        | 2 +-
>>>  commit.c                        | 2 +-
>>>  hook.c                          | 2 +-
>>>  object-name.c                   | 2 +-
>>>  t/t0018-advice.sh               | 2 +-
>>>  t/t3200-branch.sh               | 2 +-
>>>  t/t3404-rebase-interactive.sh   | 6 +++---
>>>  t/t3501-revert-cherry-pick.sh   | 2 +-
>>>  t/t3507-cherry-pick-conflict.sh | 6 +++---
>>>  t/t3510-cherry-pick-sequence.sh | 2 +-
>>>  t/t3511-cherry-pick-x.sh        | 2 +-
>>>  t/t3602-rm-sparse-checkout.sh   | 2 +-
>>>  t/t3700-add.sh                  | 6 +++---
>>>  t/t3705-add-sparse-checkout.sh  | 2 +-
>>>  t/t7002-mv-sparse-checkout.sh   | 4 ++--
>>>  t/t7004-tag.sh                  | 2 +-
>>>  t/t7201-co.sh                   | 4 ++--
>>>  t/t7400-submodule-basic.sh      | 2 +-
>>>  t/t7508-status.sh               | 2 +-
>>>  19 files changed, 27 insertions(+), 27 deletions(-)
>>>=20
>>> diff --git a/advice.c b/advice.c
>>> index 6b879d805c..f7a5130c2c 100644
>>> --- a/advice.c
>>> +++ b/advice.c
>>> @@ -93,7 +93,7 @@ static struct {
>>> =20
>>>  static const char turn_off_instructions[] =3D
>>>  N_("\n"
>>> -   "Disable this message with \"git config advice.%s false\"");
>>> +   "Disable this message with \"git config set advice.%s false\"");
>>
>> The main goal of this patch.  Good.
>>
>>> =20
>>>  static void vadvise(const char *advice, int display_instructions,
>>>  		    const char *key, va_list params)
>>> diff --git a/commit.c b/commit.c
>>> index cc03a93036..35ab9bead5 100644
>>> --- a/commit.c
>>> +++ b/commit.c
>>> @@ -276,7 +276,7 @@ static int read_graft_file(struct repository *r, co=
nst char *graft_file)
>>>  			 "to convert the grafts into replace refs.\n"
>>>  			 "\n"
>>>  			 "Turn this message off by running\n"
>>> -			 "\"git config advice.graftFileDeprecated false\""));
>>> +			 "\"git config set advice.graftFileDeprecated false\""));
>>
>> OK.
>>
>> However, instead of solidifying this message, perhaps we could take
>> advantage of `advise_if_enabled()` here.  That way, we simplify the
>> code a bit while we also automatically get the new help message, which
>> you are already adjusting in advice.c.
>>
>> More on this below.
>>
>>>  	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>>>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
>>>  		struct commit_graft *graft =3D read_graft_line(&buf);
>>> diff --git a/hook.c b/hook.c
>>> index a9320cb0ce..9ddbdee06d 100644
>>> --- a/hook.c
>>> +++ b/hook.c
>>> @@ -39,7 +39,7 @@ const char *find_hook(struct repository *r, const cha=
r *name)
>>>  				advise(_("The '%s' hook was ignored because "
>>>  					 "it's not set as executable.\n"
>>>  					 "You can disable this warning with "
>>> -					 "`git config advice.ignoredHook false`."),
>>> +					 "`git config set advice.ignoredHook false`."),
>>
>> This message is more of a warning than advice.  I don't think we want
>> to use the same approach here as above, because:
>>
>>     hint: The 'foo' hook was ignored because it's not set as executable.
>>     hint: Disable this message with [...]
>>
>> looks weird.
>>
>> So, your change is enough and right.  OK.
>>
>>>  				       path.buf);
>>>  			}
>>>  		}
>>> diff --git a/object-name.c b/object-name.c
>>> index c892fbe80a..0fa9008b76 100644
>>> --- a/object-name.c
>>> +++ b/object-name.c
>>> @@ -952,7 +952,7 @@ static int get_oid_basic(struct repository *r, cons=
t char *str, int len,
>>>  	"\n"
>>>  	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n=
"
>>>  	"examine these refs and maybe delete them. Turn this message off by\n=
"
>>> -	"running \"git config advice.objectNameWarning false\"");
>>> +	"running \"git config set advice.objectNameWarning false\"");
>>
>> Here, however, I think we should also switch to `advise_if_enabled()`.
>>
>> [...]
>>
>> The rest of the patch looks good.  I think it's desirable to separate
>> the changes in the advice messages from the uses of "git config set"
>> in the tests, as I commented at the beginning of this message.  But I
>> don't have a strong opinion on it.
>>
>> I'll reply to this message with the changes I've suggested about using
>> `advise_if_enabled()`.  If you agree with the changes, feel free to
>> use them as you wish.
>
> Imho my patch is a "no-brainer" in that it doesn't really change anything=
 about
> code or behaviour, while what you sent does, so I think the best way to g=
o with
> this would be to first just switch to `config set` with already existing =
stuff
> and then open up the question of changing them in a more meaningful way. =
In
> general of course it seems like a good idea to bring advice messages unde=
r one
> interface, but there's more in there that I don't think I could argue for=
 or
> against with any confidence.
>
> I'll send a v3 with the test usages changes split out.
>
> Thanks,
> Bence

I started to split the commit, but realized that I only updated "git config
advice\." to "git config set advice." in the tests. If I split the around f=
ive
instances of actually using "git config advice" in the code, then it starts=
 to
make a lot less sense for why it is only for "advice" and not for all the o=
ther
uses of "git config" in the tests. So I'm now inclined to think that I eith=
er
leave the patch as is, or simple just remove the parts that are not updatin=
g
expected test outcomes and leave updating usage of "git config" in tests fo=
r
a later as it would likely be a larger effort to clean up everything to use
explicit set/get. This cleanup would also only make sense if there are plan=
s to
deprecate the old implicit setting syntax at some point.

So should I remove the changes to usage in tests or just leave the patch as=
 is?

Best,
Bence

