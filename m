From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sat, 29 Aug 2015 11:50:21 +0200
Message-ID: <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net> <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net> <20150825185414.GA10895@sigill.intra.peff.net>
 <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com> <20150826021517.GA20292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 29 11:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVcmi-0003mJ-0W
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 11:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbbH2Jum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2015 05:50:42 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38529 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbH2Jum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2015 05:50:42 -0400
Received: by wifs6 with SMTP id s6so4134926wif.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=r7Z3lG3mBKIbzDb0XApGc+DyIXTj1TO1gklcDZ2tfAg=;
        b=mrkT52tmjoXC/Ku54O6QUToi94EGO8uA0H3iHq/97B6umTyISQVKMk1zsAJXufRyQN
         ZOi/wdj8zOjQImQlTZR9XzCJLmAJHKrO2z93dVtLyrdIhkfnxF9zN9I03jt8U/3TnGUB
         9wfLoK80HJGNHk2fKjEsHZBKcaody4YmSEBNX2TQP3ejRjW6zoKRHVycxeTkg9x+z4Sr
         kN4spp8RXye9UROR3739XXL9hFKCkx+L1XMB3SZb8NVPWYGbElRy89hsDgYaBNl7q3rc
         JDodVmtro3KHi86QSaQKqfbjNTh1to+euu1OtT4aKTlfKTuwO6Hpt4fW1qcGUH46Xgwi
         Z4sw==
X-Received: by 10.180.211.239 with SMTP id nf15mr9585430wic.13.1440841840634;
 Sat, 29 Aug 2015 02:50:40 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sat, 29 Aug 2015 02:50:21 -0700 (PDT)
In-Reply-To: <20150826021517.GA20292@sigill.intra.peff.net>
X-Google-Sender-Auth: EhU0CYj6kwoLGDBx0RAUuET2UFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276772>

Hello,

Here's what I ended up using, and seemed to work well:
https://github.com/gaborbernat/git/commit/766841bc1b726a5d6e7e051938b82=
975368695a0

Does this looks okay, should I create a patch from this?

Thanks,
Bern=C3=A1t G=C3=81BOR


On Wed, Aug 26, 2015 at 4:15 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 25, 2015 at 04:12:54PM -0400, Eric Sunshine wrote:
>
>> > A little googling came up with:
>> >
>> >     awk 'END { print systime() }' </dev/null
>> >
>> > which probably (?) works everywhere.
>>
>> On Mac OS X and FreeBSD:
>>
>>     $ awk 'END { print systime() }' </dev/null
>>     awk: calling undefined function systime
>>     source line number 1
>>     $
>
> Oh, well. The reference I saw was that the old Kernighan nawk had it,
> but that seems not to be the case:
>
>   http://www.cs.princeton.edu/~bwk/btl.mirror/
>
> "date +%s" seems to work on OS X, and so presumably on other BSDs. No
> clue what would work on stuff like SunOS, AIX, etc.
>
> -Peff
