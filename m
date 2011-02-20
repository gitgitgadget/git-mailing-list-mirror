From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON prerequisite
Date: Sun, 20 Feb 2011 23:31:10 +0100
Message-ID: <AANLkTikRv9BGWXrf5u7xptgZ9hajeju-QU7WS9Zj3sYP@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<1298143495-3681-4-git-send-email-avarab@gmail.com>
	<20110220021031.GB17305@elie>
	<AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
	<20110220215533.GB32142@elie>
	<AANLkTikJbwp+-=sgX2RLo-aXA_gmmO2gLsC=+MxEYxXg@mail.gmail.com>
	<20110220221033.GD32142@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 23:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHoD-0001eC-4n
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab1BTWbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 17:31:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49469 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab1BTWbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 17:31:11 -0500
Received: by fxm17 with SMTP id 17so932593fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2nj07HMRBJ+TgFYpwqTusgIxC5l4vx/ts07PF7njSko=;
        b=bvUFpr/4pOVDaqTqDfd7fPii3PQ6Gk0wqZxhMatkV/gwZLTHFxrZjIg8nW/mcOW8qt
         5K8G6ydt6Z7oBoRMRMKY+B42CbtIXvMLbgSF8WWMlB9KZ2P6KAHpoFltONGmgxXby7c7
         nQwbGTMHIFlUPBTyg1dco5OA3JtL4wFUQCCyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QXU/1xcfjMGGJuecoYXDCbDzLZroDOaADyex+fbePJrs6DwaANZr4xueYygHPeX6jA
         FSBU8vTgnMj4eacxWLGaJSHwM+zL2Fz4VOKS1kKfw8Q2vgXmK3+GdlFqunlM1Ju3zK/S
         d1GtNAkROUHLpP7SpphixoLfoErOGDAxsSjG8=
Received: by 10.223.95.203 with SMTP id e11mr965796fan.60.1298241070363; Sun,
 20 Feb 2011 14:31:10 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sun, 20 Feb 2011 14:31:10 -0800 (PST)
In-Reply-To: <20110220221033.GD32142@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167433>

On Sun, Feb 20, 2011 at 23:10, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Well, the feature I have is to inject garbage into the gettext strin=
gs
>> in an effort to smoke out when I break the plumbing. So I think give=
n
>> that functionality calling it NO_GETTEXT_POISON makes sense.
>>
>> But I plan to add something to smoke other languages etc. later. The=
n
>> I might name that other prerequisite something else.
>
> On second thought, another possibility would be _two_ prerequisites,
> one NO_GETTEXT_POISON one and one ENGLISH one. =C2=A0The weird edge c=
ases
> could require NO_GETTEXT_POISON, causing the reader to look to
> t/README to figure out what is going on. =C2=A0The others would just =
use
> ENGLISH.
>
> Does that sound reasonable?

Yes, I suggested implementing that in the "enter the commit message"
patch, but since we don't have a 100% translation yet I was going to
wait until then.

It's also a very low priority, the point of these tests is to make
sure I don't make a plumbing message translatable. The things that
start failing under a testing mode like ENGLISH are by definition a
subset of the things that'll start failing under NO_GETTEXT_POISON. So
there's not a lot of incentive for me to implement that.

The only reason I can think of to have it is to make sure that
messages like the "enter the commit message" ones have the correct
newlines in all languages, but msgfmt --check catches that anyway, or
to somehow test Git's output in different languages, but I'd rather do
that differently (not test output, but behavior).

So given all of the above I might never get around to implementing it.
