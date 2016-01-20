From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 20 Jan 2016 10:10:28 +0100
Message-ID: <9ED87AF7-5880-4E40-8859-0DA0F1DF1883@gmail.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com> <20160119191234.GA17562@sigill.intra.peff.net> <xmqqegdd8997.fsf@gitster.mtv.corp.google.com> <20160120002606.GA9359@glandium.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 10:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLonn-00063L-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 10:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907AbcATJLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 04:11:38 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36538 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130AbcATJKc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 04:10:32 -0500
Received: by mail-wm0-f45.google.com with SMTP id l65so170280688wmf.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TPmvbblaRATKqSP4mfG5Pp6l8cYjbmaMa481l2K5jsQ=;
        b=GqpDiBy7CZCTgzqIY1QBUK004QmOf9AY/E3odLKmNkJO7n6zTsvHO5CNya1Xukv5/H
         NHtwWm0A7Y32gwf644ZlLdglL3h07CWkdznljTvbFCpQ31T1GYXv5y3aQs9HplZnXePP
         EDNd7B3MwXmFc1+j3ZkFaiadzUhfyl5V2cz+pPqSFUNgFmkNHuSZ/VGFTxVpeSpytr1V
         qDfgDpVenPorAP3UPu81QXN4gXuGvwQatpMvxs57ZpPPMuyf98SLuFzEczX02S1Dfp89
         RJ6Al5lD3umWVL2kRP8xaHWr7Y4BOdYEjihu3S1ulntaQ0KSvDTvQPu5wZP8q1F9f581
         DupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=TPmvbblaRATKqSP4mfG5Pp6l8cYjbmaMa481l2K5jsQ=;
        b=KZKvENNzSe8DW6w5GijqDqepF2QLTiBb4HEO9sv/YOLPdkDiNyGfu+c8HgYdr6qZmQ
         lDxabxBYa7qufONjSoOzA2Oyv9Gu7zUDty/cnfJ6rO1zNka2GKyRzaSOCUU1+/VIaP0v
         e4VZ1lDj8ktIsS6YKMSTwoKyIRsgk7iK7t6VCHLWDYVZS18e/EqsiDU1DKDPaa31cM1E
         RHDEbK6v6ghXS16jCBKZIeP/bk+usO25h7PRJfdUFm1VzQNGdfUY3Kja1irvyIzVS5sE
         WTHELzItZewVgu4p0BhiPRg8CCqHJfYssyaM2LU0Mvy9gqM1QPR0bVt1ZpPDgXBjRN6k
         qijg==
X-Gm-Message-State: AG10YOQkYQYbMlGJWJA4bugGHZh/f1QJngksLXA+xQDvJ+XSUMY00kXRu71KCEyomxejfw==
X-Received: by 10.28.130.205 with SMTP id e196mr2847265wmd.34.1453281030897;
        Wed, 20 Jan 2016 01:10:30 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA58E.dip0.t-ipconnect.de. [80.139.165.142])
        by smtp.gmail.com with ESMTPSA id 75sm24162908wmo.22.2016.01.20.01.10.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 01:10:30 -0800 (PST)
In-Reply-To: <20160120002606.GA9359@glandium.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284432>


On 20 Jan 2016, at 01:26, Mike Hommey <mh@glandium.org> wrote:

> On Tue, Jan 19, 2016 at 03:00:52PM -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>> On Tue, Jan 19, 2016 at 10:24:29AM +0100, larsxschneider@gmail.com wrote:
>>> 
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> Use the Travis-CI cache feature to store prove test results and make them
>>>> available in subsequent builds. This allows to run previously failed tests
>>>> first and run remaining tests in slowest to fastest order. As a result it
>>>> is less likely that Travis-CI needs to wait for a single test at the end
>>>> which speeds up the test suite execution by ~2 min.
>>> 
>>> Thanks, this makes sense, and the patch looks good.
>>> 
>>>> @@ -18,7 +22,7 @@ env:
>>>>     - P4_VERSION="15.2"
>>>>     - GIT_LFS_VERSION="1.1.0"
>>>>     - DEFAULT_TEST_TARGET=prove
>>>> -    - GIT_PROVE_OPTS="--timer --jobs 3"
>>>> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>> 
>>> Have you tried bumping --jobs here? I usually use "16" on my local box.
>> 
>> I think 3 comes from this:
>> 
>>  http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279674
> 
> Having recently looked into this, the relevant travis-ci documentation
> is:
> https://docs.travis-ci.com/user/ci-environment/
> 
> which says all environments have 2 cores, so you won't get much from
> anything higher than -j3.
> 
> The following document also says something slightly different:
> https://docs.travis-ci.com/user/speeding-up-the-build#Parallelizing-your-build-on-one-VM
> 
> "Travis CI VMs run on 1.5 virtual cores."
> 
>>> I also looked into the Travis "container" thing. It's not clear to me
>>> from their page:
>>> 
>>>  https://docs.travis-ci.com/user/workers/container-based-infrastructure/
>>> 
>>> whether we're using the new, faster container infrastructure or not.
>>> ...
>>> depends on when Travis "recognized" the repo, but I'm not quite sure
>>> what that means. Should we be adding "sudo: false" to the top-level of
>>> the yaml file?
>> 
>> In an earlier discussion
>> 
>>  http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279495
>> 
>> I found that we were not eligible for container-based sandbox as the
>> version of travis-yaml back then used "sudo".  I do not seem to find
>> the use of sudo in the recent one we have in my tree, so it would be
>> beneficial if somebody interested in Travis CI look into this.
> 
> The https://docs.travis-ci.com/user/ci-environment/ document says the
> default is "sudo: false" for repositories enabled in 2015 or later, which
> I assume is the case for the git repository. "sudo: required" is the
> default for repositories enabled before 2015.
> 

I made the Git job run on the new container-based infrastructure for Linux.
We can add "sudo: false" to make this more explicit!

Thanks,
Lars
