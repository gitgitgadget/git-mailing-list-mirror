From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 14:29:11 -0700
Message-ID: <20130410212911.GE27070@google.com>
References: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net>
 <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
 <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com>
 <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2a0-0005Ya-VR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935885Ab3DJV3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:29:17 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43236 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3DJV3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:29:16 -0400
Received: by mail-pb0-f48.google.com with SMTP id xb4so479249pbc.7
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=giV5NOBSDVCE6voDMpvmtUs2eRZnpT3IAMNnr8ggDDI=;
        b=cUgziGMUWGZSX2u4CTaWJYR9pj9+NuSQV7mSm5pvX3AANhCrxX7WamrDFIHN2r7iZT
         84/r1BIJ7ZNgCHjqVXbIUU7czTE7lyEDsJQ8rL4yAT+EGOfKHiW20RFvuln09AHCjXDG
         sCb0RprE2xZudz39TfxN4TWP6pQoVtaep3GDMs49WVMkhV72BM2wzTyBG/Q/7eH4HWLe
         xKKhFfNe927e7G/OjRr5owKUBGDZua0yPwhhxQldKIzyJfPMhupk8VIDyp6l2oUrzPaq
         US7qFCh9rdp2kQJw82nAxj30w/5K9w9KIsLPhwmJXu64WJz71VtkT60vZ7ftpUdzh42u
         FIXg==
X-Received: by 10.68.27.229 with SMTP id w5mr5079588pbg.220.1365629356201;
        Wed, 10 Apr 2013 14:29:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id be7sm353360pad.20.2013.04.10.14.29.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 14:29:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220775>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>>        git push master
>> ...
>>  a) Error: you didn't tell me which remote to push to.
>>  b) Just behave like "git push my-personal-remote master".
>>  c) Behave like "git push origin master".
>
> Here, I'd argue for (d): push to branch.master.pushremote/
> branch.master.remote/ remote.pushdefault/ origin.

My first hunch is not to like this, since it means

	git push -- master next

might push to two different remotes and because it's not obvious
to me when it would be useful.

So I am still leaning toward the behavior Jeff suggested.  That said,
we're probably at the point where enough scenarios have been described
for someone to write a patch with a clear explanation about how their
proposed behavior takes care of them all.

Thanks,
Jonathan
