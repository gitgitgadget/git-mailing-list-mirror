From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 18:21:20 +0700
Message-ID: <CACsJy8DCBEp9jPrq=vR-dcJ4hSZss=4i900OCDzUFm_NvonvTg@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <CACsJy8D6nAt3fMw=oh5mwUwfAJKViN1pk9pf9gZSBGyquU_WBQ@mail.gmail.com>
 <20150304103119.GA19234@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:22:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7NG-0006rk-7o
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbbCDLVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:21:53 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:41804 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759234AbbCDLVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 06:21:52 -0500
Received: by igal13 with SMTP id l13so35891478iga.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NI5091vl6hAL3oI70E/U0e2LqVxUunPOTnvDD/D7Bjw=;
        b=HyuBXFKxytsJtwG1bSZqeXfnJvKhAKJ/zOncAnBFGd2KMFfFl+V7t8WYbIrL/hyyJ7
         guXQuSejh5cUnsogiX/6FOaPEuPe6HihAJZYk4GnYqwFAPhRsHIzsRnykJ+ciLXHWVOB
         1YQohjKHrx+Q4dAZQZmanBy9Ijz0ecsUYeYaiG+Hrgj1IJ47rvcZFJlTOpmrMeB6g098
         beddWUaGGtEif7ddabiEV094+eJi9Z2ZGdkvuXRIVH8AngqBvpyWl+yPh5jcTvyzIQhd
         lzYvf40a0hUyvmEfEu4R9z2IePIstaTzHdRYMRB8ZeL/b24aZkEu3Szub3ZlwLwKZxbN
         LR0Q==
X-Received: by 10.107.9.88 with SMTP id j85mr612959ioi.60.1425468111846; Wed,
 04 Mar 2015 03:21:51 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 4 Mar 2015 03:21:20 -0800 (PST)
In-Reply-To: <20150304103119.GA19234@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264753>

On Wed, Mar 4, 2015 at 5:31 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 26, 2015 at 08:10:38PM +0700, Duy Nguyen wrote:
>
>> On Thu, Feb 19, 2015 at 2:14 AM, Jeff King <peff@peff.net> wrote:
>> > Where I really need help now is in the "ideas" page:
>> >
>> >   http://git.github.io/SoC-2015-Ideas.html
>>
>> Is this too ambitious for a summer? I suspect the answer is yes, but anyway..
>>
>> Due to http limitations and stateless decision, a lot of data is sent
>> back and forth during have/want negotiation for smart-http. I wonder
>> if we could implement the "long polling" scheme in a CGI program. The
>> program terminates HTTP requests and recreates a full duplex
>> connection for upload-pack to talk to the client. upload-pack falls
>> back to the normal mode, used by git:// and ssh://.
>
> So basically Git-over-TCP-over-HTTP? :)

Yes. The hidden agenda was, if it works well, we might be able to
deprecate smart-http one day. That day, if happens, would be in far
future though. By that time hopefully we could just use http2
insteadof tcp-over-http1.

> I'm not sure it is too ambitious in terms of actual implementation time,
> but I think the design work may exceed what most students are capable
> of.

Not to mention that I think it can be man-in-the-middle attacked if
we're not careful (e.g. send to session token in unencrypted). Which
makes it less appealing to me.
-- 
Duy
