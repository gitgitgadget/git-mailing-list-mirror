From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 07/10] send-email: reduce dependencies impact on
 parse_address_line
Date: Wed, 8 Jul 2015 09:16:38 +0200
Message-ID: <559CCE56.7080808@web.de>
References: <vpq8uasqeru.fsf@anie.imag.fr>
 <1436276295-694-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 08 09:16:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjbA-0003gu-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbbGHHQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:16:48 -0400
Received: from mout.web.de ([212.227.15.4]:59158 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367AbbGHHQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:16:46 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lw0vl-1YwLPJ1Ni1-017pNn; Wed, 08 Jul 2015 09:16:40
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1436276295-694-1-git-send-email-Matthieu.Moy@imag.fr>
X-Provags-ID: V03:K0:IIi6OMP3D24jn6PwJpoFqmXA1bDLOn2qYQJJny7RmuJ/CAL8ZEr
 GU+ZYWOcDj8cP+6k97oV3ej+K7ZNpFKAyShnA82+zFqNxtA21z3IsmA6MaZr3EXpS8/HTMm
 oLzwlnRmm0/WxlscPmPkpYxMeRvt+fB4FWewPSh8kH0U67yAwCX9gt+E4NFFQtYIiXo0jUl
 nbWr/+OK28iwh4HFG/M2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XhSsGz9Cfgw=:dETbPPhUCN7PW1Qu84c+qP
 UBPTtR6/ehDvfLX8CMKGjlRtsyfvMTUc0HdHIy3TIWTmhOLbcJwAUJJAfYfAiHPUR8p85YaXT
 RwdFa1UFu/GBGGJpaq2dpYai4AMvSkf6sQ/VJc8aLpNJZxA74CSsUAEOfR/OmJzHy21LuzAYL
 QT2dHdI1SXl5jH1O+Vkf+Sl5+w2w0IwBmfwjPyNYAGLYeF6R9DAfbnIbj4ZDUBmEqsKON2x1X
 VqFfrrXdTjTYpJswEatZM8N6cvzrzCpYfeXAR7A56zA8Bd9hMuoOZQ6BN3iB2ElxwRyRAj7OW
 /jGce1C1EUd7xwvxm68zwOgxhavSQXHimTrx4+mymF+7OqyHJBPc3MUjK+M0x21tdnFTelZs0
 n1mQKxPv+5hsUlHVzcVaNHUL49kBI8UKmDQ4cbeAG86NwjQM2EbXH0CzweAEMfRoCDl3wt07d
 wgxR5ZKt/PJ8plf+EhQDwZzQj3RVgnOwRHsYAfusGd73nvfAPXkknlj22w/YTnSok5Qaw7Ql5
 rZUXm6icCnR7BCFOU/fpmEczman6bBNp7tgQiMB6Lznt97Z6We0mAnnGbe90P+6+Ofut+7rgn
 pPm0SjWWcUeMR6mThyI5+x6fT3yDSXW3p3l1PrUsj7KuTpc2HvMFLErdFJ2BhjHjw9YKmjn/f
 pU1KGppTfsQwCNtNopyEFJ6MaGcYELDrH6JD5sD4AwB2DgUj0A476xRW3DCpNr1g3tig=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273641>


(Thanks for the quick reply.
Sorry for the noise about
#!/usr/bin/perl
of course we call the right perl)

The new patch seems to be integrated in pu (I tested d08caa8e022f08d)
Test seems to pass, but some noise is on the channel:


Initialized empty Git repository in
/Users/tb/NoBackup/projects/git/git.next/t/trash directory.t9000-addresses/.git/
# run 0: Perl address parsing function (perl
/Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl)
ok 1 - use Git;
ok 2 - same output : Jane
ok 3 - same output : jdoe@example.com
ok 4 - same output : <jdoe@example.com>
ok 5 - same output : Jane <jdoe@example.com>
ok 6 - same output : Jane Doe <jdoe@example.com>
ok 7 - same output : "Jane" <jdoe@example.com>
ok 8 - same output : "Doe, Jane" <jdoe@example.com>
ok 9 - same output : "Jane@:;\>.,()<Doe" <jdoe@example.com>
ok 10 - same output : Jane!\#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
ok 11 - same output : "<jdoe@example.com>"
ok 12 - same output : "Jane jdoe@example.com"
ok 13 - same output : Jane Doe <jdoe    @   example.com  >
ok 14 - same output : Jane       Doe <  jdoe@example.com  >
ok 15 - same output : Jane @ Doe @ Jane @ Doe
ok 16 - same output : "Jane, 'Doe'" <jdoe@example.com>
ok 17 - same output : 'Doe, "Jane' <jdoe@example.com>
ok 18 - same output : "Jane" "Do"e <jdoe@example.com>
ok 19 - same output : "Jane' Doe" <jdoe@example.com>
ok 20 - same output : "Jane Doe <jdoe@example.com>" <jdoe@example.com>
ok 21 - same output : "Jane\" Doe" <jdoe@example.com>
ok 22 - same output : Doe, jane <jdoe@example.com>
ok 23 - same output : "Jane Doe <jdoe@example.com>
ok 24 - same output : 'Jane 'Doe' <jdoe@example.com>
not ok 25 - same output : Jane\ Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane\ Doe <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Jane \ Doe" <jdoe@example.com>'
#     $expected->[0] = '"Jane\ Doe" <jdoe@example.com>'
not ok 26 - same output : "Doe, Ja"ne <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : "Doe, Ja"ne <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Doe, Ja" ne <jdoe@example.com>'
#     $expected->[0] = '"Doe, Ja ne" <jdoe@example.com>'
not ok 27 - same output : "Doe, Katarina" Jane <jdoe@example.com> # TODO known
breakage
#   Failed (TODO) test 'same output : "Doe, Katarina" Jane <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Doe, Katarina" Jane <jdoe@example.com>'
#     $expected->[0] = '"Doe, Katarina Jane" <jdoe@example.com>'
not ok 28 - same output : Jane@:;\.,()<>Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane@:;\.,()<>Doe <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[1] = '\.'
#     $expected->[1] = '"\."'
not ok 29 - same output : Jane jdoe@example.com # TODO known breakage
#   Failed (TODO) test 'same output : Jane jdoe@example.com'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = 'Janejdoe@example.com'
not ok 30 - same output : <jdoe@example.com> Jane Doe # TODO known breakage
#   Failed (TODO) test 'same output : <jdoe@example.com> Jane Doe'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane Doe <jdoe@example.com>'
#     $expected->[0] = 'jdoe@example.comJaneDoe'
not ok 31 - same output : Jane <jdoe@example.com> Doe # TODO known breakage
#   Failed (TODO) test 'same output : Jane <jdoe@example.com> Doe'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane Doe <jdoe@example.com>'
#     $expected->[0] = 'Jane <jdoe@example.comDoe>'
not ok 32 - same output : "Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com> # TODO
known breakage
#   Failed (TODO) test 'same output : "Jane "Kat"a" ri"na" ",Doe"
<jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Jane " Kat "a" ri "na" ",Doe" <jdoe@example.com>'
#     $expected->[0] = '"Jane  Kat a ri na ,Doe" <jdoe@example.com>'
not ok 33 - same output : Jane Doe # TODO known breakage
#   Failed (TODO) test 'same output : Jane Doe'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = 'Jane Doe'
not ok 34 - same output : Jane "Doe <jdoe@example.com>" # TODO known breakage
#   Failed (TODO) test 'same output : Jane "Doe <jdoe@example.com>"'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = '"Jane Doe <jdoe@example.com>"'
not ok 35 - same output : \"Jane Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : \"Jane Doe <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '\ " Jane Doe <jdoe@example.com>'
#     $expected->[0] = '"\"Jane Doe" <jdoe@example.com>'
not ok 36 - same output : Jane\"\" Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane\"\" Doe <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane \ " \ " Doe <jdoe@example.com>'
#     $expected->[0] = '"Jane\"\" Doe" <jdoe@example.com>'
not ok 37 - same output : 'Jane "Katarina\" \' Doe' <jdoe@example.com> # TODO
known breakage
#   Failed (TODO) test 'same output : 'Jane "Katarina\" \' Doe' <jdoe@example.com>'
#   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = ''Jane " Katarina \ " \ ' Doe' <jdoe@example.com>'
#     $expected->[0] = '"'Jane  Katarina\" \' Doe'" <jdoe@example.com>'
1..37
# test_external test Perl address parsing function was ok
# expecting no stderr from previous command
# test_external_without_stderr test no stderr: Perl address parsing function was ok
