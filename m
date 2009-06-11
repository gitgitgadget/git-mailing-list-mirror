From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] git-format-patch, git-send-email: generate/handle escaped
 >From
Date: Thu, 11 Jun 2009 13:58:36 +0200
Message-ID: <4A30F16C.5040207@gmail.com>
References: <1244714434-20794-1-git-send-email-bonzini@gnu.org> <20090611105538.GA4409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 13:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEivu-0001gP-Oi
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 13:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZFKL6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 07:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbZFKL6t
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 07:58:49 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:64194 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZFKL6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 07:58:48 -0400
Received: by ewy6 with SMTP id 6so1944661ewy.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+ZQQZIecqRtDmWWKKKBRE431eM12PY5dj9KhAC1+eNM=;
        b=Lud/49yQYRlPqM/ls3Fhyyf+m2IDCb6zkPiu4FXQ+2jqpMUgFE9yxN+OEWi6/O3gSi
         K83Z8Rn0TM5/tOG7H2pNte/kd3WQ4f7Cl+zAZDZFMM9O9L8tfJ1FLYrOwZuixq1QLp3a
         ag3xIxSLuDLOgVsfYdHxWXFMpG8W6AL7Z9YI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PINtZj1VMhTwh5dLHIe9CYsE3pd4MzvgXqkBPg4fBxvxsGN7c+bQr6/iUjKIP5HuTN
         6qIgr39dOHOnC7lgt8/O3YGT+D2qVaytge+eYq11+zW9ymmKox6U7Jt5uZ9oNLcYKwVH
         f9xqKnJPGbYvGnmqh2io/luSHIFrHnR7DxObk=
Received: by 10.210.78.7 with SMTP id a7mr5597267ebb.65.1244721529092;
        Thu, 11 Jun 2009 04:58:49 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm117121eyd.12.2009.06.11.04.58.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 04:58:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <20090611105538.GA4409@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121338>


> But of course, which conversion you want depends entirely on what you
> are going to feed it to, and which mbox they are expecting. Which is why
> it really should be configurable.
> 
> Your use case looks to be feeding it to send-email

Almost, :-) because git-send-email does not support sending multiple 
messages out of one mbox file.  I have an upcoming patch to add this 
support, and I was just "feeling the waters" before posting it.

> I suspect you would
> be better served by improving the 'From ' detection in send-email,
> probably to something like:
> 
>   /^From \S+ \w{3} \w{3} \d+ \d\d:\d\d:\d\d \d+/
> 
> though that may be too strict. It would probably make sense to steal one
> from one of the many mbox-reading CPAN modules.

Good idea.  I'll let others speak and can make this configurable (as 
well as use the s/^>*From />&/ conversion), but if no one speaks, I'll 
change my git-send-email patch to use the above regex or a similar one, 
and withdraw this patch.

Thanks for the prompt remark!

Paolo
