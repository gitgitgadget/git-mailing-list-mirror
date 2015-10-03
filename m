From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of
 verify_refname_available
Date: Sat, 3 Oct 2015 23:07:01 +0200
Message-ID: <56104375.3030904@web.de>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
 <1443477738-32023-2-git-send-email-dturner@twopensource.com>
 <560F6172.3040404@web.de> <1443891000.7753.4.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 03 23:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiU1T-00022O-5s
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 23:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbbJCVHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2015 17:07:08 -0400
Received: from mout.web.de ([212.227.15.14]:61394 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbJCVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 17:07:07 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Ll30X-1aJCHT0iv7-00aqNu; Sat, 03 Oct 2015 23:07:02
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <1443891000.7753.4.camel@twopensource.com>
X-Provags-ID: V03:K0:YgZZX2tPRcQdCuofEi9QSgL720nMuylYdeXL6C0+Qz0hp19Yjy4
 TQuKFdTmWmCXcIk33rsuqiF+L60Gxm31vT54ttR8Dt5eLT2fYvG1kwonlr0c2yOH3ebbGzS
 qAXcnatJQN4oShnBrJttieymlteKUQABHQZkrvDW8dGfxOqxfMvKBmd99qtQSM5Fe37bndM
 VgU/bc32jY+CoUgpYbspw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LgtYB0hmcDs=:Lu7k4lIbQzm06hOl2iIw1T
 r/MOE36Q1wr1fKmvE29VF9HSxeBd1D1dweX53N6rN6HZhJ/malNtkPL7GxMesKXQCNdhvSuhX
 U7X5O4VqCMifRTzcPA/trrxQ/XSiOdt5cN1e0DVCm2B3aEG4Hza6JWjX//9NHpUv53DUg2G2P
 Sck17m+mVJB+z1QG9O8sXnIVArfOcM7i6ztsb6cOEE4X9gySv2hThwcRG/WoYv9gDFcpzGNM0
 g6ReJSgL3BS9Fu+X7oIOVejDy9onQc49otSmn0hOco+e04e0VKvGGcn9BppR3+U9CUSXJ1IfN
 w/QXbb1CjReTNVf8Xw+X9evnxaaLhbaPE5qh6U+n901vLJ/EkkpZEOjMhLMyLQIry6ftbjKec
 d9tWkP7loWfUN5YIEsxn/oP1EJReWWOj+NAMYNOKngLk5JvDbQLIIZ6GIrjFfJmb2qKK3yhb2
 UXZszfQdnc1J5x7w54xWJF7/6w508ugQ+0D1I0EwssBWRffo8T8PBJrz/FyQ2xaeX4QeQhoRd
 NG30gMm2ovN/fTZRBmywbQFMbogcdytY+TSNaLQeOiS4/JGo7KzSYvn5U+5f0xwCw+vRHM9wo
 xJyz95TLEE1XTr3Mstz+O1ZiGs9ezzT4dwTpxsdZuYxZymJ7GGyHxpPxi4fi5l3jyOx9uGGEg
 3qZXrBuFiZTpZlHX1VbFNolnYWI7hg4N/DxEYftF5Rlg4S5c0sZPNYykBLY7cU8PtyaRKnK7+
 HGl5I2uigy+S6gcQvyYHI6szwD+54C/CpADfC9pHgXdPMi6cUd0Q5hSedtx3qJxR+hiQ+/Od 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278985>

On 03.10.15 18:50, David Turner wrote:
> On Sat, 2015-10-03 at 07:02 +0200, Torsten B=C3=B6gershausen wrote:
>> On 29.09.15 00:01, David Turner wrote:
>>>
>> (Not sure if this is the right thread to report on)
>>
>> In file included from builtin/commit.c:20:
>> ./refs.h:695:16: warning: redefinition of typedef 'ref_transaction_f=
ree_fn' is a C11 feature
>>       [-Wtypedef-redefinition]
>> typedef void (*ref_transaction_free_fn)(struct ref_transaction *tran=
saction);
>>                ^
>=20
>=20
> Fixed, thanks.
>=20
> What compiler flag did you turn on to see that warning?
Mac OS X, 10.9:

 gcc --version
Configured with: --prefix=3D/Library/Developer/CommandLineTools/usr --w=
ith-gxx-include-dir=3D/usr/include/c++/4.2.1
Apple LLVM version 6.0 (clang-600.0.57) (based on LLVM 3.5svn)
Target: x86_64-apple-darwin13.4.0
Thread model: posix
