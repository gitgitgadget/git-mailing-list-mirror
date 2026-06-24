Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C233B635E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307512; cv=pass; b=ZwHmXnMCVBsTtY3XmGM69BM8i+pb5S0To3hs062rsfUmaBue3KkL0hS/VyEQvS5zZZAP8uusjQN6gZ5UBrBlosIgB5qEufMrMNTNPUCUQOWV37xs5dv+QiKLWIlGdIYpwguHBOfmgWL7dYAbhflT/z9E05haW+l97CzWCAsI6fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307512; c=relaxed/simple;
	bh=+HxKJ7roPjOE8BZXkIz/qCamUyAa2Dgfplyk2JM0e54=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4GtGo3YqWAJHiJRrXWnz4q2FPyL6xsUTT0VnIp6nGaiPwyS2onm957M+QFJ15icRf5tU945Pem+tZMevnBTEX2xHFTzgTfHVA1BjE4wVbIFnGhWyffFHIlJAcm+7kvxm9qeKQT3pelAbz6tySGdaLUzTvuMya7nfdS4/Q3x7ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgGdgKhF; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgGdgKhF"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7269038ad05so767007137.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782307510; cv=none;
        d=google.com; s=arc-20240605;
        b=Lon6yR25Blco9eOeDNlq2QJlocTUa30Fo0NagWa+bx/KNYTzUaCTg8wRswJPMvcTRr
         /cDjFSo79AcNCWWIWy6lJCbhtUR+E1hyfvqEzf4o0UvCPywHu9Tx5/JocpYLaqx3CkB2
         orxyQ72QL1q2C+0H7GPVrFt+KwO9O07e1wPAZwbBjF0n8wbniTfejQVRkfa7Q6lEkqtH
         xtyNZqeWDm7jgcubZUWf3eOa4x8/QDKTgM7/BsTt7GslttO85+c43r84FcjnK7YtqCLf
         9Ohnfnp7BPNvvf1aDFHDuWtzpn4hVKN/5+pkP4QgEBHrcK7QKHJTqYJtaFDLeE7qeWcJ
         ND9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/DAEaR6QBkVhAARItuZ6BtuYK4PghUD61XzWlE+J7ho=;
        fh=meLeTkZYGdDdTDxIO5ZHWVl7Xi2Q65vkBcqRUpD/2SQ=;
        b=DXEBiJdtxVO4gg0boSZqagwmGcaAk8HGDc6eQi6K0ATwG5SlgRV7h8LA05lo9nBM7k
         kcpesA3ZwCHXfxH/uYQGQP7Zzzljz706eAtVtClKgiXzpsSznGeS4X9MReU+j/LdrL0D
         qsFxgk3yjmiOf/WLw1yeWo1OWix92EtxS0pc8Is4y0pFHxRTDmXNr80AqTSlrURMRi/h
         SHM36OXP+MjmSERlWJCrD98UQGNAAkm2V3QV/KnJ/+osjiBeyYBnysM8EFQOH9xXDych
         gCoyXIVsyHrXQf3eKlu/VgAVFPHk+qifvmXIiCUXJNxJK+cwn8RZo+49bZ1vULveHC8w
         J8zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782307510; x=1782912310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DAEaR6QBkVhAARItuZ6BtuYK4PghUD61XzWlE+J7ho=;
        b=cgGdgKhFsj6zGWmW+ONL086l+QYGM0g4Q6A67OMSgM9e1mEO2dR2+NWYU0JdRrPEBV
         dQmIQo/jWLb6ME9O51p553kQuedbVswbvyF6sw+g6Tx3IMxErzmQGqP3Q1PEt04nDxOw
         VV336SA0ceAi7h806YnZyBkMXkJTutS9IGbYGKi8Je6JvB4pREs8Yv8+Dwh3YGsTsxRK
         Av95Z6F/tVVQBHZLlsv3ImiMwylh3BNlez7Lo/VFXeSua+FMCO7YksAuq4QHa6WMOTNj
         SlG5dBq50ZCp6EvxuZyCUV2asDq9kTlT7yZDvCrFdFyAQoHLHxS0ev0gVLTqudKwMU2V
         rtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307510; x=1782912310;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DAEaR6QBkVhAARItuZ6BtuYK4PghUD61XzWlE+J7ho=;
        b=TVzJC9s/Py/Nk2LeF3NxihFSdcWh5it3PpGRWaAIhDCPKPcBVafzP/I7WI685sUBEN
         oJooa/qZ/QL8ZXhVJOH4xmzmUC1N5h/dTt/CCsAknbC98JDh0ACGRqdcDueFJkpjtBBs
         sPrjmrCEu3XfF7asvUPGRPHKTwHY2+PBPbcWg2277cAkk7d4PdXKoEDv9Fv0zliiM2Y3
         yEXGtu1TYKc+4bc3PSB6DyoFuKv7BNWh5zHcO3OYb7ivpu6gtYo0XbB/3b+ls/Y5Ka3p
         +sABzoetqsrNEeK4GCPHDunEe+S5eC+FiOgbbOnkmhwrD6Ki1/lCHB1d5IravL+NZhmR
         8xEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq2tMj/KyBe0Znb2TyTPGCePcOTOnqONyWYYt8Gg8X+MdqwM9JaN1/FVelrkUG3BiXV2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OhMOi22ChHXXiXowBPWHurDQLzWmRr4UPR3KoUofBj7dA00z
	7cda/c3xkwLTs9KQhNL7SV4otqm0o7CoKV+rNHLv7m8Js+idGJ1Hj7qh7sHdYDbVUE9oCDt8KUE
	P2N72LFRZLTHgVaek6AFcY97dYI6X06c=
