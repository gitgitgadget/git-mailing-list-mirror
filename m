From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Fri, 02 Oct 2015 08:00:24 +0200
Message-ID: <560E1D78.1040805@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net> <20150924210736.GL30946@sigill.intra.peff.net> <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com> <20150930002347.GA23406@sigill.intra.peff.net> <xmqqh9mb7k3r.fsf@gitster.mtv.corp.google.com> <20151001025119.GA31565@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 08:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhtPJ-0004yW-B9
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 08:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbJBGBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 02:01:16 -0400
Received: from mout.web.de ([212.227.17.11]:60844 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbbJBGBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 02:01:14 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LqDUa-1aLbsK3TsW-00dnMc; Fri, 02 Oct 2015 08:01:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <20151001025119.GA31565@sigill.intra.peff.net>
X-Provags-ID: V03:K0:VwIw28Rvx0Qkn5QIqtrPEbqH4eXsvQflno8owUIZHzggfT2hTED
 MC3nGSsmD/eT0NUjGVE/S4MjQMk+y8re3jzIIesnIFOqEmQovIzZYA6LSQs2fJHD4a2Kn6h
 hZi72MSMIZ8VyLoxUeYxKxzSwOF6MJkRoMbC0MueWqMI99FdnPGhiHqBHfNTcPt7lOkvSTu
 HaHFNl94wGU2+LDbXsjbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jKwtiDh2QOg=:Z7fcVHTJErQHObtrBOGSqX
 myFtkVOa6wug63fsjVRAtbHaYVaX/GKa/frrY98enoBMGpNVzzWEzec5ZtoetRohz/BuAT7EB
 4PCWHAesw1HfVRPeCnFmhUdiR8VbKk9ku3z4DBZAHNpF5M1eLaeJzjL4EdOb3EuJXsJbG2Q5O
 NlOb4/jao+Un1o1O4hKYkNBvzbJZ1/NfDGDol5OuYe8JNktmW+ACIYyMvTBImQibyN+e3JDb7
 zLkAqzgUaMyCI63r1a2IjZkwQMe7p7G/uqB6oe3LD8NzXQekgHwxtkzsmxOuEORhAU7H4DDW2
 8a8h9ln83xfAERPImSST+65iCIDw96TAzjNnQljRCDAgPG1seTGhpK0oJiOekHLDwJcNpaJDN
 sCaoLZ6QTbVhWlIbwAeIGe3Hih5wQRNKzR0b7jngTa96YTqIvRVK4/Jntdwu9TrMnHN+aHxGG
 Jg4syfonmcZmvy/pIUsq1SGxi3wppe2AOhqD4tkIo2wb3/VRzOUZPVfKIfF80jnLHaFD+Sn+g
 8CFGqLPcx5FMwhRf0380yNoiZMKLL/n9vOd0fowjCz3T01pRR4biveO4zEHzLplHGjl0kEV4E
 cLUsDw80iYk9gtn43Nokr33TI/K7oy0rFoSvOjCxN9XnDiP+6elKvfbWa12Swa4cKGr+8G52P
 p2GajCVHEzEwrPb1sfIW0itpK4cdu9ADPyYJd5Kw+5FgnhPI0vwvyiMMbSduZ6rnxiJZnRIIH
 fn308IPHwM4E5ey1Y54Qx9PYtzbH5degvZZdFkBMF3snLAB9ZC1ODASI4/3dvI+MFC6p19+d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278908>

On 10/01/2015 04:51 AM, Jeff King wrote:
> On Wed, Sep 30, 2015 at 01:00:56PM -0700, Junio C Hamano wrote:
>
>>> Wow, my patch isn't even close to reasonable. I didn't realize because
>>> we do not compile this code at all for non-Mac platforms. Sorry.
>> Perhaps the way we completely stub out the platform specific helpers
>> contributes to this kind of gotchas?  I am wondering how much additional
>> safety we would gain if we start doing something like this.
> I think it is an improvement, but it does not solve all of the problems.
> I also botched the implementation of probe_utf8_pathname_composition,
> and that does not get compiled on most platforms (though we _could_
> compile it and just never call it).
>
> -Peff
>
Peff, are you planing a re-roll ?
Or. Junio, do you plan to fix it ?
Or should I send a patch on top of pu ?

The compilation can be tested under Linux like this:

diff --git a/config.mak.uname b/config.mak.uname
index 7486a7e..6d09bd0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -13,6 +13,9 @@ ifdef MSVC
         uname_O := Windows
  endif

+COMPAT_OBJS += compat/precompose_utf8.o
+BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
+
