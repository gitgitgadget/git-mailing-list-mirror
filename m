Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FC748F
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035333; cv=none; b=dwPZ+zvJtUovvtXq5D0J24eGeOh3xR/x7tzgTiY3G0IKSUhmXMCTcv8I6oYtfBZiYo2Wq4pI8GBg5iXl/8iElA6eKhrgnsjF2WsngpSvjN9iihxR3sFvrO4jBa79JxzT80DxwBIrs7gOv6mbsMhT+o9EqBFVxskrUhepijnG3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035333; c=relaxed/simple;
	bh=Pd/m0tWU+//hStaWp6N7yjdzA9eyL8FsGeKqIvRdp6A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBm4RAgElBmQd9UVeF43kyrVKo5fYw6Vs8S9DIvztJ4i3aZA6jQeriAxULjV0/D84jI7iIHFBQUEDMxFbLDklK6KP0EbtfHlN/LdP9yEfWjJt8+rPdX1Cjyaqu40toIwnSlgVTvrP+ZOiDvpC7DWwSCUvwdKdmGb88zd1h0ylPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4FV1oXd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4FV1oXd"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d094ef02e5so85729785a.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749035330; x=1749640130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+tFMHMFeDWlxYO6BRceXM6A+O55LyVC8YyZrY/s8Oo=;
        b=V4FV1oXdVkb276VpYxGbgNNzbrUhTICyQVOCx2ufA3QDa6uLwJ6WRrRtz8kG7CLyOd
         H+bRIJvzpYy+5vsw3qriSQj9YP9u2zqXxX8fXFvwu1WWNYt96b+aN+WZP0xDopCIxBpH
         z2BuNXQrXZ4j0qYdTiGN+XXWY1Npf8j1HXe66kVchj9sGJ3DGWRlOlXjs6SmhR5sWIph
         vgYykoQB5SJkldU9/HcOpKzliI4lQB/hNqhe8L2kdZUOwsc8FOhQf5Rumo3lJG6d9K/H
         Jijub55U8Crg07Ji81LJeD5ArSUCRUmbVj3CBMY/C0xxKDwmEuMWtuTJfWjlsJzNbVFC
         YF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749035330; x=1749640130;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+tFMHMFeDWlxYO6BRceXM6A+O55LyVC8YyZrY/s8Oo=;
        b=R/T0QAj8m41hX6Yvf5Iw8g+rOfuDzXFi3dVGg/rCs+7CQ4cCHYHkYq80KfXX9GEPlL
         5Zkq/5ZcZa5lPW/xykT/L7r6uuSya1oGcIcXBdFYUyQ0RoewaYl347DhufHJze9Hoq5G
         xC+0jjz80lCcr9ZBTy6PNWPNf1uj3hfnh0fwNIv2NqhfrL4/d2Jm/A6qIBhDO6/h2CTv
         j7VeUW7YRlEIOt9xmxLc111I+r4qGge5FjEyHFFWKdS56EDOJ3Qy4OqSlcoA4H4fqNef
         dUydaxu3UlBJwpky3Br2xGxSqN1sK3iY9Ywd/N3yEvl4GNCfLW6G1Rc6UlTzE02PIqKp
         xEzQ==
X-Gm-Message-State: AOJu0Yz0ItYZ3A2PxP8FxIuGIp0MT1pIBoCLKtRtVuFSwKkw2tnt9j4v
	ySRiSbZ2NMl/lIgV+4bbUZ9px9d0TRtT7P6vkTBLhGfTMLq1AZQFEoxvP4S7yloXg73NXhTQZuM
	OvosknNLytRbzsa0LEe+yI8ukODIy54k8uMR0
X-Gm-Gg: ASbGncsjXIeIz+o891ijZtGrFaI2aKKb/UPIiGiHznarDU0EskOGs8syZnWF1oq/j3M
	Prem1uKzGJy0LhvQIFh2wZYv9Y5b9LOjxajU1bOk1tvRX6vlQnO3dp3OS2eS+1kzHqu4GcD1VJ8
	jG2HLt7N2KDBMr13MwE+iHcIAGXQojfbEd+VnHHTbkrs04XL43gIgE2bTlD+9Dgs+S
X-Google-Smtp-Source: AGHT+IG1neGTcIXGc5LmiNYV8Cm8pgh/3thtG/60vGri/lbfW3dupnzPHC7B2zrVXlJqef95ygDMS+WeWTuyILYF61w=
X-Received: by 2002:ac5:cb43:0:b0:52d:cc6f:81a2 with SMTP id
 71dfb90a1353d-530ba2f667bmr4060913e0c.6.1749035319577; Wed, 04 Jun 2025
 04:08:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Jun 2025 06:08:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Jun 2025 06:08:38 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aD3JsdlRPVi4wjuz@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
 <aD2SPsro694yr60Z@pks.im> <xmqq7c1uuq52.fsf@gitster.g> <aD3JsdlRPVi4wjuz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Jun 2025 06:08:38 -0500
X-Gm-Features: AX0GCFsTpswDNnu_eVEzfE_wdXlHLDL7DzqXswMF0pykUipzJ0LE_LrlZ_0zmfc
Message-ID: <CAOLa=ZQmNNtTCeisdgk3gnqC_YDbWk4+To36bzp1A2-zXompJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] receive-pack: handle reference deletions separately
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000ec9c380636bd04b3"

