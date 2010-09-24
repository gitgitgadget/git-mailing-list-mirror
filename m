From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 12:56:31 +0000
Message-ID: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 14:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz7pO-0001bG-B9
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 14:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab0IXM4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 08:56:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab0IXM4c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 08:56:32 -0400
Received: by iwn5 with SMTP id 5so2401435iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=tWkUEaj7j2f8lP4c97i7v5V9sdjOkEvHUBCiD9fxp14=;
        b=XTSKnoSdL89anDNMgdXbcfK4Thi6kdR1gto76FECcQqgaTXBjqqQiYDoeyKjJYxvHr
         Sl93KbWy893J7eD5epXRXWLmVoBa5LiU0Nh1DHTaLmrbKeS3WkMvJwt/oyIjzNmA95bw
         RekjozD8kr/NcUO9kRjnxkHOpkRDm5gV6uEwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jEtqIJqYXx65XpD4kCZ3OGAJwQbeWZOREwBf+/kOOD8GtUEMYmiydj60NMYNEIwbV+
         rD7QCjst4UU+jRnIDLkI9RlYe5D6ps26T4+duI+gRnWvIy6Ucm8AvQEpegNJ6W2GXUxh
         JyXwyrR2xMFJwpYzwhAItB+c0cbpvCypcV7pE=
Received: by 10.231.193.11 with SMTP id ds11mr2232670ibb.192.1285332991095;
 Fri, 24 Sep 2010 05:56:31 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 05:56:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156983>

On Fri, Sep 24, 2010 at 11:22, Tor Arntsen <tor@spacetec.no> wrote:
> On Fri, Sep 24, 2010 at 13:05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> On Fri, Sep 24, 2010 at 10:27, Tor Arntsen <tor@spacetec.no> wrote:
> [..]
>>> I've found that for add -p you'll need 5.8.x or newer, due to stuff=
 like
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $fh =3D u=
ndef;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open($fh, '-=
|', @_) or die;
>>>
>>> which fails in e.g. perl 5.6.
>>> There could be some other stuff (in addition to add -p) that also d=
oes
>>> this kind of thing.
>>
>> If that's the case (I don't have a 5.6 here to do archeology on) the=
n
>> git add -p never worked in 5.6. That was added in 5cde71d6 when it w=
as
>> introduced in 2006:
>>
>> =C2=A0 =C2=A0+sub run_cmd_pipe {
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 my $fh =3D undef;
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 open($fh, '-|', @_) or die;
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 return <$fh>;
>> =C2=A0 =C2=A0+}
>>
>> Can you show us the specific error you're getting, and the output of
>> your `perl -V` ?
>
> I don't have that particular installation anymore (I installed perl
> 5.8 on the machine I had trouble with), and the only other system I
> have left with perl 5.6 only has an old Git 1.5 version. But it's eas=
y
> enough to reproduce, Perl 5.6 simply doesn't support that notation.
> Put the code above in a perl script and execute it:
>
> Can't use an undefined value as filehandle reference at test-pl.pl li=
ne 5.
> (that's the 'open' line)
>
> I can provide the output of -V if you wish, but I don't think it
> matters really, except for the version:

It matters because you keep saying "5.6", which is ambiguous since the
syntax in question was introduced in 5.6.1. The error you may be
having on 5.6.0 is very different from 5.6.1, and 5.6.2 has additional
bugfixes:

    http://search.cpan.org/~jesse/perl-5.12.2/pod/perl561delta.pod#open=
()_with_more_than_two_arguments

Anyway, I compiled maint-5.6 from perl.git and confirmed this:

    $ /home/avar/perl5/installed/bin/perl5.6.2 -Mdiagnostics -le
'print $]; sub run_cmd_pipe { my $fh =3D undef; open($fh, "-|", @_) or
die;  return <$fh>; } print run_cmd_pipe(qw(git --help));'
    5.006002
    Can't use an undefined value as filehandle reference at -e line 1 (=
#1)
        (F) A value used as either a hard reference or a symbolic refer=
ence must
        be a defined value.  This helps to delurk some insidious errors=
=2E

    Uncaught exception from user code:
            Can't use an undefined value as filehandle reference at -e =
line 1.
            main::run_cmd_pipe('git', '--help') called at -e line 1

As compared to a more recent perl:

    $ perl -Mdiagnostics -le 'print $]; sub run_cmd_pipe { my $fh =3D
undef; open($fh, "-|", @_) or die;  return <$fh>; } print
run_cmd_pipe(qw(git --help));'
    5.013004
    usage: git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path=
]
    [...]

And to reply to Alex Riesen I can't get this to work with `my $fh`
(which would be undef too) or glob open either. Although it should be
possible with other types of pipe open, or even using temporary files.

    $ /home/avar/perl5/installed/bin/perl5.6.2 -Mdiagnostics -le
'print $]; sub run_cmd_pipe { local *TMP; open(TMP, "-|", @_) or die;
return <TMP>; } print run_cmd_pipe(qw(git --help));'
    5.006002
    Can't use an undefined value as filehandle reference at -e line 1 (=
