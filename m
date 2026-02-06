Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34326A0C7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345530; cv=pass; b=nmBEr6T2c/g970YmVJvh9L+ah/l1hhc+F2U+oD2dPp4LEDcK2IgZhqZPFAIfegsW0WBVUC1QhW0EXeBvQPW8q0xYlLziamuAq7L4kZnvg4vsTC0uhTaiSzZFH6qVeBbsRCOW92qW2S099tQnGnz/kvgkEMjqIGgFkRseiHSPJds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345530; c=relaxed/simple;
	bh=A4XA2GpvZVriDuyGcgda8mWwIcKwUu7BPGZHmbSiKCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJoxar1nve/ageRPNBjl18KgEYfXBur4O5M4Hb0p7Uetj/U0QhCA7lbmSaUSyTP/AovtSfDDyNVwwgkMrOzGgmYOiZ+xPHvn/pFxOLMbOQcp2NU4YmmKBUgD/qt6z3/6GKJFIg9qs/s0SYYlDbzjZ5Wandw/w66b/JIj8noeR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fms+rV7c; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fms+rV7c"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-794d3bba0ccso14494167b3.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 18:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770345529; cv=none;
        d=google.com; s=arc-20240605;
        b=jNcvM6uOZ8B9smSNlINlbdYCY9Ql2YLUPaIA3wIZT/5UCqjwdmL5RRQYek7nGS/C36
         m0Laafb6hIqDZDBV3BOmZzuT13jyeThkE0RUURn20fvHQ9yGR/p/aOOG1lrNOUpC3Pqp
         zfcavkyqLYWi+p1okgDK5EHG2s26KewLofNi9S2S1pAh7IKGTT82XCnT7Covaw5Et+l4
         yi1Fmd/PGfIOPKAGKPpnGAPrJPgPHnatm7FI8UtRVYsOYSAjFy6aihr2YxxiNf9iqbcs
         Gi+rzIvHoOLq+SeaPaXUT3n2CL4lpdwMyzMsdv4elyULlaVsGY0YzzSmzZGJoMID38rP
         aj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xo7uKrhrZaoUEtVIYtw9M/SGHxqY/t9CokkihZl0KZA=;
        fh=m/7UfAVYDenrDJ6TImYck104PYGXAbpZsWw/GNKCBEE=;
        b=Glpf7YvBWpyXt835plTrHVHJBWY+gR3/aLdth+20f2mVqbtVQQ0D81yEd0lkeNwRsj
         hkpO+hOTn5QIdptH7PYvynQ9lHAmobsutUay5JRSpPj3cLG1KiDYh8y3zLvgyM7j5GFi
         wqS2kh3xUuJptSDdn4si1IYQj/28xxhQw3Bz+JF8+ST2Hk5UEj5mlu5Txl+yEvRwuGP1
         1u5JUybSDftcea91+CGJQzUuqDmHL7kWm+rB3GNRmn936F7AvgyPv90Z7NWyVBMEB2gg
         N66LPbN1HI0OAzXhSbdc0aV/1Q+d6RQO8xGqKPcHCYlFrz77Ju0y11A32efoNf78H3FN
         qOsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770345529; x=1770950329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo7uKrhrZaoUEtVIYtw9M/SGHxqY/t9CokkihZl0KZA=;
        b=Fms+rV7chOUZDObcS4z9c3Ub6nq53yS1bLa7noyo+Kt0jVIpahT1PkkdHSmgeYVYS4
         gsHLrz2+3nuItZG+g6m7/+QnQwM6eCs2GgBtcRFk9WnE/Ia4sBLVM0jIJR/2/oaSsOqA
         BlwOOu0alj4C8zst1uW44kdasJkaQr3k4MRp6IwJBk//9A5Pf8N7B5J5JcE0UhdUP9F1
         5zpIloXkbkszU+oZwIL7VD+q7U1GrBL4oDw84NmLw+CcEBSWIB8UBcfAYpxrxbt9NTkS
         aq9g5jYdgqgnEAuOf4nl1GCjFUGxLVolLt0ydSJ0wV4/ehIXHjNuKItDdxxW+LXf1+yX
         9+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770345529; x=1770950329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xo7uKrhrZaoUEtVIYtw9M/SGHxqY/t9CokkihZl0KZA=;
        b=ayq3u1Zd4oa+Loj7ScQrRsQ+L8F9KLjnayX7JpEsEKfDXA+Yx4/aJK98p/HCrC8qYg
         Kf88oQqHwBEGjYe1mxqFkW5SHV6tbBUHqFRHQy31gmgNXHpohV4p5c6BtCmL0yIuy953
         DZal3EDAVKDSrEejdTOzlojyEJLr7KexJ4/Iik/upcgPLF7IfZJ/yBxkVTDupPjf83JW
         BIbY2T0rSm9hHZeS67f+6qXmPckpb2+CwuOSU0nAB9SwRX/f48gFT09zWxe0+J8kv2uW
         uGdQv30E+EYR20iHIzJ+90diQIt5HTG4vDAjcpDxHTzp/WuWbhHTJ7sZOefN5sdQmA5A
         ygLQ==
