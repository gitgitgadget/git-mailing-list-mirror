Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A204F1E5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40AMCBn71699562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 22:12:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <ZZ77NQkSuiRxRDwt@nand.local>	<b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> <xmqqjzog96uh.fsf@gitster.g>
In-Reply-To: <xmqqjzog96uh.fsf@gitster.g>
Subject: RE: [DISCUSS] Introducing Rust into the Git project
Date: Wed, 10 Jan 2024 17:15:53 -0500
Organization: Nexbridge Inc.
Message-ID: <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQNL0k5wzhXZATyUnQ76Vxjn4eCV+QKEQ1wBALH7sDyt1s4UgA==

On Wednesday, January 10, 2024 5:12 PM, Junio C Hamano wrote:
>Dragan Simic <dsimic@manjaro.org> writes:
>
>> Thus, Git should probably follow the same approach of not converting
>> the already existing code, but frankly, I don't see what would
>> actually be the "new leafs" written in Rust.
>
>A few obvious ones that come to my mind are that you should be able to
write a
>new merge strategy and link the resulting binary into Git without much
hassle.  You
>might even want to make that a dynamically loaded object.  The interface
into a
>merge strategy is fairly narrow IIRC.  Or possibly a new remote helper.
>
>Adding a new refs backend may need to wait for the work Patrick is doing to
add
>reftable support, but once the abstraction gets to the point to
sufficiently hide the
>differences between files and reftables backends, I do not see a reason why
you
>cannot add the third one.
>
>And more into the future, we might want to have an object DB abstraction,
similar
>to how we abstracted refs API over time, at which time you might be writing
code
>that stores objects to and retrieves objects from persistent redis and
whatnot in
>your favorite language.

Just a brief concern: Rust is not broadly portable. Adding another
dependency to git will remove many existing platforms from future releases.
Please consider this carefully before going down this path.
--Randall

