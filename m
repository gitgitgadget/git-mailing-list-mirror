From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple estimated time remaning
Date: Sun, 30 Aug 2015 22:06:26 -0700
Message-ID: <xmqq4mjgyrl9.fsf@gitster.mtv.corp.google.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
	<CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
	<CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
	<xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTf2YLWGi2swmMxdx_XpEU=GkAx11ng6VVACMX9NpA_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 07:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWHLH-0001H6-6t
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbbHaFGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 01:06:31 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35398 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbHaFG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 01:06:28 -0400
Received: by pacdd16 with SMTP id dd16so126339268pac.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4yjxwuT1t7e7aXY1XDHVJvPz05ca7NxiY5cOAZ9YwsQ=;
        b=KqrW4V8w7pI12K2GMH6suXENCtsJF1KVObLzR9mpYiu+jbXoJgMtN9Ybno/UjB3rWe
         M9RkDcfd0I3Fse6d+ThgW3zeLEKapBqMT8fF7l4f4fXFd+W8vDNR7aCTrFevANFhWmd3
         1NZhKk0tKMYY3HCtbIAoEl7dBqZHFV9DDv7nFoJK1xtmZ/ifuVJ5nTietSQzdO2NLCzU
         etVsRM3f9JWIfvmI0nsJ+9jDtHIzbbtpa+O5TlBNavMYTy9Iy+xMU6oN5fPHcQX7CFrM
         XeM0W4rRY7JMYPgSyWVgC6iJ8bGxAKtDbe/ZEDYCqh0psa3is+TiNsYcS2WitKYGeEDr
         Rieg==
X-Received: by 10.66.248.72 with SMTP id yk8mr34240800pac.112.1440997588286;
        Sun, 30 Aug 2015 22:06:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id bc10sm12907278pbd.14.2015.08.30.22.06.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 30 Aug 2015 22:06:27 -0700 (PDT)
In-Reply-To: <CAPig+cTf2YLWGi2swmMxdx_XpEU=GkAx11ng6VVACMX9NpA_SQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 30 Aug 2015 15:40:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276846>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I suppose a viable approach might be to test once outside the loop if
> "date +%s" is supported and print the "(%d elapsed / %d estimated
> remaining)" annotation within the loop if it is, else not. The test
> might look something like this:
>
> echo $(date +%s) | grep -q '^[0-9][0-9]*$' 2>/dev/null && show_eta=t
>
> Platforms, such as Linux, Mac OS X, and FreeBSD, which support "date
> +%s" would get the annotated output, whereas it would fall back
> gracefully to the non-annotated output on platforms such as Solaris
> (and perhaps AIX) which lack it.

I kind of like this for its simplicity, especially given that it
would cover the vast majority of users in practice.
