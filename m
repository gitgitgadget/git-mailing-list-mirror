From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/5] Update compat/regex
Date: Wed, 18 Aug 2010 10:41:09 +0000
Message-ID: <AANLkTin6ojQzrPDh0EGVQUGvxtX3OP58nokEUpXw5pEQ@mail.gmail.com>
References: <20100817080322.GA28476@burratino>
	<1282037082-12996-1-git-send-email-avarab@gmail.com>
	<7vzkwkaktr.fsf@alter.siamese.dyndns.org>
	<20100817235016.GL2221@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 12:41:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olg57-00012W-D4
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 12:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab0HRKlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 06:41:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57073 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0HRKlK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 06:41:10 -0400
Received: by iwn7 with SMTP id 7so534520iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G+em8OuUn7zzwM1Ni7OyjBtV99q4kMQGyrzJt2Bs+E4=;
        b=S/oz7vVIfS0IksaG1jgyf6+eH179v+w0KTDhRCJVUVKZLuECXsYPgZ3o0mOB5V8ZWW
         v3Gz/6kARUO+51NYi1jVO8viSP8VCCZl44E0A16PJXyoF1pzcwMWaOF4gwAkUUcRqXBW
         pAAsuHl6AVW2YXjZFR/ViT6IeQDpkboz3AgNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KsgyFrP0R2+Rn0iITxNlgV1cLjjybURl7tOG0Hg4A8mhf9XH0uId5EfFu7nOTwh2pS
         eRjtXqTAxFok2tWN6KVAahMVYapfyvja0Gfi/FR949P/zqxTpauYoQQL8a2hUuazqJXM
         QYAJb1VI2LEfL9k7V9NwVbIgNSLP4/gOc76Gw=
Received: by 10.231.146.141 with SMTP id h13mr9481945ibv.1.1282128069403; Wed,
 18 Aug 2010 03:41:09 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 03:41:09 -0700 (PDT)
In-Reply-To: <20100817235016.GL2221@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153827>

2010/8/17 Jonathan Nieder <jrnieder@gmail.com>:
> Junio C Hamano wrote:
>
>> Hmm, is there [1/5] in the series?
>
> Yes, but it probably missed the list because of vger's message length
> limits.
>
> For convenience, here is the series. =C2=A0I also think the first two
> patches should be combined, but this does not do so because others
> might disagree. =C2=A0Patch 5 (autoconf) is the v2 version.

Pedantic: If there's going to be squashing that should probably
include the regerror change too, otherwise it can't be bisected on
MSVC either.

Personally I think nothing should be squashed, because the history of
having 1 commit be the unaltered gawk library and the rest being the
changes we need on top of it will help future developers when we need
to update the regex library again.

And since most people hacking git probably do so on GNU or the BSD's
which don't need NO_REGEX=3DYesPlease the practical downside of doing s=
o
is *very* little.
