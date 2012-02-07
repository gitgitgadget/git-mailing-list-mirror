From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH 5/6] Allow to use crc32 as a lighter checksum on index
Date: Mon, 06 Feb 2012 20:04:59 -0800
Message-ID: <159A2D07-0B02-4E85-B7AA-C668FDA9F382@apple.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-5-git-send-email-pclouds@gmail.com>
 <CAJo=hJvSyhv8EUh=6ROotc3Q=zQo7vbww_ShQJP3tf1T7s889g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 05:05:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RucJK-0001o8-5e
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 05:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab2BGEFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 23:05:03 -0500
Received: from bramley.apple.com ([17.151.62.49]:61668 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab2BGEFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 23:05:01 -0500
Received: from relay16.apple.com ([17.128.113.55])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0LZ000AS88OCUV51@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 06 Feb 2012 20:05:00 -0800 (PST)
X-AuditID: 11807137-b7b87ae000004a2b-4e-4f30a2ecc73e
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay16.apple.com (Apple SCV relay)
 with SMTP id 64.A0.18987.CE2A03F4; Mon, 06 Feb 2012 20:05:00 -0800 (PST)
Received: from [10.0.1.254]
 (adsl-70-231-241-90.dsl.snfc21.sbcglobal.net [70.231.241.90])
 by kencur.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0LZ000I1Q8OBSC80@kencur.apple.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 20:05:00 -0800 (PST)
In-reply-to: <CAJo=hJvSyhv8EUh=6ROotc3Q=zQo7vbww_ShQJP3tf1T7s889g@mail.gmail.com>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsUiON1OTffNIgN/g98nTCy6rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJVxrfcFU0EjW0XLEssGxhcsXYycHBICJhI/7m6FssUkLtxbz9bF
	yMUhJNDOJLHv1l1GCOcwk8S3/lawKmYBLYn1O48zgdi8AnoS5/bNZQexhQW8JP7fP8AMYrMJ
	aEh8OnUXzOYUCJZoO30WzGYRUJVY3v6CHWQos8BGRol329ewQgzVlnjy7gKQzQE01EZi0rsw
	kLCQwAFGieNtdiC2iICaxPYLPawQl8pKHJqxknECo8AsJCfNQnLSLCRTFzAyr2IULErNSaw0
	NNNLLCjISdVLzs/dxAgKvIZC8x2M2//KHWIU4GBU4uE9wG3gL8SaWFZcmXuIUYKDWUmEN+6V
	vr8Qb0piZVVqUX58UWlOavEhRmkOFiVx3k2zgFIC6YklqdmpqQWpRTBZJg5OqQbGhNSjpxqv
	e85r1z4623HpnJ6lJT2JWttP3njHZd/UdfCptNh7jtCzFsckBK4taEj7Xfd/O8Mz8c83n5ZM
	njntXKfGD9FJ5XeU86fzuDnODH2WGpzscXSlz7ELSr+Z3tYE+l4NyxcyYFbYHWnZp3Mr+qP8
	IevezV8Dz62cuGAl1wr/KV+e3V/+UImlOCPRUIu5qDgRAOcCq1c4AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190134>

On Feb 6, 2012, at 7:17 PM, Shawn Pearce <spearce@spearce.org> wrote:

> I haven't really put a lot of thought into this. But I suspect CRC-32
> is sufficient on the index file, until it gets so big that the
> probability of a bit flip going undetected is too high due to the size
> of the file, but then we are into the "huge" index size range that has
> you trying to swap out SHA-1 for CRC-32 because SHA-1 is too slow. Uhm
> no.

CRCs are designed to be implemented in hardware and provide basic single-bit error checking for networking packets of disk blocks. With a good polynomial, they're reasonably effective at detecting a single-bit error within 8 or 16 kilobytes:

    http://www.ece.cmu.edu/~koopman/networks/dsn02/dsn02_koopman.pdf
