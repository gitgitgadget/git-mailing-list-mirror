Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723886;
	b=OtpK2anh81YSIDwCWZ3ots8nJcglMF9gR/nGQa9MkbzovqnhsJiUu+kUV8CokuZhCStn
	 Wb1Ojm9dEE3FeZaDyfqOXU+1CntDl14iegFOE1ZBrufleFSfzuBmfpPqm6HVtlU2/+yYt
	 vqcMOfPZst//YXDAJyfXsoIPaGY6NiiV5Uxp7iLglPKr3yEGBSwL+4uGm43hz4Lj4IXRs
	 F9wN6P/gbSKUmD+0GtrswRIdAVN8JGILnII+E6lA/ZCwzi2J1cilZLa6CiZ1wo8Qa6qkC
	 AJRi5o0fsSK0xYLgA3w0BXfTRF9Mqqn9G/ldWme/jHkIMRmSxDJadQHYDA4x686DycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Md94lRjsTJNzxA5wOiPj6JUbBKz0gu1PDUGkIWGGkr8=;
	b=nUmrsggEtsYPyKfpJFnnbO6F8z6UlkHX7QV+06BY8UBkBf0xGLPkPQPygCNTCCS4AOmq
	 +5yj3g0JdV0j9UXq+mgL0d2h8tj4oGRB92utwnnuH/RyiwV3uxyU9Eguh96m5DBMJuJSd
	 8dHYWtGZHudKDj2VmeZwKNzlk1jzWJtfV3lyzDlAgmRvX3qd82xOf4DJZRVvcF9Kv4CiA
	 2AsxVrA3yfwZ4rFxcnXWh/SY6DwVq53ehlkICTUSRuG5bxdxd796BTYeMtXdN2x7YqxPO
	 7x4bJFh+yMQwu6MOX8e4gYEzEfAUd+QuVtsBrtOnCd6wewHclk289MJWRlgSgquMwLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHMFeVbj;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67989606EEBF
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67989606EEBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHMFeVbj
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so45956275e9.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723885; x=1794328685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Md94lRjsTJNzxA5wOiPj6JUbBKz0gu1PDUGkIWGGkr8=;
        b=tHMFeVbjyOk7RlUAxuIQ+1FzRiKZPSbd0AHQISxY2BFc/IExuuEYyFIHWNxmsmPzag
         ++G52xuld93t1LEBsK/7Awbhmc7NBvmx+WlQWMF12pZRSpnNJzMp+vSJG2S5kE9vPdIp
         TPsUxoA4DK9ZARgqyyBXfbwLPb1cx5AsdY3Yb2psiwRVR7IVhtQHTaufBuGwGG+8544E
         Q06tZ2p+72xhxWIhSRpyrmf0MhmS8srkGt3HiPIoSl5tSphDJcDr044wpLGg4AJMHtST
         ArX8m/743Iy7S6EOJ27QA1nlwNghPVwkkB9KnAI1w8CaCNCtOk4ErlREcRsGzC89dJt7
         rSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723885; x=1794328685;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Md94lRjsTJNzxA5wOiPj6JUbBKz0gu1PDUGkIWGGkr8=;
        b=nwYIcIzi21QnnLX6GsRH3qGcIUDOTfe2g1OVTQvWjztf/g/bmjv5yl4Mdl0K0bxpBP
         2/xWGtY2lk8CT59yP/AlcwVOFrroy8qN0j2RthbzmFmQ6gcgl1yQBTA4SGQwBw2QGIJW
         fNlBAzKquFBLuPrm1gVr+b2Aclq4MSBYAxLDH0+f/MCX0fHFZTm25L01n5+am3k75scs
         Eqw9ohTrdtypF89M4VtRqdW4/0VNfnjVJdUH3Hi7Z9HU1ZkoD2w/rbOo60bbsxQ3oCSF
         bWCTLWZIELvNJpyfea5cHpqAV5PrIAmzRlMCy7Zi1L4JUqLzyETdeC+sTW2N76AVDy1v
         tIiQ==
X-Forwarded-Encrypted: i=1; AKwUvByMVw2rK1K+r3F+iFoQYe72oZGT3krPDrhZdwYgnvl/LQ3Ske18Bktp0yv9D72CRVWaZO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uyrZdTmwNEuEqzCNzibNasolhHFJ0qCDnBK9db4v5t+BcGOte
	I2WHn1wAE7WvsszCMPFPD79hTy5xSVP6yCNA9OkZdmlWur9509MC5+zc
