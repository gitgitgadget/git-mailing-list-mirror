From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sat, 29 Aug 2015 15:29:50 +0200
Message-ID: <CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net> <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net> <20150825185414.GA10895@sigill.intra.peff.net>
 <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
 <20150826021517.GA20292@sigill.intra.peff.net> <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 29 15:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgDM-0007ja-Fu
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 15:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbH2NaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2015 09:30:12 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34879 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbH2NaL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2015 09:30:11 -0400
Received: by wicne3 with SMTP id ne3so38890818wic.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=9CDqV8wXZPWWZKOZGVOU9HMzz08VBc3LyKWM9HqCRcA=;
        b=wvlF82qg68GGld3VEzKdD36Pm4fMXl730LsQyAokgHeiYOYofC47kLUwQ73LZXZxA1
         sVMaE+pJUZqTsC09Sa7IXE0T4j1zdXJ8WFH1og32Pvl54UOkihioA9JSFLVB6H67Wpys
         5BH2b/SK6NOwcIa2Lb0DWNWVQ/jpX+T9WHgl8MF407HsR86a6uMfal03uwSVkzZCkmee
         Jq0m1OJhENof1pDf46ItVyBrhzptzHZjyGzpmnpJmvzigOBuO2LVnNfO4LkuhDyiqWnU
         /wljgQOjyfH4N+g3LTEqLGn6oR4lWWhdZW5WtOCbWuyndk8SeNqaVkmWMdIYGUCtOdCo
         ug/w==
X-Received: by 10.180.107.202 with SMTP id he10mr9919162wib.35.1440855010065;
 Sat, 29 Aug 2015 06:30:10 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sat, 29 Aug 2015 06:29:50 -0700 (PDT)
In-Reply-To: <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
X-Google-Sender-Auth: pgk2kmc3NruqjLMYuG-F_jTZxLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276775>

Amended, the latest version is at https://github.com/gaborbernat/git/co=
mmit/ :)
Bern=C3=A1t G=C3=81BOR


On Sat, Aug 29, 2015 at 11:50 AM, Gabor Bernat <bernat@primeranks.net> =
wrote:
> Hello,
>
> Here's what I ended up using, and seemed to work well:
> https://github.com/gaborbernat/git/commit/766841bc1b726a5d6e7e051938b=
82975368695a0
>
> Does this looks okay, should I create a patch from this?
>
> Thanks,
> Bern=C3=A1t G=C3=81BOR
>
>
> On Wed, Aug 26, 2015 at 4:15 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Aug 25, 2015 at 04:12:54PM -0400, Eric Sunshine wrote:
>>
>>> > A little googling came up with:
>>> >
>>> >     awk 'END { print systime() }' </dev/null
>>> >
>>> > which probably (?) works everywhere.
>>>
>>> On Mac OS X and FreeBSD:
>>>
>>>     $ awk 'END { print systime() }' </dev/null
>>>     awk: calling undefined function systime
>>>     source line number 1
>>>     $
>>
>> Oh, well. The reference I saw was that the old Kernighan nawk had it=
,
>> but that seems not to be the case:
>>
>>   http://www.cs.princeton.edu/~bwk/btl.mirror/
>>
>> "date +%s" seems to work on OS X, and so presumably on other BSDs. N=
o
>> clue what would work on stuff like SunOS, AIX, etc.
>>
>> -Peff
