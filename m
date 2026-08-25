Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2830C16A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696092; cv=pass; b=qsfUtWEcOMJyBsTCuLtcWgNonErct4VLAbHxw99Gak5ooPIdPp0PMONyhpC1mWVLyMEIbIKn0QYLz8/Bc0mFwkaGJJkSz+6OuVdv5YU5GPtjMyym83BwO/BFZxJ+LxDqZcDuowx4Gr9n8k3VqH4sMLyxsyOO8Bk4zhf/BT58ots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696092; c=relaxed/simple;
	bh=c8tqax6QiImIpdGZcumB+n+z4XaMMozYEHfOj1v0YY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grhXBgKGTZpzHVC8Kbjw1MESVfT8gjc1KaxPI1KoVOoNob36UaLzbd83beUK+Cr+Tz8wUr/5sbLo+gr1KP/fnGaBkadBA8DWRb5znT3ZdddPX8bu36rdU2DaCas9dNcaTagpLEYMo8KzVxa5gd+4v4wZzMloSBHUxWjRsqYZRo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klo+E1c8; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klo+E1c8"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab70b882c5so319927b6e.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787696090; cv=none;
        d=google.com; s=arc-20260327;
        b=PBt8fk+f791E3KndcbqmbHYYNFDWc/beRzmlaOLAvf+sUaojFazrbutYsigEEtzwSZ
         564u1+Rl+oEPELkykUw979WvpWNMVRgKvpRUkbf8c8aMHqdrijUUh0Lhc5gtWhq/WDI0
         2gJa4RhJc4qE/f7MNibQMsFdj8a3K3IPaIfFRjjmuUFeZL3v8fFnGZc/kWOo1Mkrvyna
         IbpKFLwCeMoaCq1nLclKrgNlVgj1Fxw7hmEl8nS05KGt5j7jvu4s4DeUea4osKjVYFMO
         LtFSxad/cTwsv4vUUgqjVwMTXT7Kje5ac0bOhYROoos7C8GxlJjQlN/Q+PA5js0ZnVna
         qJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mOLdPOWiJR8OoJwOaJFzXx59jq3ZXhglondlZVPNg2A=;
        fh=8kE2VkWfDdS5fLCIXYYt7RvkWfuys8Lc4lEVxWzzsJQ=;
        b=N0Jotlc8o1Hj/AF/EvWZRz2rrK0vXs1qOsa+RzPPODZyRvDEAssWldkNE5P5U18RaA
         X2wSs9ILTHFYIz2eoMPRBPKnn2Y0N+KoasKl6UwzJxb+lYDF36gWQDCBpLEjL+OzeYxY
         UO9LzwQ3vdQ/+DvPdbajBPbfY8G7KIO2ZJd1IAw2eWcc/2eGSlmh4EOagHJJmxfF7cHN
         BMaaLuJG+Yu40Slvx02OYMC7tSkQanIlOGq8rrHF1NqAFtn3OV3vh5v/AZib7MPxaWNG
         iOU1BMNtcmamZcqQr+IXGnVDauhWv1WUf4hlIDHTl4UaNy4agR3I9dBTxwsb8MiqEaYj
         ajLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787696090; x=1788300890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mOLdPOWiJR8OoJwOaJFzXx59jq3ZXhglondlZVPNg2A=;
        b=Klo+E1c8JhAxF45MPlMLnFcjAewr2AYRskFnrznOBtlOT+Dezuoa5DqalDWTwRTd72
         KjWKFXFIv7b9Agh32F2mqIV1ZQ9fhHKSdsQJJwcQ8R4uzF6uJFt6uQNZL9jspXvdCj8b
         +Jg66GdvqNqgnJoTb6QC9A/s4djf1wb/QLdagq7bEp/DFl53xIA8LFUaXQGGOU8rDNSJ
         dwI3APMyn900E9psZIPtzZ8onNWMk8DHqmcsm8JzrWxK3Y7ieJ11tssry8VTxF603Nhz
         kOL36fhkHk//aYaMMDTRLzZ+ijlUCCoCWLQBzjTubXZmSVd97R3NiEoOAcYdG7VhL2ib
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696090; x=1788300890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOLdPOWiJR8OoJwOaJFzXx59jq3ZXhglondlZVPNg2A=;
        b=My6LpmWIRHNbd3q1tBOz5EmDhU/WP3F7wdshUkAYpjgHSRO4WAtbquZHkwq67Q5TWL
         H9gbA9HL1xYRoC3yVjFtPMeJTm2T8mv0y7zdpdnRoWZoPrYu9gm60FOBZx8Ha5kn1L5P
         2TGO3fBuX3eqDXuPyIvoLnqD912YMdfaQvAYJm2EAO6ucdtpN2vSQLGb6lWSSMUAOt15
         skyzpSL3+NyoUMHhmYEx8gXcIy0hscD/BNkInZwZhqFI189sg+gt9A0j8120Pb/TIA0/
         pbeIGGN/o0p20lbdEXMU5lRtKnLRk2nwao2CYSgbkSKraZxZPOs5moTtYsGrLCpNXHo2
         /LDA==
