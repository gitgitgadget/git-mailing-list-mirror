From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 14:37:21 -0800
Message-ID: <20141210223721.GG16345@google.com>
References: <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <5488A87C.4030505@alum.mit.edu>
 <20141210215154.GF16345@google.com>
 <xmqqlhmff8cs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xypsv-0000ts-T8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbaLJWhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 17:37:25 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:42019 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbaLJWhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 17:37:24 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so3561692iec.25
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9xJuF5fSq+XPnWJmxLnRZF/iJ/koRBogaLotlwA8tD8=;
        b=rxjGcSBdGPXvjtBQOlyd1zuOteY4o/WPJkJLfGRiGQ/vPGjr4w8VPGj9xI85B40gg+
         mwCmA0D+eHyFO3zzMnAHuP5P4NFutBEPNP9tYO+zlPtIikPDhY3xw0D9exx0/G+EjZP4
         tbXWxr4c1p7ds0PqXybfmCwbIXSIG5ZAEL/qKhAdFhxx5EWULIy2gvcenKVlX4KhZhGh
         Pgst6EkYcog7/3p+vlg5DUpWLYjiwn3rs9QOHCPHZAzdMwpIkbgqm5m11golnBrSuuOe
         WE0FaqbBjlzxUHhXAI7peHFmSOZCq9MCMkOgZrqUybL3EkdDmPMEErZdNlU/ZVHosEyS
         l7Ig==
X-Received: by 10.42.68.203 with SMTP id y11mr8883058ici.62.1418251044143;
        Wed, 10 Dec 2014 14:37:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ad0e:8148:e84b:d170])
        by mx.google.com with ESMTPSA id t15sm2991235ioi.21.2014.12.10.14.37.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Dec 2014 14:37:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqlhmff8cs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261252>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Michael Haggerty wrote:

>>>                              I would find it a pity for that work to be
>>> squashed into Documentation/technical/api-*.txt, where in my opinion it
>>> is less discoverable and more likely to fall into disrepair.
>>
>> I think we're in violent agreement and keep repeating ourselves.
>
> Hmph, I am confused.
>
> I somehow had an impression that the "move to doc and remove from
> header" patch was to illustrate how unpleasant the result will be as
> a whole (i.e. results in a nice documentation as a starting point,
> but we can see that it will be hard to motivate and help people to
> keep it up to date during further development).  Which would suggest
> that you are in favor of moving the other way around, to keep the
> header rich with documentation only at the higher level.  Am I
> reading you correctly?

Sorry, I think I was unclear.

Some possibilities, in order of my preference (earlier items are better):

 1. Move documentation to header and provide a program to generate a nice
    standalone document.

 2. Move documentation to header, being careful enough that the header
    sort of works as a standalone document.

 3. Move documentation to Documentation/technical/ and keep the header
    bare-bones.

 4. Status quo (comprehensive documentation for some functions in both
    places, for others in only one place, no reliable way for someone
    to find the information they need in one place).

Since (3) is better than (4), I wrote simple patches to do that for
strbuf.h and string-list.h.  I meant them in earnest --- I hope they
get applied.

I think peff was working on (2), which is an admirable goal.  The
patch seemed to be incomplete.

Thanks,
Jonathan
