Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C965235
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481637; cv=none; b=roJNRLH9eIAuFvtIahGkylN/HqaWLtVb61zsHWdHARm3RbiPXOIi08Ur0+76Acgm5Iet3tm6ZXZdvYFZ0i72YJrZ2lnVQZRGW0HX01PoJuXaiPj5m6TwNUSXFA757Fgv6AbolVMpEM/7eogX9TffrlnhXpR0JfUCsN/o2yG6XRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481637; c=relaxed/simple;
	bh=8CKGrHBi2dNRYUfR63TJsueNH+jSZpauPC6t6ofUX0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZ4qoBFp16imOd1B3GUPwPGbzIqBep+eYViCaSQIc+evNPfGUZD1klAArDo0G3acps0HjuxzaFiC6Sleb/iDov6JtB+oe4aKiMQJVkmAyvGKmEPWhUjYWcmLzZJQ18Aw+mZwnEleG/5IznmbUVYiHLi812FaD3vgWbR6w2EcyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmimDHZK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmimDHZK"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b85d03daso2175986e87.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708481633; x=1709086433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YN4GGVTwscUpzart2kwAUMF9Q7e3OrIGimUH3UAWU=;
        b=WmimDHZKH9UF1fKnVj8NQEU5KlRhQ4yrZY+XEQKg/HLp2AAmjkaaZc+aDWIBV+fu41
         sMV83YaTPM6cgmzAiodEbsvuRwmBxcYIab7wBTqPAQqoawumWns/yt8aJodibVIHfUYc
         oVS2Q57zfwuaNyAD0lKUd4HYBB2qZgcP3beREdn0keccuLRsIl8a6nbc9oonLAcs31kH
         VJ1ICrAEYOTGsRn1plhTa5EXOcXCCPYtEK+hW3fDc6DNPcHLsjWZ46mD+GTQaXcdIgax
         lGznm58pGQb1JHESRh9xvtiJYPIMVZL4T4xaE9/sIkKHAgty49smD5WlUEOdDn2r2ecR
         ln+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481633; x=1709086433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01YN4GGVTwscUpzart2kwAUMF9Q7e3OrIGimUH3UAWU=;
        b=afRN6oSw+K11HlDHYbm9z5VIRYmdSqTMfnNznQUyAM3OPnrwpkpXnAjDlAzAkTUDag
         Q61MK0g3yEExi02QIcI+I1XWBm7Wr+xHjk8lECy7+/TD0njCwg2dU82I6YuNfXEB+BwR
         axW8fJwVPQKvkxcn+F9u0/eey0bm+2gLYmAKwEWLdzAuCKl0bOISR1wRfYmxQvM5E83t
         aO1oSnOLVBff5A76R+PZd783MFHCNLPLSZ6wEyBf++VFNanHJtl72N1VeNzSfgDvRVB5
         tfXWK++9kpRU7QxXgxpb3xNZovPfiUL/sqysr2N24GHHHs4vz2Sdzfth37oaMvw2g1Jg
         TmVw==
X-Gm-Message-State: AOJu0YzX9QfsKtcQHyom3gQHn12Y1Chfz1/oklqo0XjJrJKLz9VPNwyy
	85KgPcTbDX4/eYkosiZmFEcOvJ7+blKpbhfmPjmq5wIqXs2sHwCBb3K/ymD1rDjiTsvlOwWVrEl
	fBo68c/vLhopMYY9XPz4wijkmqVkSREL84hI=
X-Google-Smtp-Source: AGHT+IECa3O+fn42IkuOEcP3o38vcPM26bzWDrjFcTY2DmzCdVP2B/zJ9iUzYw3W51GL+JmYBfINfxmEMJWjqLN8I9k=
X-Received: by 2002:a05:6512:2355:b0:512:888f:b02e with SMTP id
 p21-20020a056512235500b00512888fb02emr5991554lfu.11.1708481633109; Tue, 20
 Feb 2024 18:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF7CYk6dERu7Lb0iKeq7zwtZVVd_bG2FMZReSDeejcu1JGiaFw@mail.gmail.com>
