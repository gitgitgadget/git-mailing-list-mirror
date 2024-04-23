Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5E83CCF
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871842; cv=none; b=j+Dj2Wticb2A/SKIuXME2ANR+UR4s2SsKTeToPGHfQxStWY9bKqZ2C+ovOC83+Hl/WjrRvcy0Jv7EWmKMlOocenhGkoSBV8YNB1ASdC4BoKOxIhng9xMsInjDTFVpm4pBKGnpIOq0xsjVE6J4HFkJH6le7idSoqLlnFJhFhPX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871842; c=relaxed/simple;
	bh=rcFeNJW0r8aRqQbKWHEafZbI0WXXdhHBRyZU3lkGnEs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C237XFItL7dkdRZ68/yO3Z/EHL9jic5vMDmZEM45Kcuxojf0kgISPGz2rTl8oX8q1QQO/PjiV+6YvtY2/jo2vPdE76IoXVfklbxK8b7BO7DZdPlBBLYIH6/p/ho3q0SFVt9KpeQ5vEFrBI1DQ54HXvA+kJNj9l5ONMQVOuusnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXTUnBve; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXTUnBve"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2330f85c2ebso3258236fac.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713871839; x=1714476639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YufjNmhMlYTrm/kmqhhiixvQ0/05bt6x3bWWx7HIqYo=;
        b=gXTUnBveHOig8i5rtLN2yAq7xnv0EheRLZvqpKUSNi3fC7AspBHUFIZuxr8OGtPxg4
         BDpo28x37bjuGAPeVmF6LObeQCUCo4UdxkMd/6khQUEnD0Ua/0iYvfgwRd9ANBsNkW0s
         VNNaercOAxHcQRhwJu3b6jPduHaRScf7q2LAEP6p5mfg9CmuzegSwcyX1DojZOB8zUP7
         vC8r46Vlju9K46SgEvN3yGlYwRT8kv7YTNUHbRdTnY2WQXh4zyT5pctZg//0v8f0f+V6
         /sTLeG0uQ3jdQ4dOB4GaX34A/7jqC9ymEDxIVF45UqbbHbm82ZEO1cYlxecyBiRv+NMM
         tbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871839; x=1714476639;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YufjNmhMlYTrm/kmqhhiixvQ0/05bt6x3bWWx7HIqYo=;
        b=AqgkHpGjoSY8fqaLJv9g5cxP/Y9WiDn6nm9aaGJccflE6QLy1Wj27UXBBTwMCfugKd
         v7v5Vw+Te3/miR1kHsz00RNrxrS2Fu2O0JY31CUK665XwJfTk4gY8mt2v38LyBMWvbL3
         6eTeX8JCyw3tSWMAo+AxbPboxmf7GiBnzV9ptow001pYzv0qUkTT5fTpW19TU6O345oE
         28BohbFj/+/6xYO4U27zwk12srwIZxY8iRxTZO9I1LcBXYMynMpKTcKarrAj330rO6uk
         Lz5vBg1G25eohSaHbXDOFQtSN5UXW4aNeaAQYDgF34rNt3u9Bzsolc8BHZnwWbB8Vt1f
         /Q8w==
X-Forwarded-Encrypted: i=1; AJvYcCWbztFjusadEcB3+7wzJa+Dv+/4CXxo4lNSXK8PNWSVNwi+aUq/hF7/uD2VFFQ4hoW33Ou83OiVaYVsoBipa0ExZxS+
X-Gm-Message-State: AOJu0YzRAaOqeVfx4ETYe8gQySO+JbndHdIJxZJ47TXiYrIqtP08MYLJ
	OQEaafuybHllhDKqDlgSp3BrQrv+oeh7QP8DBLs/3WOIt4YWqe5Nh5ETOcYWytUxCVTzS839w4r
	XLvv81HoL6qaAaECw2uRFXHBzu3I=
X-Google-Smtp-Source: AGHT+IGouS++0Sh7Sn+F7KczEcINj4JbMu3KRrqZXL/2oLql4eZWcSaJPbSqHKxiCHU2TfCVSPvxzoJshF/hsZyBrOs=
X-Received: by 2002:a05:6870:c089:b0:239:3cc:57a with SMTP id
 c9-20020a056870c08900b0023903cc057amr16355666oad.49.1713871839418; Tue, 23
 Apr 2024 04:30:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Apr 2024 07:30:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZidZ8N6WsvgxMcrv@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-7-knayak@gitlab.com> <ZiI8IFdfBHEqr02C@tanuki>
 <CAOLa=ZTA94HModfa40So7Uk7WAG99G+XabvKfOY93RCL6Xac5Q@mail.gmail.com> <ZidZ8N6WsvgxMcrv@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Apr 2024 07:30:36 -0400
Message-ID: <CAOLa=ZSMjhEzSMhb3BnRdOmd_NV9ZaBy6aOE4Sm9_1Y8OCBT2w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] update-ref: add support for symref-update
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000002df4490616c1e223"