X-Gm-Message-State: AOJu0Yz2AhyU49/FAyaJYXfh31plCUbdk2Xp83j75DMlB3yq3UER07va
	fUfbPrmGoDpo30Fr2G4a4fxH9BTVM4TpWDTED2urOaDnOpG0xe+hFusdij5OUV9Jn042OD1yRE8
	mQOVEbfUtG85lCRmKqWHfgUf32aGRMRKFhDQ29o4=
X-Gm-Gg: AZuq6aIgjR3Ximne6skYpN6ICMo/aM2upx7BLFs7wM1SfFRNAVThWBYPRyZQKanTxy7
	tEwuUhO5gIp+3iFPhhOGE0vSB0hOWKQJs26knDsW9YB5AeNuS/I6aKB0hpvmqSFkxIbRTyG4Guf
	Zd6//wHob8+41DWePK19gNRIzchxjo0fOL1fJil5HuZqrdKKOYxGJXua+xZlBYoEkkZwwTYPlfp
	q1kJ/0YVsB1mf3/iTvRv6VViY9TfXyOXvq3OUoo+HzJJnvvWNuv0UZW9b5q57vE7mntc2iCiC26
	vmSDtNzS+M+4uSdpgXIrVdobjp/jwOyJ7JjVQykG+SY9ia4BLQwb5YaYr62/lTMsp1YCaKU=
X-Received: by 2002:a05:690c:a92:b0:794:b2be:f488 with SMTP id
 00721157ae682-7952ab397a6mr12389717b3.36.1770345528707; Thu, 05 Feb 2026
 18:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <71bfd9231e339cf43af86cfbffbbdde753d3fb82.1770296405.git.worldhello.net@gmail.com>
 <xmqqfr7fkjx4.fsf@gitster.g>
In-Reply-To: <xmqqfr7fkjx4.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Fri, 6 Feb 2026 10:38:37 +0800
X-Gm-Features: AZwV_QjkmvaQUy2aosi26LW71mFa5w6uO3iqYGVvwcWfy8DYDRSW91yHdlX2_0o
Message-ID: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] l10n: README: document AI assistant guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 4:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Add guidelines for using AI tools as optional assistants in Git
> > localization work, while emphasizing human translators remain in
> > control.
> >
> > Also update `git-po-helper` command examples to include the
> > `--pot-file=3Dbuild` option.
> >
> > Example usage in prompts to AI assistants:
> >
> >   - "Update translations in `po/XX.po` following the guidelines
> >     in @po/README.md"
> >   - "Review all translations in `po/XX.po` following the guidelines
> >     in @po/README.md"
> >
> > Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> > ---
> >  po/README.md | 294 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 291 insertions(+), 3 deletions(-)
> >
> > diff --git a/po/README.md b/po/README.md
> > index ad7f72ba83..6ba082376a 100644
> > --- a/po/README.md
> > +++ b/po/README.md
> > @@ -227,8 +227,8 @@ L10n coordinator will check your contributions usin=
g a helper program
> >  (see "PO helper" section below):
> >
> >  ```shell
> > -git-po-helper check-po po/XX.po
> > -git-po-helper check-commits <rev-list-opts>
> > +git-po-helper check-po --pot-file=3Dbuild po/XX.po
> > +git-po-helper check-commits --pot-file=3Dbuild <rev-list-opts>
> >  ```
> >
> >
> > @@ -430,7 +430,7 @@ There are some conventions that l10n contributors m=
ust follow:
> >    your commit:
> >
> >    ```shell
> > -  git-po-helper check-po <XX.po>
> > +  git-po-helper check-po --pot-file=3Dbuild <XX.po>
> >    ```
> >
> >  - Squash trivial commits to make history clear.
>
> Is everything above specific to using AI assistants to help your
> translation process, or do people who do not (yet) use them also
> benefit from these updated examples?  If the latter, it probably
> should belong to a separate patch.

