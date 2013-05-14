From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Problems with Windows, Was: What's cooking in git.git (May 2013,
 #01; Fri, 3)
Date: Tue, 14 May 2013 21:37:34 +0200
Message-ID: <5192927E.3030203@web.de>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de> <518BDA49.400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mlevedahl@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	j6t@kdbg.org, msysGit <msysgit@googlegroups.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 14 21:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcL2e-00027f-VY
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab3ENThk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 May 2013 15:37:40 -0400
Received: from mout.web.de ([212.227.15.4]:49518 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab3ENThj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:37:39 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MgfJz-1UqPuL3eml-00NNM8; Tue, 14 May 2013 21:37:36
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518BDA49.400@ramsay1.demon.co.uk>
X-Provags-ID: V02:K0:EAfp8d3nv705q1vTBC3bnAj+cuplslb0pXr7hyIWZXj
 1QUd4kaWe/Lk0a9jMYnY8BqFRHKUGqZe1BIieKmnK0/elzB+uZ
 VWjrGWz/LaJjtM7rMHsWmPpMtldMZ73gT/+MWzMkkC9Vq0JS1X
 HZ2hKAgzHxwMFguMKx1q908pSGwqRhPPVVob0OVDqvu9Cg2fhD
 Jr/9Tmz7lrDoE6ji/Ix3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224324>

On 2013-05-09 19.18, Ramsay Jones wrote:
> Torsten B=F6gershausen wrote:
>> On 2013-05-04 01.14, Junio C Hamano wrote:
>>>
>>>  Cygwin portability; both were reviewed by Jonathan, and the tip on=
e
>>>  seems to want a bit further explanation.  Needs positive report
>>>  from Cygwin 1.7 users who have been on 1.7 to make sure it does no=
t
>>>  regress for them.
>>
>> I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.
>>
>> Running the test suite under cygwin doesn't seem to work any more (?=
):
>>
>> Scenario 1:
>> The PC is running alone, and goes into the screen saver.
>> Pressing CTRL-ALT-DEL didn't get any effect.
>>
>> Scenario 2:
>> The PC didn't react any more, when the test suite was run in backgro=
und.
>> In 3 or 4 cases the PC needed to be reboot hardly.
>>
>> Using the commits before and after this change makes the test suite =
hang=20
>> as well at some point, then it hangs somewhere at TC 3000--4000.
>>
>> Scenario 4:
>> The I disabled the screensaver, upgdated cygwin,
>>  and went back to an older commit:
>> The latest run from commit 52d63e70, April 28,
>> hangs in TC 5500, ok 26 clone shallow object count.
>>
>> I can see 2 times=20
>> git.exe pull --depth 4 ..A=20
>>
>> Scenario 5:
>> The run of today 1.8.3-rc1, hangs in t5510,
>> some git.exe are running fetch. (or pull)
>>
>>
>> It seems as if some process/exes are not terminated
>> in the way it should be.
>>
>> I will try on a different machine,
>> comments are wellcome
>=20
> Hmm, I'm a little puzzled, but not shocked. ;-)
>=20
> Somebody, I forget who, had already tested Jonathan's patch
> on cygwin 1.7 successfully and my follow up patch should be
> a no-op on cygwin 1.7; so I'm puzzled! (The high risk should
> have been on cygwin 1.5).
>=20
> I'm not shocked because running the test-suite on cygwin has
> been a bit of a magical mystery tour for quite some time.
>=20
> In about 2007, I could not run the test-suite for about six
> to nine months; it would randomly wedge my laptop solid - I had
> to pull the power-cord out in order to re-boot. (I suspect that
> commit 9cb18f56fde may have cured that particular problem, but
> don't quote me on that - I didn't investigate at the time.)
>=20
> I have noticed that running the tests with 'prove' is more likely
> to prove successful, so my config.mak looks like:
>=20
>     $ cat config.mak
>     NO_SVN_TESTS=3D1
>     GIT_TEST_OPTS=3D--no-color
>     NO_GETTEXT=3D1
>     DEFAULT_TEST_TARGET=3Dprove
>     GIT_PROVE_OPTS=3D'--timer'
>     $
>=20
> I currently run the tests like so:
>=20
>     $ time $(GIT_SKIP_TESTS=3D't0061.3 t0070.3 t4130 t9010 t9300' mak=
e test \
>     >test-outp13 2>&1)
>=20
>     real    172m25.311s
>     user    132m15.133s
>     sys     66m43.122s
>     $
>=20
> The t0061.3 and t0070.3 failures don't require much discussion. The t=
4130
> failure is an intermittent "racy git" issue that has been on my TODO =
list
> for several years. t9300 also fails intermittently. However, t9010 fa=
ils
> every time for me, hanging the test suite (although ^C interrupts it =
just
> fine).
>=20
> I have a "fix" for t9010 that looks like:
>=20
>     diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
>     index b7eed24..4d01e3b 100755
>     --- a/t/t9010-svn-fe.sh
>     +++ b/t/t9010-svn-fe.sh
>     @@ -22,10 +22,9 @@ try_dump () {
>             maybe_fail_fi=3D${3:+test_$3} &&
>    =20
>             {
>     -               $maybe_fail_svnfe test-svn-fe "$input" >stream 3<=
backflow &
>     -       } &&
>     -       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 <stream =
3>backflow &&
>     -       wait $!
>     +               $maybe_fail_svnfe test-svn-fe "$input" 3<backflow
>     +       } |
>     +       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 3>backfl=
ow
>      }
>    =20
>      properties () {
>=20
> but I have not tested this patch enough to be happy to submit it (I h=
ave
> some suspicions that it would still fail intermittently, just like t9=
300).
>=20
> Also, commit 7bc0911d ("test-lib: Fix say_color () not to interpret \=
a\b\c
> in the message", 11-10-2012) caused several random test failures. (do=
n't ask
> me why). So, before each test run, I have to apply the following:
>=20
>     diff --git a/t/test-lib.sh b/t/test-lib.sh
>     index f50f834..ed32b7f 100644
>     --- a/t/test-lib.sh
>     +++ b/t/test-lib.sh
>     @@ -230,7 +230,7 @@ else
>             say_color() {
>                     test -z "$1" && test -n "$quiet" && return
>                     shift
>     -               printf "%s\n" "$*"
>     +               echo -E "$*"
>             }
>      fi
>=20
> which effectively reverts that commit.
>=20
> So, as I said, a "magical mystery tour". :-D
>=20
> ATB,
> Ramsay Jones
>=20
>=20
=46irst of all,
the patch we are talking about does not any regrssions at my side.

Second,
I was able to do some testing.
The hanging is not 100% reproducable, and I had one hanging in Git 1.8.=
1

Turning the screen saver off in Win XP helps that the machine reacts,
and using process explorer showed that the hanging is happening
in test cases doing "git fetch" (or git pull) from a local repository.
What I can see is one git-fetch.exe together with git-upload-pack.exe

=46rom my understanding is the upload-pack a "forked" exe from the main=
 git,
and they should talk to each other.
One interesting part is in run-command.c, and there we have different c=
ode for MiNGW
and the "rest of the world", Linux/Unix/cygwin.

I tried to steal the code around mingw_spawnvpe(), but could not get th=
at working (yet).

Another approach could be to steal the pipe() from mingw.

Does anybody know if we have a similar problem (hanging TC which test f=
etch/pull)
in MinGW/msysGit?

If no, why not ;-)

Thanks for reading
/Torsten
