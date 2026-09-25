Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E543D891F
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340918; cv=pass; b=sMDjdv+4Y1gitO4WZeyMgtc8G81bZqSe9FxyaKuz3ZWL7GjXVu7zN/4O/Mn8FFxOFVoRkId75nu+8jen8+YZGq+2GleZdBcduFODKJTpO7C0FcdhwqPtZi/e3kzG0NrA9UgrUFYgECowS28n9n/HBH4CCGxW4G/kBnQtOgw+mjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340918; c=relaxed/simple;
	bh=HHNGBd9TLcb5hwbh8Zm/YrhXJdojQ4ETaxV2ogKst1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9lerMsJ2ptAA8DP7ZYBl7oFj6cx3/jETZdQM+FUuJTf7BnnIxvbQe2B5DNbkvSsF3GYH/IRdibLnQPMD+ntM3qTfVHj0ea/hb4bzZuIWUjyS5OMXGyWs6xENXBRAmPwZJipDGL85oEXqtmoX+Q6v9k8AwJHpddRW96H6HxDfI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHCLdwEQ; arc=pass smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHCLdwEQ"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so308556a12.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 05:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340915; cv=none;
        d=google.com; s=arc-20260327;
        b=RZy3JJ5WAJ172agF1BZgcyf1jaKaFfRCCkMeiCfL7R/WidiaddKbRjLb4juXqGHej/
         BIeG+iiSQklHTHye23QiTm/AtwbYKGRK3WL9V8cYNnDQG1aPqoz/3PiC6QJAkWzYY7W/
         UCdE2GrBVT4XR7j7aOxS50TAYFtK5S6JNSzXD4XPwTVsfBUjF3X9pbRIdUUPlyVk69fS
         WgOjA8rZnWrhXw6SUCOtRinPNOi9X1Ixp3NWYd6MTrpPJxBMVGr1Cg88zXk3yR923kXy
         vKX5ff7mffcTmnMEVExA6ywcjCpUkKzQOgSIox+mE5SF4ikJdB0qYuWcr/JDJOluJVcm
         Qc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=18ZDBoP1IJDdqHz+7/LawOUfTNPW4uCk+Y1nmu+pbA8=;
        fh=f01fq+WVgncbxFGCkL4Sg49FsiA+NYBLlF+Uh+09I2s=;
        b=Qa3Ygzm0X575FJy7qHmXLfc9oITESSxkQ7cVpHOvQhIZwJdvzQpcORmuaWRBc4euH9
         IHqYFOXHcX1rd3VADeetuD5BZAvpJKK0koBFP6Z44SIO1Yb1qAqNDQeSv9gxLBKp6Eaw
         LSheBtzWW5nktnjNHX0JVq1Trck965MVOdL3piUOBTlFg47ggx2SOHfeAy5O6PgQtP8N
         QgMRdg241uG5oLpHl8lxCWOlOkzK+12aWoEpbzAPJ/K815RyUqPpTsXlD8kbWfgGzsYZ
         qnSPDjxxBKUK6HpGJ1/dEQwK+GqfoYyS9NIwnbiErYomxX2eJBP6EVJvXpST/kWYU4wP
         Jm7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790340915; x=1790945715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18ZDBoP1IJDdqHz+7/LawOUfTNPW4uCk+Y1nmu+pbA8=;
        b=JHCLdwEQkipySw5M7FFbgnCUr1cNbuQG3QbovLlAcfvgUCKDS91mwf7hG8iQzHFvrg
         HPZ6Vj5jAjal35kdty5HQ6j16VusoQXe70xPx25v7AACxtLi1e1PjS+rNOHQJ4Na5z8R
         SYBTE4gDbrpJd9QCEjPw4L3anuOO5kyKcsUeRMHaJxwgw4M9gFnU59VPFm+KDbTLUhdT
         HLwfn3vTAMqCwAKFOKx6Y+PrQDw8GLqwJXCXTC0RVBYfOz4YsG6AnWnU3cR9XnUXDrZa
         TcxJemd2z7UjWgbGA8vBlU2DsSbd7Z7Uj9WSNDAWW/nmETk7HcL4x+EhhXd7wQqFVdnS
         8lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790340915; x=1790945715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18ZDBoP1IJDdqHz+7/LawOUfTNPW4uCk+Y1nmu+pbA8=;
        b=fKDGGhAdufngVlGZQfdcNNpGtj362CrNwjqyj+AIvZUcniH6Hg3XOZBflhFID5VSBe
         MqYIeGAVL1ZI4PfgCNDCObwMo4Bf36Glpav04FZnAFsKaFo1WLxqI6Ap2Mmkvgpq4ZGH
         GmuBicfnVD52HdWS1CYZThbctPHwos7d936spCwhPSVjpkA1y4f3w22ng3AFTJ8Dl/ZY
         JaTO+c91gTgSUw+oAJr1wmz5wgM68C88YIX6QjAQQEIgnjI69b6R5nVpp/xZchE19gAG
         +82Qc+Sy++isqzukHZwMTQqx6K1vuDd/r3s8oFI1hOYa14ha5yeC3pS3/2SjJdldUZ3s
         mQdw==
