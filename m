Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294914A3F27
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360143; cv=pass; b=irVwubkK8Yg65bkTkCcZ2rJWl7VJQmZd3+ALSniSz8D2efWt1sgTaDfs65NxIy95GFe89MXzLBRLXsZJGX3ykZ8p3uW5KPNK95OI36dOMDqqMWgrEusn5Tb1UiIQRmOMm3pVwXIrgHWiit0YXzDNfcVjsiDMxDfL9Vl4ItKib0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360143; c=relaxed/simple;
	bh=JFTnsyQELw68r4qXv99ZvbgOGJgO+Wsnb9gpKuOmB8k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmh44J4dnUNCgEM2Jyjv4793qVPGBQ+GP/l3o8qN7HwD42z6pGgH+FSqcVbybJ+/hZIuxOWx9idS7b83Scj/BfgrptsFjiYyubuoZ4+M6O1jIyS3TeOsn8i9Cf4wzjADfdDXjmjrE0qqscQlEb4fSmn3QZxbciJ6h/7KS0MkrAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFOYC88j; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFOYC88j"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97c441e66f0so680905241.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 07:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788360140; cv=none;
        d=google.com; s=arc-20260327;
        b=OWAJgORcAQAhSh8bvPGSgG+AtCXBbv3YByosbLDxnZlSJiunHApp1LhzRmdHxjwIaq
         N/TyIg2AXpueZHaPCYiMNGxRl4PBGjgco3PrQWSXmiL4dYfI5ZzDhVmx4oCVHQTegM2g
         2rLgpdo0SXB9ZBHkIMbPvEDd++JMVOi6oo3JqasGvAUXFySv6G6Qd2iVZmGkmBYd6gxX
         a68JMYvNc4ktkQqOmXnaZ14zkXFNsVnEr5HR1P5IWHUNeMXn9BopC+DO64un+j+SGg/R
         75JDimscCdKlr+OsKMJtXW7DXYcn2D+ccwvV4AMmmWhFM/ndnd63CEFEHajmXYEnaTBg
         tDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fr6BcP+dLTdUkm92P8WziVryr20hXiHyloaJSOciPtI=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=JhsAtWp2c67NUZYPNpGCO2X1aCUrGTueI1F8Gf3WKgsizedVNFAPq73CuRON9APaPG
         MwlM/xmYquDze6kcoEtCJXDlDEvAq/yBPcn4+wJmQcUIJUjGSA1/4KyH1NRGqlFDnvV8
         ZbVAhz1CCVLKRL9Ss+5A+U3QT63LA/ocq4zC8koUk+F2H/QeKB8wtMmWvkrjsMBWIueZ
         xRxMQU40zmY/zgqwPc9dbM1SMRJFxjdwyTxTzS76hyNhK3InY1PUMMhJHQrVKFQDEyoe
         /22bpnygGNSrT7sh2MniMYKX+zTv17x299WmZm27IBcF6wgDpEK4CTpw11g7NLVrgy8Y
         GkcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788360140; x=1788964940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fr6BcP+dLTdUkm92P8WziVryr20hXiHyloaJSOciPtI=;
        b=fFOYC88jVyhg+TiBXdsieGVgj8sgujqwwFNhRhw1KcRUdK4aMVUKhRSlcU0P0zpAsE
         2+nqsNcitAP/8tUue3mJgvsFArI+l5rUYn9A6z5DEDU7/52wr/HrIWn63Vc29kSf97KF
         byJBseRebMx3Xl1FlaUY134m1pRKGI5EZYwMwmgCKIZEvMrAfaXSLx9IkrSoZrXqEXFq
         vILt3xB5t52E4kDXiujtCWBsjk/nFmzVe+Z9GM/J46p6f5cvgdrtAvhLs7+xBOQlwVRM
         Kf7yPIh3+/G5SrMCR84lbWv9uI2SwRFvypK/0qevMtNgKf7skKo1SW+tEcoQGvhWVvCg
         banA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788360140; x=1788964940;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fr6BcP+dLTdUkm92P8WziVryr20hXiHyloaJSOciPtI=;
        b=rwx161THMb5vuL3EC6253Sus0KgAiHh/jeFS+xqGcrcaDfjBBmj6oD/PHco3n94BZi
         fapc1ou9aslMrS0pc2Bfcwy5c0Uf5dkExbXgEB1Ul3DKB4KBWoRi4ESfiE7UuSyL68yi
         cEUgVFrrzfe5FiU3zhsvjCx4zBeoDkqF47m4pqQVM/2oXZjnmAh0BxPpff/DF01rahYy
         Ys7OKzYc7HOQ90b1N1mS6ZRzubNJ59GFJH2WUKbNM3533wZTEPm/o+F43TNp93JrBlH1
         DzSFu98fJYvweSjeXt9fSyX8rB2ik9ebqRAS+w2itdv2+FUR/tMqcUGvgfDZjEXSIyBo
         wvtQ==