When git-po-helper is used in GitHub Actions, it cannot build the POT
template from source code because the CI workflow uses a partial clone
of the Git repository with only =E2=80=9Dpo/*.po=E2=80=9C files checked out=
.
Therefore, by default, git-po-helper downloads a prebuilt POT template
file instead of compiling from source. However, building from source
code (--pot-file=3Dbuild) should be the safe and default behavior when
working in a complete source tree. I will update the git-po-helper
code to automatically detect the environment and set the appropriate
default behavior for both scenarios, eliminating the need to document
the --pot-file=3Dbuild option explicitly.

> > +AI tools, if used, serve only to accelerate routine tasks. They do not=
 make
> > +decisions, do not replace human judgment, and do not understand cultur=
al
> > +nuances or community needs.
>
> They may very well do any of the above.  It is your responsibility
> as humans to monitor their decisions, judgement, and understanding,
> and countermand them as needed.

Agreed. I'll adopt your suggested wording.

> > +### Preparing your translation environment for effective AI use
> > +
> > +If you choose to use AI assistance, investing time in preparation will
> > +significantly improve the quality of AI-generated suggestions:
> > +
> > +1. **Maintain a glossary**: Add a "Git glossary for XX translators" se=
ction in
> > +   the header comments of your `po/XX.po` file (before the first `msgi=
d`). List
> > +   key Git terms with their approved translations. AI tools can read a=
nd follow
> > +   this glossary.
>
> A few random sampling of po/XX.po files seems to tell me that this
> is already the case for some languages but no all of them.  Perhaps
> refer translators for other languages an existing example to help
> them start their glossary in their po/XX.po file?

Will do. I'll add: "See `po/zh_CN.po` for an example."

> > +2. **Keep translations up-to-date**: Regularly sync your `po/XX.po` wi=
th
> > +   upstream. AI learns from existing translations. The more complete a=
nd
> > +   consistent your PO file, the better AI suggestions will be.
>
> I am not sure what this means.  When you are working on updating
> translations for your language, you'd want to be working from or
> near the tip anyway, regardless of what tools you would use, no?

Agreed. I'll remove this redundant point.

> > +3. **Document style guidelines**: If your language team has specific f=
ormatting
> > +   or style preferences, document them in your `po/XX.po` header. AI c=
an
> > +   incorporate these guidelines into its output.
>
> If we have an example in po/XY.po that translators to other
> languages can learn from?

I originally kept that point because I wanted to document how to
generate the location-less file format in the PO file header, but it's
now obsolete since I added a repository-level gitattributes file in a
previous commit.

> > +4. **Choose appropriate AI coding tools**: Evaluate and use models and=
 tools
> > +   that work best for your target language. Different AI models have v=
arying
> > +   levels of proficiency across languages. Test multiple tools to find=
 which
> > +   produces the most natural and accurate translations for your langua=
ge.
> > +
> > +
> > +### Technical guidelines for AI tools
> > +
> > +The following sections provide technical specifications for AI tools t=
hat
> > +assist with Git translation. These guidelines ensure AI-generated sugg=
estions
> > +are technically correct and follow Git l10n conventions. Human transla=
tors
> > +should be familiar with these requirements to effectively review AI ou=
tput.
>
> Are the subsections of this section meant to be fed as part of
> prompt to the tools?  Otherwise they look mostly repetitions of what
> human translators already have learned elsewhere in the document.
>
>
> > +#### Scope and context
> > +
> > +- Primary files: `po/XX.po` for translations, `po/git.pot` for the sou=
rce
> > +  template (generated on demand; see "Dynamically generated POT files"=
).
> > +- Source language: English. Target language: derived from the language=
 code in
> > +  the `po/XX.po` filename based on ISO 639 and ISO 3166.
> > +- Glossary: Git l10n teams may add glossary sections (e.g. "Git glossa=
ry for
> > +  Chinese translators") in the header comments of `po/XX.po` immediate=
ly before
> > +  the first `msgid` entry. If a glossary exists, read it and keep term=
inology
> > +  consistent.
>
> This overlaps "Preparing #1"; do you want to cover "Preparing #4" as well=
?

"Preparing #1" tells humans to maintain a glossary; this section tells
AI tools to read and use it (add to the context). Different audiences,
complementary purposes.

> > +#### Quality checklist
> > +
> > +- Accuracy: faithfully conveys the original meaning; no omissions or d=
istortions.
> > +- Terminology: uses correct, consistent terms per glossary or domain s=
tandards.
> > +- Grammar and fluency: grammatically correct and reads naturally.
> > +- Placeholders: preserves variables (e.g. `%s`, `{name}`, `$1`) exactl=
y. If
> > +  reordering is needed for the target language, use positional paramet=
ers as
> > +  described below.
> > +- Plurals and gender: handles plural forms, gender, and agreement corr=
ectly.
> > +- Context fit: suitable for UI space, tone, and usage (e.g. error vs. =
tooltip).
> > +- Cultural appropriateness: avoids offensive or ambiguous content.
> > +- Consistency: matches prior translations of the same source string.
> > +- Technical integrity: do not translate code, paths, commands, brand n=
ames, or
> > +  proper nouns.
> > +- Readability: clear, concise, and user-friendly.
>
> The fact that these are important does not change if you use AI
> tools or not, no?  As I am not sure the purpose of these repeated
> instructions in the "Tech guidelines for AI tools" section, I've
> trimmed most of the contents in it here.

You're right that these standards apply universally. However, the
following sections reference this checklist explicitly (e.g., "Apply
the quality checklist to every translation" in the workflow section,
and "Apply the quality checklist to each message you review" in the
review process). Without defining the checklist here, we'd need to
repeat a shorter version of quality standards in multiple places.

I'll evaluate translation quality with different versions of
"po/README.md" and share some data in v2 to demonstrate whether the
AI-specific guidance adds value.


Best regards,
Jiang Xin
