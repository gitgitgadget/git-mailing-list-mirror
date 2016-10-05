Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488691F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbcJETG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:06:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35838 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbcJETG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:06:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so67079wmg.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0L6F8lvJMpbJQoUHZe5jxQqpcBM1PwRE9VGmgrqGvvI=;
        b=PIpvRmegZs080qC7UIYYXczDsInUa4Xvzbx/z+C2GJaZ0VpFxQMhicCgi0lOeu7Tuo
         chX4ZZQX40yVCbthQ4zyKVaP5PodEy4gWRHNgWdOwrjlFgMyeW985b0J4gYHPogXbAiX
         3266aEJVK8YILu2Ho2XvCnJc/OBZV3p89UJyI4ff7H7gcelB+qwj4w7VoF6D6a24qQsy
         Ak43h/CgtArxuBTAZLwUB4o4/3TxVTSS7NyrsCWKbUL7lOviUR+NSYEqtHlz05c+k4uT
         o8RnGZ8wP2zmDp2aBPY9oDjkT36/DvVh3ewzzWdE9HtTQKd3HldLFy2fPYwrx6XZDxB5
         vQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0L6F8lvJMpbJQoUHZe5jxQqpcBM1PwRE9VGmgrqGvvI=;
        b=WMRpddsNzqHNN/uynEcr7l7W8rCxRjGTRYhTD0FFC+uiL45eu4FGxVzljkGmsGLaVE
         lYBbv97o12jvhH0Zk1XiAnx258qiFyaqG32n9+fIumEnMOB8nkLkR5rw5i77gNWt4Z/O
         4/zMgvPs0relz2XEqAkVXw43gOAIn9qBUktHVFdtfekl7PyX//j/V5PhPy4moqt0kIV/
         VF2Cc5GK91/PP0WZIn073sx6EMDZV2BmYN+vi6TE1rSRgBdusRlI8Tr1bCqhnGIouITs
         vnzuVpzpvmXr05d/wmFVm1Yn/YEaHL1cBbWVYIUE+z3bT0up8Hv2Xaeo47gN+xznsotL
         KbdA==
X-Gm-Message-State: AA6/9RmoW26J/pddOG7YaUH3EjUiM4i0NTUIC1N6iu/8GKQCdl1aHyIQ1kxWfeObIR6y7Q==
X-Received: by 10.28.13.205 with SMTP id 196mr11264394wmn.46.1475694385119;
        Wed, 05 Oct 2016 12:06:25 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA355.dip0.t-ipconnect.de. [80.139.163.85])
        by smtp.gmail.com with ESMTPSA id zz9sm10368809wjb.36.2016.10.05.12.06.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Oct 2016 12:06:24 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 09/14] pkt-line: add packet_write_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqd1jfucwo.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 5 Oct 2016 21:06:23 +0200
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1968DDD-7EAA-477B-B088-5F2A83F29C8C@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com> <20161004125947.67104-10-larsxschneider@gmail.com> <xmqqd1jfucwo.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 21:33, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>>=20
>> +static int packet_write_gently(const int fd_out, const char *buf, =
size_t size)
>> +{
>> +	static char packet_write_buffer[LARGE_PACKET_MAX];
>> +	const size_t packet_size =3D size + 4;
>> +
>> +	if (packet_size > sizeof(packet_write_buffer))
>> +		return error("packet write failed - data exceeds max =
packet size");
>=20
> Hmph, in the previous round, this used to be "is the size larger
> than sizeof(..) - 4?", which avoided integer overflow issue rather
> nicely and more idiomatic.  If size is near the size_t's max,
> packet_size may wrap around to become very small, and we won't hit
> this error, will we?

You are right. Would the solution below be acceptable?
I would like to keep the `packet_size` variable as it eases the rest
of the function.

=20
 	const size_t packet_size =3D size + 4;
=20
-	if (packet_size > sizeof(packet_write_buffer))
+	if (size > sizeof(packet_write_buffer) - 4)
 		return error("packet write failed - data exceeds max =
packet size");

Thanks,
Lars=
