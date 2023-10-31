Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F141DFDC
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMy6BJvR"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BAA6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:11:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso83560011fa.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775912; x=1699380712; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSmzn/mZI77d0Qe4P+tgBrXgFYtDEO/R1DSr5bFGv/Q=;
        b=CMy6BJvR50vBtEoj4CyuisaA4qwwEphvIG9coKXg6+s8TlRN1hbhcNNHZomgQ1DeED
         j9IgjNIfzd50UTeV2CZsoSSAFu5wsgP4/LscqWLfp8TyHcNtmgwuTY6VU1SWQ8ok9kS2
         xMGfqNyoCg7hpNeadg8xz16Pm72rDgO2/jn5sbxk2+a2YetWxyFVEU6E29vXJYvKrX0g
         0BFztOdgX7hUFt50d9P4K6eorW/0AxuHaUDhDaLQypTxuse9tl4K+CoPDaIhp7jOpY43
         ik38lgpl6Zt5RkRDNgHEm2dboEhuT7oACYfnlYkbFATH4LqHhLgBijrK2vwHc1l4rUIY
         TogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775912; x=1699380712;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSmzn/mZI77d0Qe4P+tgBrXgFYtDEO/R1DSr5bFGv/Q=;
        b=VZEWpe+c184b4cX9YqN67CubiK0h61mzJV1XniUYwW0W/dlOkwTJF+kuz6gZBQk53X
         BWGWuxjFTfNMove2jVYPCA5L9K6cAf7WiXDOlMh1cpuHBx31uwWT0uhHT3u+kHlX8Md0
         dPj/22B1pQ9MsXJyxQON7meJ6x62vTWm3yMUC6rFywZbC1a52ql6xuERF8Jlc4qNhE7Q
         2Pfr/wKv0aCZQ1grKClRMrf/sDKXDi68OsprMkuyVBRy2jraKo+67c8gSAMMchFwzGIa
         UssBl8qQ8Awalzjmib0Ujqk/wiylr+RWljIaWtdiAHHbgqN3x6QigMMoAzGVIyjAUMEi
         jr9A==
X-Gm-Message-State: AOJu0Yxv1QCOb6X8kPSTvKFCCF300xQnP6C41M1WFPNpxC3mrfQDTOzK
	45r6Uy5WSYrlA+ivH4Fng+uR8SZ5OnnlkkcSLb3u7+MP
X-Google-Smtp-Source: AGHT+IHBZI2EAF97OhGz7mfDr+TQf2wSeuN3ihZHv4NPlHLC2Qzk0XRr2/987GJOkaKEeJByXZmnXkM0OEgeyWlltBg=
X-Received: by 2002:a2e:a68a:0:b0:2bf:af49:daf7 with SMTP id
 q10-20020a2ea68a000000b002bfaf49daf7mr10015268lje.42.1698775911906; Tue, 31
 Oct 2023 11:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOh4nmk2KZBTuW9qn_ZgDY3yLRZ6NgGOWuBMLRRm1sU=pdmRoQ@mail.gmail.com>
In-Reply-To: <CAOh4nmk2KZBTuW9qn_ZgDY3yLRZ6NgGOWuBMLRRm1sU=pdmRoQ@mail.gmail.com>
From: Jeremy Hetzler <jeremyhetzler@gmail.com>
Date: Tue, 31 Oct 2023 14:11:23 -0400
Message-ID: <CAOh4nmm9fTm8fa=1Hyi8t3R-VMnf30-0xe0vcst57dvY-FrL+w@mail.gmail.com>
Subject: [bug] 2.39.0: error in help for ls-remote
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

All,

The short help for ls-remote advertises that '-h' is short for '--heads':

> usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>                      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
>                      [--symref] [<repository> [<refs>...]]
>
>
>     -q, --quiet           do not print remote URL
>     --upload-pack <exec>  path of git-upload-pack on the remote host
>     -t, --tags            limit to tags
>     -h, --heads           limit to heads
>     --refs                do not show peeled tags
>     --get-url             take url.<base>.insteadOf into account
>     --sort <key>          field name to sort on
>     --exit-code           exit with exit code 2 if no matching refs are found
>     --symref              show underlying ref in addition to the object pointed by it
>     -o, --server-option <server-specific>
>                           option to transmit

However, 'git ls-remote -h' instead prints the help. So perhaps the
help message should be revised.

git version 2.39.0

Thanks,
Jeremy