X-Gm-Message-State: AFuF++n6q4B2VOXQWsIWExtRBMVJETGEhMEjH2WrFnDkJnj6jgVCKVK8
	hqes4PkI2fU09HsPgdRb00i7xXg7gCcq+hBUBvAFNaqE19gFPT71WiruxaR2VQYMXhoI2pkLIxz
	NmW44K4u4RBFKYYrbOxl1NVC8H+d7Eoo=
X-Gm-Gg: AR+sD116DYq+OU624Ambk4N0C3AdxhNO7lKyLipPqkGG9aYykXm0FUAMVpLNg/fjTdf
	qznnYCP7DRbSAdfdwyw3c2iGg2tliEDLWXHB/kY4RDZ8rDJtIFYvLTRHmbLJJgIT0tx1mt8283B
	u6G5/PLmkjnmTq5joFJDw5+YvWbIeUVQjzm4neKFzrx46VZ3qxZIaSVKFjCqJjlg54ZIS3w4BrY
	0UUrftLhotttQyKCo13ux37u6s2p32XkPHkW0TgkVLLFWlwl2j3s0BdgTVO+57gOw7RnX/ZC+e+
	6u4m2aCxXJ4M1AeC1fZIpIofEtKd6iniwB8k/suS6B2BJTGvSAmUkjdbecih6RM4UTzRcilR3j1
	zdQtx/p3eBjVK3rV09HpEdUglP2skVdja8sTN9PQcrMtiBLSRpOLDKqJteFSO
X-Received: by 2002:a05:6808:c195:b0:4b2:98a3:a567 with SMTP id
 5614622812f47-4b3666a9fbamr3197360b6e.4.1787696089800; Tue, 25 Aug 2026
 15:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com> <ec447a6a778a5c49344346df54b434a96c792082.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <ec447a6a778a5c49344346df54b434a96c792082.1787684181.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 15:14:37 -0700
X-Gm-Features: AcwNN1WRigpy4RZKBGywQoGUUbaMtgW3ZzruiCok9OYu1_Usty2m6Z2XBEk-alk
Message-ID: <CABPp-BH1TeDTeqddZw+cvzou+3PRgw+HNpYF2JnhMTSBp9qfbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] trace2: remove use of xstrdup()
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:58=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> For full defense in depth, we remove the xstrdup() calls from
> trace2/tr2_sysenv.c.
>
> First, in tr2_sysenv_cb(), we need to handle a failed assignment of the
> value with a negative return to halt the config parsing loop.
>
[...]
> --- a/trace2/tr2_sysenv.c
> +++ b/trace2/tr2_sysenv.c
> @@ -74,7 +74,9 @@ static int tr2_sysenv_cb(const char *key, const char *v=
alue,
>                         if (!value)
>                                 return config_error_nonbool(key);
>                         free(tr2_sysenv_settings[k].value);
> -                       tr2_sysenv_settings[k].value =3D xstrdup(value);
> +                       tr2_sysenv_settings[k].value =3D strdup(value);
> +                       if (!tr2_sysenv_settings[k].value)
> +                               return -1;

I'm not sure if this matters, but I think the call sequence from
config.c to this function is:

  read_very_early_config ->
    config_with_options ->
      git_config_from_file_with_options ->
        do_config_from_file ->
          do_config_from ->
            git_parse_source ->
              get_value ->
                git_config_include ->
                  tr2_sysenv_cb

and the -1 unwinds back to git_parse_source, which breaks, formats an
error message, and calls die:

   error_msg =3D xstrfmt(_("bad config line %d in file %s")...)
   die("%s", error_msg)

Am I reading this right?  If so, the -1 actually triggers a die as
well -- unless the allocation in xstrfmt manages to kill it first.
This isn't a regression (the old xstrdup() also died) and the die
isn't inside the trace functions, but the commit message might read as
promising more than it delivers.
