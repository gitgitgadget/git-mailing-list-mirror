From: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
Subject: Re: tags not present in bare clone
Date: Mon, 23 Apr 2012 14:43:45 -0600
Message-ID: <98431788-0ED7-4ADB-972A-193587433216@linea.gov.br>
References: <0BE9553B-C799-43D5-BA9A-28FC83CA0773@linea.gov.br> <xmqqsjfui7gn.fsf@junio.mtv.corp.google.com> <xmqqobqii7c2.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMQ76-0004em-I7
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab2DWUny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 16:43:54 -0400
Received: from mailout17.yourhostingaccount.com ([65.254.253.139]:49125 "EHLO
	mailout17.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752967Ab2DWUnx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 16:43:53 -0400
Received: from mailscan10.yourhostingaccount.com ([10.1.15.10] helo=mailscan10.yourhostingaccount.com)
	by mailout17.yourhostingaccount.com with esmtp (Exim)
	id 1SMQ6x-0007oO-L7
	for git@vger.kernel.org; Mon, 23 Apr 2012 16:43:51 -0400
Received: from impout01.yourhostingaccount.com ([10.1.55.1] helo=impout01.yourhostingaccount.com)
	by mailscan10.yourhostingaccount.com with esmtp (Exim)
	id 1SMQ6w-0000QX-Sn; Mon, 23 Apr 2012 16:43:50 -0400
Received: from authsmtp10.yourhostingaccount.com ([10.1.18.10])
	by impout01.yourhostingaccount.com with NO UCE
	id 1Yjq1j00C0D2B7u01Yjq14; Mon, 23 Apr 2012 16:43:50 -0400
X-Authority-Analysis: v=2.0 cv=aoEw+FlV c=1 sm=1
 a=8Grkd2U8ihpDTr+s4w7xLA==:17 a=Qa21fcannPsA:10 a=dRfE2LE2RnoA:10
 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=aYzm1YcmrKgnEhV_UUQA:9
 a=viFgh9_kTIIFQv8EXfkA:7 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=qIVjreYYsbEA:10 a=2gI1vAumJwWs0gD4Ojj1yg==:117
X-EN-OrigOutIP: 10.1.18.10
X-EN-IMPSID: 1Yjq1j00C0D2B7u01Yjq14
Received: from [153.90.103.210]
	by authsmtp10.yourhostingaccount.com with esmtpa (Exim)
	id 1SMQ6w-0005I3-3N; Mon, 23 Apr 2012 16:43:50 -0400
In-Reply-To: <xmqqobqii7c2.fsf@junio.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1084)
X-EN-UserInfo: 957f87d35c43172285e6793414996149:be26a490d08ddddd1ae22626b86f1c91
X-EN-AuthUser: patricia@egeland.us
X-EN-OrigIP: 153.90.103.210
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196164>

Thanks Junio. 
I confirm that I can see the tags. 
I was looking (ls) in .git/refs/tags, only. 

But, after more search, it looks like tags may be stored in .git/packed-refs to improve a repo access. I didn't know about that.
It is also good to know about "git for-each-refs" to list tags and the commit they point to. 

Thanks,
Patricia


On Apr 23, 2012, at 1:19 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Patricia Bittencourt Egeland <pbegeland@linea.gov.br> writes:
>> 
>>>       I'm trying to create a bare clone from a regular repo (all
>>>       locally; in the same machine). However a tag created in the
>>>       regular repo can't be found in the fresh bare clone.  I
>>>       expected that the tags would also be present just like anything
>>>       from "refs". Am I wrong about that?
>> 
>> Reproduction recipe???
>> 
>> A simple and straightforward attempt to reproduce what you said you did
>> in your message does not exhibit any problem.
>> ...
> 
> Oops, I forgot --bare.
> 
>>    $ cd ../ ;# back at /var/tmp/junk
>>    $ git clone src dst
> 
> This should be "git --bare clone src dst" (or "git clone --bare src
> dst").
> 
> But everything else in my previous message still holds true.  I am
> getting the identical output as the following.
> 
>>    Cloning into 'dst'...
>>    done.
>>    $ cd dst
>>    $ git for-each-ref
>>    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/heads/master
>>    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/HEAD
>>    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/master
>>    33a6b315ffb461cba32d84ecd1692525a0846f5a tag	refs/tags/v1.0
>>    0d3f9dce20e28c6898423eb4a2c2010908e46a6c tag	refs/tags/v2.0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
