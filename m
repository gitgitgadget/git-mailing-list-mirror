Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793102220;
	b=T9rgDh6J6YfPlmuYgfKG2jTtersedupyz6nUpgI7Y3o6EyGTrJe4yqt/pYtcqH11JqqJ
	 8QwHF+AlWi6qivtUs7Bj2ZPcDHj3hTfMRNm4WcWIyo5l5hO9+kPf6GDm379nBYEMhGEhJ
	 IrJPGEbr3o/SuHJOScbvlQT4B2/c/YUzR3uStuJdgnYiLc5djr41Vz1ni0adE7MSKIVPR
	 MbK4thDNilu6cqp8bsdOL05U51YoxnL/0nUx1KAl/HzXriQE5ToSqUXD03yAms18aKEua
	 lsqUtVW+x1amLzm/qgZksqYmXqkiK3X8PKdZlTF4/zg04wjKTDbBudDJVRc5eFQy9Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=eZiWrNtZNJzA3VDsl7SBj650Zb5zRC9hiK9mMAlcDlU=;
	b=SWxDRiBNKl2DBo7NHMU+WpuTjOXje2TSQyLd33YxASlDzZMsNkautfoCIkWoEGimcDC2
	 C6U5dJuREFW2TJ4cKl0Z2Y+QcySezsICi5WiSZfH9ysRxKyFwFYP0+zijHfeF4ITJSKQF
	 1uHOmlEg7hPHlfP9GQh+fFTSjYqUzmo56egdJ5tZxOTmYLguthPQbDcQfWVOcBAnbf9ou
	 O/00sPqk5lqvJjz8D4y7UHV/f0B8VYmV0F72GtzJnLJsISITx2lU3JGBQYlSe8jCah4d2
	 8N2G8tYZ4d9hgtU+cCKrIpEFmMiYRZ3YPggWsNxdW3WoHf9OEUfyXxob9Vk2UTtiadQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="eP/E++JJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649F606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6649F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eP/E++JJ
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b10ac6ab7bso37496947b3.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793102219; cv=none;
        d=google.com; s=arc-20260327;
        b=IzshrxUw/KwjOv0agYHXEUEDayfHnxR97A6Y1A21XmlbrATgo6VDf6JWWUkoQxTkoW
         v9SsIhsqDZcHtP5CfCTpCq7HFroRtYz9hahTpJhx4kcwmPiPA8R9XGDcU2RctFfqcU1e
         oIIuMdLi2+PQSPbJy8/n1ZGGKabr6txee4qY0FpZ5LpETzv0PfOd7NmQ+lAbVaLnlSPj
         BgLZha5L8QuMgjbhK2EPs6WGKV10oo+1/xT3yDQZ32xoh6OjYB4UbrK3bxv9xAu+Hd+/
         hWCnL59tLJLbmToR/eeURF3CJ9KHHj+LFnA9qa0aaUw1bhN85ZvfyCG+kInv8G8tIAho
         pYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eZiWrNtZNJzA3VDsl7SBj650Zb5zRC9hiK9mMAlcDlU=;
        fh=yh48E+bIdIF5bkOxOqeqFS6MqWS5L1IGeGCToXGaOZs=;
        b=Ckfvb2Bq8FZuZ7mx50UeAArrlas3o9kLBxnia2d605wONFNB8RlaE6bx3YdwbETl37
         scB7/gsqR2/oNK9RmWsgGreKzRRDRUKeYKAvUuw+ltUHUQRjKaia+hyXmdi9uHPIqY70
         V41fNRjkJwQ+iXbUBfWhYZmhm2qTBYkB+ZFlRUW1N6I2qwEybCeSDR9GLE8SUWSOyFbO
         pANQiTmwhM3td3yriB7ZoC28GujkdXhxQP3lPq7g3rU/tg6r7XiGSq87j25gd/2/ihl1
         bcJmoaynutjR7jUnQzGbYT0hJFJuyR5ghDntui+dWY8fa2KHaOp9J35v9Gcn1evK4REx
         w/iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793102219; x=1793707019; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZiWrNtZNJzA3VDsl7SBj650Zb5zRC9hiK9mMAlcDlU=;
        b=eP/E++JJzAPN1vVOr0rDOzIvp5QvsQ2hUtW/SNjGc952cSD6UFLfR69U4BNymf5IKF
         YOkEo4q9vSX5O8v89K9wk3XMWBePhM48ESQxovqYW7U4IVLY0rZP7hwfSQJrCvpP9InN
         VSR3HqeImjdsiquZdmyisGBqmvKy++6hgMfJx24B+WrYn0m9S8//zjBjAwoYIEXd/qiB
         LTZwUm57R3knNAKhViPu75Cx3o69qjrF4OcX2/SMY3Rmn/8zBKFusrqxcR3BtmfLmkuf
         W2LDrwlBqb0Ux4mHXEuQiDl1VRp/nUlY6nIkjI/akvuFrHMfIfO1HKdS5my+0L8P7O2C
         1n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102219; x=1793707019;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZiWrNtZNJzA3VDsl7SBj650Zb5zRC9hiK9mMAlcDlU=;
        b=q5vDj4IWMEYhTRY9F41tGVmXJO3hUS2bBcf3hE0KEcubARO36LipGCf4jm1/ED1TFt
         8fDsucc7vbEaI8ZMwevwzrSCe5suwlspngZCoRqqWn+V6+o2fdSm/u/8CQC7yA/w8Fwl
         McJFfPNBdt7agfUVM0grYkbNMotc2mIAJGLiQTNp9TWX3LBrpQU3ygR1HUa0xiwO4EXQ
         LgM5uCDJo9yeiMeuw5KvbOYXKyvUXzR6S0Tco2zRpAS9VTCpQAw+1z5tIXv6/W6IHHb7
         g38i1dEmDmPy/ZFMPu9c6TZNkUTSBU7K+qgh6wMWzekouPUfS14BZbuSq6x6kwAXmXX/
         mAUg==
