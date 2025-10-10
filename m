Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CC1EFF8D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130242; cv=none; b=jbSIxkIfdeYeotKc084kN/cAh1hWqbnftUIMWqeaEhe1R0dBBzFbZoD1Z/7ZzjrZc2PoD2xDYANGWROMd2jIOqfPa+4Qvsw23chh71SFP8ecaCyXujpc09gm7oFT7Uer7PbPaenY+eGPCVLoXkFeBPynIyaVfksdqvZAYg6rHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130242; c=relaxed/simple;
	bh=dOvmZIKOBUChl6q6Nd2LaAkOL3wzlxflIfvEdPofu54=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eJ88K8jdBmXCVyih0+cncXgqPl27vsrUFZZKe7g7ClSE/oFumyX9+WsJeKQgcWfP38cX5Uo2Z7SNJgHzgKG47OQXIdwG4cJA2LnZzKShO0WcdUotpb7svxLGaALUCjcDJbW/v0qxJHwEx+mQMN4CoE/mXwszVr27J5PyCpjmk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=WOcjGUk/; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="WOcjGUk/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WEpRGxEIj3qWOEjcZ2yV+KKZxJ5l8R5oSDiKdusqK20=; b=WOcjGUk/brqRb/cxJCSksAAtiE
	PeX8Kf5BTAS1YE1IjrT53mrEAvvzLog2umpXtNjcCtRqMFrvn9A7k6dz972IHS4gd6v1S6N9hnAdX
	V7LIcnlFvOTtk/0Xqmztndd+c36AVy/VkwF2oZEBgtfNWG/OpbfBEiRgVmE2zkvu6aKdzm5F5911e
	nzea3v81Jx18dVdK5mQi9RA0Yl9KVjkpWI+l4Y3yyt0KzgmdWW4fGH/lcu0LhCTg2LJ7AEgnscIFN
	Dhg+OPdeqdZrZUhZPCE7UmaElXZi1qHm+pqDRagL5+E8Co/YFzjnNckxjFEmlMCHr5kQXMOK4lS8l
	7p8fIaew==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1v7KHJ-00EAwZ-KM; Fri, 10 Oct 2025 23:03:55 +0200
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Fri, 10 Oct
 2025 23:03:47 +0200
Date: Fri, 10 Oct 2025 23:03:47 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <xmqqbjme8rs4.fsf@gitster.g>
Message-ID: <c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de>
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de> <xmqqbjme8rs4.fsf@gitster.g>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
X-ClientProxiedBy: MSX-L421.msx.ad.zih.tu-dresden.de (172.26.34.141) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout3.zih.tu-dresden.de

On Fri, 10 Oct 2025, Junio C Hamano wrote:

> Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:
>
>> diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
>> index 97ce9c9..8ee6cce 100644
>> --- a/contrib/credential/libsecret/Makefile
>> +++ b/contrib/credential/libsecret/Makefile
>> @@ -1,17 +1,21 @@
>>   # The default target of this Makefile is...
>>   all::
>>
>> -MAIN:=git-credential-libsecret
>> -all:: $(MAIN)
>> -
>> -CC = gcc
>> -RM = rm -f
>> -CFLAGS = -g -O2 -Wall
>> -PKG_CONFIG = pkg-config
>> -
>>   -include ../../../config.mak.autogen
>>   -include ../../../config.mak
>>
>> +prefix ?= /usr/local
>> +gitexecdir ?= $(prefix)/libexec/git-core
>> +
>> +CC ?= gcc
>> +CFLAGS ?= -g -O2 -Wall
>> +PKG_CONFIG ?= pkg-config
>> +INSTALL ?= install
>> +RM ?= rm -f
>> +
>> +MAIN:=git-credential-libsecret
>> +all:: $(MAIN)
>> +
>>   INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
>>   LIBS:=$(shell $(PKG_CONFIG) --libs libsecret-1 glib-2.0)
>>
>> @@ -22,7 +26,13 @@ OBJS:=$(SRCS:.c=.o)
>>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<
>>
>>   $(MAIN): $(OBJS)
>> -	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
>> +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)
>> +
>> +install: $(MAIN)
>> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
>> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>>
>>   clean:
>> -	@$(RM) $(MAIN) $(OBJS)
>> +	$(RM) $(MAIN) $(OBJS)
>> +
>> +.PHONY: all install clean
>
>
>> diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
>> index 0948297..b1d7c29 100644
>> --- a/contrib/credential/osxkeychain/Makefile
>> +++ b/contrib/credential/osxkeychain/Makefile
>> @@ -1,19 +1,35 @@
>>   # The default target of this Makefile is...
>> -all:: git-credential-osxkeychain
>
> Having the primary target name on this line very early in the file
> has documentation value.

I understand your point.  I guess it has not been done like this in the 
other three Makefiles because a variable ($MAIN here) was used instead 
of the executable file name itself and this variable is yet defined down 
below.


>> -CC = gcc
>> -RM = rm -f
>> -CFLAGS = -g -O2 -Wall
>> +all::
>>
>>   -include ../../../config.mak.autogen
>>   -include ../../../config.mak
>>
>> -git-credential-osxkeychain: git-credential-osxkeychain.o
>> -	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) \
>> +prefix ?= /usr/local
>> +gitexecdir ?= $(prefix)/libexec/git-core
>> +
>> +CC ?= gcc
>> +CFLAGS ?= -g -O2 -Wall
>> +INSTALL ?= install
>> +RM ?= rm -f
>> +
>> +MAIN:=git-credential-osxkeychain
>> +all:: $(MAIN)
>
> What's the point of an extra $(MAIN) definition (not just here but
> in the other Makefile as well)?

I am only guessing.  git-credential-libsecret was renamed from 
git-credential-gnome-keyring somewhere in the past when the Gnome 
developers decided to dump libgnome-keyring in favour of libsecret.  So 
it could have been convenient to change only one line in the Makefile.


> It may be slightly convenient to write while the thing is simple and
> stays one-source-one-binary, but programs including Makefiles are more
> often read than written, so we should optimize them for readers.  I
> personally think this extra indirection is hurting readability more
> than helping.

I was just using $(MAIN) as a variable name because this is the variable 
used in the other Makefile git-credential-libsecret.  Would 
$(GIT_CREDENTIAL_HELPER) be a better variable name?


> Other than that, yes, it is great to make these three or four
> Makefiles look similar to allow readers compare and spot
> differences.

My initial reason was just to add an install target rule because it is 
obviously missing.  And I wanted it to do in a similar way like the other 
two Makefiles (for git-subtree and git-contacts).  So I then ended up to 
reorder the lines.


> Thanks.

Thank you for the review.


>> +
>> +SRCS:=$(MAIN).c
>> +OBJS:=$(SRCS:.c=.o)
>> +
>> +%.o: %.c
>> +	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
>> +
>> +$(MAIN): $(OBJS)
>> +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
>>   		-framework Security -framework CoreFoundation
>>
>> -git-credential-osxkeychain.o: git-credential-osxkeychain.c
>> -	$(CC) -c $(CFLAGS) $<
>> +install: $(MAIN)
>> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
>> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>>
>>   clean:
>> -	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
>> +	$(RM) $(MAIN) $(OBJS)
>> +
>> +.PHONY: all install clean
>>
>> base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
