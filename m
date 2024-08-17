Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E11854
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723918430; cv=none; b=EfLrhrWCJ3stVYW4kht676atB6sTvuNR+44Ktgv2e9J1cD2Fs1SxSYMh3hfzCRQHHOZfaeOmbxrP+EkJygFEUcNjPY3Ru30tHsqA/6JNOEPUnAxWgeptbS7qlMsjcRpY37frPlB25EB9f4g5duoXarAePluxhwmtjzzjvRFdJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723918430; c=relaxed/simple;
	bh=MS+CrblHJCjA+WPdzkjsNirXdstyqZO0GzvjBMkpxOQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DvmgGchdPuwdEFfEHpq0NJtOjQYmppGz30WXAJh/DFruVUn2FMuBk+Z8YFYhyVi+5Wa7TLFqilHpiAQgjlwOHf/fw+TUhNmpgDxOcxsLrK/vENI8J0k5DgUB749OB7lTXCIxQ2+Rjmx27qH+uOnkEZvQJzb/ZUFx97B9eftxNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MnGDhv/J; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MnGDhv/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723918421; bh=MS+CrblHJCjA+WPdzkjsNirXdstyqZO0GzvjBMkpxOQ=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=MnGDhv/JGMUHbG7f9aY6zEP1dUirlX7O9YFiStF+PZLAxO7DmaEjMg7EBvxTsB4mkCYc6I09e0IHWncnrIWT3h+yyjtuILqZutCFIH2c0xZtQy2Chcix8IF6vZfxAFljQLh7WZHJo/JxIMjrqLnMFUaCufkp8H7kAY87lFRuEcvYd4QSNQ9xiTmSPKcjS9zvmcEGZb2wbZaIZNo1+X24e48KK7r66SoHe1Arp9VxD0mHMWVWPsN7vwF+uUY3cEAr7Bagv63GRJKoIbJRELgkAIoIhypabd8nV1V1kvMzjAFF6d2KVUmwAhGF7wmqFc2D2q0AEThX1BjvqXSi6NE9Yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723918421; bh=llRlEC42XleTB+LTpRJMMRrNeESsCNqSngglr8YeJia=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=oOSQVS5HEUDrxpxa4qU2uIou1kHpwniWxWoK2MFM/Vm4v12FriXupf7FMiHFhA968WX/1l6so8SIHoXkduxA4OCrea18Hv6d2v3lVFvLT56fu/PGkzYnlGxHSb4QQ2hqWUp02kG+rW2CsdJOq+Pu3tiTGWRK0sBDbEWHvPyIe25K/rdxwZe8xJKSE/jnElaftL8ey7ecs728Wku2RCYlnadt00eavhPmlyJVpwpCVgiCKwmKRQBxwtBCYnvahUK7xlWsvPQXbaH/+F+Txf5yJzcBIdUz8ygURvtfvmjVUdoBR+4KBm8xBWY5oU9JXBQGBA8/YGZ6l52UEtFw0wRLWA==