X-Gm-Message-State: AFuF++k+YgtYmniP3AHm+j1jyjlAdzQY3zGFdx/3QCE+CeS0RWcXuY2B
	WXd6gEFT05i2g1wNGFKdVRXezX0SvQdDSgWZs3MTaxDDWISy3vkbKQeb9jsVPWACgrvcaQmcFR5
	wQXf/uGiiUWVlphz4zfWK18lRm0YNzZc=
X-Gm-Gg: AYBFou3ZQQMaZenMwA0lhuYDnDujCJdGQnZP3TSwX5SiIPhzQpvB1KMb3bHKxNOAb4G
	GCDxI/HiPiSQQeNILnbq1cDUDVMpwReR4T8h05RBSyvWWiqAOitRo70OigocjtkAVAO39XhDD8q
	cWLMsSKu2LCpivKV0jXmad2OGNtObg/j6vwwjLgU3uCdQ1wjhco4j8vufL0+LFvs8q8hFc4QPeq
	PPORhK9au92mdks25MA0e+JLfl7JBIuM530sAeOMpMCOeumxM8IgkcRwY3j6xIJ6Y1bGVgrVlxB
	9nBp09MzjAZ8jdfuMNfymD8OWiOeWYKnncbY3bfSEySiFn7PbAhCBd9uuMyDWZ0fwjXvNSHLW45
	SJZr4JfQ25CJo0HRBE8tdnLyeZkailwMGmCM++SqBUFQHXzsmm1yKkHXlAnWlInnevOU3rklipp
	gwvhObZIw=
X-Received: by 2002:a17:90b:35d0:b0:39e:6c6a:209e with SMTP id
 98e67ed59e1d1-3a098ac2404mr5080268a91.63.1790340914674; Fri, 25 Sep 2026
 05:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <68e83baa-6ccb-4ca8-a1df-f09d51749c67@gmail.com>
In-Reply-To: <68e83baa-6ccb-4ca8-a1df-f09d51749c67@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 08:55:03 -0400
X-Gm-Features: AclHuK-EAtOhInAvCXAOCCzwtLFxpK_8eAeM4MuSZiWnefHBSZ9tVlKUdsQ3riM
Message-ID: <CALnO6CDpS9GQfONKJs=LAUvwYzYyMby+rGAUtvFQruj-ERXt-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>, 
	Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, Sep 24, 2026 at 5:42=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> I've spotted a memory leak that I missed last time, apart from that this
> looks good.
>
> On 23/09/2026 13:58, D. Ben Knoble wrote:
> > @@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(con=
st char *prefix,
> >                   oideq(&c_tree, &info->i_tree)) {
> >                       has_index =3D 0;
> >               } else {
> > -                     struct strbuf out =3D STRBUF_INIT;
> > +                     struct merge_result result =3D { 0 };
> >
> > -                     if (diff_tree_binary(&out, &info->w_commit)) {
> > -                             strbuf_release(&out);
> > -                             return error(_("could not generate diff %=
s^!."),
> > -                                          oid_to_hex(&info->w_commit))=
;
> > -                     }
> > +                     o.branch1 =3D "Upstream index";
>
> This is the current index, calling it "upstream" is a bit confusing to
> me but that's not worth a re-roll on its own.

Will fix. The "upstream" verbiage comes from the working tree labels.

> > +                     o.branch2 =3D "Stashed index changes";
> > +                     o.ancestor =3D "Stash base";
> >
> > -                     ret =3D apply_cached(&out);
> > -                     strbuf_release(&out);
> > -                     if (ret)
> > +                     o.verbosity =3D 0;
> > +
> > +                     head =3D lookup_tree(o.repo, &c_tree);
> > +                     merge =3D lookup_tree(o.repo, &info->i_tree);
> > +                     merge_base =3D lookup_tree(o.repo, &info->b_tree)=
;
> > +
> > +                     merge_incore_nonrecursive(&o, head, merge, merge_=
base,
> > +                                               &result);
> > +
> > +                     if (!result.clean)
> >                               return error(_("conflicts in index. "
> >                                              "Try without --index."));
>
> Sorry, I missed this last time, but we should finalize the merge before
> returning to ensure the allocations in result are freed.

Yeah, I think CI caught this:
https://github.com/benknoble/git/actions/runs/36033463504/job/107747745741#=
step:5:31

But I'm not sure I could have understood what it was telling me
without your hint, thanks!

--=20
D. Ben Knoble
