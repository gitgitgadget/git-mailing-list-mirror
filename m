From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH 5/6] Allow to use crc32 as a lighter checksum on index
Date: Mon, 06 Feb 2012 20:29:53 -0800
Message-ID: <947C7419-52B3-46B3-A849-C4498DF9A099@apple.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-5-git-send-email-pclouds@gmail.com>
 <CAJo=hJvSyhv8EUh=6ROotc3Q=zQo7vbww_ShQJP3tf1T7s889g@mail.gmail.com>
 <159A2D07-0B02-4E85-B7AA-C668FDA9F382@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 05:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rucgp-0003UI-Sz
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 05:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab2BGE3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 23:29:55 -0500
Received: from mail-out.apple.com ([17.151.62.50]:33491 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab2BGE3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 23:29:54 -0500
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0LZ000EIL9TK5DL0@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 06 Feb 2012 20:29:54 -0800 (PST)
X-AuditID: 11807136-b7cd6ae000007787-a8-4f30a8c23e60
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id AC.02.30599.2C8A03F4; Mon, 06 Feb 2012 20:29:54 -0800 (PST)
Received: from [10.0.1.254]
 (adsl-70-231-241-90.dsl.snfc21.sbcglobal.net [70.231.241.90])
 by cardamom.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0LZ0002DB9TT7NB0@cardamom.apple.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 20:29:54 -0800 (PST)
In-reply-to: <159A2D07-0B02-4E85-B7AA-C668FDA9F382@apple.com>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsUiON1OVffQCgN/g8v9IhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MpYe+YFS8E89oqbxxcyNTA+Z+1i5OCQEDCRWNoa1MXICWSKSVy4
	t56ti5GLQ0iglUniZO8vdgjnOJNE98EtTCBVzAJaEut3HgezeQX0JM7tm8sOYgsLeEn8v3+A
	GcRmE9CQ+HTqLpjNKWArseDKGxYQm0VAVWLjn3WsIEOZBTYySrzbvoYVYqi2xJN3F1ghhtpI
	bHs3hQli82dGiYP/P4MlRATUJLZf6GGFuFVW4tCMlYwTGAVmITlqFpKjZiGZu4CReRWjYFFq
	TmKloaleYkFBTqpecn7uJkZQ8DUUmu1g3PFX7hCjAAejEg/vQW4DfyHWxLLiytxDjBIczEoi
	vHGv9P2FeFMSK6tSi/Lji0pzUosPMUpzsCiJ826cBZQSSE8sSc1OTS1ILYLJMnFwSjUwVjrZ
	7Y5XevtlO+ftm4mGQVV1XXNO7T149VeS9ubE2jzF27pvJ3GFa68tqN7Btlv6FddL67n/dyVm
	azGrfz7LdP3HcvHAgBAup/JriefXO5nsz1ZNqt2l/ZJvXfTzh4eXxactCv+6m6ntzILAUr0t
	zpkBATFcNw45RapXNsWsOv3myRZhhYQiJZbijERDLeai4kQA9Q56zjoCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190136>


On Feb 6, 2012, at 8:04 PM, Dave Zarzycki <zarzycki@apple.com> wrote:

> On Feb 6, 2012, at 7:17 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 
>> I haven't really put a lot of thought into this. But I suspect CRC-32
>> is sufficient on the index file, until it gets so big that the
>> probability of a bit flip going undetected is too high due to the size
>> of the file, but then we are into the "huge" index size range that has
>> you trying to swap out SHA-1 for CRC-32 because SHA-1 is too slow. Uhm
>> no.
> 
> CRCs are designed to be implemented in hardware and provide basic single-bit error checking for networking packets of disk blocks. With a good polynomial, they're reasonably effective at detecting a single-bit error within 8 or 16 kilobytes:
> 
>    http://www.ece.cmu.edu/~koopman/networks/dsn02/dsn02_koopman.pdf

s/packets of disk blocks/packets or disk blocks/g