X-Gm-Message-State: AFq9FYK2YIbBwyyP13oyAwgpxh0Aq2wkp2fpi/+sd3Jh18Y9Ti+hwJmr
	i/81NRlT0Zhb951pHqWPCNo/5d9LIzreEFQFXkfkgzgkUBY0fctvZ7+EmgtyHcxV5rJ5iHJiFNW
	OMc7s5EY1ASeNGdofUCKNDolTfi+yuw==
X-Gm-Gg: AYBFou2Gcd1B/FnARO32I+7Hjolcmg527NOavGmSqKNUBWvWYDX30+wRZ9vajRLWyKE
	HP9dVchgqWCh61GsYemUME3FRHsHBfHImJiWuF/7b8BIBuZBUtQHmav53aIBoMO72Y/hcXrHwJz
	8s+S3llYqvxtFdAE7zSKEnB4SsFDtuaTi1NH5GGG1CYvKoiSESkT8WV412C1+b3lI7m4ckpsQv1
	00MtB2bAUZRJXDDtyuffSNPSGn+YN9iPvnaNMkxr/EZ0lM7raaTeqNQTn3g7pmd1QwKyuKy8jt7
	8BDIX3Lh1KudfTnrgLskV3FdqoFMBa4gRjF3xsvUedllVUGBWrEMspxfP1lKFX5DIKVGtZkvf4I
	9kKmwQVIiJBybINg94bXhS5rmxDh6q4FSeg==
X-Received: by 2002:a05:690e:4008:b0:679:935e:3543 with SMTP id
 956f58d0204a3-67a4525b8bbmr7431542d50.1.1793102219246; Tue, 27 Oct 2026
 04:56:59 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026132525.45414-1-fiendora5@gmail.com> <xmqqfqxsp3xb.fsf@gitster.g>
In-Reply-To: <xmqqfqxsp3xb.fsf@gitster.g>
From: Fien Dora <fiendora5@gmail.com>
Date: Tue, 27 Oct 2026 12:56:47 +0100
X-Gm-Features: AclHuK-7M4_d1-ws4d-ZIlupypeRBD0qojboufcZ5Xth87NuNm67O4YPUcwt1FU
Message-ID: <CACWAS-U2-riX0ajiaE4VgiQWxmoWcL-d9-arrSASa+dnVxoyEA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] t1402: test --no-allow-onelevel option precedence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thank you for the feedback.

I'll revise the commit message to better explain why check-ref-format
needs these tests, with the rationale highlighting its handcrafted
option-parsing loop and the planned conversion to parse_options(),
then send a v2 patch.

Thank you

On Mon, 26 Oct 2026 at 22:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> Fien Dora <fiendora5@gmail.com> writes:
>
> > Git allows later command-line options to override earlier ones.
> > Added tests to verify that --no-allow-onelevel overrides
> > --allow-onelevel and vice versa.
>
> There are many other commands that take --[no-]foo options and a
> later --no-foo overrides an earlier --foo (and vice versa), and most
> of them do use the parse_options() API.  It probably is not worth
> our brain cycles to add tests to cover all these other commands to
> cover all these options that can be negated in a way similar to this
> patch does for the ones based on parse_options().
>
> What makes check-ref-format somewhat special is that it does not use
> the parse_options() API to handle command line options, and instead
> uses a handcrafted loop to parse them.  Covering the behaviour of
> the command with tests may therefore make a bit more sense than all
> the others.
>
> > This ensures that the expected behavior is preserved if the
> > argument-parsing code changes in the future.
>
> So I would say that we need two changes to the log message:
>
>  * The rationale should highlight why check-ref-format is special
>    and deserves to have this pretty common "no- prefix negates"
>    behaviour tested (i.e., it is a handcrafted parse loop); and
>
>  * We have immediate plan to rewrite the option parsing logic (i.e.,
>    not a vague "if we change it in the fiture").
>
> to sell this change better.
>
> Thanks.
>
> >
> > Signed-off-by: Fien Dora <fiendora5@gmail.com>
> > ---
> >  t/t1402-check-ref-format.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> > index 9dd64662b2..6036df0210 100755
> > --- a/t/t1402-check-ref-format.sh
> > +++ b/t/t1402-check-ref-format.sh
> > @@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
> >  ref='foo'
> >  invalid_ref "$ref"
> >  valid_ref "$ref" --allow-onelevel
> > +invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
> > +valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
> >  invalid_ref "$ref" --refspec-pattern
> >  valid_ref "$ref" '--refspec-pattern --allow-onelevel'
> >  invalid_ref "$ref" --normalize
