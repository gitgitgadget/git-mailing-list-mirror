From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 5 Feb 2012 22:45:50 -0800
Message-ID: <20120206064550.GE10489@tgrennan-laptop>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <7vvcnkeu2i.fsf@alter.siamese.dyndns.org>
 <20120206054819.GB10489@tgrennan-laptop>
 <7v8vkga370.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 07:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuIKu-0006Go-0M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2BFGp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:45:56 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61844 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2BFGpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:45:55 -0500
Received: by vbjk17 with SMTP id k17so3669347vbj.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 22:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UA+uoyI1f8JsDHwYSXVKyJJ9KzTV8gG8zB+qrlIy3P8=;
        b=PH5NZE25ToEZlUAIZCK7z4aEwSdcymXL3M7lHJJAs08bP6ao/bp2uEsyWz3TtbkNHz
         9H7tOMdH+i4qvthm84WkfvtBBcFF2PBWirkPkYuxbDE8ZMP8/1ONjLJMlghyddqffQhO
         2TT5beWKJqvCOM3UQMrZ/DZu4JEnUaAapwDFw=
Received: by 10.52.29.17 with SMTP id f17mr7000860vdh.126.1328510754655;
        Sun, 05 Feb 2012 22:45:54 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id hk9sm9751473vdb.13.2012.02.05.22.45.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 22:45:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8vkga370.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190031>

On Sun, Feb 05, 2012 at 10:25:23PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>>>I wonder if defaulting to HEAD even makes sense for --points-at. When you
>>>are chasing a bug and checked out an old version that originally had
>>>problem, "git tag --contains" that defaults to HEAD does have a value. It
>>>tells us what releases are potentially contaminated with the buggy commit.
>>>
>>>But does a similar use case support points-at that defaults to HEAD?
>>
>> Yes, the usage, "--points-at <object>..." implies that there is no
>> default. So, I suppose that NULL more appropriate than "HEAD".
>
>That's a circular logic.
>
>The usage could very well say "--points-at <object>" and forbid missing
><object>.  I think that would make a lot _more_ sense, because I did not
>think of offhand any good reason that --points-at should default to HEAD
>to support some common usage, and you also seem to be unable to.

Sorry for the miss-communication. I agreed with you - at least I thought I did.
So, "--points-at <object>" should forbid a missing <object>.
I think I can do so by using defval = (intptr_t)NULL instead of "HEAD",
right?

-- 
TomG