X-Gm-Gg: AfdE7ckVJgwsCIcSbk7JWlBRWzAFQw/Xi+sXFsyhHtMmuxTfbeYNFqKe5hJBmDO2kZ0
	v9Cc3MzPw4GDakeYJkIt0UmN1I+6l6tkI4ho0T4p3oMv95J/P5Ao1oTSVZJFgzB2xNc3doNKCyJ
	3aacEcqmOppn6c+hcnzPMkxsG4jdDDnSb9H/WLP50ZripxLK2/i0nSH/HRb6W6nakbBA8VcQme4
	9gjeafJrpfkErfkd/1whrlFSuBa87M9dA/7Uiww6a9BKGUVpEZTiF5DvBhP8unXAW1aBZKypH8k
	uOfz3iSONBk+Z2z3k4Jh3iqqTcCK1KEJRoCqElip/uSkRmR21VlNvT+4Gpc1Rbg=
X-Received: by 2002:a05:6102:424d:b0:633:c6c4:b32c with SMTP id
 ada2fe7eead31-73114c0580fmr1380424137.15.1782307510148; Wed, 24 Jun 2026
 06:25:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:25:09 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:25:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAN5EUNRN4_5PS3cbQtQfpyRuwByvV=qvAVKnVbgT-pirKGnnTg@mail.gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
 <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com> <CAN5EUNRN4_5PS3cbQtQfpyRuwByvV=qvAVKnVbgT-pirKGnnTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 06:25:09 -0700
X-Gm-Features: AVVi8CfaFLhGbu3AeG1Gh0odZhvHGfQvv4Af5HaCYamt9lIL_qgBukCwlKZmvBs
Message-ID: <CAOLa=ZQUCrAgnyoUCpd_G8PEdYunN7on=unR-TYcUe=yURyrtA@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000787600654ffce25"