X-YMail-OSG: j1NK70wVM1kCshIipWYL3acyJVO5fRvPxKJwyAJbzR74EJ94Ld_9JJnm6lonae3
 4SbZ0MFGO6P1CzOOhDFAnlDPSsBchfoQi8MYV1_iCkUogjG6wWX9HLS4rlrlSwnFhEWIGXYnyD.L
 uwzoK77j_SAXa9FSTf6mG4f3r7J.7cQdrPn4KNLnWXHIEm65bj6xIngW8GhdVvAwArwVhU8S_jCb
 ItOrNQSz_YAn_C85IA0Qs7eVq.fQHn5hD9vSAs3HuZuMGMpkIGOiF4kTNSNKuTG4S8bbj8yyJoX4
 1Z4wI.1GUUDrsrWqrk_QZgykNYMqyyFIPNJIKHIDdSzbKEuoQ9wuaPsYx8pqCvWGuN3eoQpC65fy
 Vp4m8XbiJ0yCWspn9trHq.2KAIvAmehdM261XvQWEzKi4OUKPAxoZDh8C0cvUTpI1U7pnRSGlfEV
 zELKEdpI2WgZji_4TkUxgI_.oLfueBz77gHbXWWDSZtV3TErh9HPsWMBLDj6CYlGk.7HvD49xXHw
 BByRxqJ46dkIpDZCokgH.sXKBSRdCYclPPuLUJ0inlNXMHl_oZlgFfpgMlsoDsVFQ0PmLGgDEzRP
 46t4w2c24n9NwG0UqxDtXejexVhzOBH0aPeIYXk12Kd02jlbWgqTiOZ1sCG550eG5avOO1eOhiFU
 9mz2Tg8SpyKhE5Z49eO9S_rpKigWcPDSKouNba1isjI_kbUR_U7WvoFWvbktTgkNL6hKnTPynRa2
 Oth7.Yyb2AT_vXzh7MuRo5H9yGrftFqzemf80QSGF2lBdjPp9USQANxxJq9i.2kHezOxRTn10LqX
 9LoGXfjgiJvoQ2pqx9zeWVnnOSVfmczPh4D1VZtLPJFqlqNsDMq_g_AgLyfUNQYcs2aMfB0t9OYZ
 Ywnt0tJcbv16fcPwpviPKRc9lNohX8JTuTluFki8nRcc8KZPbqewNFf3ZzqNUct7WxeVM4nSGsaF
 W2.JFs884hUDRk_vndrE_XLp68Ho7N.stkOGOCN8GEY.zgPMWsHL5ESEpQA7hXN3QekmTqH_gxJ_
 EmAyZN9_2_DLxG8JuzvPW8d7TLERFkQC07An.daSSICzkQ.oKo1XJGNUivfgU6EWm6_m5oAxJowB
 V.yNvB7etOUQeJt1_lda04pbACpZWrK0KjohBnQgcsSpujvT_YHSLd0vhJGLI0im4npc8PKImX.T
 JRVyYsbf7qoouC6HwXoIAkXe11dX12VZbBZ_Ax0sr3oPPq47LHzyJwlfJ.SrkaPHbInx9WGZQBi.
 fcWcTtreISMja4WLNY8axoC.9eDjmqHnFnUSqUH7FYP5e8fsWk9MvqR32c_ycVDB_IOYSlMXfLIY
 Pjdh1hIIVHX5TFp6yzjBAy_OGkkq1bXdkNoorwS3RBO19cW1dXDYfeVGg8R11ZdubdsCQIhwiauE
 X24L8UYAS7sl0emjQ2KCeEPZ7zZWENVzCY2ubcuT.v8bZV0b52twC9t2lnR1TzWSYTaJLnXNW41J
 vtowWK9_92cb0zGi1Evixz6SaBF0p8ZDYX72Kew0nUzY0F5Ph3Poz3_4qNeF151A9Lwby3w6mfZN
 9bzFfLYROFbwGKNdWkmPB8hLUekixyqEnmkqZsGQ9z8RlgJzHjqasIXrckMq45UZCIILgeND2.N5
 _29Zz8aaeykkl6Xv4gGlGhVaCkfYyx9A2CNjmo9nIVQIJoxu4C099.pnh1omeYfdpvJfMN5nFNc.
 Uhu.d9wDxJe8sJO5ZvNqKGMYJusT7b.e87tsE901YsnpFciiOwpbZVYRZvIQD0fpbgdCCSvH.MvP
 CAqRCviq0OmBD1dgmG6YppxQT4xfiFosBLXwZIJQTq3H_YkgTSWbq70uI8FfczyaFrOKNfWCANor
 Oi6nXEbT23Jf1.L9O9eDCA7BWKf6757LXeg1W9t259xQcSa5w6eLPCXiYJBUxX5f.Eh1mxPfigq1
 zIIHc1sVTzvXBDgsm1DtPAhLyPr4RJrLLuniOzeNCMLaR9qRe2GDo9AVZFQjArsXa0xmc6KUjuFj
 FglJx2SkkOl6I7n407dYr5Ju9LTVvE1Z91QmRSQzsjoh72qGhjgVnlY6IpPLkHtyIlQOakoX4vMw
 StBwvcRqkdZJf6Xc0MvRVcCCZ4TK56kpo8oyCDhVu9HdAoZNjom49caTspjgsrDpdYM_L6RkuA.y
 30rNhmfIPDnAA4RAYFPZkXW3XHyiPjiNrsgBOaWuMJKUqqLiMdnR5beT02Z4bX9PD2rJNwYvS.71
 KkilAyqCEmcczlOu7BdpjN1rpOHEG7fsTqDI-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 63862a03-1782-4bcf-817d-ee6c58a52787
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sat, 17 Aug 2024 18:13:41 +0000
Date: Sat, 17 Aug 2024 18:02:35 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>
Message-ID: <301312741.4747142.1723917755269@mail.yahoo.com>
In-Reply-To: <xmqqcym7i05l.fsf@gitster.g>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com> <3a41ad889cc33a1fc0414b8f14af6438b49c88ee.1723886761.git.gitgitgadget@gmail.com> <CAPig+cQVHVoDFD484dxu2gOuvzVHj9-78pyTnCo2-uy6=N5P-g@mail.gmail.com> <12028161.4698975.1723889226498@mail.yahoo.com> <xmqqcym7i05l.fsf@gitster.g>
Subject: Re: [PATCH v3 5/8] git-prompt: add some missing quotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Saturday, August 17, 2024 at 07:28:44 PM GMT+3, Junio C Hamano <gitster=
@pobox.com> wrote:
> avih <avihpit@yahoo.com> writes:
>> I was trying to wait few days for more comments on v2 (perhaps
>> like yours), but I noticed that v2 was already was just integrated
>> into "seen", so I posted v3 to address the existing comments on v2.
>
> Please consider that it is just like being on the list and nothing
> else to be in "seen".=C2=A0 It merely is another place some patches I've
> "seen" are published, to help those of you who find "git fetch &&
> git log -pW origin/master..origin/topic" a more convenient way to
> review the changes.=C2=A0 This is outlined in the note I send out
> occasionally.
>
>=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/git/xmqqmslewwpo.fsf@gits=
ter.g/

