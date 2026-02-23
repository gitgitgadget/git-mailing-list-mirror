Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37682368285
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874212; cv=none; b=il+uWXSNGFv+G1ulR/j3gUq/V/2GkjydUqgRNbyUiW+nB3XsgfF0Zu/fjjGmFu9xhCBjOuTFkgq8kcz7qkNfpjNK+PWgMQBao/lnOI+11/e5LXYSSO+Qh0JZq3e9EuG/1cV5Yyq6tKAWni6QE7EmmUzt9zo4l5X0Exr1vDyhsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874212; c=relaxed/simple;
	bh=OeJN6oXQLDxO3pjXzpK2mOAvDvPneATyFX06RwgP5NI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=W3ZXZd6bHvgC6Brmf+LBzJMfyF/CxySCyabwvWcNnLv+aLSIgpP6o3sMPckn15/gT1XhqZzNUDXmCpfTiZVH2kCaeHTXbzyro+jxQ60n5vTGy/rH3PAykNTmJTCD2W0rb8GgrU5OI7neFybNr39NhyjlSqFpvVUcY48sOw42nYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=A/ky5xqe; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A/ky5xqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771874210; bh=OeJN6oXQLDxO3pjXzpK2mOAvDvPneATyFX06RwgP5NI=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=A/ky5xqevzA+FEm4x0n8ikm7mKDPTYDh746hKcBucgn+nJWrfW4X5m9koPhcSOYSMOdcNZFdpsB7tClMbae58vxnVe7cmQo7ruwNFk0bhpf7cJzTR84n3X92nfBluENkXKIhi6I41XE5gppIneJTnpgrEa2P0LcAsiagUsIkS7oKLZABAJipsFioGZKuf1WkDdGDPPbTd74Ehok5FQg89o0x3OWOUYE5whu2OSyU4iFkMRJjgs8Delh3QWzF0jPk59bZXUSOTyzv1EiTMAjuo6zOGUtsIYUYthuCMQjtilbyKVtHurMS6kOisqz20t+lJNjrv7Pqe7Yu8c0VNRABEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771874210; bh=PiAq/STf9783rGrc/SZOFJocGAIwrOVlwUZDyeQ2q5y=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=HNcKHeglaWKSCgED2ea6VJwCKsFUJuxRCoPDfg/5ueZft1oVWR6zFjQQl1Ys3lG3gSL+u2/OZJzDM3bLNNbhdC1Jk1aLcTY+uBzamzMmi7IasHxhFFMAFZg0E9qvMaqcrTfVgwC/oBw4/WRd2ou0LdcZ5HMTqt/mmE+9lrWf5UJmPqtaN+z+4Ew8KTPVtF2aAYg0Jit8aAndyfKM7I91/3eW9KdpM+lDYRRI0BedVTdyezrIIPaM2P5wrtK6suk3gvKOylSP99H5VTN6yrJBJO5PL1tqCe6invtqndJbZ+sM0eX1QcjD1ndZuSc1ggkLwFQLFvzyawr9U8jDK7ofBw==
