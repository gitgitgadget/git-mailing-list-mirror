From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Sat, 23 Aug 2014 00:51:29 +0200
Message-ID: <53F7C971.7080100@gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>	<53F7A119.7070704@gmail.com>	<xmqqiolknvfz.fsf@gitster.dls.corp.google.com>	<53F7A68D.2000109@gmail.com>	<xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>	<53F7AA48.3000601@gmail.com> <xmqqa96wnoj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKxgG-0004DC-3L
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 00:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbaHVWvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 18:51:32 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:62846 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbaHVWvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 18:51:32 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so11141890wes.28
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e16ZoD6nT4fWiG1IvsZwRLGn9DVXG+9CH1hcMrXzr2g=;
        b=0vHR+GOp6LFyPrrulXN/3dibHyrdIUOWPHDGCE1xzRd2XgIsE5Fb5iijW5MQviVRpx
         qZfTEd6a9HGqvi2rj4cV7NPdX1dbtkZq3LZ4GEmr14vFKV1LQGxL2gjZnQdAZoRj3AS+
         yxmUfQDeR6u+1P4PkHPjVlf6PzKeWDOlaiwJKenPVrjqnVXuaOxpxSvnqco4tKL3y/It
         XcwPEPBKXLzVQCZ/pCYJvhU6pFE7U6h+Rvj5Z6EbL3OaNBeoCQb9E2H+uP7pzb1WYUh6
         n9y4OrGX/t84/STpSvhXgcNlzAiHfQXvQekxxTnk1Nb3kkY12UBjEiXPQ8SNLl464htj
         ylZg==
X-Received: by 10.194.206.67 with SMTP id lm3mr8045342wjc.70.1408747890901;
        Fri, 22 Aug 2014 15:51:30 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id mx10sm2664468wib.1.2014.08.22.15.51.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2014 15:51:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqa96wnoj1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255724>

On 23.08.2014 00:32, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> On 22.08.2014 22:33, Junio C Hamano wrote:
>>> Stefan Beller <stefanbeller@gmail.com> writes:
>>>
>>>> On 22.08.2014 22:03, Junio C Hamano wrote:
>>>>> Stefan Beller <stefanbeller@gmail.com> writes:
>>>>>
>>>>>> So there would be tags like:
>>>>>> 	master_2014_08_21
>>>>>> 	master_2014_08_22
>>>>>> 	...
>>>>>> 	maint_2014_08_13
>>>>>> 	maint_2014_08_21
>>>>>> and so on. Whenever there is no tag at the tip of the branch, we'd
>>>>>> know there is something wrong.
>>>>>
>>>>> Who creates that tag?
>>>>>
>>>>
>>>>> My guess would be usability as tagging so many branches is cumbersome
>>>> for a maintainer?
>>>
>>> Did you answer my question?  Who creates these tags?
>>>
>>
>> It would be up to the one who pushes, the user, or in our case you!
>> ...
>> As I wrote in the first email, I made up this workaround and wanted to
>> see, what's so bad about that workaround and how to overcome the
>> problems. And all I could find was a burden on the maintainer/user.
> 
> "burden" is not an issue, as I'll be signing the push certificate
> anyway when I push.  A signed tag or a signed commit and signed push
> certificate solves two completely separate and orthogonal issues.
> 
> What happens if you break into GitHub or k.org and did
> 
>     $ git tag maint_2014_08_22 master_2014_08_22

Ok, I personally haven't used tags a lot.
I just tried to
	git tag -s testbreaktag v2.1.0
	git show testbreaktag
	# However it would still read:
tag v2.1.0
Tagger: Junio C Hamano <gitster@pobox.com>
Date:   Fri Aug 15 15:09:28 2014 -0700

So as I do not posess your private key I could not create signed tags
even if I were to break into github/k.org



> 
> to create an extra tag out of the tag signed by me?  If you want,
> you could also remove the original while at it. 

Considering I'm in the hosting server,
could I delete the push cert as well?
Now that I deleted the push certificate,
I could pretend "Junio just forgot to sign the push cert today"
and we're back at the tag solution?

Ah wait! the subsequent push certs would not match,
I'd need to delete them as well.


> The goal is to let
> us validate without having to trust the hosting site, its management
> and its software, which is what creates the tag there, controls
> where the tag sits in refs/ hierarchy and how it is shown to the
> outside world.
> 

Ok, I got the goal. :)

Thanks for your patience,
Stefan
