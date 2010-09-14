From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: use test_cmp instead of piping to diff(1)
Date: Tue, 14 Sep 2010 01:45:24 +0000
Message-ID: <AANLkTinGt6d8tKh8yOT0SJpcgsv+KgrE4jPT2_RgGzeG@mail.gmail.com>
References: <1284411582-1088-1-git-send-email-avarab@gmail.com>
	<7vy6b59q5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 03:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvKac-0005T8-JU
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 03:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab0INBp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 21:45:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35822 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0INBpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 21:45:25 -0400
Received: by iwn5 with SMTP id 5so5642810iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WMNQXyBh/GNv4aInRsjvUjHWWaFxAuMtIfIiK2wTWq4=;
        b=qwB9MI0oJRDBxupHjtHbMCKBMZjjKcqk9aAW8y1F5wwbpI3eDY56mxLqYbbTXa3xj3
         vfnwp9k6UJPQP2VlfZOcy1vwyEePNIKJmCYkz9ChmUzZF45D/e0BUnfyovMquURt7MDg
         hXqdcQmM93a2q6eSs+Vr90Lpb/+ClwuNnkW2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VKZG8DkasrvLPBhfT0DVxZdnRtE/gwcZrwh8EgZz2osEj/0J+WdLGjHvNycBDgNX1N
         E7DTg1RJAPkilTS6Idpfndjfik4wCJYqEHA7+MithIJamQj3tv5zWKnxdsq/euZFsRQn
         9ZHKVQ2zsn0KCwinR/aHJK6h11DirAK3hd5eU=
Received: by 10.231.145.16 with SMTP id b16mr7027541ibv.198.1284428724496;
 Mon, 13 Sep 2010 18:45:24 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 13 Sep 2010 18:45:24 -0700 (PDT)
In-Reply-To: <7vy6b59q5a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156158>

On Mon, Sep 13, 2010 at 23:31, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> @@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
>> =C2=A0test_expect_success 'added submodule' "
>> =C2=A0 =C2=A0 =C2=A0 git add sm1 &&
>> =C2=A0 =C2=A0 =C2=A0 git diff-index -p --submodule=3Dlog HEAD >actua=
l &&
>> - =C2=A0 =C2=A0 diff actual - <<-EOF
>> + =C2=A0 =C2=A0 cat >expected <<-EOF &&
>> =C2=A0Submodule sm1 0000000...$head1 (new submodule)
>> =C2=A0EOF
>> + =C2=A0 =C2=A0test_cmp expected actual
>> =C2=A0"
>
> Nit. =C2=A0Did you really mean <<-EOF, not <<EOF, here, especially yo=
u are
> writing the here document without indentation with any TAB?

I just meant to replace the diff invocations with test_cmp. Changing
the surrounding here-docs was outside the scope of the patch.
