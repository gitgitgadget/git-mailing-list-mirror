From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] test mailinfo rfc3676 support
Date: Fri, 15 Feb 2008 11:44:24 -0500
Message-ID: <76718490802150844w7cc583b7v4d3480ed43de5cd1@mail.gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
	 <1203042077-11385-2-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802151058270.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 17:45:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ3gL-0005eB-3o
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 17:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYBOQo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYBOQo1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 11:44:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:17256 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbYBOQo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 11:44:26 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1137685wra.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 08:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fpSMc8p6pEikJGsDt2ljajoK8RO/RUMI/bfbcqDom4Y=;
        b=wOn9JebOY4FHMwt+wEt3VVfWxlyBt7raNNDB62TU2tP95I+QQOssTSEeTXV1p01C82P+DdVHKNE6EL1QLm3E1NRjJ510XIjfiynyQ3foL0Ugq325kwfcNOH50tijbJQ3PvkmPz3uiy/7mApYOsF1jUvg0ru2KnNLLSY0tl5ineA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jA+GZPVtiF4KtcgmDIQF1tOf27MB7gWiRW/Zqimuiiy3Uz+XkJeR7jkixgiov9hYrKIDvFI0uDRt0Pq3iJ0b3/2Or7DW2RtXTBGY6GJCmEBUkMqAh9+12eZcgzSp1oyCubdIKj+UN9VhPUa97iyDV9QF7esQFjwafJH5coEp0yc=
Received: by 10.114.181.1 with SMTP id d1mr3180494waf.10.1203093864158;
        Fri, 15 Feb 2008 08:44:24 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 08:44:24 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802151058270.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73957>

On Fri, Feb 15, 2008 at 6:01 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  Hmm.  Such a corrupt patch (lacking spaces at the beginning of the line)
>  would not be accepted by git-apply.  I briefly thought about teaching
>  git-apply to grok that, with a flag.  But now I think that mailsplit
>  should handle that, no?
>
>  Question is: can you "de-corruptify" such a patch? (Note: it would
>  probably need a validating step, too, i.e. count the lines it added a
>  space to, and match that up with the numbers in the @@ lines)

Heh, I see this was a confusing patch. It is a lot clearer to read if
you apply it and then take a look at what's added to sample.mbox, as
well as look at the new files in t5100.

What I did to create this test was add the format=flowed code to
mailinfo (my previous patch email), extract it with format-patch, then
cut/paste it into my MUA and mail it to myself so I could have a sample
format=flowed message. I then added that to the sample.mbox to see if
the code I'd just added to mailinfo was working properly. Yes, it
"de-corrupted" it just fine by removing the flowing.

j.
