Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76361B0434
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244420; cv=none; b=LIUApJ8l62eZvqIy91TfXmBVzTaK5hbzhJ6RrOPFB2vvjWeuIpGutUiHvjBKAchhGyJicafuS6rw2HnBPUcwDWuE+EVtmgxbfGJi1zLqNJOJw/XN52aKNv5PXMwhxMVubWQfHHP5kIMtF5nzVXCkBWXTjUtPvXAmf4hRCJ/arQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244420; c=relaxed/simple;
	bh=QvSuKmoDfFY5mbGfGfqNVn0LKWOEpBBQVb0iw17H8Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq+G6kgQyMCkn2sYChFv2Eu4JUKPprpRAun9kKTkKMhcxII5KUn2pK5hytJXV5rF6QdXLWtaj+2pqv5GxirkwjkP0NdVMvahXcdWM4fpsBLg4wjPx0B+F6Sg7x3iMFBTzfplcZKOIy+rfpBQpGXMQ+ls2f91VFThw9YBYARc6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=GcpWEsId; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GcpWEsId"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id uHJKteDLAeYyCuHJLtZ4Vr; Mon, 17 Mar 2025 20:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742244228; bh=8tt9hLKXzplfpaFqSIoVLZzVLK1J8HqyTmV8smteIYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GcpWEsIdnnET+zvMxj2Cn2PSbih/Rqw6mybUP7U0OzsM4SN4vT36RE3wQkAmg2dxu
	 LSxkn4g347TOSGgqO9unUjWC+Bs8UBoUpptZahXKD2qppKye1BTb4/BY4ydxfZPJT5
	 h1mfmrF7halvj/q5pTgtZsVS4v/VuSDPn4C24ObaQhv6zmNAmRycO1TEOexmcGcRhs
	 Yq+XCm3B6kFjqMZ9IuzVTfbuckv9w4B37gRwLA7WBnWSqzlK41fnIhFh34zZhnUk5/
	 Qr4fXic4Ra0sexnZC7r3vgTgwhd8vQXIbqWD7XFrbakvtX9UxaFjT5h9/+k614fVAf
	 towbvQmUdXccA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=67d88984
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=CWkIQ_dwkXbIpV46u1MA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <13ab486c-45b8-4dc4-885b-55db17c4641e@ramsayjones.plus.com>
Date: Mon, 17 Mar 2025 20:43:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] config.mak.uname: only set NO_REGEX on cygwin for
 v1.7
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
 <33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
 <xmqqecyvbqhn.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqecyvbqhn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFZg0ciQjSSqO+K8/R+pFCvy9U8mYrbif3QSh18yhl8fP1R6ydyWaaPCVcyBFil8kEcHEvSAqYK9mq1A+0N/eMpNO8bPcwWHo9qWZG7Rk/bCbPF/jx7S
 FBGA89NurwTiLgAlAwz1JZEJcjSpOKW/j88oji1A4Cy4pE/BXK4j/z5CaQCTGYfT7uBhQ3POC/5X3XlpP5WEIhVdFtNRpYplVGQ=



On 17/03/2025 15:56, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>> After some time (may a year or two), the platform library had been
>>> updated (with an import from FreeBSD, I believe) and now passed the full
>>> test-suite. This would be about the time of the v1.7 -> v2.0 transition
>>> in 2015. I had a patch ready to send, but just didn't get around to
>>> submitting it to the list.
> 
> So is it safe for us to just drop the bit that sets NO_REGEX and
> require Cygwin that is less than 10 years old?  As long as people
> are willing to actively maintain the compatibility wart for older
> systems there is no strong reason to do so, but at some point it
> would become diminishing returns even for those who have hardware to
> develop, build, and test on, when the reason they keep such an old
> system becomes only to maintain it instead of actively using it,
> and I am wondering if Cygwin 1.7 has past that point.

Heh, I have a patch (without a commit message) which I had intended
to add at the very end, so that it is easy to drop, that looks like:

  diff --git a/config.mak.uname b/config.mak.uname
  index 1a897bd022..1dc69fc65b 100644
  --- a/config.mak.uname
  +++ b/config.mak.uname
  @@ -235,22 +235,6 @@ ifeq ($(uname_S),SunOS)
   	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
   endif
   ifeq ($(uname_O),Cygwin)
  -        ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
  -		NO_D_TYPE_IN_DIRENT = YesPlease
  -		NO_STRCASESTR = YesPlease
  -		NO_MEMMEM = YesPlease
  -		NO_SYMLINK_HEAD = YesPlease
  -		NO_IPV6 = YesPlease
  -		OLD_ICONV = UnfortunatelyYes
  -		# There are conflicting reports about this.
  -		# On some boxes NO_MMAP is needed, and not so elsewhere.
  -		# Try commenting this out if you suspect MMAP is more efficient
  -		NO_MMAP = YesPlease
  -        else
  -                ifeq ($(shell expr "$(uname_R)" : '1\.7\.'),4)
  -		        NO_REGEX = UnfortunatelyYes
  -                endif
  -        endif
   	HAVE_DEV_TTY = YesPlease
   	HAVE_GETDELIM = YesPlease
   	HAVE_CLOCK_GETTIME=YesPlease

This would effectively drop 'support' for cygwin versions less than
the v2.0 (which was tagged on 27-apr-2015). Note that I don't know
if it is possible to build git from source on those versions, even
with that conditional intact, but I guess it's more likely!

Given that it is unlikely to be me fielding the complaints from the
cygwin git community, I wanted Adam (cygwin git maintainer) to
provide his input into the decision to incorporate such a patch. :)

[I doubt there are many people building git from source on a very old
version of cygwin, but I just don't know! ;) ]

I have been building (and running) git from source since about 2006,
on both Linux and cygwin, but I suspect that the vast majority of
cygwin users just install Adam's package.

>> I forgot to mention, that one of the reasons that I didn't get around
>> to submitting this patch then, was because of a '# TODO known breakage
>> vanished' in test t7815-grep-binary.sh:
>> ...
>> The platform regex library is happy to match a NUL byte with the '.'
>> pattern. (presumably this is also true on FreeBSD?).
> 
> In this test, the haystack has "binary\0file\0m..." and the needle
> to be sought is ".fi".  The system I have at hand uses glibc 2.40
> and it refuses to match NUL with '.', it seems.
> 
>> I could not decide on the best way to 'fix' this issue. The options
>> seemed to be: do nothing (it's not hurting anyone), disable the test
>> on cygwin or simply remove the test.
> 
> The part "On Cygwin" somewhat puzzled me; aren't folks on various
> BSD variants seeing the same symptom?

Again 'I don't know what I don't know'. :) I would have thought that
(at least) FreeBSD users should also be seeing this 'known breakage
vanished' issue, but we have not heard about it, so ... we *know*
that cygwin has this issue, hence the suggestion to disable the
test there.

[Also, it is possible that either cygwin or FreeBSD changed the
implementation after the import.]

Thanks.

ATB,
Ramsay Jones


