From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: cherry picking and merge
Date: Wed, 06 Aug 2014 17:58:08 +0200
Message-ID: <53E25090.7010803@gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>	<20140801200201.GS12427@google.com>	<20140801205040.GT12427@google.com> <CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3bd-0003i8-7y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbaHFP6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 11:58:21 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35690 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbaHFP6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:58:20 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so2869054wgg.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iknbT9fSjaRN0rqeVjeeznec9UK7ZlXC+zI4XXuSmEg=;
        b=fSkBBbdlIISUsKKu9wcVP5aYuKadEaSo/h0qOQ4BSz/WGvZZSIbLrZs63jlOi8r+A2
         l4Lxq481EWffkzYpRmQUWMaNJOVw2GdXGd/t1nW39bb7IK0jxvSPueyz2Q2gwlaMo6XO
         BBswmxU0WS3/Td4PwBwcW+83LWvyhCsl5ras6s0n7l/GqZ3/8eBt0aFaLSEe0fQmQoWS
         2BNKJyli32TDe4KPwuNGlH7IJAjQ4CrnGTtcN3PbkUH6qOCJs2WKta8gz1ngBDUVbyAK
         R4te/kYx9U53WGbIsh8D9TPgqMWUUepiV6/3Ey6mJvbm76oZXHEzjbzH7iE32z/nGSN1
         rAYg==
X-Received: by 10.194.185.175 with SMTP id fd15mr16801677wjc.53.1407340698540;
        Wed, 06 Aug 2014 08:58:18 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id wi9sm3359445wjc.23.2014.08.06.08.58.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:58:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254873>

W dniu 2014-08-01 22:55, Nico Williams pisze:
> On Fri, Aug 1, 2014 at 3:50 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> Jonathan Nieder wrote:
>>
>>> Do you mean that "git merge" should be aware of what changes you ha=
ve
>>> already cherry-picked?
>>>
>>> It isn't, and that's deliberate
>>
>> That said, when today's "git merge" fails to resolve conflicts, it's
>> easily possible that we could do better at resolving the merge by
>> walking through both sides and understanding what happened.
>
> It would help if cherry-pick history where recorded somewhere (beyond
> the reflog)...
>
> Cherry-picks should record two parents, like merges.
>
> (Of course, it does no good to know about an unreachable parent, when
> a commit with two parents is pushed to a repo that doesn't have one o=
f
> those parents, which can happen when topic branches aren't pushed
> upstream.)

There was (long time ago) a long thread about idea of adding some
kind of 'weak' references (links), 'weakparent' that can be=20
automatically used by Git but do not pollute the commit message,
and do not affect reachability calculations.  Ultimately it went
nowhere (as you can see) - there were many problems.

=46or example: how it would work for reverts and rebases?

--=20
Jakub Nar=C4=99bski
