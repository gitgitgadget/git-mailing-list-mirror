Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VTYjTSJb"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C51704
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1701372509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TV3IggTagANcWhm6IYLl0u0fTC+/BhOwMDlGndTp1tg=;
	b=VTYjTSJbGGQI5g3sVulbNInLz5E7XNp21OVVGuG4UFzHWZOuFKUCubjKUNSxa3ErEhHJ4U
	SQITqGtgYeqY3q0TW9s9a6IjwP4n3M1UYmna1EdJ4Vsz4/0DmrDWiFqMhjXQpZToGVAyaA
	qvcy/F7KNfP0cNrhOjk3CAZGx9r3NMJm0cnpyrltLByi97Mq2y5xHMA39RcnO0KW1Q+8MY
	GZlt2qxlCkJ1Hq3oygfMIPQfbG2iWVYhLPCauC1RmTFVH0x7KV3rMMlWOSG3z8jnw4PF7O
	k0P73xzVXr28NS5LHXBJk869V5FJPyP/7RI1FKfZy2MndP3GSEIVFJXFN0PMyw==
Date: Thu, 30 Nov 2023 20:28:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonny Grant <jg@jguk.org>, git@vger.kernel.org
Subject: Re: Consider dropping the decimal places for KiB/s 52.00 KiB/s
In-Reply-To: <ZWjdatp3SRb4mN6G@nand.local>
References: <637be919-0b04-4e5c-8f2e-43340521e6d1@jguk.org>
 <ZWjdatp3SRb4mN6G@nand.local>
Message-ID: <9c93eba836a22ba8dfb46c43e5b325ac@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-30 20:07, Taylor Blau wrote:
> On Thu, Nov 30, 2023 at 06:11:57PM +0000, Jonny Grant wrote:
>> $ git clone git://gcc.gnu.org/git/gcc.git git_1
>> Cloning into 'git_1'...
>> remote: Enumerating objects: 2949348, done.
>> remote: Counting objects: 100% (209238/209238), done.
>> remote: Compressing objects: 100% (14579/14579), done.
>> Receiving objects:   7% (210878/2949348), 76.33 MiB | 52.00 KiB/s
> 
> On my machine:
> 
>     $ git.compile clone git://gcc.gnu.org/git/gcc.git
>     [...]
>     Receiving objects:  11% (342176/2949348), 108.09 MiB | 24.01 MiB/s
> 
> I suppose we could consider dropping the decimal component if it's a
> round number, but I think that it may produce awkward flickering if the
> rate oscillates between a round number and a non-round number.

You're right, the resulting flickering would look really annoying.  In 
fact, I already modified the reported download speed in another project 
to avoid pretty much the same kind of flickering, and it looked much 
better without it.