X-YMail-OSG: uSnfBNAVM1l1nWzoq70m_hCHAQJx5lJ3bXAXHfAuKpyxd7TcCEV_HFVm5u_DNLP
 bnJ8Ywmg.2d9eZ2HM59fJxmzNeeN3oLO0ZMQAnVRV_B32qIX6kQ4WpX.Z.6J32Z1yUOrwJ9ybTkg
 PFnGbvdqqly_PLnG8Tw3X04tLYkCIPPaiZtRRY9.w72IfXDppOLLJq0QqX7ipmRxI3ntnCwHw_1U
 8aKnYxmPo6RPxaxAeBb8x6dTMA1hE9m7Zaxb8R.Tp.V9vELQJv.DfaHZ0hRAowLZmY9vhRcqhdpm
 6.EpnZqQmyrD9jJGl_hqT1Gs5mh2ZvnhhXLvDZ4eEWI286yJf.AEdRN7o3r0G7Z0fLx54mMHM9MJ
 6hyIduRAoLrhOhoQxTUgt92jD039j_I1DVQbk2ZuAet_8l_RCDCjw7hALEWGMBW7FsSAJXWg_K.B
 0dEEzhlUEJEZchDdJUkbL90N_e7wMNb68t6UxCAacH_5hQ4ay.cyIOr7vZBkBkIEM5D8j_zhEGOQ
 WwFZ2Y3f6BJBogV6f8caUkMnGEasaRgmVkM9FKJO9UnpSKAy1BZ5PwO6wfnjueex8g0LKUlfoWRU
 3x.GHvhpmi8lVuARRYPoZLAgjPo7uFyPols69_IT017skbtt5qN1bVNRZ9Ey4oTwI9wn5Tsw6.oz
 y8YmNRE7gntooh5Cn6uPVC_LSu3_XP7HvwAxiZtTPIaePOXvC8K8ZLuHOcJakaUjvdH.sAUzPne9
 6ouTOB6a5bhTkkH9mAhKTqj6YsdExrj9vx0glGGvc0vSQu0mRpqG9FcK3KQ65yboN2LbxHi0WzHU
 DmRr5PL.cka1rl5GG.WqNs7a6VNqrMv9S0S6IWPtfDPWcG7j9T.UXkp8gPgSBQ5Z7qYh9QVWMb9b
 qZAN16ZenBS1lJCDvANxXRrKiFJej6RBI93D47EIX5PeIGFrJnwfdW1CEd4weLLGc5luf6dqLtE5
 ngTF0LHbZo.iovh4.iDxGr4eCDGykn_dyWWHOU6bq6kusXcqyyzbGPPUu6MsPEzaW09jA_KZiPHe
 WXCthN47nG5h9rAkg0jehsaentaEtHbzaqymwton7LpPi5OtL2oSv9LqVqpkxNWzLm9i34CzDQ9B
 IOSio08Ttm3SzzzLUPTdKm5VPy_63ME_hpCD_wX4ZaeVG.8w5hvsTn499LcB4S3x575zQJNAOzg3
 eEAmtMkG3qpP8cV9E9vOatJTGU1KorDTQI2h9vBtaQ3no9p7wTlYSkQeizR8ilhEo.KnVEtdtLI.
 PABFVLTA.d7dE5JVk1iuKuoyhUC6dZDTTV2E3LYh0LMcelZCyCiRWmgFG2WB4jvrjDMYgZPsPVqR
 Qh86z6jLuGeyEG3KRG8DVj.AylJm.qvjIOUW4pdwxBxg5_aIPnxnTq2xb3apCNI2y0Wa2DBMXsQz
 ZJd9ugiyIb0h8yLf66_y.ZRjSdOYLx13fU_YF4tTV8E4raVeNnW.f44zxLSEKNqjTd7PBmPnSpAH
 TFvzbavgjcUye7kHNqHeLLP93TqJErBZTqbY60bWyvfWs2a0V..QfmFVd0u1_BcOjHrKSdq2dcXH
 XWEENFHhUNAQ_28ehblFBPayKhopxpC4tsXKCRK78MuhY6dNMQPDMQCQX2wMHOMU97Mo1q2DJbez
 H9n8PSdfryuMDgskb7r0AxV9YPSrXUnRe830CojhvY7xArGDz1p1awMd_Z9bR5jKAQn1vUdgA5KM
 4G0lVHfR8fTVg8XErZNff0raDpMyv1KflsGs9n5f0S6IKZX0inQjgyd2CMoXaig.njfWWWXy1B4O
 XajHESPYP.h1F8gMhGAFlb_KgJc6IITagJQos83l9GP3kZFSucjXCy6WUOjvRu8tw6QWwC8UyQsp
 D.rS0CUcjwBBqDvZQP.ic0ko6bcdupQmpsobwdvOrxfrMvH0UkmXJwRLbLtIy8Wq.y_Jggk.BlW_
 nMDK0FEtdH6iw3OtSx7J7OV6KmzqxCqITTEam_2DKVgLlFVMMjdYSSTbHxvJOsMNdGOCmZwBDscl
 gBEJOal_QTfNXUaARPfXD0W2GesJXST_bdyMZXd8UEqvZMflfdPeVoo4cJcbnLJFK2OdNVTs6ExJ
 ACZruUdKWqqdNHiauCg7_Jo.Kg7h8PZK1ddqIcOPS2iaWcBiiXdXWwhjdbvEyMfZ6xHeAk6E1OYp
 NYK3q_nuWWCzYR51qCQJ_cmO9UnXvtra11JZ_LNnz78feH1jFl3.SFARCLHRvVqv2vcamejpNkP8
 0pR7fTCdeQvuQjN8PrM9M8fNGJ1fukewFb529g3ZK8n.QVGm0bhK8ifpsMtBMUnEuvrS05MpV7xy
 0rMlNpzf870n26FoF9yQ6AJIZ_g--
X-Sonic-MF: <mdferdousalam1989@yahoo.com>
X-Sonic-ID: 522993e5-f89b-4676-84e4-4d6d552fe8f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 23 Feb 2026 19:16:50 +0000
Date: Mon, 23 Feb 2026 18:56:31 +0000 (UTC)
From: Engr Md Ferdous Alam <mdferdousalam1989@yahoo.com>
To: Md Ferdous Alam via GitGitGadget <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1858262678.1052976.1771872991160@mail.yahoo.com>
In-Reply-To: <xmqqa4wzo077.fsf@gitster.g>
References: <pull.2051.git.1771836303147.gitgitgadget@gmail.com> <xmqqa4wzo077.fsf@gitster.g>
Subject: Re: [PATCH] doc: commit: document special date keywords for --date
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.25198 YMailNorrin


Junio C Hamano <gitster@pobox.com> writes:


> I've always thought that these are easter eggs to be discovered,
> deliberately left out of documentation, as they mostly exist to be
> amusing.=C2=A0 For those who want to be precise, the date formats section
> gives sufficient information.
>
> Moreover, 7.days.ago and 1.week.ago are also in the same category as
> what you called "keywords" here, but we do not try to make an
> exhausitive list.
>
> So, I dunno.


That makes sense.=C2=A0 I had not considered that these were intentionally
left undocumented as easter eggs.=C2=A0 And you are right that trying to
list some without listing all (like 7.days.ago) would be incomplete
and misleading.


I will withdraw this patch.=C2=A0 Thank you for the explanation.


Md Ferdous Alam



=C2=A0=C2=A0







On Monday, February 23, 2026 at 11:10:23 PM GMT+6, Junio C Hamano <gitster@=
pobox.com> wrote:=20





"Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:


> From: mdferdousalam <mdferdousalam1989@yahoo.com>
>
> The --date option in git-commit accepts human-readable keywords
> like "now", "yesterday", "noon", "midnight", "tea", and "never",
> but these were not documented.


I've always thought that these are easter eggs to be discovered,
deliberately left out of documentation, as they mostly exist to be
amusing.=C2=A0 For those who want to be precise, the date formats section
gives sufficient information.

Other than perhaps "now", which may be handy but not so useful in
the context of "git commit --date=3Dnow".

Moreover, 7.days.ago and 1.week.ago are also in the same category as
what you called "keywords" here, but we do not try to make an
exhausitive list.

So, I dunno.