Thanks for the time and info. That's a useful intro, and I now do
see it says this:

=C2=A0 until a topic is merged to "next", updates to it is expected
=C2=A0 by replacing the patch(es) in the topic with an improved version

> If you think that v2 needs a few more days' exposure to receive more
> feedback from reviewers, and that v3 might be incomplete before
> waiting for their feedback, just saying so as a response to the
> "What's cooking" message is a very effective way to make sure I'll
> wait for an updated iteration.=C2=A0 Such a comment on individual topics
> is *not* limited to the author of the topic, e.g.
>
>=C2=A0=C2=A0 https://lore.kernel.org/git/owlyil264yew.fsf@fine.c.googlers.=
com/
>
> is an example ...

Thanks. I replied few times that requested changes will be included
in v3, so I thought it's apparent that v3 is sill to come, but in
retrospect, when you replied to [PATCH v2 0/8]:

> I've read the series and they looked all sensible.=C2=A0 Will queue but
> I'd appreciate a second set of eyes before marking it for 'next'.

Then I should have replied with something along those lines:

=C2=A0 Please wait for v3 with requested non-critical changes (typos in
=C2=A0 comment and commit message) before moving it to "next", if at all.

or even sending the same message once I noticed it was merged into
"seen", instead of posting v3 out of "panic" that it boarded the
train without all the requested changes applied, yes?

If yes, then here's heads-up that there's still another non-critical
requested change to arrive in v4 (commit message wording), which I'll
send in few days, to allow for further comments to arrive.

Because resending the whole series (is that "reroll"?) for every
minor typo or wording change feels noisy and inappropriate to me.

Thanks again for the time and info.

avih