X-Gm-Gg: AYBFou3soVNrj0x31Uc7LVKDtL+22gM65Fouxdbk5Mq5lFLUNUWrrU9R8/+BGnlnZ4G
	KhWfm6cIbS2oG0mIRAm3FEYTqJPfLk1pMRppyWnHrsmwqPkmFCj303sbFu61aoaBx8VE9IYlNuC
	wJfCSdc4VwxRFEXhOeJaun8YkAnag+IMGKfQngVzO9OBSaSU3vnND1S70+j6zoQvBTLykP5/6Ik
	+t1+o5ll8//4aBA8jRzoWlNg/qavob2gef2/dd7mXlh6yEA1oifJ16Dh0ZCIbKsMEir45h33UoC
	ecA4ETDrof2oZ2SioT7BwEoNnv7oYnSl+wbCZLjTCZRKtZTYrNRqLfnzt78BS00xuzxU1b4pc7O
	OaMrHFSGFaETgHgP3GPCUpELV3FJt3tNJbTBYzLMZRmP+upRIFbIbJYrU7j/c2bice/kUmHO0t0
	ShwAglmm1AiPQ0oM1PTXVQIjB/N86JQIZFE+FSvSuXwivo3o+6L0wIo6B1Qiz+gIwnkThmjTWCg
	0TxEAoqaYsNkCfcrHY0AoSVZKgcDxDMBJe9VL9lqpj8kWWBINv2u2XcAk2pq2UbjQNh40LRAqqR
	AEHD54ORC/xDLbTlBca4rFx9n7MNGQkwBw8dRahdF5QuhM9gK1pTSMje23DaoLxDSAiNe2/kAzr
	GmFD5hQ==
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ac180f28f7mr301039505e9.15.1793723884568;
        Tue, 03 Nov 2026 08:38:04 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a555e59dsm78870455e9.0.2026.11.03.08.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:38:04 -0800 (PST)
Message-ID: <9fb1cf95-1cfb-4bc9-a722-e98d0a0664df@gmail.com>
Date: Tue, 3 Nov 2026 16:38:03 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Strange word diff
To: Jean Abou Samra <jean@abou-samra.fr>, git@vger.kernel.org
References: <4dd76eef8a2a355ba435e8c784c1e37f3fe47074.camel@abou-samra.fr>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4dd76eef8a2a355ba435e8c784c1e37f3fe47074.camel@abou-samra.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jean

On 03/11/2026 14:14, Jean Abou Samra wrote:
> Hi,
> 
> Attached is an archive with three files. file2.txt differs from file1.txt
> by just a few words, as correctly reported by git diff --word-diff (using
> Git 2.56.0):
> 
 > Is this a bug? It happens with all --diff-algorithm option values.

Yes and No! I think the diff is correct, but it is also pretty useless 
if one is interested in seeing the word-level changes. The problem is 
due to the way git calculates word diffs. To calculate the word diff, 
git first calculates the line by line diff which looks like

diff --git a/file1.txt b/file3.txt
index a9eaedc..81c3eb9 100644
--- a/file1.txt
+++ b/file3.txt
@@ -1,4 +1,5 @@
  \subparagraph*{Context}
-Our object of study is an extension of Turing degrees ...

-While this game was introduced recently by Kihara
+Our object of study is an extension of Turing degrees ...
+
+While Arthur–Nimue–Merlin games were introduced recently by Kihara...

then, it splits the line diff whenever it sees a context line and diffs 
the words in the '-' and '+' lines it has seen up to that point. As git 
has chosen the first blank line as a context line, it looks like the 
entire first paragraph has been deleted which messes up the word diff. 
We had a similar report a few months ago. I think the solution is to 
feed whole hunks from the line diff into the word diff instead of 
splitting the hunk when we see a context line.

As an aside my local git installation uses a modified implementation of 
the patience algorithm that removes the fallback to the Myers diff when 
it cannot find any context lines[1]. That algorithm cannot find any 
context lines in this example and so gives a sensible word-diff.

Thanks

Phillip

[1] 
https://github.com/phillipwood/git/commit/7eda9d836c8db76ad49b6cc8b5760ff458d81e9c

