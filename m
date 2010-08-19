From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 15:04:11 +0000
Message-ID: <AANLkTi=t1FLi9eaFUdR1TDvoDcKaHVMcfp=HoyrR6_LZ@mail.gmail.com>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
	<20100819030237.GE18922@burratino>
	<4C6CE61F.7060305@viscovery.net>
	<AANLkTi=z6rs5U8N_piUUzR=t6oSNNF02RxVCws-1YRS1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 19 17:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om6fJ-0005AR-I4
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 17:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab0HSPEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 11:04:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44150 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab0HSPEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 11:04:13 -0400
Received: by fxm13 with SMTP id 13so1105435fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V3S2PQ29BS6eD23wmqPh2ZLnvb4rAudQGFsqYtziChQ=;
        b=KIROnQlhJFzh6nqfhP2reLOQTBzFXxysHPLpQi+PP0kZ9lmQgxXyHXHK2bbG9Diz80
         OpdIhE+jOIP/l8llssWlL1m8QL6MxCvgGgZgdgQmZqGekwzSCpCMlGPbRnLzofqZPU7S
         ROIE+SPByZ6HhmnmH61xn+y65SAfGZAEO3PtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZVIxZidtxc4jU9TwVXqLJ5no/FwWZcFTWwX0twuXb5kBPHexCF6jFOZ+pjxbYQREjZ
         kHR33MoZREX8o0U+YKx7p6ErrH88y8ImNCzbDE3Q4tDeyJlWT/rXtFXpJ8HUV1BMDCdA
         NipnJOso9pIVSYCHIRwdFg6/Whg7Y2XtKoW7g=
Received: by 10.223.119.210 with SMTP id a18mr9518974far.52.1282230251944;
 Thu, 19 Aug 2010 08:04:11 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 08:04:11 -0700 (PDT)
In-Reply-To: <AANLkTi=z6rs5U8N_piUUzR=t6oSNNF02RxVCws-1YRS1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153926>

On Thu, Aug 19, 2010 at 12:48, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Thu, Aug 19, 2010 at 08:06, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>
>> and I see these warnings:
>>
>> In file included from compat/regex/regex.c:71:
>> compat/regex/regex_internal.c: In function 're_string_reconstruct':
>> compat/regex/regex_internal.c:696: warning: unused variable 'prev_va=
lid_len'
>> In file included from compat/regex/regex.c:78:
>> compat/regex/regexec.c: In function 'check_arrival_add_next_nodes':
>> compat/regex/regexec.c:3062: warning: unused variable 'err'
>>
>> This happens because RE_ENABLE_I18N is not defined by regex_internal=
=2Eh. Is
>> this how it is supposed to be?
>
> I noted these in <1282015548-19074-1-git-send-email-avarab@gmail.com>=
,
> although I was off by one.
>
> I haven't read all the relevant code, but we almost definitely do not
> want RE_ENABLE_I18N, since we aren't doing the relevant setlocale()
> things (and doing so breaks git, see the fix in the ab/i18n series in
> pu).
>
> I was going to report this upstream once I got around to finding out
> what upstream *is*, I don't *think* gawk itself is the canonical
> upstream, they just copy it from somewhere else (again, I *think*).

I sent a patch for this upstream.
