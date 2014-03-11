From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: Re: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Tue, 11 Mar 2014 23:37:33 +0100
Message-ID: <531F902D.4050102@aegee.org>
References: <20140311183529.GA73693@hades.panopticon> <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, wxs@FreeBSD.org,
	Dmitry Marakasov <amdmi3@amdmi3.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 23:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNVZk-00031X-5P
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 23:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbaCKWzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 18:55:00 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:46168 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbaCKWy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 18:54:59 -0400
X-Greylist: delayed 1019 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2014 18:54:59 EDT
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1WNVJ1-000234-8t; Tue, 11 Mar 2014 23:37:51 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.9.0 smtp.aegee.org s2BMbaZa032609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1394577471; i=dkim+MSA-ssl@aegee.org;
	bh=xLnDyre7MS4vXPsHtR8iIAsU2fsPWnbqmyDeISmrCxk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fmKS+lyqngFeaeTLHJSbUp2sfUSSckdp8ywin2PXfG9mPqwZ2aguhe9Wd5+dpB2xT
	 Lph252nun3O438/B16kblTngNgXwXPSAImH7UtTqq7yFaJynkUgr3hodnFNzvj8zHe
	 3RBKwTyR/xuFuyOkRpeikHkCluqrK3YZicBIGmjnWIuX2v3l8tOOGJTzEHLxX7hU9t
	 671Dh/g1klnFMd6pOMMug5lQJQiZeDzAmk1TS5Qdz6Lbj8ioU7pYr4cNTbYlXjw3Rp
	 HvA+qbWXOZT/WZFtxS7GwxA6X5zN7JJm/adryil7yjWgcLjjIrfsN7fthS9JeExsDw
	 IsQSsQxSWOAKuBzRyyumDA1oFQfaRkthLj1rbJmiFvMnN5i60xh/Pn6YxrVYvvKuma
	 m9Y2ZD3V9vI+RisCB++UPDTIR7Zhc6fWL0jlegdqct4rvL0hOhym1C8NC/AkZp6sV8
	 DYvvHXZwiYb+yCBz58PytvjmhBEwqzAJFWFVAABU3At3N0vyQT4S9pizvIqMqqDISl
	 OTBV/uO2Ui8NuVl0AAQr9MJKkUvSXPASHCCPLMSuYRrFJQAktxinUEy36/R9EWWXPj
	 TWIw3DBqa1Yc7NF/wPfBGaUPNqnn5OUpkwaQUBe+ObbY0srBLCHXxTLd4Lx 
Received: from [192.168.0.2] (port-212-202-110-243.static.qsc.de [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.8/8.14.5) with ESMTP id s2BMbaZa032609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 11 Mar 2014 22:37:39 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: clamav-milter 0.98.1 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243910>

Hello,

this changes effectively the meaning of CHARSET_LIB to=20
always/unconditionally contain the library with the charset_locale ()=20
function.  The snippet at the end of the email updates the description=20
in /Makefile .

However, I checked now how gnulib deals with locale_charset ().  Contar=
y=20
to my expectation, where gnulib builds only functions if they are not=20
found in libraries on the target system, gnulib module localcharset=20
builds unconditionally from source the function locale_charset ().  I=20
guess they do this in a portable way, but still.

My preference is to agree on universal approach for finding this=20
function, something like:
   OK, if found in libiconv, else
   OK, if found in libcharset, else
   OK, here are the sources, build the function from them, and don't=20
look for it in (shared) libaries

I asked at bug-gnulib@ why they build locale_charset() before checking=20
for it in libiconv / libcharset.  My posting shall appear at=20
http://lists.gnu.org/archive/html/bug-gnulib/2014-03/index.html .  Let'=
s=20
see what the answer will be.

I don't know if in the git codebase generally is refused to use gnulib=20
code, but if you agree on the above procedure with 3xOK, then=20
locale_charset() will be available even on systems, that don't have thi=
s=20
function in libcharset or libiconv.... Maybe /compat/poll/poll.[ch] in=20
git-core from gnulib had similar history.

Kind regards
   =D0=94=D0=B8=D0=BB=D1=8F=D0=BD


On 11.03.2014 21:35, Junio C Hamano wrote:
> Dmitry Marakasov <amdmi3@amdmi3.ru> writes:
>
>> On e.g. FreeBSD 10.x, the following situation is common:
>> - there's iconv implementation in libc, which has no locale_charset(=
)
>>    function
>> - there's GNU libiconv installed from Ports Collection
>>
>> Git build process
>> - detects that iconv is in libc and thus -liconv is not needed for i=
t
>> - detects locale_charset in -liconv, but for some reason doesn't add=
 it
>>    to CHARSET_LIB (as it would do with -lcharset if locale_charset()=
 was
>>    found there instead of -liconv)
>> - git doesn't build due to unresolved external locale_charset()
>>
>> Fix this by adding -liconv to CHARSET_LIB if locale_charset() is
>> detected in this library.
>>
>> Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
>> ---
>
> Looks sensible; Dilyan, any comments?
>
>>   configure.ac | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git configure.ac configure.ac
>> index 2f43393..3f5c644 100644
>> --- configure.ac
>> +++ configure.ac
>> @@ -890,7 +890,7 @@ GIT_CONF_SUBST([HAVE_STRINGS_H])
>>   # and libcharset does
>>   CHARSET_LIB=3D
>>   AC_CHECK_LIB([iconv], [locale_charset],
>> -       [],
>> +       [CHARSET_LIB=3D-liconv],
>>          [AC_CHECK_LIB([charset], [locale_charset],
>>                        [CHARSET_LIB=3D-lcharset])])
>>   GIT_CONF_SUBST([CHARSET_LIB])


----------
diff --git a/Makefile b/Makefile
index dddaf4f..dce4694 100644
--- a/Makefile
+++ b/Makefile
@@ -59,9 +59,9 @@ all::
  # FreeBSD can use either, but MinGW and some others need to use
  # libcharset.h's locale_charset() instead.
  #
-# Define CHARSET_LIB to you need to link with library other than -lico=
nv to
+# Define CHARSET_LIB to the library you need to link with in order to
  # use locale_charset() function.  On some platforms this needs to set=
 to
-# -lcharset
+# -lcharset, on others to -liconv .
  #
  # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
  # need -lintl when linking.
