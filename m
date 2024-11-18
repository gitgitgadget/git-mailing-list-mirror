Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3B22F19
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947317; cv=none; b=fp5xTDyYmjnYhs6illoqd8pfQ4suvyHjvhvPlSPeqcmKfSmT6/+95bhB4Q43DvFxdMJRNqIOyEoeG2Vb9aro3KNP2Km+/zkNrq6+Eu7S5eX2yFdpQSutn7KaYSvJN/E0yUL94dvO4oL3Ded9SCqq7c/QFQY56EcEi7Kjy99nW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947317; c=relaxed/simple;
	bh=qDXJe3kXQjXbaNUoNUSvIFJkyRtFR3khgHsWJt6SrLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYpo5BYdFLJ041Ic932GB3ndirXjlnNwfTDoP1PSrMOyQjd4c2E05oyFOUebXum7AP6n2PiikcuzcMbOFOtNRHDaOt5nv7gJZPGxGYdU6+zzMGheaFdV2iEzBljSuvnkkss139LqcgMWi4Tc+IWwoqq1XxwV8VaGoJgvuJ1XZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKYAV90y; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKYAV90y"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ee676b4e20so48947b3.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947315; x=1732552115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q3WT7I60KKGuvTB1hDAxTBTbflmWqH6+ZaP1zh6nio=;
        b=dKYAV90yoaw+5QVIoHLvtCt36/z9zhl4+Wg8KxHXP7Mg3dGOWI563iKMXLtWCAKgB1
         Dj42C82Ug+5FtIcn/0AHWZNXWiqlKFx8wE66JlgTTdr8R26nxohVuOGhiUyxFD6P82Ll
         i32uCynNr+M2Y9GsXwLRPXkuO06ZdcyLk4/wx7v6Hwsj+RJccDG88kvVoXM9LwVG7z4Q
         F9tS30NzqLBj1Fth/WyvrkUKjqLoN8b2RFaMamlp6reXzo0heJFHFVCVn3/osemCAXf3
         g+3vmdc1nKM3liBI6dtbic14/lYIVST6/rl2BQQJoANQhv2ogn7I+2f4M5zA/YKuqf3Q
         pT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947315; x=1732552115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q3WT7I60KKGuvTB1hDAxTBTbflmWqH6+ZaP1zh6nio=;
        b=XP6r7z++XwczSPo+JQrv7877huzlEo4Bi+YWrEDaXjYOL9OI/MgqNCFUkgNtRAULCl
         HPmtFZ8jrut+xdLQVQ4bYQmF2n3xq9JRcTOAN5Kehf0hoi+gojY5e1WqigKtN4TFBolY
         5hkr/OzqqT0u7xG97xfVAyFyWScLC8qDQeieeKvoRTJKusC0wPTGvhkE4a7N0eQB5i78
         5LMx3iqJqB/17dOoGeSSPGs68SzB1ynJ92bK8PgLl7ehMKCpVfMKoCGq3dW7gQ/cIazc
         xjlyDoh7cu0387XnUGGLFF2qBR3IiYtS4CrY9PCypYAFV2Oo7dNZVd7shbha+39uRi4e
         rMxQ==
X-Gm-Message-State: AOJu0YzupplDB0cff9TPvGjcH04bOSSc6OolMLmHc8yhugmV8B0kdP5K
	I47BR4SX+z6wu1uEIIqNeQv7HTViz4Hl4sYoUzIKPvg18AANB9QtpTPNyifJwaExrX53A0RyYMb
	IAVzS3MDUF/o9TVFJ9pG9+nxsafE=
X-Google-Smtp-Source: AGHT+IE1UMNzknlLXrUCABuabwb3YpuG2kMtItuRj+dtapTJsR2KQa3/iVyfNh3i0TVavM2SUB+Gv6Sw0u8EHigs12A=
X-Received: by 2002:a05:690c:74c7:b0:6e7:fb87:7097 with SMTP id
 00721157ae682-6ee55bba2dbmr139718307b3.8.1731947314642; Mon, 18 Nov 2024
 08:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com> <xmqq4j4egza6.fsf@gitster.g>
In-Reply-To: <xmqq4j4egza6.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 18 Nov 2024 11:28:23 -0500
Message-ID: <CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 11:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > This is a continuation of Calvin Wan's (calvinwan@google.com)
> > patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object=
-info command at [1].
> >
> > Sometimes it is useful to get information about an object without havin=
g to download
> > it completely. The server logic for retrieving size has already been im=
plemented and merged in
> > "a2ba162cda (object-info: support for retrieving object info, 2021-04-2=
0)"[2].
> > This patch series implement the client option for it.
> >
> > This patch series add the `remote-object-info` command to `cat-file --b=
atch-command`.
> > This command allows the client to make an object-info command request t=
o a server
> > that supports protocol v2. If the server is v2, but does not have
> > object-info capability, the entire object is fetched and the
> > relevant object info is returned.
> >
> > A few questions open for discussions please:
> >
> > 1. In the current implementation, if a user puts `remote-object-info` i=
n protocol v1,
> >    `cat-file --batch-command` will die. Which way do we prefer? "error =
and exit (i.e. die)"
> >    or "warn and wait for new command".
>
> In the primary use case envisioned, would it be a program that is
> driving the "cat-file --batch-command" process?  Can it sensibly
> react to "warn and wait" and throw different commands to achieve
> what it wanted to do with the remote-object-info command?
>
> If the answer is "no", die would be more appropriate.
>

