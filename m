From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Fri, 26 Jul 2013 19:15:07 -0700
Message-ID: <251106F7-56FA-4503-A4C9-267A5EF04A2C@gmail.com>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79> <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79> <20130726043748.GA20286@sigill.intra.peff.net> <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com> <20130726222732.GA3444@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 04:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2u2m-0008Bu-6M
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 04:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab3G0CPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 22:15:12 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58717 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab3G0CPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 22:15:11 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so2654142pbc.15
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 19:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=hUP3sX4KG8/dfpSTM6V/ztb28vj10m06zvGRr/Nm7Jg=;
        b=HkQPHWXCgRAQ1ZSOOm7dzdRFQ06cBcMisaeez6/K98l/1CM/awajcCRNzrVxfCGdck
         ER8nuRZw5UNSG58VVLv38m/hMA7pfEKZrA9i2UYfRw/vIAnPe4hh+Ui1v7ApnV9RLFpk
         m630IVcgw+wo/XWzdxJtd7ScIMwvG8jkjYF57ohTr0gsLLZa1c2eY/i0+ZU9Bxv8DKxX
         O7qreOqaHcMtJWMbyY7RmzZdf0ASsz0najbwVBWhC5J1ko9/6VBe3Cv6vLAOkC82nEjW
         ZVf+UgFVClNrD/QmCbQTapWC9MrryBhYyXMsX6F35LiKJylEwKM3UnlWE6Zm1XdkcRJm
         bdtQ==
X-Received: by 10.66.189.225 with SMTP id gl1mr58119578pac.22.1374891310778;
        Fri, 26 Jul 2013 19:15:10 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wf7sm6510197pac.20.2013.07.26.19.15.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 19:15:09 -0700 (PDT)
In-Reply-To: <20130726222732.GA3444@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231222>

On Jul 26, 2013, at 15:27, Jeff King wrote:

> On Thu, Jul 25, 2013 at 11:23:23PM -0700, Kyle J. McKay wrote:
>
>>> IMHO, this would be more clear as a single item, like:
>>>
>>> . User name (e.g., `user` in `https://user@example.com/repo.git`).  
>>> If
>>>  the config key has a user name it must match the user name in the
>>>  URL exactly. If the config key does not have a user name, that
>>>  config key will match a URL with any user name (including none).
>>
>> The only problem I have with a single item is what's the precedence?
>> Does an exact user match have the same precedence as an any-user
>> match?  That would seem to be implied by having them as the same item
>> number.  Separating them would appear to make it clearer that an
>> exact user match wins over an any user match, but if you have some
>> alternate text as a suggestion for the single item that clears that
>> up...  :)
>
> Ah, I see your thinking now. You want to say "no username has less
> precedence than some username, which has less precedence than a path",
> so they are all elements of a single list.  My thinking was "username
> has precedence less than path, and like a shorter path has less
> precedence than a longer path, an empty username has less precedence
> than a non-empty username".
>
> I agree my suggested wording would need to mention that explicitly.
> Like:
>
>  . User name (e.g., `user` in `https://user@example.com/repo.git`). If
>    the config key has a user name it must match the user name in the
>    URL exactly. If the config key does not have a user name, that
>    config key will match a URL with any user name (including none),  
> but
>    at lower precedence than a config key with a user name.
>
> I can live with it either way, though. They are just two ways of
> considering the same thing.
>
>> I am considering this text to address that:
>>
>>> All URLs are normalized (%-encodings are standardized, case- 
>>> insensitive
>>> parts are lowercased, `./` and `../` path components are resolved)
>>> before
>>> attempting any matching (the password part, if embedded in the URL,
>>
>> but I'm not sure the extra verbiage makes it better.  I think it may
>> just complicate the explanation unnecessarily?
>
> Yeah, I think I agree. Let's leave it out.

So there's a version of this in next as cea9928 and I think that  
version is fine.  If the documentation gets updated in the future, or  
perhaps moved to a separate urls-matching.txt for some reason at some  
point (git config --url, git config --url-parse), I'll make a point of  
inserting the ", but at lower precedence than a config key with a user  
name" text.

Kyle
