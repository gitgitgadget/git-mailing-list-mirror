Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECDE1F42D
	for <e@80x24.org>; Thu, 19 Apr 2018 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeDSIcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:32:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33004 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeDSIcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:32:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73-v6so11657500wrb.0
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cTdJAdG43HZxMFkVC0V/t7N7ddpWlul+dAxe912oK94=;
        b=n54cjEAcKvRmqzjYKlX1fXvNHdRTJbXx0grxNFEqrwB5nbJXbfKpIdBaa2LjPNk7DN
         Hx+uemRLKU3GjzDpGs2GscHOYskfEAFJiMH95QJWuIzGX67NXeD5Gh9G6hWHVvEpoTIm
         9c7/z+UussTUEoT1128015PibavtUpxyjmM/etctAkGBolcixOS9RBRIzawlFUmHItJ+
         WqZ2cM7qlWmJfCiQnHWmD4d4J5+swKk53cbrY7tmHJhzCfpTXLl8aV3eybUIuNWef6c6
         ylYrV+UG0QYu8sWR5dIgXe8JqoWiKR5ubsnglTLWQqDcGq9WpqVm1eec0DsY55mf8FOz
         LpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=cTdJAdG43HZxMFkVC0V/t7N7ddpWlul+dAxe912oK94=;
        b=OpFOo44rgSobj2mBqj+u5lfjq9tUGmsMvfxQl4TG5AFhyHz3VmualUs2Mw/Ti2yCnn
         HApJrybnqVRT9kWYU9wZhu209HieOC2Gv7y6I3Fs7T+cF1XMwQiVuocwvetzVeZgUrp/
         GU9gTGQvDP4eJjHrwCnPacGwXDUoaYEXi5XRcWVMqVibxg5GLkxambohmDkXm/A1fAwk
         2FPlBlhzmdXRaZHUrP4viDB3++7BVgZ84fh5KYuxIZDJQVS3LUF4SMwi/WrNX1iygC1P
         Djgz8IpKjvVT7YqTtK4LQ5ms3vI5PJpkAtK3XFfW9jbHshaSFphfbi2CGLQbNMoiTgfF
         PqdQ==
X-Gm-Message-State: ALQs6tCZDcaOzxfa0MiAhEDcbueHVmekGNfEJTrsS8DxJaudYaxZt2ya
        ZnD9JlFRhSNVVQHejl9rImY=
X-Google-Smtp-Source: AIpwx4+u6M57gxI+glUd6mYX3XgHuM4jEIet9oXDE6JvshaKPWOnWGufdZzrAJSAuQ1OBt7h1430iQ==
X-Received: by 10.28.161.4 with SMTP id k4mr3958723wme.106.1524126728379;
        Thu, 19 Apr 2018 01:32:08 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id g75sm4407964wmc.47.2018.04.19.01.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 01:32:06 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 7/9] commit: add short-circuit to paint_down_to_common()
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-8-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 10:32:05 +0200
In-Reply-To: <20180417170001.138464-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:32 +0000")
Message-ID: <86sh7rfvga.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct co=
mmit *one, int n, struct co
>  			return NULL;
>  	}
>=20=20
> -	list =3D paint_down_to_common(one, n, twos);
> +	list =3D paint_down_to_common(one, n, twos, 0);
>=20=20
>  	while (list) {
>  		struct commit *commit =3D pop_commit(&list);
> @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, in=
t cnt)
>  			filled_index[filled] =3D j;
>  			work[filled++] =3D array[j];
>  		}
> -		common =3D paint_down_to_common(array[i], filled, work);
> +		common =3D paint_down_to_common(array[i], filled, work, 0);
>  		if (array[i]->object.flags & PARENT2)
>  			redundant[i] =3D 1;
>  		for (j =3D 0; j < filled; j++)

Wouldn't it be better and more readable to create a symbolic name for
this 0, for example:

  -	list =3D paint_down_to_common(one, n, twos);
  +	list =3D paint_down_to_common(one, n, twos, GENERATION_NO_CUTOFF);

Best,
--=20
Jakub Nar=C4=99bski
