From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv5 3/6] Gitweb: add autoconfigure support for minifiers
Date: Fri, 02 Apr 2010 13:28:42 -0400
Message-ID: <4BB6294A.7020800@mailservices.uwaterloo.ca>
References: <4BB430D9.1090900@mailservices.uwaterloo.ca> <201004020040.26177.jnareb@gmail.com> <CBD7C6CF-01CB-4525-8AAB-B1E8086CA06E@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 19:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxkgP-0003gP-Jd
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 19:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab0DBR3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 13:29:22 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:51747 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755861Ab0DBR3U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 13:29:20 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o32HSgqE000777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 13:28:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <CBD7C6CF-01CB-4525-8AAB-B1E8086CA06E@mailservices.uwaterloo.ca>
X-UUID: 9c60bc8a-d1cf-4248-a85f-4425999c3c4f
X-Miltered: at mailchk-m05 with ID 4BB6294A.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 13:28:44 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143830>

>> Makefile        |    4 ----
>> configure.ac    |   20 ++++++++++++++++++++
>> gitweb/Makefile |   14 ++------------
>> 3 files changed, 22 insertions(+), 16 deletions(-)
>
> Why there is no change to config.mak.in?  I would thought that it
> would contain JSMIN=3D@JSMIN@ etc.
>
> But see also below: perhaps current version is a better version.
>
=20
I don't understand what you mean by this. Are you saying that the
patch is good as is?
=20
=20
>> export prefix bindir sharedir sysconfdir
>>
>> CC =3D gcc
>> diff --git a/configure.ac b/configure.ac
>> index 914ae57..bf36c72 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -179,6 +179,26 @@ fi],
>>    AC_MSG_NOTICE([Will try -pthread then -lpthread to enable
>> POSIX Threads.])
>> ])
>>
>> +# Define option to enable JavaScript minification
>> +AC_ARG_ENABLE([jsmin],
>> + [AS_HELP_STRING([--enable-jsmin=3DARG],
>> +   [ARG is the value to pass to make to enable
>> JavaScript minification.])],
>> + [
>> +   JSMIN=3D$enableval;
>> +   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable
>> JavaScript minifying])
>> +   GIT_CONF_APPEND_LINE(JSMIN=3D$enableval);
>> + ])
>> +
>> +# Define option to enable CSS minification
>> +AC_ARG_ENABLE([cssmin],
>> + [AS_HELP_STRING([--enable-cssmin=3DARG],
>> +   [ARG is the value to pass to make to enable CSS minification.])]=
,
>> + [
>> +   CSSMIN=3D$enableval;
>> +   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifyi=
ng])
>> +   GIT_CONF_APPEND_LINE(CSSMIN=3D$enableval);
>> + ])
>> +
>
> Why not follow the code as it was done e.g. for iconv (--without-icon=
v
> and --with-iconv=3Dpath); this would require JSMIN=3D@JSMIN@ in=20
> config.mak.in (and respectively for CSSMIN).
>
> Alternatively, if you decide on appending to config.mak.autogen (by t=
he
> way of config.mak.append) instead of filling config.mak.in, why not u=
se
> ready macro GIT_PARSE_WITH_SET_MAKE_VAR?
=20
I think this is what I am really not understanding here. Are you saying
that you think it would be better to use =97with-OPT=3DPATH instead of
=97enable-OPT=3DPATH?=20

Is this just a preference? I'm not seeing the problem with =97enable-OP=
T..
This is confusing me a bit...

Thank you for the input.

=97
Mark Rada
marada@uwaterloo.ca
