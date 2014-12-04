From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Thu, 4 Dec 2014 15:37:38 -0800
Message-ID: <20141204233738.GE16345@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:37:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfxx-00020D-PM
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933315AbaLDXhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:37:42 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40041 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbaLDXhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:37:41 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so16800276ier.27
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nSUjqeS7VRUaPNp4jw/q/4Xbu7wnRgAvBrP5unAq9A4=;
        b=DUxAJYCeayNK9skGuMVkGYTnSpofvNXsf9MRmi5s4NhFJVjIUXtDpI7IGQFjywC0Jb
         CFhny5rbFGOpwyEpx/8wV2bZoN6IdDZduTygBPUgmLwH+LeuQ8osG5tIPyvjHgG/q99F
         JplxR+0N3Q/P+yWT1zEEIlVANLrppb75oeWFfAOoaCDBPwlEuQ1Yy8hK+dlBZrKchTb/
         hvqKRStJV88SIFz03coSuwInFHDeixti7rnbxCred1vHqS198kR66gTmgQUaPaAN0ilB
         zMoGvBB6TCnqe7vKnz2M774tsFMyD5d+4spl8WXSenqtPs8KgkpbAJGTz5PiXsLBKXPh
         Ejbw==
X-Received: by 10.50.28.49 with SMTP id y17mr10622311igg.3.1417736260734;
        Thu, 04 Dec 2014 15:37:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id bd5sm19787322igb.14.2014.12.04.15.37.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:37:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260838>

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Here's a draft for documentation on that.
>
> Thanks; looks reasonable; even if the discussion between you and
> Peff took us to a slightly different direction than what you
> described here, the earlier description of long established practice
> is a welcome addition.

Thanks.

Can you say more?  I didn't think the discussion had reached a
conclusion yet.

Unless there's a strong reason to do otherwise, I prefer to stick with
the strbufs in this series for now.  I prefer strbuf for this purpose
over char[1024].  And switching later doesn't seem hard.

But if others prefer char[1024], I can update the existing code that
uses strbuf from the transaction API to use that and reroll this
series with that convention.  A part of me dislikes that but I'll go
along.

Jonathan
