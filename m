Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61A4A1A
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768569; cv=none; b=L6BWb8GhT88UnGKIHtT5GDz6D9yHrb6ST40MCRQgyqOd2jWVUjbhbJMTLRWnOJQB17pVtE0qNJ3hzXPatF60h8ZLyxbwZyhFxR3j8QjsUhJfLILdQzfe1flzifys2ciJBcmjxz0tWg8BmVoqQU2mql4/ttRQR/0KR39fuNvqlOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768569; c=relaxed/simple;
	bh=+5RofJy8lTXjC2v6aVsdXKCr3HiCeTstt5UWLPVmfdE=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=ibSaO2DubEwsrOSNRIw6xD+NNQf2zqML/+R4uVWPR7+V+/1ZrbT6jn/zmO4eYqMqtwq9xaOHSoVh4NvDYEfbMpuRx8/oOuZZ0EP67J8qDtWTHbqqO28o3toPioISWLGNgZx5mcgpJW9CHvjG6mg3NaBT9LuH1NVtaPNzibjc9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=BMBQ1w0J; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="BMBQ1w0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PlQFYXgBvVkjUAjmoqrVd0MuEhChSxpz9np7hxC5yWM=;
 b=BMBQ1w0JqzxK2J7I592dOxjiWs8WsvcAuAEj+wZdNnBANK79QoK0DONuWlmSUwmuz8frFKDWbzxN
   B5gyaBNIQyl768VesL2SvPJS3TIkwJgDRxMRDbzSGAjcdGswn3sOy+hV7PcdFRDBOR/0zfS4TGhO
   ngCGjfzcpF3do1gHiz6mfMuayp/5fMG0JRlWJXEM49J01Me+lXnehPJgQCUFca5ko8dlSsIH7Dl7
   cK8AIjBB1gD2tv+8jigxn4KsXdREktYzw9fI8f2AoyVzEt6Ofui50O4vTz/jh317JxgTMvkzbpYD
   KBORF/L+reIA/OX7twdpMl7AOMgEfykboXndQQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN1005D2SXU1YB0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 16 Nov 2024 14:44:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 16 Nov 2024 15:43:36 +0100
Message-id: <D5NOLJO397LO.3RS986OX5GIZ6@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Junio C Hamano" <gitster@pobox.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-5-bence@ferdinandy.com> <xmqqcyix11w8.fsf@gitster.g>
 <D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com> <xmqqo72gyqy7.fsf@gitster.g>
In-reply-to: <xmqqo72gyqy7.fsf@gitster.g>
Reporting-Meta:
 AAGkwcJPYXdE1jjJhGZv5KOvGVg7eB4PFdZ+aI+wB4cG37Lvupufwu/at5jyznJ1
 VGiJ1vJ88PdmQQNOx12KTvuycF5CCywryOpJt334W/vzh22otdCzg8fgHy10OQxY
 ++DjQr0qgGZBckHacGfRc53eCeS5tFqsY9nWrTw7ju7iJA+0N5aR+rzH1u3CKh35
 1cMta3XpKe2ZNwAIYMdJXIi6fT+DzBKAXTlkJNbiCQs8v99Fu82QX6y8+ojZ38Gh
 nMXK+yjtMsjrS8cNW4NbecNSy6oBwL65yIMrBPUc2TzHGGhlUWXIik4vsaXnnqf0
 XYSz0Ly862zGwS6ejJbvaChmw87nssp5mv+NP9r+HTbTNQALsMQcPh2Vk5R7P//U
 9Lb+BiaBkDnPNnlvgELS+NKi3uC9rVoD3Lp1XE0209sLYIGqbOWahWmH2bQA/u/F
 8ZGoxmJNH+kTTeZqKEdno7c9AuC6ls61Hj7BtKZ8SB7gcSEBySne9OA=


On Sat Nov 16, 2024 at 01:15, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> Good point, and yes, that is what happens. (Although I'm not quite sure =
how
>> valid that state is where a remote's HEAD is not a branch).
>
> Not often when you cloned from a publishing repository, but if you
> cloned from a repository for your own work with an worktree, the
> HEAD at such an origin repository may have been detached, so it
> would be sensible (I think "git clone" historically guesses over
> eagerly to hide the detached HEAD state of the other side, though)
> if the clone's remote-tracking HEAD reflects it, I would think.
>
>> ... So maybe if we put "Not a symbolic reference." in the referent
>> (which should be an invalid symref), the caller could check for that and=
 then
>> should be able to distinguish this special case?
>
> Yuck.
>
> Are we limited by the narrow interface that only passes "referent",
> or are you in the position that allows you to extend the interface
> to "do it right"?

How about we do the following if we can't read a symref:

1) remember to return a new exit code for refs_update_symref_extended (I gu=
ess 2),
   but continue on with updating HEAD

2) read the non-symref ref into "referent" (I think this should not be able=
 to
   fail since, otherwise locking HEAD will already fail earlier)

this way the caller can check the exit code, see that it's 2, so not entire=
ly
a success, but HEAD has been updated and can report things accordingly.

Does that sounds more reasonable?

Thanks,
Bence

