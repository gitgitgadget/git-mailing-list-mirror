From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 16:08:12 -0700
Message-ID: <20140424230812.GM15516@google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <87tx9ia5zq.fsf@fencepost.gnu.org>
 <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
 <20140424213529.GB7815@sigill.intra.peff.net>
 <87lhuu9z69.fsf@fencepost.gnu.org>
 <20140424221308.GA15061@sigill.intra.peff.net>
 <87ha5i9wkp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	d9ba@mailtor.net, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:08:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSkf-0005fy-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbaDXXIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:08:18 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52959 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbaDXXIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:08:17 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so2399388pde.26
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C6ozO1EpQMHf/rqPNckuSAQC4yX9YSNiZDbQ5ocJV10=;
        b=UoofxbqBRWKKnZiaAV8QhT07fWed51vtTNW8llmgMeABsMUy2jUgSkr1sCPG94EjWl
         lBbmvhUf+N9Q4lwjJxASMUtzYbNGteYVHo4rpFCcx+5ZG/NmKXJ74fi4QGaYHE2eiw2A
         roB/wIOn/eIbBD9DmVEpvWqwyNVgqDkCRkB6Dfao80eqCE3bMCjx7CV3nRB7rZZCy4aB
         gt8FSo8ZWYDMA5SrCHsAI74lrSOw/TemCmVGIHz3md/2hfEiVNjDnYsgq639nFEuf2Ph
         eFVPe7X6ztY5LeoeN7Whj8gyTwWNXfA1puzYfH7dmwpfr1fG6cwCIRG5P3+fMsPElHif
         SPeQ==
X-Received: by 10.68.135.195 with SMTP id pu3mr7072021pbb.70.1398380896710;
        Thu, 24 Apr 2014 16:08:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iq10sm11510927pbc.14.2014.04.24.16.08.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 16:08:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ha5i9wkp.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247023>

Hi,

David Kastrup wrote:
> Jeff King <peff@peff.net> writes:

>> There are two questions here:
>>
>>   1. Can less do a better job of indicating what's in the input when -S
>>      is in effect?
>>
>>   2. What should get put into $LESS by default?
>>
>> I was specifically addressing (1). Your comment does not help at all
>> there.
>>
>> It could have an impact on (2), but you didn't say anything besides "I
>> don't like it". That doesn't add anything to the conversation.
>
> No, I said it is useless, which is different from "I don't like it".
> The information is not copy&pastable from a terminal window since it is
> cut off.  It is also useless for review since one does not actually know
> what's in there.  The only thing it has going for it is that it's
> prettier than the actually usable information.

I disagree with your characterization of what's useful here, but it
really doesn't matter.  Why are you still arguing?

I think it would be fine to change git's default for LESS to FRX and
document that change wherever the documentation currently mentions
FRSX, if someone wants to write a patch for it.  (Such a change would
sit in "pu" or "next" until after 2.0.0 is released, of course.)

In the meantime, when you're on machines using the current default,
you have two choices:

 a) set the LESS envvar in your .profile explicitly
 b) hit the two keys '-', shift+S when git opens a pager

The argument about safety is a red herring here, since it's always
possible that a patch will wrap to make new lines with '+' or '-' or
'@@' at the beginning that are equally confusing.

Hoping that clarifies,
Jonathan