--0000000000002df4490616c1e223
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Apr 21, 2024 at 03:00:11PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> [snip]
>> >> +	/*
>> >> +	 * Since the user can also send in an old-oid, we try to parse
>> >> +	 * it as such too.
>> >> +	 */
>> >> +	if (old_ref && read_ref(old_ref, NULL)) {
>> >> +		if (!repo_get_oid(the_repository, old_ref, &old_oid)) {
>> >> +			old_ref = NULL;
>> >> +			have_old = 1;
>> >> +		} else
>> >> +			die("symref-update %s: invalid <old-ref> or <old-oid>", refname);
>> >> +	}
>> >
>> > So we first try to parse it as a ref, and then as an object ID? Wouldn't
>> > it preferable to try it the other way round and first check whether it
>> > is a valid object ID? That would likely be cheaper, even though it may
>> > be premature optimization.
>> >
>> > Patrick
>>
>> I think the issue is `repo_get_oid` would also parse a refname to an
>> OID. Whereas we want to first check and keep refnames and only if it
>> isn't a refname, we'd want to parse it as an OID.
>
> Okay. The question is whether this matches precedence rules that we have
> in other places. Namely, whether a reference name that looks like an
> object ID overrides an object with the same name. Testing it:
>
> ```
> $ rm -rf repo/
> $ git init --ref-format=files repo
> Initialized empty Git repository in /tmp/repo/.git/
> $ cd repo/
> $ git commit --allow-empty --message first
> [main (root-commit) 09293d8] first
> $ git commit --allow-empty --message second
> [main 1588e76] second
>
> $ git update-ref $(git rev-parse HEAD~) HEAD
> $ cat .git/09293d82c434cdc1f7f286cf7b90cf35a6e57c43
> 1588e76ce7ef1ab25ee6f846a7b5d7032f83a69e
>
> $ git rev-parse 09293d82c434cdc1f7f286cf7b90cf35a6e57c43
> warning: refname '09293d82c434cdc1f7f286cf7b90cf35a6e57c43' is ambiguous.
> Git normally never creates a ref that ends with 40 hex characters
> because it will be ignored when you just specify 40-hex. These refs
> may be created by mistake. For example,
>
>   git switch -c $br $(git rev-parse ...)
>
> where "$br" is somehow empty and a 40-hex ref is created. Please
> examine these refs and maybe delete them. Turn this message off by
> running "git config advice.objectNameWarning false"
> 09293d82c434cdc1f7f286cf7b90cf35a6e57c43
> ```
>
> So the object ID has precedence over the reference with the same name.
> Unless I'm mistaken, your proposed order would reverse that, wouldn't
> it?
>

I wasn't talking about a reference being mistaken for a object ID,
rather I was talking about how a reference will be `rev-parse`'d into an
object ID.

So instead if we did something like:

```
if (old_target) {
	if (!repo_get_oid(the_repository, old_target, &old_oid)) {
		old_target = NULL;
		have_old = 1;
	} else if (read_ref(old_target, NULL)) {
	} else {
		die("symref-update %s: invalid <old-target> or <old-oid>", refname);
	}
}
```

The problem is that now:

$ git init repo && cd repo
$ git commit --allow-empty -m"c1"
[master (root-commit) af416de] c1
$ git commit --allow-empty -m"c2"
[master 52e95b2] c2
$ git symbolic-ref refs/heads/symref refs/heads/master
$ git branch b1 master~1
$ git branch b2 master
$ cat .git/refs/heads/symref
ref: refs/heads/master
$ git update-ref --no-deref --stdin
symref-update refs/heads/symref refs/heads/b1 refs/heads/b2
$ cat .git/refs/heads/symref
ref: refs/heads/b1

This shouldn't have worked because symref was pointing to master, but
this did work, because `refs/heads/b2` was rev-parse'd to '52e95b2'
which is also what master is at.

The issue is that we call 'repo_get_oid', which takes in a commitish and
this could even be a reference. But ideally in 'symref' commands we want
to first treat refnames as refnames and not have them parsed as an OID.

Since, I'm not moving to 'refs:<target>' with the existing commands.
This is no longer an issue.

>> Also, why do you say it is cheaper?
>
> Checking whether a string can be parsed as an object ID should be faster
> than having to ask the ref backend whether it knows any reference with
> that name. So it should be fast for `repo_get_oid()` to bail out in case
> the provided string doesn't look like an object ID.
>
> Patrick

Yes. But for a valid refname, the `repo_get_oid()` is querying the
reference backend similar to `read_ref()`. Also `read_ref` also does
initial checks with `check_refname_format` which I think doesn't check
the ref backend.

Thanks

--0000000000002df4490616c1e223
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 814e5a16f2be37ae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zbm05b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXpUQy85MGVubDAwQzBSQUpDV0JoUFhORTczZUpOYwp0YzZIOXYzdThS
TmdScUwvcUx1SFFiQ0ozSGE4R3cyU2lTRUcxaGZQLy94SXhjOGVIK0FuT3JwYW1ZS1Y2eUNXCnR5
dTkxZVc4V3AyaGk3cUIxdTBZM2dDM2hkejlVNUFHUkFubEkvaDV1bmNuUWpyZStHMkxXWDRsbk9I
dmlkNVoKWXltdi9ydkVYVlBheTRSYTZpZUJHbkRZL2Z0SWlqVWFPSGh5MkRQNEJUbjB4dVp5UjBl
K0pGUmtWV0UvWHJwMgp5VW13S2g3TDFicGxBK29sUzZLSjFBeDU2QmJ1QVovRzVmZFM5RjZFeFZo
eWJpYkczWGIzWDlBNW9XWlY4MjFrClFuVDE5RlI2NmdxYlYrM1BWcG10U0daN2UxaVBydm85cm5q
VFZEcGFKSEw2aStXWUJrdUxBSzhiR3dsVW5nS0kKZ240OEY2L29RYUtJR0NsdjBGVHNyT0NLYmRr
SXV6L0Y4bnR6WGdTSkppTi9JZU8yUitMS0lCRHZDQUxrVVpjYgpPQkNlM3c1MFVoZFF3Um1xNlBE
d0VPTFhDcVZvZ1RDUkcxbmViMjlxbjlpRUMrYmN0enB1alV4akFOVVcza2EzCkVsaHBORlV5YkxR
R0ZJUjR1eVMweU5MKzhZczBZOUNxMUpzZTlrYz0KPWNEaHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002df4490616c1e223--
