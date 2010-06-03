From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Thu, 3 Jun 2010 13:28:48 -0300
Message-ID: <AANLkTikUpyH6nmTfB4XbjQqJHHJOZiea4hn61tIH2ulR@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 
	<7vzkznqmir.fsf@alter.siamese.dyndns.org> <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com> 
	<AANLkTikKAkwHYj6OvfEJM1YE8w2TZL2oeMBrj28V3CwX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:29:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDIC-0006nM-EC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab0FCQ3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 12:29:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35681 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0FCQ3J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 12:29:09 -0400
Received: by yxl31 with SMTP id 31so131895yxl.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R6jfsMgoK9ykFGJMUL5ULPUcG37vJuvyNHWRDVk3l9Y=;
        b=WpshzYvMQf3JD9I1M3g8qjcYGTRUph6oBysYNwlVONaLmJwvPAf3+5iWe+tRO1Q4ZD
         oIywnb+IpH1e/HHWH6LzbaahoHTrp+bpO2HJBm8XsR/L2pNxpZe0Muv0fSIDHaCp+Qmr
         lxNrolhfvcgcVLiXr1MlnQ0lvcV4oiG6GNM5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QvHUnLnT2qbYXpgOIWH5siSQsxgQJRP86NLHHZ2yEiFqVq6tradCtt1ENXVMsYEtHx
         wDfI5WblmmxInWL8+TjE3tyaLlHwIwqiAZ+rMbmbHH5pAKyB7nQsL9F/BOqG/JKekTtN
         l6uLsOYcz3GvUZwxY8K5MGtF8lqt/pqU+Tjew=
Received: by 10.151.92.12 with SMTP id u12mr9423179ybl.93.1275582548220; Thu, 
	03 Jun 2010 09:29:08 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Thu, 3 Jun 2010 09:28:48 -0700 (PDT)
In-Reply-To: <AANLkTikKAkwHYj6OvfEJM1YE8w2TZL2oeMBrj28V3CwX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148345>

Hi Junio,

Just a small fix...

2010/5/26 Erik Faye-Lund <kusmabite@googlemail.com>:
> On Wed, May 26, 2010 at 4:52 PM, Erick Mattos <erick.mattos@gmail.com=
> wrote:
>> Hi,
>>
>> 2010/5/26 Junio C Hamano <gitster@pobox.com>
>>>
>>> Erick Mattos <erick.mattos@gmail.com> writes:
>>> > @@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv,=
 const char *prefix)
>>> > =C2=A0 =C2=A0 =C2=A0 if (opts.new_orphan_branch) {
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.new_bra=
nch)
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die("--orphan and -b are mutually exclusive");
>>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.track > 0 ||=
 opts.new_branch_log)
>>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 die("--orphan cannot be used with -t or -l");
>>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.track > 0)
>>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 die("--orphan should not be used with -t");
>>>
>>> Why s/cannot/should not/? =C2=A0Just being curious.
>>
>> I have typed that text, not changed the original so this is not a fi=
x
>> to your text.=C2=A0 Anyway for me "should not" is more polite, like =
"you
>> should not yell" meaning you really can not do it.=C2=A0 Or "you sho=
uld not
>> disrespect the captain".
>
> I don't think it makes sense to try and be polite when we're actually
> refusing... "should not" implies that it possible but not recommended=
=2E
> And in this case it's impossible, because we die()...

If you agree, please do that 's/should not/cannot/' on pu.

Regards
