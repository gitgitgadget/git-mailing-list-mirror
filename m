From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 1/3] compat/regex: use the regex engine from gawk
 for compat
Date: Mon, 16 Aug 2010 22:37:01 -0500
Message-ID: <20100817033701.GB17840@burratino>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
 <1282015548-19074-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 05:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlD0h-0004ak-CP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab0HQDim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:38:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38357 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab0HQDim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 23:38:42 -0400
Received: by gwj17 with SMTP id 17so1236323gwj.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gKxSIJ6Cxnuidbq9StKn4CAWngY7nr+XCGyYeiRPQUo=;
        b=JbJoljXdMdx0eeLiJNL65QHEQ7cXzx4vVRbX0FwNS2QnR54LBS9F76uWMBHWTI99ER
         jxB/n4Qed0my0LmlZ5AzqgguX7LyLtjBZlvxhgm8Z2KuwEjFg0lcOGwsXfhx64vqGb5W
         lPJL6FUrVHRO2iAREtHE5ycaVI8v5Xm9EXeo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KQFRl8YC97ZbVCHCBzxqynp2djKg7KLSXXemnmQuJDVZbArseSYOzhZuKdp6S8OMKW
         M+Ru2PANxwjEnOqXdTSJkH8PXWTOw1818T/655nqTYvfo+TNlU/vPxwE4zHzDJBJEXKf
         ISce0xg12FHFFP3DjiyZqzaXkYZpMBpjkqYs8=
Received: by 10.100.210.6 with SMTP id i6mr6858372ang.143.1282016321113;
        Mon, 16 Aug 2010 20:38:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f22sm11452113anh.4.2010.08.16.20.38.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 20:38:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282015548-19074-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153691>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/compat/regex/mbsupport.h
> @@ -0,0 +1,59 @@
> +/*
> + * mbsupport.h --- Localize determination of whether we have multiby=
te stuff.
> + */
> +
> +/*=20
> + * Copyright (C) 2004, 2005 the Free Software Foundation, Inc.
> + *=20
> + * This file is part of GAWK, the GNU implementation of the
> + * AWK Programming Language.
> + *=20
> + * GAWK is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.

Worrisome.  (Most of git is still GPL-2 only, which would not be
compatible.)