#1)
        (F) A value used as either a hard reference or a symbolic refer=
ence must
        be a defined value.  This helps to delurk some insidious errors=
=2E

    Uncaught exception from user code:
            Can't use an undefined value as filehandle reference at -e =
line 1.
            main::run_cmd_pipe('git', '--help') called at -e line 1

However, I'd like to shift the discussion a bit: Do we want to support
the 5.6 line *at all* anymore? I don't think so. As you point out
yourself you can just compile 5.8 or later on these machines.

I just tried running our test suite with maint-5.6 after compiling with=
:

    NO_PERL_MAKEMAKER=3D1
PERL_PATH=3D/home/avar/perl5/installed/bin/perl5.6.2
prefix=3D/opt/git/perl-56 all install

NO_PERL_MAKEMAKER=3D1 is needed because the ExtUtils::MakeMaker that
comes with 5.6.2 doesn't know how to move perl/private-Error.pm to
perl/blib/*/Error.pm. So if you don't provide it you'll get:

    $ /opt/git/perl-56/bin/git add -p
    Can't locate Error.pm

That would also break e.g. git-send-email.

Here are the test results *without* NO_PERL_MAKEMAKER=3D1, for
reference:

    Test Summary Report
    -------------------
    t2016-checkout-patch.sh                          (Wstat: 256
Tests: 14 Failed: 12)
      Failed tests:  2-13
      Non-zero exit status: 1
    t3701-add-interactive.sh                         (Wstat: 256
Tests: 33 Failed: 17)
      Failed tests:  2, 4-5, 7, 9-10, 13, 16, 18, 21-25, 29
                    31, 33
      Non-zero exit status: 1
    t3904-stash-patch.sh                             (Wstat: 256
Tests: 5 Failed: 2)
      Failed tests:  3-4
      Non-zero exit status: 1
    t7105-reset-patch.sh                             (Wstat: 256
Tests: 8 Failed: 6)
      Failed tests:  2-7
      Non-zero exit status: 1
    t7501-commit.sh                                  (Wstat: 256
Tests: 42 Failed: 1)
      Failed test:  21
      Non-zero exit status: 1
    t7800-difftool.sh                                (Wstat: 256
Tests: 22 Failed: 21)
      Failed tests:  2-22
      Non-zero exit status: 1
    t9700-perl-git.sh                                (Wstat: 256
Tests: 2 Failed: 1)
      Failed test:  2
      Non-zero exit status: 1
      Parse errors: No plan found in TAP output
    t9001-send-email.sh                              (Wstat: 256
Tests: 85 Failed: 59)
      Failed tests:  4-7, 9-10, 12-13, 15, 17-20, 22, 24, 26
                    28-30, 32, 34, 36, 38, 40, 42, 44, 46, 48-55
                    58-77, 80-82, 85
      Non-zero exit status: 1

And with NO_PERL_MAKEMAKER=3D1:

    Test Summary Report
    -------------------
    t2016-checkout-patch.sh                          (Wstat: 256
Tests: 14 Failed: 12)
      Failed tests:  2-13
      Non-zero exit status: 1
    t3904-stash-patch.sh                             (Wstat: 256
Tests: 5 Failed: 2)
      Failed tests:  3-4
      Non-zero exit status: 1
    t3701-add-interactive.sh                         (Wstat: 256
Tests: 33 Failed: 17)
      Failed tests:  2, 4-5, 7, 9-10, 13, 16, 18, 21-25, 29
                    31, 33
      Non-zero exit status: 1
    t7105-reset-patch.sh                             (Wstat: 256
Tests: 8 Failed: 6)
      Failed tests:  2-7
      Non-zero exit status: 1
    t7501-commit.sh                                  (Wstat: 256
Tests: 42 Failed: 1)
      Failed test:  21
      Non-zero exit status: 1
    t9700-perl-git.sh                                (Wstat: 256
Tests: 14 Failed: 0)
      Non-zero exit status: 1
      Parse errors: No plan found in TAP output

All but the last error are due to this bug in
git-add--interactive.perl. I didn't track down what was wrong with
t9700-perl-git.sh.

git-svn would have failed too if I had SVN libraries:

    $ /opt/git/perl-56/bin/git svn
    Can't locate Digest/MD5.pm in @INC [...]

Getting a working Digest::* (and anything else git-svn needs) for 5.6
at this point is a *lot* harder than just compiling 5.8 (or even
better, 5.12).

Since we're not getting patches for common things that have been
broken on 5.6 for years and bumping the requirenment to an 8 year old
perl (5.8) instead of a 10 year old one (5.6) would make things much
easier, including:

 * Fixing the perl/ Makefile mess

 * Being able to use 5.8 features

 * Being able to honestly support the 5.8 release, 5.6 doesn't even
   compile on modern systems without undocumented monkeypatches, and
   few people use it so we don't get fixes for it.

I'd like to propose dropping 5.6 support, and move to say 5.008. I can
do the work required to add appropriate docs / use statements and
fixes to bugs that we can't fix on 5.6.
