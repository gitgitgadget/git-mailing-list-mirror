Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F7178387
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401423; cv=none; b=LvljVVnN/RLnkf2lfPSkA0KQ7mLVzJIm+Fw1AI7JHhsmYhb/hIbm7NPB2iqdenZCSHPODaF0rpVwp+Wvb6B4zqVNDK3cW7j15a8MHclFRkmGou4aR3hJq5A2yaS9uJChX0Fb/jQWK4+SHPD432L/aGZTrTsRgKlzT/pGretFxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401423; c=relaxed/simple;
	bh=2s2ixjvxZxPfQU/RXAtD1vMR4iek8Xz/+Umme0luwbI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAnP5KjR0SErU1u6Cuum6KajM9GOBMs9GpsG3eOWZKj4iPO87PW29dOfvZ9cdI4RPtS0BuZLERnszAoDHlkhzHMJ+FTWDXD3V0GeEG6T7P2+Z8N3BWVw12oK7k8uVZLNXQsmP2yTbjLIoBCC/1ApmWvIzPu9GD277DY85aZrLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHCqsmT1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHCqsmT1"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25cc31f3716so2942159fac.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719401420; x=1720006220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7ItmtTra8vNVfxACj2HKeWoKbq5XwAwez5pHwrPLDM=;
        b=hHCqsmT1SP1MOEuJ0CtvdUBwYLKh//Zg27M9rvfvPgVWTMy2uksjXfm7KLgNALBUHS
         H7mnJmtLgEXcxEuZfMSLK9LMtMWjZAyJc5bLWOPQYmXiupJ080kYozwBo+8yi/hSImGh
         7E/3jf+LVnhytOIs3Jzft5cIH1qPClPDjYnf0bP7QL5ujDG+Y8G0o5UO9WQAtiodOYmI
         1Vxy7TqORJgmz9UIdI6e9twgVRDyjqg2vk1+ga+ywOVl1EAGJWCfC+lNdQeua6SRlr1a
         XqCeeNQ/JMSFqVtf4CrwNrvHGV0GTEQDkYQ5RZ+I48llvgFwmzFwXZsU6qimCSA1UVv+
         bNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401420; x=1720006220;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7ItmtTra8vNVfxACj2HKeWoKbq5XwAwez5pHwrPLDM=;
        b=sWV4tfWYm+PmGpexpIcodYGgRtS/4MyChfsb5kdsSS1QMcTfsCB9sxRZJOMfA5pYPU
         7XAdQtWMERGv/GGocHeBhFR1TVObI9p8EGIzNH0VGwE2zNEAZHTfgu458KHC0wszRHBo
         QoINKMR8l+BPPCJuSFHMmd1440qf40CflDWUd4bQnPAovv9cO9cB+XRcGmbYjRI3Jwk0
         pJi1WsUPehOI0Z8p7Rfz+EX1TYcHN+9Xh+SlsOMpEYg4w8MMhAw4TrzLGlJniW/NSNy3
         dnHI+qziNnRWyXCUlQ0mcMtSzqdPhqrKmefvNIdKaTzwdQ+vGqJ58tGewlEcs5VLPmsw
         R7lA==
X-Forwarded-Encrypted: i=1; AJvYcCXgkuxvYjnkSzYEdwassVAfvP03/8RZSR/5tgtTGZiG2jFhmU7vVxNiAdzOvianGLsR1gQcrQw+VwXDriRjH0CAHzHe
X-Gm-Message-State: AOJu0YwOrHP6TAce88K905r5qc8unNZnTN5CtMQdXCWWcPA9xz03A4RH
	GsnKCR9ITscOGz5MIvkJ+00Cf4Wq/Jr3gLyFCvNRTZZnnTin+grVQ3glP4PNURlpQrM70rf6pD5
	Zz/voEmEEi7bIl0ZKEp1JahmmEE782Q9b
X-Google-Smtp-Source: AGHT+IHfaB4gPR/iDX6i+zHK8c9eGikkrLi9uzQZFDVAdnoc8g5Tok0w8WLJUbxnC/qNw2dm1BSbpSXoedVABpPH0JQ=
X-Received: by 2002:a05:6870:972a:b0:254:8c7a:6c97 with SMTP id
 586e51a60fabf-25d06cdd8demr12008892fac.30.1719401420454; Wed, 26 Jun 2024
 04:30:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 07:30:19 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240626065223.28154-1-abhijeet.nkt@gmail.com>
References: <xmqq34p1813n.fsf@gitster.g> <20240626065223.28154-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 07:30:19 -0400
Message-ID: <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
Subject: Re: [PATCH v5] describe: refresh the index when 'broken' flag is used
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000e499b8061bc956a5"

