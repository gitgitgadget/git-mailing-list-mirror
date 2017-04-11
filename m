Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C26720970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbdDKT3l (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:29:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35883 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbdDKT3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:29:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so2258371wmd.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rhAGRziCNdd+u99xONDyqzM6eqQuwZHgKed8mx6ORnI=;
        b=QgJo4qVU3HAKJ7c266e7NShU2Dl61Wx447egrVhkuDl7NR8LUxqhh2cXJQ1QREbllw
         Cqng0bw66CgfsRwcHP7KEQqmnV8vWck7N/gnOfwFjS5OcUpZkjzuagWB5zkFq8gX3hlt
         zV946sQivLIux/kZhYdzuNd64ZsOfNKMvhw06/HT9BYN5KFrmlOEOGsChkRll/2Ee6aR
         iNw90I+IHvKjqils3o7W9X9bOG/3F0f7uUayuqU0WPiilFCFlVPd+Z3SP3CeikCdEQiy
         t1tKudFuH/2t39tZhQUUOnJ0Ye6nTehmUA8mNc66D6lptyrnaCYhzzNLSmU710vUbh6O
         SoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rhAGRziCNdd+u99xONDyqzM6eqQuwZHgKed8mx6ORnI=;
        b=YK41PjfYkOuvYJBs47jsyLahVRr+UR3u2dKHMmn9cYnZgqW9ndlU/tyTF8qBTFhizz
         bUhjOAfPHiQfPbddQBltlbR/WUC9dfFXaicny2kYPzIz7Nlx79g3gA8SSoZI8XOEDxjS
         3oGv1PgwPITADv921mVDTZ97SbSlL/fg7ZDF9o3zGteGjXMctcOLKHtGlx93BCl813Tu
         Cw7tM3rMSlBmE+ON0sHwVG4HfE6Hz2UzMvy77thxtfbS4VBuWxccqXiESFVnbfK/3zwx
         qvNXUUDWtAyvaqtZqngRkPho9F5LOZc2cZe66PhvHxl0ksRIZI0JgqxMdIG5lQ3G7afy
         +Ttg==
X-Gm-Message-State: AN3rC/4NCGCglMbfGFh2HqFmgpIp0+G0Qv3azdpBEymqaMIUgCAOPro0o9Xi2q3fwz+8VQ==
X-Received: by 10.28.234.144 with SMTP id g16mr11777910wmi.61.1491938978559;
        Tue, 11 Apr 2017 12:29:38 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB53F4.dip0.t-ipconnect.de. [93.219.83.244])
        by smtp.gmail.com with ESMTPSA id 3sm16486436wrv.33.2017.04.11.12.29.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 12:29:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two separate functions
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
Date:   Tue, 11 Apr 2017 21:29:36 +0200
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-4-benpeart@microsoft.com> <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Apr 2017, at 18:16, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Apr 07, 2017 at 08:03:49AM -0400, Ben Peart wrote:
>=20
>> @@ -642,7 +621,41 @@ static struct cmd2process =
*start_multi_file_filter(struct hashmap *hashmap, cons
>> done:
>> 	sigchain_pop(SIGPIPE);
>>=20
>> -	if (err || errno =3D=3D EPIPE) {
>> +	if (err || errno =3D=3D EPIPE)
>> +		err =3D err ? err : errno;
>> +
>> +	return err;
>> +}
>=20
> This isn't a new problem introduced by your patch, but this use of =
errno
> seems funny to me. Specifically:

I introduced these lines, therefore I try to answer :-)


>  1. Do we need to save errno before calling sigchain_pop()? It's =
making
>     syscalls (though admittedly they are unlikely to fail).

What if we add the following right before sigchain_pop() ?

	if (errno =3D=3D EPIPE)
		err =3D -1;


>  2. If err is 0, then nothing failed. Who would have set errno? Aren't
>     we reading whatever cruft happened to be in errno before the
>     function started?

Yeah, looks like you're right:
=
https://www.securecoding.cert.org/confluence/pages/viewpage.action?pageId=3D=
6619179

According to this article we shouldn't even check *only* for errno.=20
At least we should add
	errno =3D 0;
at the beginning of the function, no?

This means we have many areas in Git where we don't handle errno
correctly. E.g. right in convert.c where I stole code from:
=
https://github.com/git/git/commit/0c4dd67a048b39470b9b95912e4912fecc405a85=
#diff-7949b716ab0a83e8c422a0d6336f19d6R361

Should that be addressed?

- Lars=
