From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Tue, 13 Mar 2012 20:19:45 +0100
Message-ID: <4F5F9DD1.50907@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de> <4F5CC08C.90703@web.de> <7vzkbnvt6m.fsf@alter.siamese.dyndns.org> <4F5D14CD.6080507@web.de> <7vzkbmvmvx.fsf@alter.siamese.dyndns.org> <4F5E6362.7050001@web.de> <7vmx7lpl5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:20:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7XGK-0006Ak-4h
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 20:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759271Ab2CMTTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 15:19:55 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:43504 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759152Ab2CMTTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 15:19:54 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id D84BCE4F3C5
	for <git@vger.kernel.org>; Tue, 13 Mar 2012 20:19:52 +0100 (CET)
Received: from wanderer.site ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LyUy6-1SRpVB1pwc-015lmj; Tue, 13 Mar 2012 20:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <7vmx7lpl5a.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:yFn/ONNFUoNpcGQEcTDCbwgCDSEZQgPXrouGg66D5YK
 j5jRQ/4okwoggSlC1GQNw3A7oxvvVI/SdjrQrBewPkbXASTutw
 E6/EQppbk6Y98+fd8y5uU75bsJZAYA6THbvTIYvAQZgUj1m52R
 iqcL6fwxI+qAwr+8If7ouSle+IvMFJtO2pgKqYL7SblRd1Vc2w
 c/nNlkMLZETZZCeVbWx1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193060>

> -- >8 --
> Subject: i18n: fix auto detection of gettext scheme for shell scripts
>
> A new code added by ad17ea7 (add a Makefile switch to avoid gettext
> translation in shell scripts, 2012-01-23) tried to optionally force
> a gettext scheme to "fallthrough", but ended up forcing it to everybody.
>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>   git-sh-i18n.sh |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
> index d5fae99..6a27f68 100644
> --- a/git-sh-i18n.sh
> +++ b/git-sh-i18n.sh
> @@ -21,7 +21,7 @@ GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
>   if test -n "@@USE_GETTEXT_SCHEME@@"
>   then
>   	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
> -elif test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
> +elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
>   then
>   	: no probing necessary
>   elif test -n "$GIT_GETTEXT_POISON"
> --
Thanks for the patch. Here are the results of t0204:
a) Suse 12.1
# lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
# lib-gettext: No is_IS ISO-8859-1 locale available
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / 
Icelandic (missing GETTEXT_ISO_LOCALE)
ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / 
Runes (missing GETTEXT_ISO_LOCALE)
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing 
GETTEXT_ISO_LOCALE)
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing 
GETTEXT_ISO_LOCALE)
# passed all 8 test(s)
1..8
====================
b) Ubuntu 10.4:
tb@maxi:~/projects/git/tb/t$ ./t0204-gettext-reencode-sanity.sh
# lib-gettext: No is_IS UTF-8 locale available
# lib-gettext: No is_IS ISO-8859-1 locale available
ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / 
Icelandic (missing GETTEXT_LOCALE)
ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes 
(missing GETTEXT_LOCALE)
ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / 
Icelandic (missing GETTEXT_ISO_LOCALE)
ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / 
Runes (missing GETTEXT_ISO_LOCALE)
ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing 
GETTEXT_LOCALE)
ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing 
GETTEXT_ISO_LOCALE)
ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing GETTEXT_LOCALE)
ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing 
GETTEXT_ISO_LOCALE)
# passed all 8 test(s)
1..8
==============
c) Mac OS
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icelandic
not ok - 4 gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Runes
#
#           LANGUAGE=is LC_ALL="$is_IS_iso_locale" gettext "TEST: Old 
English Runes" >runes &&
#
#               if grep "^TEST: Old English Runes$" runes
#               then
#                       say "Your system can not handle this complexity 
and returns the string as-is"
#               else
#                       # Both Solaris and GNU libintl will return this 
stream of
#                       # question marks, so it is s probably portable 
enough
#                       printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? 
????? ??????????? ??? ?? ????" >runes-expect &&
#                       test_cmp runes-expect runes
#               fi
#
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
# failed 1 among 8 test(s)
1..8
==============
(But that was expected, wasn't it? I added your original t0204 patch on 
top of that, and here we go:
==============
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icelandic
ok 4 - gettext: impossible ISO-8859-1 output
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
# passed all 8 test(s)
1..8
/Torsten
