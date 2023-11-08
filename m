Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96B3032C
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386F1FE9
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 08:44:33 -0800 (PST)
Received: (qmail 16987 invoked by uid 109); 8 Nov 2023 16:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Nov 2023 16:44:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1019 invoked by uid 111); 8 Nov 2023 16:44:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Nov 2023 11:44:33 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Nov 2023 11:44:32 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <20231108164432.GA1028115@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <ac059db8fedc6493c64f703814c7db11adb4385e.1699428122.git.ps@pks.im>
 <xmqqcywk7k0d.fsf@gitster.g>
 <ZUtmAyVHO4ROhLEq@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUtmAyVHO4ROhLEq@tanuki>

On Wed, Nov 08, 2023 at 11:42:11AM +0100, Patrick Steinhardt wrote:

> I was a bit torn myself when writing this. I can also see a potential
> future where we would drop the hardcoded list of locations altogether in
> favor of always using PATH. After all we already rely on PATH to resolve
> other tools as well, so why should httpd be special there?

httpd/apache2 is often in sbin, which is not as commonly found in the
PATH of regular users. E.g., this is the case on Debian (it is
/sbin/apache2, and a newly created user will not have that in their
PATH).

-Peff
