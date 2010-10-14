From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests with TAP
Date: Thu, 14 Oct 2010 09:33:11 +0000
Message-ID: <AANLkTinDq4FOZd7v5C8HZ7S81xoO6nJZTEe4+-9AO8HQ@mail.gmail.com>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
	<AANLkTimuoanpbFbyv9C8qUbut22me1gMhH02eLqg0Nyd@mail.gmail.com>
	<4CB6CB97.7040009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:33:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KBc-0005sO-3a
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab0JNJdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:33:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49146 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab0JNJdO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:33:14 -0400
Received: by fxm4 with SMTP id 4so2248255fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nwl4nyksGrZK+YFywWo1w9d7aHVAsvfw67clDK8oX6k=;
        b=svhIZf4RZtYD5FXf0dCD2XJcK2bGMubjgDzRy18dLIAfp58cneRpA9iiDJKrIHMEXw
         VfyQaVFCDzDCSab8MEMPd3YV/6+dL3cjXThkOytKXBOub2dxvjo54850qachGvwTpIKw
         xKI03/97Jfhmti/V7rofd7WvyjGaBE18e2kvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Byf0+xD7AMD58NKXjYe99DrlXQPNUk2oUuiNHNEicdflD2I6efI8GqBcUczzg3VLOI
         S3ZUH1pUUfGQNVL0HFPwHveVb+D1SKgmlLh1EySPg/nuuhtzVibUlQIQ3XRpuuzKVfVf
         jJRFFm/AoXqxNOsO/dNnJbQrXJefc/ExQ03F8=
Received: by 10.103.40.1 with SMTP id s1mr1791070muj.4.1287048791298; Thu, 14
 Oct 2010 02:33:11 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 02:33:11 -0700 (PDT)
In-Reply-To: <4CB6CB97.7040009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159036>

On Thu, Oct 14, 2010 at 09:21, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 14.10.2010=
 11:05:
>> On Thu, Oct 14, 2010 at 08:53, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Introduce a new make target "prove" which runs the tests via "prove=
" (or
>>> $(PROVE) if set) so that one does not have to cd around any more. O=
ne
>>> can simply use "make prove" for "make test" or go wild as in:
>>>
>>> GIT_SKIP_TESTS=3D't[0-4]??? t91?? t9200.8' GIT_PROVE_OPTS=3D"-j9 -v=
" GIT_TEST_OPTS=3D"--verbose --debug" make prove
>>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>> RFC also because of lack of doc, and:
>>>
>>> Currently, one can do
>>>
>>> make -C t t6010-merge-base.sh
>>>
>>> or even
>>>
>>> make -C t t601*
>>>
>>> which is cool but undocumented. If we want this with prove it requi=
res more
>>> effort, or shoving prove into the $(T) target rule which is doable,=
 of course.
>>> I'm just wondering whether it's accepted to introduce a specific ru=
le for prove
>>> at all.
>>
>> I like the rationale behind this, but fwiw. I already had a patch th=
at
>> was ejected for this:
>>
>> =C2=A0 =C2=A0 http://article.gmane.org/gmane.comp.version-control.gi=
t/146566
>>
>> Quoth Junio:
>>
>> =C2=A0 =C2=A0 "Besides, "make -j15 test" from the toplevel already r=
uns the
>> =C2=A0 =C2=A0 tests in parallel. =C2=A0I don't see much point in thi=
s change."
>>
>
> Sorry for the kind of dupe then. Though I can understand that the fix=
ed
> options back then didn't find Junio's approval. Maybe it's different
> now, when it's completely interchangeable with make test?

Maybe. I try not to decipher him too much :)

But a patch for this that'd be acceptable would be great. Good that
you're working on it.

>> But I'd like to have it so that I could `make && make test_harness`
>> and get readable test output.
>>
>> But we should probably be using t/harness to run them, not
>> prove(1). Then we would make the test_harness target respect the
>> HARNESS_OPTIONS variable, which I e.g. have set to HARNESS_OPTIONS=3D=
j9
>> on my system.
>
> Didn't know about that one either. What does t/harness
> differently/better from/than prove? Does it take the same options? Is
> t/harness respecting the SHELL_PATH for the tests? Running a test und=
er
> make test and make prove/harness needs to be completely equivalent.

t/harness is just using the library that prove(1) uses directly. We
already use it for "make smoke". The advantage is that you can run
custom setup code there, e.g. this is from perl.git's own t/harness:

    my $jobs =3D $ENV{TEST_JOBS};
    my ($rules, $state, $color);
    if ($ENV{HARNESS_OPTIONS}) {
        for my $opt ( split /:/, $ENV{HARNESS_OPTIONS} ) {
            if ( $opt =3D~ /^j(\d*)$/ ) {
                $jobs ||=3D $1 || 9;
            }
            elsif ( $opt eq 'c' ) {
                $color =3D 1;
            }
            else {
                die "Unknown HARNESS_OPTIONS item: $opt\n";
            }
        }
    }

So if we expanded t/harness to use that and added a "test_harness"
target we could make it grok the TEST_JOBS and HARNESS_OPTIONS
environment variables.

The output would be the same (see "make smoke"), and we can make it
respect SHELL_PATH.
