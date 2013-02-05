From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 5 Feb 2013 15:27:28 +0100
Message-ID: <CACBZZX7JNwZYHn--Cp4g1rLPratJ9nEa-Q8HsYk65jjDYAkFqA@mail.gmail.com>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org> <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org> <CACBZZX7FJ39sereptAQ40Q4MwEpf15v0H=++WvB7+BpMknxoYw@mail.gmail.com>
 <20130205112249.GE24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 15:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2jVL-0004uE-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 15:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3BEO1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 09:27:49 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59839 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab3BEO1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 09:27:48 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so186016obc.40
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 06:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=dsr3o+7YbJSH6gn3rJOGa9spWE1XhJ7xtaHm/YjEfGo=;
        b=giH1UwXZROvri5JeUWnwCUgvaL57BacKqshKGpbCFr2RUMQXZOixtUzL5WBCyuUw2K
         5QFUi1ThFOFlmB8GMycwUP4l68jpnagr6lY1B+V5lwa9VejaIymIfT7NxgUkIXiRXMD1
         1zQ3rPIk/rySse9PJBEd4bMnckSYfGVJztcIR5ZKEex8xU32NiXH0aqKrFIheq+ueP8B
         +GKqs66qH1upcyi3E79Tm8YTEuC3UjqcHpBHAVlOYcg/K+pk/fPOIhM+wYhMjLijb48H
         JafKqgy9I7oMh4gigFK/JvFpQnFRuR/aVf//OkFGT49cIP9kZG2quTJyiIryOwzGpFiK
         WRDA==
X-Received: by 10.60.21.101 with SMTP id u5mr591715oee.71.1360074468174; Tue,
 05 Feb 2013 06:27:48 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Tue, 5 Feb 2013 06:27:28 -0800 (PST)
In-Reply-To: <20130205112249.GE24973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215502>

On Tue, Feb 5, 2013 at 12:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 05, 2013 at 11:16:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Mon, Feb 4, 2013 at 5:36 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> > "git log/diff-files -U8" do not need "-p" to enable textual patche=
s,
>> > for example.  It is "I already told you that I want 8-line context=
=2E
>> > For what else, other than showing textual diff, do you think I tol=
d
>> > you that for?" and replacing "8-line context" with various other
>> > options that affect patch generation will give us a variety of end
>> > user complaints that would tell us that C) is more intuitive to
>> > them.
>>
>> On a related note I think "--full-diff" should imply "-p" too.
>
> I don't think that is in the same class. --full-diff is quite useful =
for
> many other diff formats. E.g.:
>
>   git log --full-diff --raw Makefile
>
> If you are proposing to default to "-p" when "--full-diff" is used bu=
t
> no format is given, that is a slightly different thing. The --full-di=
ff
> in such a case is indeed useless, but I do not think it necessarily
> follows that "-p" was what the user wanted.

You're right. I didn't notice that it could work with other things besi=
des -p.

On a related note then, it's a bit confusing that it's called
"--full-diff" when it doesn't actually show a diff.