> ```
> $ git diff --no-index --word-diff file1.txt file2.txt
> diff --git a/file1.txt b/file2.txt
> index a9eaedc..a75008e 100644
> --- a/file1.txt
> +++ b/file2.txt
> @@ -1,4 +1,4 @@
> \subparagraph*{Context}
> Our object of study is an extension of Turing degrees where the oracles can
> feature certain forms of non-determinism, as in this riddle. We call these
> generalized degrees the \emph{Arthur–Nimue–Merlin degrees}, owing to their
> explicit description by Kihara using a three-player game whose players are
> conventionally named Arthur, Nimue and
> Merlin \cite{KiharaLT}.\footnote{In \cite{KiharaOracles}, Kihara uses the term
> “extended Turing–Weihrauch degrees”. We prefer to eschew the association with
> Weihrauch's name since we never deal with [-call-once oracles.}-]{+oracles that
> can only be queried once.}+} Whereas Turing degrees are defined as a quotient of
> oracles which are functions $\N \to \N$, Arthur–Nimue–Merlin degrees are a
> quotient of a richer set of oracles, namely functions $\N \to \P(\P(\N))$.
> Informally, when a program that uses $g : \N \to \P(\P(\N))$ as an oracle makes
> a query $n \in \N$ to the oracle, a set $P \in g(n)$ is chosen in a benevolent
> way (“angelic non-determinism”), then a value $v \in P$ is chosen in an
> adversarial way (“demonic non-determinism”), and the program receives the answer
> $v$. The mathematical meaning to “benevolent” and “adversarial” is made precise
> by introducing a game where Arthur, a player restricted to computable
> strategies, is allied to Nimue, the player choosing $P$, and both play against
> Merlin, the player choosing $v$. (The details of the game are recalled in
> \autoref{section-arthur-nimue-merlin-games}.)
> 
> While [-this game was-]{+Arthur–Nimue–Merlin games were+} introduced recently by
> Kihara, [-the concept-]{+they are a concrete description+} of [-
> Arthur–Nimue–Merlin degrees is-]{+objects that arose+} much [-older, having
> arised,-]{+earlier,+} in a different guise, in the study of realizability. To
> reassure the reader unfamiliar with realizability from the outset, this paper is
> meant to be accessible with only a background in basic computability theory,
> except for \autoref{section-topos-theory} where we explain how the proof of our
> main result can be understood from the point of view of realizability.
> Nevertheless, let us recall the historical link.
> ```
> 
> The only change between file2.txt and file3.txt is the addition of a
> blank line:
> 
> ```
> $ git diff --no-index file2.txt file3.txt
> diff --git a/file2.txt b/file3.txt
> index a75008e..81c3eb9 100644
> --- a/file2.txt
> +++ b/file3.txt
> @@ -1,4 +1,5 @@
>   \subparagraph*{Context}
> +
>   Our object of study is an extension of Turing degrees where the oracles can
> feature certain forms of non-determinism, as in this riddle. We call these
> generalized degrees the \emph{Arthur–Nimue–Merlin degrees}, owing to their
> explicit description by Kihara using a three-player game whose players are
> conventionally named Arthur, Nimue and
> Merlin \cite{KiharaLT}.\footnote{In \cite{KiharaOracles}, Kihara uses the term
> “extended Turing–Weihrauch degrees”. We prefer to eschew the association with
> Weihrauch's name since we never deal with oracles that can only be queried
> once.} Whereas Turing degrees are defined as a quotient of oracles which are
> functions $\N \to \N$, Arthur–Nimue–Merlin degrees are a quotient of a richer
> set of oracles, namely functions $\N \to \P(\P(\N))$. Informally, when a program
> that uses $g : \N \to \P(\P(\N))$ as an oracle makes a query $n \in \N$ to the
> oracle, a set $P \in g(n)$ is chosen in a benevolent way (“angelic non-
> determinism”), then a value $v \in P$ is chosen in an adversarial way (“demonic
> non-determinism”), and the program receives the answer $v$. The mathematical
> meaning to “benevolent” and “adversarial” is made precise by introducing a game
> where Arthur, a player restricted to computable strategies, is allied to Nimue,
> the player choosing $P$, and both play against Merlin, the player choosing $v$.
> (The details of the game are recalled in \autoref{section-arthur-nimue-merlin-
> games}.)
>   
>   While Arthur–Nimue–Merlin games were introduced recently by Kihara, they are a
> concrete description of objects that arose much earlier, in a different guise,
> in the study of realizability. To reassure the reader unfamiliar with
> realizability from the outset, this paper is meant to be accessible with only a
> background in basic computability theory, except for \autoref{section-topos-
> theory} where we explain how the proof of our main result can be understood from
> the point of view of realizability. Nevertheless, let us recall the historical
> link.
> ```
> 
> And yet, comparing file1.txt with file3.txt with a word diff gives a strange
> diff that matches a few words here and there while missing unchanged entire
> long sentences:
> 
> ```
> $ git diff --no-index --word-diff file1.txt file3.txt
> diff --git a/file1.txt b/file3.txt
> index a9eaedc..81c3eb9 100644
> --- a/file1.txt
> +++ b/file3.txt
> @@ -1,4 +1,5 @@
> \subparagraph*{Context}
> [-Our object of study is an extension of Turing degrees where the oracles can
> feature certain forms of non-determinism, as in this riddle. We call these
> generalized degrees the \emph{Arthur–Nimue–Merlin degrees}, owing to their
> explicit description by Kihara using a three-player game whose players are
> conventionally named Arthur, Nimue and
> Merlin \cite{KiharaLT}.\footnote{In \cite{KiharaOracles}, Kihara uses the term
> “extended Turing–Weihrauch degrees”. We prefer to eschew the association with
> Weihrauch's name since we never deal with call-once oracles.} Whereas Turing
> degrees are defined as a quotient of oracles which are functions $\N \to \N$,
> Arthur–Nimue–Merlin degrees are a quotient of a richer set of oracles, namely
> functions $\N \to \P(\P(\N))$. Informally, when a program that uses $g : \N \to
> \P(\P(\N))$ as an oracle makes a query $n \in \N$ to the oracle, a set $P \in
> g(n)$ is chosen in a benevolent way (“angelic non-determinism”), then a value $v
> \in P$ is chosen in an adversarial way (“demonic non-determinism”), and the
> program receives the answer $v$. The mathematical meaning to “benevolent” and
> “adversarial” is made precise by introducing a game where Arthur, a player
> restricted to computable strategies, is allied to Nimue, the player choosing
> $P$, and both play against Merlin, the player choosing $v$. (The details of the
> game are recalled in \autoref{section-arthur-nimue-merlin-games}.)-]
> 
> [-While-]{+Our object of study is an extension of Turing degrees where the
> oracles can feature certain forms of non-determinism, as in+} this [-game was
> introduced recently-]{+riddle. We call these generalized degrees the
> \emph{Arthur–Nimue–Merlin degrees}, owing to their explicit description+} by [-
> Kihara,-]{+Kihara using a three-player game whose players are conventionally
> named Arthur, Nimue and
> Merlin \cite{KiharaLT}.\footnote{In \cite{KiharaOracles}, Kihara uses+} the [-
> concept-]{+term “extended Turing–Weihrauch degrees”. We prefer to eschew the
> association with Weihrauch's name since we never deal with oracles that can only
> be queried once.} Whereas Turing degrees are defined as a quotient+} of
> {+oracles which are functions $\N \to \N$,+} Arthur–Nimue–Merlin degrees {+are a
> quotient of a richer set of oracles, namely functions $\N \to \P(\P(\N))$.
> Informally, when a program that uses $g : \N \to \P(\P(\N))$ as an oracle makes
> a query $n \in \N$ to the oracle, a set $P \in g(n)$ is chosen in a benevolent
> way (“angelic non-determinism”), then a value $v \in P$ is chosen in an
> adversarial way (“demonic non-determinism”), and the program receives the answer
> $v$. The mathematical meaning to “benevolent” and “adversarial”+} is {+made
> precise by introducing a game where Arthur, a player restricted to computable
> strategies, is allied to Nimue, the player choosing $P$, and both play against
> Merlin, the player choosing $v$. (The details of the game are recalled in
> \autoref{section-arthur-nimue-merlin-games}.)+}
> 
> {+While Arthur–Nimue–Merlin games were introduced recently by Kihara, they are a
> concrete description of objects that arose+} much [-older, having arised,-
> ]{+earlier,+} in a different guise, in the study of realizability. To reassure
> the reader unfamiliar with realizability from the outset, this paper is meant to
> be accessible with only a background in basic computability theory, except for
> \autoref{section-topos-theory} where we explain how the proof of our main result
> can be understood from the point of view of realizability. Nevertheless, let us
> recall the historical link.
> ```
> 
> 
> Best,
> Jean

