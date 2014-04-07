From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] git submodule split
Date: Mon, 07 Apr 2014 21:04:38 +0200
Message-ID: <5342F6C6.3080703@web.de>
References: <87sipviel4.fsf@steelpick.2x.cz> <53417C00.3090805@web.de> <87d2gukvhb.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 21:05:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEqd-0002SD-L0
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbaDGTEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:04:42 -0400
Received: from mout.web.de ([212.227.15.4]:56503 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756220AbaDGTEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:04:40 -0400
Received: from [192.168.178.41] ([79.193.68.171]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LtWsu-1WyUVe25Bs-010vNy; Mon, 07 Apr 2014 21:04:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <87d2gukvhb.fsf@steelpick.2x.cz>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ofCWfoqYJg4rMRnEmJgGzURebPEL9Q5q4YCbR4CRXfSY6G/hN4v
 LtS5TAejPYBS88qP0vu5naNHL7qk+u2WYw9h7h8WosnyBrC6hCsI/modcdVsw7++TGC4my0
 vN2DKGZSu+SHVI3NNXaKcP1AEbqb6I1/kOy1q9g4Ws6p0AkcsL19T6U0zuKjzph36jn9rxz
 yPDXG4D3JUeskBxi9hkSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245891>

Am 06.04.2014 23:18, schrieb Michal Sojka:
> On Sun, Apr 06 2014, Jens Lehmann wrote:
>> Am 02.04.2014 23:52, schrieb Michal Sojka:
>>> Hello,
>>>
>>> I needed to convert a subdirectory of a repo to a submodule and have the
>>> histories of both repos linked together. I found that this was discussed
>>> few years back [1], but the code seemed quite complicated and was not
>>> merged.
>>>
>>> [1]: http://git.661346.n2.nabble.com/RFC-What-s-the-best-UI-for-git-submodule-split-tp2318127.html
>>>
>>> Now, the situation is better, because git subtree can already do most of
>>> the work. Below is a script that I used to split a submodule from my
>>> repo. It basically consist of a call to 'git subtree split' followed by
>>> 'git filter-branch' to link the histories together.
>>>
>>> I'd like to get some initial feedback on it before attempting to
>>> integrate it with git sources (i.e. writing tests and doc). What do you
>>> think?
>>
>> Why do want to rewrite the whole history of the superproject,
>> wouldn't it suffice to turn a directory into a submodule with
>> the same content in a simple commit? 
> 
> I wanted to publish a project including its history but a part of that
> project could not be made public due to legal reasons. Putting that part
> into submodule seemed like best idea.

Yep, that makes lots of sense.

I'm not sure yet if this functionality is needed often enough to
put the script under contrib, but I won't object as long as you'd
be willing to maintain it (and help people on this list when they
report any issues).