--0000000000000787600654ffce25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> El lun, 22 jun 2026 a las 22:43, Karthik Nayak
> (<karthik.188@gmail.com>) escribi=C3=B3:
>>
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>> [snip]
>>
>> > diff --git a/connect.c b/connect.c
>> > index 1dced8e632..78c69d4485 100644
>> > --- a/connect.c
>> > +++ b/connect.c
>> > @@ -700,16 +700,16 @@ int server_supports(const char *feature)
>> >       return !!server_feature_value(feature, NULL);
>> >  }
>> >
>> > -void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>> > -                                       const struct string_list *serv=
er_options)
>> > +void write_command_and_capabilities(struct strbuf *req_buf, const cha=
r *command,
>> > +                                 const struct string_list *server_opt=
ions)
>> >  {
>> >       const char *hash_name;
>> >       int advertise_sid;
>> >
>> >       repo_config_get_bool(the_repository, "transfer.advertisesid", &a=
dvertise_sid);
>> >
>> > -     ensure_server_supports_v2("fetch");
>> > -     packet_buf_write(req_buf, "command=3Dfetch");
>> > +     ensure_server_supports_v2(command);
>> > +     packet_buf_write(req_buf, "command=3D%s", command);
>> >       if (server_supports_v2("agent"))
>> >               packet_buf_write(req_buf, "agent=3D%s", git_user_agent_s=
anitized());
>> >       if (advertise_sid && server_supports_v2("session-id"))
>> > @@ -727,7 +727,7 @@ void write_fetch_command_and_capabilities(struct s=
trbuf *req_buf,
>> >                       die(_("mismatched algorithms: client %s; server =
%s"),
>> >                           the_hash_algo->name, hash_name);
>> >               packet_buf_write(req_buf, "object-format=3D%s", the_hash=
_algo->name);
>> > -     } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1_LE=
GACY) {
>> > +     } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1) {
>> >               die(_("the server does not support algorithm '%s'"),
>> >                   the_hash_algo->name);
>> >       }
>>
>> Why did we make this change? If the server doesn't support v2, then the
>> object format should be `GIT_HASH_SHA1_LEGACY`. While the value of it is
>> indeed `GIT_HASH_SHA1`, it indicates a scenario where there was no
>> option to select object hash, which is the scenario here.
>>
>> If there is a reason to make such a change, perhaps we should highlight
>> this in the commit message.
>
> Hi!
> There should be no diff related to that line, In some point between
> Eric's last version (v11) and mine's firs (v12) the original code
> changed. On the diff from v11 [1] the object format is the same, i
> didn't notice this change and it's wrong, I'll fix it for v14, Thanks!
>
>>
>> > diff --git a/connect.h b/connect.h
>> > index c4f6ea4b0a..8f4c523892 100644
>> > --- a/connect.h
>> > +++ b/connect.h
>> > @@ -34,8 +34,12 @@ void check_stateless_delimiter(int stateless_rpc,
>> >                              struct packet_reader *reader,
>> >                              const char *error);
>> >
>> > +/*
>> > + * Writes a command along with the requested server capabilities/feat=
ures into a
>> > + * request buffer.
>> > + */
>> >  struct string_list;
>>
>> The comment should be above the function and not the forward
>> declaration.
>
> True, I'll fix it for v14.
>
>>
>> While we're here, why not `#include "string-list.h"` and remove the
>> forward declaration, is there a circular dependency?
>
> I believe this was right because from what I know forward declarations
> are prefered in headers when in this case, the struct is only used as
> a pointer. Investigating, this came from a review from patrick [2].
>

That's fair.

Nit: Maybe add this context to the commit message?

Thanks

> [snip]
>
> [1]: https://lore.kernel.org/git/20250221190451.12536-5-eric.peijian@gmai=
l.com/
> [2]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
>
> Thanks for the review,
> Pablo.

--0000000000000787600654ffce25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 31f0c5be40a440e3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vNzJyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVNHQy80MUF2N3JWUzR2dEJ5Vzc2R2FLMzRnNGh4TApDTHdDMmUrU0h0
cURBdnZabERLSld3c3NDdk8yOUZDcittaWJ4OXpKaHJ6TWVScWR4T3A0aTdvMFgreFZqamxPCnQ2
dmhBZUtvZ1dGS1FMeVpqOFhQZzZ2a0Nma0RPOGJNUkNEM0ExQndnNDNXT0psWEZtNFJIbEFJM1B3
a3ltYUcKdi9ZVjh0MTkvK0JMQ0N5Z2xGc2JLK0JxZTg1aHZ5WkozRThlVERPQjkrakpCMDlyQ0U1
eld5eldKdjlsbmpNQQoxZis3Lzdkd2g2SEZEemZTcnBNYm9mT3dqL0owRjFUSGYxTTNMaFY1MmRG
VkkrbUIrSXdmSGxqWHN6UjZYY0VoCmVBanBseUdqVXNHdCthSGs1aFIrRTB3Q1U1UzZYUStWOVFs
UmJ0R3l5dkdOemMrWmVMaDdnTFd2QnFlR3lBbFMKT1FySHg0TmRnbktLZTIyTVR5eFdjc1Frejd6
Zy8vMEVrVmJzRjg1Ky95T2ZQRVFLYi9ISTY2dlRUalFoOTZ6bQozYlhLclRteXgzK3JtZUF4UlNR
QnRSS1oxU0pSMFJpT1lUcVBHQ3hpRUEvRjVZVkRGYkxZenVxaDg4aVBDcEZaCm9YYlZIYUNFVzhG
UDFaTFdkdEZJUGx0YU05RzJ6WUlHWnA2QS9Qaz0KPUJXdDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000787600654ffce25--