In-Reply-To: <CAF7CYk6dERu7Lb0iKeq7zwtZVVd_bG2FMZReSDeejcu1JGiaFw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 20 Feb 2024 18:12:00 -0800
Message-ID: <CABPp-BG2m3_fyxFL6Hw4o5HhoKVd7_tYchDxCdTaXxdxZke-9g@mail.gmail.com>
Subject: Re: Bug: impure renames may be reported as pure renames
To: =?UTF-8?B?TcOhcmlvIEd1aW1hcsOjZXM=?= <mario.luis.guimaraes@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:58=E2=80=AFPM M=C3=A1rio Guimar=C3=A3es
<mario.luis.guimaraes@gmail.com> wrote:
>
> Hello Git community,
>
> please see the report below of what may be a bug.
>
> Yours sincerely
> M=C3=A1rio Guimar=C3=A3es
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> In the rust-lang/rust repository (I cloned today from GitHub), if we
> run the command
>
>     git diff-tree -r -M a04e649^2 a04e649 --
> tests/ui/issues/issue-83190.rs
> tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
>
> we get this result
>
>     :100644 100644 da931c3edaf6f9de6805e771f2b3b28edd27001f
> 11b659eec97323ea5190dac1771c7ca3241861e7 R100
> tests/ui/issues/issue-83190.rs
> tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
>
> However, the source and destination files of the rename are not 100%
> equal. If we run this other command
>
>     git diff -M a04e649^2 a04e649 -- tests/ui/issues/issue-83190.rs
> tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
>
> we get the following result
>
>     diff --git a/tests/ui/issues/issue-83190.rs
> b/tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
>     similarity index 100%
>     rename from tests/ui/issues/issue-83190.rs
>     rename to tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.r=
s
>     index da931c3edaf..11b659eec97 100644
>     --- a/tests/ui/issues/issue-83190.rs
>     +++ b/tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
>     @@ -1,7 +1,7 @@
>     -// check-pass
>     -
>      // Regression test for issue #83190, triggering an ICE in borrowck.
>
>     +// check-pass
>     +
>      pub trait Any {}
>      impl<T> Any for T {}

Heh, good point.  And more generally, due to how the similarity checks
work (split the file into lines/chunks, hash each to an integer, then
sort the list of integers and compare the list of integers between two
files), whenever you keep all the original lines of a file but permute
their order, you will see a 100% match.

Maybe a simple hack like the below would suffice to fix (untested --
anyone want to test it out for me?):

diff --git a/diff.c b/diff.c
index a2def45644b..6b7b3a8b9af 100644
--- a/diff.c
+++ b/diff.c
@@ -4405,7 +4405,7 @@ static void run_external_diff(const char *pgm,

 static int similarity_index(struct diff_filepair *p)
 {
-       return p->score * 100 / MAX_SCORE;
+       return p->score * 100 / (MAX_SCORE+1);
 }

 static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev=
)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac71..3228a898e0b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -314,7 +314,7 @@ static int find_identical_files(struct hashmap *srcs,
                        break;
        }
        if (best) {
-               record_rename_pair(dst_index, best->index, MAX_SCORE);
+               record_rename_pair(dst_index, best->index, MAX_SCORE+1);
                renames++;
        }
        return renames;

Which is based on the premise that 100% of source lines can match 100%
of destination lines and result in a score of MAX_SCORE, so we
manually set the scoring to MAX_SCORE+1 when we detect exact renames
based on matching hashes and then use that higher value as the divisor
when computing percentages.  (Note that there are several other places
where "MAX_SCORE" is used and which I'm pretty sure we would _not_
want to replace with "MAX_SCORE+1", so if you don't like my patch and
want to redefine MAX_SCORE, then all those other locations would need
to be adjusted instead.)