Thank you, sir.

I=E2=80=99m inclined to answer "no."

Our primary use case is to use git cat-file remote-object-info in a
promisor remote setup to retrieve metadata about an object stored in
the promisor remote, without fetching it back to the local repository.
This approach helps conserve disk space. I don=E2=80=99t believe other
commands can achieve this functionality, particularly without
requiring the object to be downloaded.

In the context of GitLab, we can mandate a specific version of Git to
be used alongside GitLab. Therefore, it is acceptable to error out if
the required Git version is not available, as we can ensure
compatibility by enforcing the version requirement.

Also, Mr. Christian Couder provided me with another more concrete example:

For example, consider a partial clone user initially interested in
only the foo/ and bar/ directories. They might execute git clone
--filter=3Dblob:none --no-checkout <url> followed by git sparse-checkout
set foo bar. Later, they decided to estimate how much space would be
required to fetch everything related to the baz/ directory.

The challenge arises because remote-object-info might need to operate
recursively to calculate the total size for all objects related to
baz/. A driver program that drives these recursive operations would
struggle to handle a =E2=80=9Cwarn and wait=E2=80=9D mechanism effectively,=
 as it
would need to issue additional commands dynamically based on the
warning. If the only alternative is to fetch the objects directly, it
would defeat the purpose of using remote-object-info=E2=80=94which is inten=
ded
to provide size information without actually downloading the objects.



> > 2. Right now, only the size is supported. If the batch command format
> >    contains objectsize:disk or deltabase, it will die. The question
> >    is about objecttype. In the current implementation, it will die too.
> >    But dying on objecttype breaks the default format. We have changed t=
he
> >    default format to %(objectname) %(objectsize) when remote-object-inf=
o is used.
> >    Any suggestions on this approach?
>
> Why bend the default format to the shortcoming of the new feature?
> What makes it impossible to learn what type of object it is?  If the
> limitation that makes it impossible cannot be avoided, would it make
> more sense to fall back to the "fetch and locally inspect" just like
> "the other side does not know how to do object-info" case?
>

Thank you.

It is indeed possible to determine the type of an object, and the plan
was to include this functionality in a follow-up patch series to
ensure an iterative development approach. We expect that developers
using this feature will have some experience with Git and will notice
the warnings in the documentation, which caution against relying on
the default format remaining unchanged.

While the =E2=80=9Cfetch and locally inspect=E2=80=9D approach is an option=
, it would
undermines the purpose of the feature, as highlighted by Christian=E2=80=99=
s
partial clone and sparse checkout example. This feature is
specifically designed to provide information without requiring the
objects to be fetched, making such an alternative counterproductive.


> Another thing you did not list, which is related, is where the
> "fetch and locally inspect" fallback fetch the object into.  Would
> we use a quarantine mechanism, so that a mere request for remote
> object info for an object will not contaminate our local object
> store until the next gc realizes that such an object is dangling?
>
> Thanks.

Thank you.

Currently, the fetched object becomes a loose object in the local
object store. We have a bunch of test cases covering it in
t1017-cat-file-remote-object-info.sh to cover it. For example:
'remote-object-info fallback git://: fetch objects to client' '
'remote-object-info fallback file://: fetch objects to client' '
'remote-object-info fallback http://: fetch objects to client' '
where transfer.advertiseobjectinfo is set to false.


I am not sure about adding a quarantine mechanism at this stage:

Pros:
- The quarantine area can be garbage collected, preventing
contamination of the local storage.
- The quarantine area could be utilized to calculate metadata
information, such as in the partial clone and sparse checkout example
mentioned above. Objects in the quarantine can be selectively included
or excluded from such calculations.

Cons:
- Implementing a quarantine mechanism seems like a separate feature.
This patch series already introduces a number of changes, and
including the quarantine mechanism might make it too extensive.

- Based on Mr. Patrick Steinhardt=E2=80=99s comment at [1], since
remote-object-info operates only on protocol v2, adding a quarantine
mechanism may lead to differing client-side behavior depending on the
protocol, which could complicate the feature=E2=80=99s consistency.

In my opinion, the quarantine mechanism appears to have a broader
scope that extends beyond just remote-object-info. If deemed
necessary, it would be more appropriate to address it in its own
dedicated patch series.


[1] https://gitlab.com/gitlab-org/git/-/merge_requests/168#note_2212333586
