From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] tests: use test_cmp instead of piping to diff(1)
Date: Wed, 15 Sep 2010 01:17:51 +0200
Message-ID: <4C90029F.6020909@web.de>
References: <1284411582-1088-1-git-send-email-avarab@gmail.com>	<7vy6b59q5a.fsf@alter.siamese.dyndns.org> <AANLkTinGt6d8tKh8yOT0SJpcgsv+KgrE4jPT2_RgGzeG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 01:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvelC-0002rx-O1
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0INXRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 19:17:53 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36077 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab0INXRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 19:17:53 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id B51C717019059;
	Wed, 15 Sep 2010 01:17:51 +0200 (CEST)
Received: from [93.246.48.208] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Ovel5-00018z-00; Wed, 15 Sep 2010 01:17:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinGt6d8tKh8yOT0SJpcgsv+KgrE4jPT2_RgGzeG@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18q45RvjmI0NcACQI1M3pvejYBP4Lou2ZYAlBGI
	1YQhDfC7+idsTFP7E2OIo9DACqV1ncfCGLTLbdTtz1+nayVsgZ
	sT0ZbCpi1j1POqAN7Zig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156217>

Am 14.09.2010 03:45, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Mon, Sep 13, 2010 at 23:31, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> @@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
>>>  test_expect_success 'added submodule' "
>>>       git add sm1 &&
>>>       git diff-index -p --submodule=3Dlog HEAD >actual &&
>>> -     diff actual - <<-EOF
>>> +     cat >expected <<-EOF &&
>>>  Submodule sm1 0000000...$head1 (new submodule)
>>>  EOF
>>> +    test_cmp expected actual
>>>  "
>>
>> Nit.  Did you really mean <<-EOF, not <<EOF, here, especially you ar=
e
>> writing the here document without indentation with any TAB?
>=20
> I just meant to replace the diff invocations with test_cmp. Changing
> the surrounding here-docs was outside the scope of the patch.

I plead guilty for introducing the "<<-EOF"s in the first place by
simply copying the frame for this test from t7401. But me too thinks
the "test_cmp" should have TABs in front of them instead of spaces.

With the "TAB in front of test_cmp" issue fixed you may add:
Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