X-Gm-Message-State: AFuF++n0MJC+ylS1UWJSHv9wsO0w+wndDTwAeUPkAduPekrOpKhIe2CC
	v/EoEkfN/oVAzWD5ldN4H1Yb2wOqgc6BF4IIAOqSt4UhmPSB2XGZ6nEPq4uc861gpjf9YVnhjsK
	E/r4vqqdaVprYSrTySmQJg+R5dv1rXgA=
X-Gm-Gg: AYBFou2Tt+MBBxeUt/JZAdwzHUKWASVLRlYInParJpELoaQiaAsWx6PKFxy9CDN5wew
	Iele1q14WSya0S+K8wamgwdJ9B+ZKRP9CjXSUWO5oCYkCTdgh9tmekKY7WBZ9XHQX8+aKAhkXjg
	YYBZ6bH9qwua38enDPyrYSUv2uEnazjPKEXyL4EJoSQ7eT56NSlaqbXkbll7Lqdo8rwBDSv4CwJ
	Py/eHAAiRY+kTU/NGz5aHWFtQfqmCcTMtsv6Truz+A5n5HjFUMN5YQVkKdSv9VRDpVpiKEYBu6e
	bxxJiwHvxprg3mYbvaxs+i+5tC9+nzBxRUEc+Dsiu7dFOkeJy5oiKpvwj0Kkq6SUEZ6Qui+Szvc
	PSxxiYrpWJN9+RzJxmhFML9WQLwfcfxYtzQ==
X-Received: by 2002:a05:6102:5093:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-78a1f38875bmr1791957137.12.1788360139709; Wed, 02 Sep 2026
 07:42:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 07:42:19 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 07:42:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4ig8uco1.fsf@gitster.g>
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
 <20260901-758-introduce-hook-v5-3-35cdc6be3cc1@gmail.com> <xmqq4ig8uco1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Sep 2026 07:42:19 -0700
X-Gm-Features: AcwNN1UYBeb66H4P7HkfroZR_22SBgXzqIIhngnfzkksOLrztj6iHcg6kiz8_c0
Message-ID: <CAOLa=ZTfPq3r3b7EDOSrG0-uSFQGgu-k3agPJgUV9xao8WsQrw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000dbbf8b065a810a96"

--000000000000dbbf8b065a810a96
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We cannot use any of the existing hooks as:
>>
>>   - The pre-receive hook runs too early, as we haven't updated
>>     references at that point yet and we need to have the full view of
>>     all resulting updates (both objects and references).
>>
>>   - The update hook is too inefficient as it runs once per reference,
>>     and we cannot trivially determine the last update.
>>
>>   - The reference-transaction hook cannot be used by us because we care
>>     about the phase where it was committed already. And while the hook
>>     fires in that phase, it does not allow the caller to modify the
>>     result in any capacity.
>
> Here you explain that the reason this is not suited for your use
> case is because it does not allow the caller to modify the result.
> The transaction hook is notified in what phase of the reference
> updates we are in, and what updates are planned or have happened.
> But the hook cannot interfere to change the outcome (except it can
> make the transaction abort as a whole in preparation phases).
>
>>   - The post-receive and post-update hooks cannot be used as they run
>>     too late, at the point where we have already reported success to the
>>     client.
>>
>> Introduce a new 'receive-report' hook. The hook receives the complete
>> pkt-line encoded status report on standard input, after all ref updates
>> have been applied to the repository by execute_commands() but before the
>> report is sent to the client. See linkgit:gitprotocol-pack[5] details on
>> the protocol structure.
>>
>> The hook's stdout fully replaces the report sent to the client.
>> receive-pack fully buffers the hook's stdout before acting on the exit
>> status, so the exit code is known before the client receives anything.
>> This gives two distinct behaviors depending on exit status:
>>
>> - Exit 0: the hook's stdout is used as the report. The hook can
>>   rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
>>   client while receive-pack itself exits cleanly. The client marks
>>   rejected refs as '[remote rejected]' and exits with a non-zero
>>   status if any ref is 'ng'.
>>
>> - Non-zero exit: the hook's stdout is discarded, receive-pack modifies
>>   all references to be rejected with a 'receive-report hook failed'
>>   error.
>
> And the new hook lets you pretend to the other side of the
> connection that ref updates that happened on our side is totally
> different from what actually happened, but ...
>
>> In both cases, any output the hook writes to standard error is
>> forwarded to the client over the sideband channel and appears as
>> 'remote:' lines on the client terminal. Writing to stderr alone does
>> not affect the push outcome.
>>
>> Note that in either failure mode, ref updates already applied by
>> execute_commands() are not rolled back. The hook can cause the client
>> to perceive the push as failed, but cannot undo server-side changes.
>
> ... it still cannot interfere to change the outcome.  What has been
> committed as reference updates have happened and there is no way to
> change it.  So the reason to reject reference-transaction hook seems
> a bit weak.  The explanation I heard so far makes it sound as if it
> is an equally viable, if not even more viable, alternative to teach
> the reference-transaction hook at the commit phase to optionally
> allow rejecting the transaction, instead of adding an entirely
> different hook (note: I am not suggesting it as an alternative; I am
> just saying that the explanation is weak to support this design).
>