--000000000000e499b8061bc956a5
Content-Type: text/plain; charset="UTF-8"

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> When describe is run with 'dirty' flag, we refresh the index
> to make sure it is in sync with the filesystem before
> determining if the working tree is dirty.  However, this is
> not done for the codepath where the 'broken' flag is used.
>
> This causes `git describe --broken --dirty` to false
> positively report the worktree being dirty if a file has
> different stat info than what is recorded in the index.
> Running `git update-index -q --refresh` to refresh the index
> before running diff-index fixes the problem.
>
> Also add tests to deliberately update stat info of a
> file before running describe to verify it behaves correctly.
>
> Reported-by: Paul Millar <paul.millar@desy.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  builtin/describe.c  | 11 +++++++++++
>  t/t6120-describe.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index e5287eddf2..7cb9d50b36 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
>  	"diff-index", "--quiet", "HEAD", "--", NULL
>  };
>
> +static const char *update_index_args[] = {
> +	"update-index", "--unmerged", "-q", "--refresh", NULL
> +};
> +
>  struct commit_name {
>  	struct hashmap_entry entry;
>  	struct object_id peeled;
> @@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  	if (argc == 0) {
>  		if (broken) {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			strvec_pushv(&cp.args, update_index_args);
> +			cp.git_cmd = 1;
> +			cp.no_stdin = 1;
> +			cp.no_stdout = 1;
> +			if (run_command(&cp))
> +				child_process_clear(&cp);
> +
>  			strvec_pushv(&cp.args, diff_index_args);
>  			cp.git_cmd = 1;
>  			cp.no_stdin = 1;
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index e78315d23d..6c396e7abc 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
>
>  check_describe newer-tag-older-commit~1 --contains unique-file~2
>
> +test_expect_success 'describe --dirty with a file with changed stat' '
> +	git init stat-dirty &&
> +	(
> +		cd stat-dirty &&
> +
> +		echo A >file &&
> +		git add file &&
> +		git commit -m A &&
> +		git tag A -a -m A &&
> +
> +		cat file >file.new &&
> +		mv file.new file &&
> +		git describe --dirty >actual &&
> +		echo "A" >expected &&
> +		test_cmp expected actual &&
> +
> +		cat file >file.new &&
> +		mv file.new file &&
> +		git describe --dirty --broken >actual &&
> +		echo "A" >expected &&
> +		test_cmp expected actual

Not worth a reroll, but you don't have to create file.new twice.

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 6c396e7abc..6c4b20fec7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -683,14 +683,12 @@ test_expect_success 'describe --dirty with a
file with changed stat' '

 		cat file >file.new &&
 		mv file.new file &&
-		git describe --dirty >actual &&
 		echo "A" >expected &&
+
+		git describe --dirty >actual &&
 		test_cmp expected actual &&

-		cat file >file.new &&
-		mv file.new file &&
 		git describe --dirty --broken >actual &&
-		echo "A" >expected &&
 		test_cmp expected actual
 	)
 '

> +	)
> +'
> +
>  test_done
>
> Range-diff against v4:
> 1:  1da5fa48d9 ! 1:  52f590b70f describe: refresh the index when 'broken' flag is used
>     @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
>      +			cp.git_cmd = 1;
>      +			cp.no_stdin = 1;
>      +			cp.no_stdout = 1;
>     -+			run_command(&cp);
>     -+			strvec_clear(&cp.args);
>     ++			if (run_command(&cp))
>     ++				child_process_clear(&cp);
>      +
>       			strvec_pushv(&cp.args, diff_index_args);
>       			cp.git_cmd = 1;
> --
> 2.45.2.606.g9005149a4a.dirty

Other than this, this looks good to me.

Thanks!

--000000000000e499b8061bc956a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bb9e4bf4a41d2fd8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNys4b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUZuREFDay9WK3RuaTlJTFNEai9XRG9OQUdoeGQxVwptRHhnK0lKdStx
aGVqMVdYOWs3bHhRU2srYU1EaGJkVmxSQzl5YVpPU1Nvb2dnZGJlRHd1VmZJeVpHT2Qzc2w0Cm1q
V1hhVm9ONUhVeU9Ia2J0WU1kZ3JmdzYrN0xXRmFIRTJWRmd5eU83bTI1SWRTSng4NXBvbllacFpw
YTk4Ti8KNTNPYXh6c0NBc1gvaDJhSWdCMlNtNUNwQXpGa3NGbUlkcVVleGRWeXg4alB0cUlFU0xr
aVpyR0NDdC9RTHMwSAp0dVFneC9SOFY4VnppS0wyUFRkaVV2STU5VlNPaU9sTU9vNytyWms5R3py
c3dCbUNuSmtUQXlNZDNEWUF0a2N4Cjc3YTNkOC9BYjlBSHFJQUJXenNMZ2VnbFJ3cE1SV1M4cWNW
b05mcTROenJzNXgwM0lHamlXRUk3NkZ0dEJDbzkKcTFPc3pKRUpMNTJncjA2OGsxSjF2TzdoZkJX
RjV4c3NhOVZ3VmVjSU10VkpXVTNVV01OSGM4andJK01WWWxOTQo4QTNQbWF6cEdybUg0VDlKWm9K
cXNaRVZSR1FqU1M1Rmt5aUhremFzckhidHV0Y1BQaHJBZkNOV1kyQWJRN1JzClVIcGYzOHFVaWJM
UmRHM3Z4SGNQb2NMbEdZVU96a3I3Z3lLTFVDMD0KPWkxaDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e499b8061bc956a5--