--000000000000ec9c380636bd04b3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 02, 2025 at 08:20:09AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> >> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> >> index 9e3cfb85cf..7157ced2a6 100644
>> >> --- a/builtin/receive-pack.c
>> >> +++ b/builtin/receive-pack.c
>> >> @@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
>> >>  	for (cmd = commands; cmd; cmd = cmd->next) {
>> >>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>> >>  			continue;
>> >> +		if (only_deletions ^ is_null_oid(&cmd->new_oid))
>> >> +			continue;
>> >>
>> >>  		cmd->error_string = update(cmd, si);
>> >>  	}
>> >
>> > Fancy.
>>
>> Is that a new synonym for "not worth being overly clever to
>> sacrifice readability"?
>
> Yeah. I wasn't quite sure whether I like it or not as it felt a bit too
> clever to me indeed. But I didn't feel strongly about it either, so it
> turned into the above somewhat unhelpful remark.
>

I will make it easier on the eyes in the next version.

>> This may be a comment for [2/3], but a two-call sequence
>>
>> 	doit(only_deletions = yes);
>> 	doit(only_deletions = no);
>>
>> looked somewhat iffy for a first reader, as it hints that the second
>> call would do both non-deletions (i.e. creation and modification)
>> and deletions, which makes readers wonder "so we delete twice and
>> rely on that it is not an error to delete something that does not
>> exist?"
>
> I also wondered whether it wouldn't be nicer to have the loop in
> `doit()` itself. It would require a bit of reindenting though, which is
> why I didn't propose that variant.
>

This is mostly what I was trying to avoid, but perhaps the way to go
anyways. So I'll do the needfull.

>> >> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> >> index 029ef92d58..34eb3a5a07 100755
>> >> --- a/t/t5516-fetch-push.sh
>> >> +++ b/t/t5516-fetch-push.sh
>> >> @@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
>> >>  		EOF
>> >>
>> >>  		cat >update.expect <<-EOF &&
>> >> -		refs/heads/main $orgmain $newmain
>> >>  		refs/heads/next $orgnext $newnext
>> >> +		refs/heads/main $orgmain $newmain
>> >>  		EOF
>> >>
>> >>  		cat >post-receive.expect <<-EOF &&
>> >
>> > Hm, so the ordering does change now as all deletes will now be listed
>> > before the updates. We don't make any guarantees about how these are
>> > sorted, but it makes me a bit uneasy to see this change. Can we avoid
>> > this change in behaviour somehow?
>>
>> Good eyes.
>>
>> I was wondering about the "git push -v" reporting and was happy that
>> the order there follows the order the pushing side listed refs and
>> the reordering on the receiving end would not have any effect.  The
>> hooks on the receiving end can indeed observe this change.
>>
>> They can observe, but can they notice?  If the pusher listed refspec
>> elements for deletions first before creations and modifications on
>> their command line, that would be what the hooks see.  They do not
>> know what the original "push" said so they have nothing to compare
>> and complain.
>>
>> Ahhh, but humans that control the both ends may notice and complain.
>>
>> OK, I think I agree with you that it is worth to at least spend some
>> brain cycles thinking about avoiding the behaviour change.
>
> Hm. The thing I didn't realize is that the changed output order is for
> the "update" hook. I thought it was for the "post-receive" hook, where I
> do expect that ordering may matter as you see the whole picture of all
> refs that have been updated. But for the "update" hook I think it is
> sensible to change the ordering -- after all, the order of updates does
> change a bit now. Furthermore, the "update" hook itself doesn't have the
> complete picture anyway, so it's way less likely that anybody relies on
> the ordering.
>
> Patrick

You're correct. I still think it'd be nice to have the 'update' hook
also be in the same order. But like you said, its okay. I do plan to
take up conflict resolution within transactions eventually, so that
would also fix this. So I'm going to leave this as is for now.

Karthik

--000000000000ec9c380636bd04b3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9051953000f364ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oQUtUUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0psQy80eE9ldDJNM3RNek56ajVlOWR5WGdac3JqSQozVit1YWVFSk5x
NVl0dWxJL1oxN1BhL0JONEVpOEs0YTVicFBCdmVDK2tYS012ejRvQUU5anczaURWQUE4TXBTCkVZ
OU91K0czOFlpWHNIeTlFZjltMEVkQXNoZkwzK2IrZkozSkY1Y1NYUVQ2QTN3b1p5R0J4d0NzcitT
dXRFVVkKakN5QWxwSWZ2WHJXdDMzejNrKzduV2laMm13N25yU2VpVjdFMEpNbjBMVDZCclJGd2ts
VTJJVTJpcmxGZytiNwpqUWtqaWg2OVFjQVM0TFF3a3BSZnVoa2hoV21mSDdZMzhZN3RoK2UxZzF4
MjdoZUJaeE5Jc3oyNWRyWHpXamRhCmp2UEF2Q2dIWnh3bEoyV1ltQXBBV25NaGYyaE4rTUFZeE8y
OUZxenNIbmVnSm5IUEtzMUdTRUhycmpwTzBQQm0KVytxUmZQeW5ZTFJyUlJXYW1zcGtFQ2JMTWo3
a2R3Z3grS1MxTHh4cDd5TFI3Ky9NWGZEcUxKSnY0NUllakhtTwo2N1hjWGFQM1pVSGJxNHArNGMy
N3lqOW1YOWZVT0cyVWhNUXg0Q2xhZm9LSjRsYU9yakdlei9aaSs0MjZ5WDJ0CkVJQVdMbFh6bmJK
TFVJMVdjZkFMZlQybjIyME5HcVVYdCtHMlBmZz0KPVRFYkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec9c380636bd04b3--
