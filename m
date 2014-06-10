From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3] t9001: avoid not portable '\n' with sed
Date: Tue, 10 Jun 2014 08:30:48 +0200
Message-ID: <5396A618.5040306@web.de>
References: <5396849F.7060206@web.de> <xmqqk38pb95s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:31:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuFaI-0003VS-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 08:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbaFJGa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 02:30:58 -0400
Received: from mout.web.de ([212.227.17.12]:50151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbaFJGa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 02:30:57 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M1G20-1WenA642n2-00tCdL; Tue, 10 Jun 2014 08:30:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqk38pb95s.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:YIKnqSP/6HCIfds399LYIMnetktr9JLn0yXrN0Pl2ehLd76G11F
 ddCrzkO3Cv3PvUjAMu3JtaS9wMQNCbautpzPjG6dlD25YKO5RZYb/JDKVe+ilnwP7nWvFNM
 OYKjFS+EKn25Ko2NqiA4QEijTh9AcTfYo0VCgdbljTIow8drSt/hW6ZHEpoW8+BYbK5qeu1
 0IdDvWoPkVUaXeZGeH4BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251165>

On 06/10/2014 07:55 AM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> t9001 used a '\n' in a sed expression to split one line into two lin=
es,
>> but the usage of '\n' in the "replacement string" is not portable.
> This looks peculiarly familiar; don't I already have it queued?
Yes, V2 is queued and in pu,and only the commit msg is changed
between V2 and V3.

I think that V3 explains the difference between POSIX sed and
gnu sed much better, and does reflect all the comments from
the list, which otherwise may be lost.
And I suspect that not only the sed under Mac OS X does not
handle this very '\n' different from gnu sed, or in other words,
more platforms may not have a gnu sed and may need the fix.
