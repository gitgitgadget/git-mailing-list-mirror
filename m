From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Wed, 23 Sep 2015 09:34:37 +0200
Message-ID: <3E330347-0F89-4E6F-8663-694AD3A559CC@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com> <1442829701-2347-2-git-send-email-larsxschneider@gmail.com> <xmqqio73abl0.fsf@gitster.mtv.corp.google.com> <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com> <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com> <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com> <9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com> <xmqq8u7y5toe.fsf@gitster.mtv.corp.google.com> <CAO2U3QgehMcBrDUtChLLrn5VrH4jLE0CF5xDSShY72yycLryCg@mail.gmail.com> <CAPc5daXm9sBGAgrqz12d5a=zhR3PUXbFpPvOkBCoNQcQVhyOhw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Blume <blume.mike@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 09:34:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeeZh-00048U-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 09:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbIWHel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 03:34:41 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37781 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbIWHek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 03:34:40 -0400
Received: by wicfx3 with SMTP id fx3so55907639wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gmkQxixazplDop8upPSdA1hT/zjx5UVx6oHgyNJ+aIk=;
        b=RFAzbyt0ZDzMi1+n4LhkOlXQ2+wui17RYuaLQbWFsoEBgIp1Vc8GydBICCt7w27br2
         NfgAQpHFLGw8Bb6727kpDF9KIrawQveDlRGeXDRcLlTfdG2SzM1qq9oar19k6A3HNE1L
         c1lkw85j0k2hmAIklLb4+Oy4bmlIW+8GsRxKbaQ9MmjGSFfBwd4u+ztI65XW/H/dhWUo
         dsB8m0wMksNkR6osvKtMdFfwZAiIlobGt5zlOxE9t8NNDDCxZOZa5hxRhxIvgfnuMqX1
         KZid+g1LgW0olYwf0vQXeGjSOKrR/mC0lCQ6e9L2WnMikSuhBLrnSM6j8r5Hc6p/dhLr
         tULQ==
X-Received: by 10.194.178.196 with SMTP id da4mr40051513wjc.41.1442993679067;
        Wed, 23 Sep 2015 00:34:39 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r9sm5748291wjz.35.2015.09.23.00.34.38
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 00:34:38 -0700 (PDT)
In-Reply-To: <CAPc5daXm9sBGAgrqz12d5a=zhR3PUXbFpPvOkBCoNQcQVhyOhw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278472>

Thanks a lot for taking care of this!

- Lars

On 22 Sep 2015, at 21:17, Junio C Hamano <gitster@pobox.com> wrote:

> Yup, this was privately reported and I just squashed a fix in right n=
ow ;-)
>=20
> Thanks. "cd t && make test-lint" would have caught it.
>=20
> On Tue, Sep 22, 2015 at 12:11 PM, Michael Blume <blume.mike@gmail.com=
> wrote:
>> I'm seeing test failures
>>=20
>> non-executable tests: t9825-git-p4-handle-utf16-without-bom.sh
>>=20
>> ls -l shows that all the other tests are executable but t9825 isn't.
>>=20
>> On Tue, Sep 22, 2015 at 9:02 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>=20
>>>> This works.
>>>=20
>>> OK, and thanks; as I don't do perforce, the squash was without any
>>> testing.
>>>=20
>>>> Do we need the =93-e=94 option?
>>>=20
>>> In syntactic sense, no, but our codebase tends to prefer to have
>>> one, because it is easier to spot which ones are the instructions i=
f
>>> you consistently have "-e" even when you give only one.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
