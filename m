From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 15:23:05 +0100
Message-ID: <55098A49.1020003@aegee.org>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:23:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYEsW-0002GL-7r
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 15:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185AbbCROXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 10:23:11 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:47952 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933828AbbCROXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 10:23:08 -0400
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YYEsE-0000oN-Hj; Wed, 18 Mar 2015 15:23:06 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t2IENBbp026089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1426688592; i=dkim+MSA-tls@aegee.org;
	bh=NBgXW8eEc6F1FIq4CjHSjvH4LU03LQxtiKja34x5uAQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LvOKYQynZhc1PaIPy5u3h3AmaY05VN07iYea6D3IWd+lhSvWoK/2MI3yTHA6ZH8az
	 aYgwf1JdAuFPUGrlJgJT9lNahPcpsFBokmO0ZVc8V6x+AWW+6U/1mgMOkmtoXQ6D2b
	 owmLrxRurBALp3vLME499uunQJsaxgFMSVMTRfw+rrYprsQ+HOAMxThNUWzfVxrZ4r
	 SqZiAVA+TRX6oqrqIR5a9ry/fiQz2Y5gRXp50c6UDBuuPECET8T05lg3ym5bh9OrI8
	 jX83kWld1NkNWTsIg9b+KZOA9zje7JHp0/nk9WTnlDRXbcj8xXVJJMV87emzQv+0Rl
	 X2tBBhcS+N07DcMY31GDTAkJGTVQXosNAULox3Lh30TyCsAXixKq6KXgBYTwjkBprA
	 f1/hezNHFUJaenCQqPIiRICiOgFNG+2u/pdvntmhKfmHG+/RukORMgE43sWF4fPDeG
	 X9BovOdvewYEK4ezMIggurj1WDUkzTZuCISOldXm5IUtxSsOLk7FRRGORYg3amW8iA
	 dQDatCIq15Rjj6G/zg25VgfScIJJFZt9umenEGXvu54x004Z3fUK+RU9s/RWic7DtD
	 6FqG/oBhlD44BeaUJ/XcQ68gaP+RYR5/DUz2HJiDJyMaph+gBSScHKiSXIX 
Received: from [192.168.0.6] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.15.1) with ESMTPSA id t2IENBbp026089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 18 Mar 2015 14:23:12 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265732>

Hello,

# git gc --auto
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.

and calls in the background:

25618     1  0 32451   884   1 14:20 ?        00:00:00 git gc --auto
25639 25618 51 49076 49428   0 14:20 ?        00:00:07 git prune=20
--expire 2.weeks.ago

# git count-objects -v
count: 6039
size: 65464
in-pack: 185432
packs: 1
size-pack: 46687
prune-packable: 0
garbage: 0
size-garbage: 0

Regards
   Dilian


On 18.03.2015 15:16, Duy Nguyen wrote:
> On Wed, Mar 18, 2015 at 8:53 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=
=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
> <dilyan.palauzov@aegee.org> wrote:
>> Hello,
>>
>> I have a local folder with the git-repository (so that its .git/conf=
ig
>> contains ([remote "origin"]\n    url =3D git://github.com/git/git.gi=
t\nfetch =3D
>> +refs/heads/*:refs/remotes/origin/* )
>>
>> I do there "git pull".
>>
>> Usually the output is
>>    Already up to date
>>
>> but since today it prints
>>    Auto packing the repository in background for optimum performance=
=2E
>>    See "git help gc" for manual housekeeping.
>>    Already up-to-date.
>>
>> and starts in the background a "git gc --auto" process.  This is all=
 fine,
>> however, when the "git gc" process finishes, and I do again "git pul=
l" I get
>> the same message, as above (git gc is again started).
>
> So if you do "git gc --auto" now, does it exit immediately or go
> through the garbage collection process again (it'll print something)?
> What does "git count-objects -v" show?
>
