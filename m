From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Tue, 22 Sep 2015 12:17:52 -0700
Message-ID: <CAPc5daXm9sBGAgrqz12d5a=zhR3PUXbFpPvOkBCoNQcQVhyOhw@mail.gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
 <1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
 <xmqqio73abl0.fsf@gitster.mtv.corp.google.com> <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
 <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
 <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com> <9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com>
 <xmqq8u7y5toe.fsf@gitster.mtv.corp.google.com> <CAO2U3QgehMcBrDUtChLLrn5VrH4jLE0CF5xDSShY72yycLryCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeT5A-0004Lm-H4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766AbbIVTSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 15:18:15 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34969 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124AbbIVTSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 15:18:13 -0400
Received: by ioiz6 with SMTP id z6so24367938ioi.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=oZXECJHNh0D6NW+TBT2weEv9ZGAr+G7FVjYdUvFZMPk=;
        b=Nm0OhupGBWBf/jUYRE44zG1fMiiY/YfPtgs95+qgHqT5PHH5nRdQAglAFPofw9SrLX
         0wu2UvVi3fRWbtJX7O5fq8j8ePnDC+c0qYg9aLZVgf35s46omIcxQkP7GRfx+TbCe2km
         TiW7a5OrlfWvS7PtlcXZcAhvuQAO9++KzZEjQTv5OejDc6s/H1O/Km+tbstOcNYRygG+
         1Uh/xq3OpIyJ5h3Hes+qdXmYt1bEO/wC9XNjhuD1yYo5GRn6hP20/L/tv2iRCs/Kp96M
         4U21niAX0YWMNv/B33LgBpKFJhxN/wo3geTD8iJuCPLPrYKL2GW2OuD88QOpVbfPEajG
         5y6w==
X-Received: by 10.107.155.78 with SMTP id d75mr39582298ioe.44.1442949492363;
 Tue, 22 Sep 2015 12:18:12 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Tue, 22 Sep 2015 12:17:52 -0700 (PDT)
In-Reply-To: <CAO2U3QgehMcBrDUtChLLrn5VrH4jLE0CF5xDSShY72yycLryCg@mail.gmail.com>
X-Google-Sender-Auth: MJSkedLmcgDavqjY8jayo3orSS0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278420>

Yup, this was privately reported and I just squashed a fix in right now=
 ;-)

Thanks. "cd t && make test-lint" would have caught it.

On Tue, Sep 22, 2015 at 12:11 PM, Michael Blume <blume.mike@gmail.com> =
wrote:
> I'm seeing test failures
>
> non-executable tests: t9825-git-p4-handle-utf16-without-bom.sh
>
> ls -l shows that all the other tests are executable but t9825 isn't.
>
> On Tue, Sep 22, 2015 at 9:02 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> This works.
>>
>> OK, and thanks; as I don't do perforce, the squash was without any
>> testing.
>>
>>> Do we need the =E2=80=9C-e=E2=80=9D option?
>>
>> In syntactic sense, no, but our codebase tends to prefer to have
>> one, because it is easier to spot which ones are the instructions if
>> you consistently have "-e" even when you give only one.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