Without getting into too much details on our specific implementation at
GitLab, let me state the issue.

The important distinction is that in our setup a success from
`ref_transaction_commit()` is not the final step of a push. Further
operations run afterwards and can still fail, so at the point the
reference-transaction hook is invoked with "committed", the outcome we
need to report is not yet known. There is no phase of that hook at which
it could give us the answer.

Apart from the timing, the hook doesn't work because it has no knowledge
of the push. It cannot express a ref push failure and cannot convey
messages to the client via sideband.

And rejecting at the commit phase would need a post-commit rollback that
none of the backends support, besides changing behaviour for every

> In any case, if the actual ref updates and the reported ref updates
> result can be made different, somebody then needs to step in and
> reconcile the inconsistencies, no?

Naturally, the server is in charge of that, this is similar with the
pre-receive or proc-receive hooks. In that aspects this is very similar
to the proc-receive hook which transfers the responsibility of updating
refs to the owner of the hook.

>
> The way pusher perceives the state of their remote repository they
> just pushed to, which they learn from the output of receive-report
> hook, would have no link to reality when this hook is used on the
> remote side.  This may matter because the "git push" updates its own
> remote-tracking branches to match what the remote says (i.e.,
> pretends as if "git push" was immediately followed by "git fetch" to
> the same remote).
>

For remote tracking, that's exactly the conservative behavior we want
from the hook. When the hook reports 'ng', the client does not update
the reference to a new value, meaning the push did not happen and that
is what we want to convey.

Will reroll with the rationale rewritten along these lines.

--000000000000dbbf8b065a810a96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5f174cd90d7fa46f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWU5ja1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnBKQy93TXZ3eVZuenRQR3lqQzU3NThLelREVElGYgowSGdrUkRwd1NC
Nzd6dkZjSWxoWWsrMGJGeFg3T0NVdEY4cmJkR2NiQjdncWFhSHJPRm5keHZtK3pPVTRJVnNLClp5
MmVEZ0NTdzZReEJjVFVSVlM0VTNCb3VHSTBlMjB1aVliZlR1U1ozYi9FQ1N6ZHJYUkhIcGx2R1ZR
dlZoR3QKZUZPL1hyQmRoek9LNEdmTnNlMFliRUQ2V05GU3ZrUjBSNWJWSzdCZkdXQmJhVEZ6Y3Z4
bUJCc1JwbG1FbVo3MgpUckc0dXdZdFk0cjNaaUdPeE5RUU5uYzIwcFRrODBQbHcwOXFqZlBqcVIv
M01qcWcxd3ZUQ01objZLNDJuSFJMClhaRjBnWGVVWC9FdXdYb2JNWGxINWx2S2c2M3ZaNFdoYkNU
QzVmc1dqMk9zNFU1OUxOTVdoOGJ0R3hEWFJNd2UKajZpVGV2MG1RL3VFYm9iTHNhMkNEMWxuUHZx
TXNBM21aUzlRNjAxeHhnM3JGNUF6Wk5IVlJ2QnJRSTI2N2JqLworRTJzMGVEcjhyRktWbzVYYmZU
WUt5OG1EbnMxZklDZE5RWnFQYVhsREdYOXVudmltUVcycFlraVdPcVR1b0I1ClBhSkFKVHVWQkFW
UmZyRUUrdVlJZ1NYMnBrUC9DMUk1Zmk1L0p4VT0KPVRKVzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dbbf8b065a810a96--
