Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C8332908
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802873; cv=pass; b=bK8GH6Eczkwjh69MeXipJsMKsdy/YLVHl6XbDbbQMwTnU74a2SMyxRMmHIulvjheMCQJMS65OJOYoY3pVCDxKoNlv2I7QtPbeBTKNsWKoLEizLvBP0mcnoxlFOboSxqs/3GJ3CB2eiRvoFcNalyPL6aZzrgQ4LYkN7voOzgch3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802873; c=relaxed/simple;
	bh=oC6xRM+dCLJqrcSXJvn6qy/4locjn+p73Z6fa4IFdiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=egvvpjlGRNsYwRs8nNGDh0mZkNmdIYHP/dQoXDqyIhG4fHcavXX4KEYnlVVVGMDtVb5Gp8rZI30Yd7m5NeHD8blknG7jc4s+GGATxrKpe3CwbAV9gSoASNck4SRj/dDWj9OQCasFX9Rq8YDYm4mTcGHL3VgP+vVv5jf1Wzi7/aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iVMlfP63; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iVMlfP63"
ARC-Seal: i=1; a=rsa-sha256; t=1762802861; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zt9tzT7qs2StoAhWPNE83GXoPrX8VsjCjdtF7xmmC5SFKFAZj9E3GyDOZHDi3L0nHijfgF1duZoDxNEP9p3sh8Ix7HnRBx+NChrGyBve8U2d8LhUS6y6AUzcoLe9Z/6C5O+TmH6lxiGiUygL0cbCvD9htAqq3W9PiZ7cR76pupo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762802861; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jWeMaMJUjbt7+s5TrRujWE8PU5zOZ7to9mmAN/VcR9M=; 
	b=kADTCuD8VHF2WcORIW64AH3IeoN5oczKJdLZV7CJROgELIc0JRkVjqQaeX+9xKgIUZByYlRJv/31CtF2D0GF0H63crdsr/nFEhsQ9LXfN0WeAFsgY/0gIlJRAeuf3dJRDgVSsIH8wH+GgGMlHB1DmxvdY1xMVr8otfFCyECKm5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762802861;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jWeMaMJUjbt7+s5TrRujWE8PU5zOZ7to9mmAN/VcR9M=;
	b=iVMlfP638tuuXlNWlec9SWb7Na6piF8xwgDWi6UwNLPMiS4b0pdernFnFJyNDGA0
	WSnbMFRHde9b8lN4VmK4ZPmBUvsEGVTOzjg4QEPzGsLMfyO2uHkH9MMJYEM59cQ9LM8
	8n8yk0TSpFiA4NfkY2Lh5NqeSV7/aEqWb5bA2vG0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 176280286002335.7544537223547; Mon, 10 Nov 2025 11:27:40 -0800 (PST)
Date: Tue, 11 Nov 2025 03:27:40 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a6f3cffe1.7bb06d38542332.5515171012908783042@linux.beauty>
In-Reply-To: <xmqqqzucl5xr.fsf@gitster.g>
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-4-me@linux.beauty> <xmqqqzucl5xr.fsf@gitster.g>
Subject: Re: [PATCH v6 3/4] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Junio,

 ---- On Thu, 06 Nov 2025 01:56:00 +0800  Junio C Hamano <gitster@pobox.com=
> wrote ---=20
 > Li Chen <me@linux.beauty> writes:
 >=20
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > Route all trailer insertion through trailer_process() and make
 > > builtin/interpret-trailers just do file I/O before calling into it.
 > > amend_file_with_trailers() now shares the same code path.
 > >
 > > This removes the fork/exec and tempfile juggling, cutting overhead and
 > > simplifying error handling. No functional change. It also
 > > centralizes logic to prepare for follow-up rebase --trailer patch.
 > >
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >  builtin/commit.c             |  2 +-
 > >  builtin/interpret-trailers.c | 46 +++---------------------
 > >  builtin/tag.c                |  3 +-
 > >  trailer.c                    | 68 +++++++++++++++++++++++++++++++----=
-
 > >  trailer.h                    |  5 ++-
 > >  wrapper.c                    | 16 +++++++++
 > >  wrapper.h                    |  6 ++++
 > >  7 files changed, 90 insertions(+), 56 deletions(-)
 > >
 > > diff --git a/builtin/commit.c b/builtin/commit.c
 > > index 0243f17d53..67070d6a54 100644
 > > --- a/builtin/commit.c
 > > +++ b/builtin/commit.c
 > > @@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
 > >          OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]c=
ommit"), N_("use autosquash formatted message to fixup or amend/reword spec=
ified commit")),
 > >          OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("us=
e autosquash formatted message to squash specified commit")),
 > >          OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit=
 is authored by me now (used with -C/-c/--amend)")),
 > > -        OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),=
 N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 > > +        OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_=
("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 >=20
 > What is this change for?
 > As the external interface of the amend_file_with_trailers() helper
 > did not change in this patch, this cannot be a change that is
 > required to "remove fork/exec and tempfile juggling". =20
 >=20
 > Or did amend_file_with_trailers() changed behaviour without changing
 > its function signature?  If so, this patch does too many things in a
 > single step, I am afraid.

it allows remove the use of skip_prefix in amend_file_with_trailers, and I =
would add seperate
patches to make this clearer.

 > Perhaps split this step further into multiple patches.
 >=20
 >  - update the internal implementation of amend_file_with_trailers()
 >    to avoid having to fork/exec an external process, but *without*
 >    changing its external interface at all.  This step should not have
 >    to touch builtin/commit.c and builtin/tag.c at all.
 >=20
 >  - if the strvec styled after passthru-argv is cumbersome to handle,
 >    perform the interface change, such as change from passthru-argv
 >    to bare strvec, as a separate step.
 >=20
 > There might need another preparatory step to clean up the
 > interpret-trailers.c itself before the above two (or there may not
 > be---I haven't thought it through).

Thanks, I would split into multiple patches in next version.

 >=20
 > > diff --git a/wrapper.c b/wrapper.c
 > > index 3d507d4204..1f12dbb2fa 100644
 > > --- a/wrapper.c
 > > +++ b/wrapper.c
 > > @@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char =
*buf, size_t len)
 > > ...
 > > +int write_file_buf_gently(const char *path, const char *buf, size_t l=
en)
 >=20
 > I do not think this new helper is warranted.  You only call it from
 > one place anyway.

ok, I would remove write_file_buf_gently and do it in-place.

Regards,

Li=E2=80=8B

