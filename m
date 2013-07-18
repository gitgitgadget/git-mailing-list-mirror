From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/2] Git.pm: add new temp_is_locked function
Date: Thu, 18 Jul 2013 12:35:52 -0700
Message-ID: <20130718193552.GU14690@google.com>
References: <1373170849-9150-1-git-send-email-mackyle@gmail.com>
 <1373170849-9150-2-git-send-email-mackyle@gmail.com>
 <loom.20130718T202918-857@post.gmane.org>
 <842D3E63-9E6B-45F0-A7F6-03082C4D067F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rothenberger <daveroth@acm.org>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 21:36:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztzk-0003bV-3A
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933776Ab3GRTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:35:57 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64740 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933632Ab3GRTf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:35:56 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so3551481pac.40
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=axbLXUxOMd+N7uro2VI0f2AXyAbLWLZ/TSlSbwpLEAM=;
        b=VqbNYLz3xs1Olh4QVMAR6dA3v2QNQcLVk8VEHeLJcb5P8+Qgtr0KybganjgxRe1ZnL
         Nzp6+P5lL2LWxDbUUxdG98cPOsMcA+Vz8vjxbdHke8uiQ7bJMNLG+jgVhssqIOAzeG4Z
         W3u9vt1p5+SqQqXPTBbSIwCLUV6Rfou38K9D3zRdjuP4KIBdgCGhOc9xgCtgBRIPBVFK
         h32tJCu+whXhYijpitwwxe6BWdGgiWsdEomgXZzqmrudXcNuvH8av90whgmzYeYHzyLj
         nvI7d22E98a9cFY4AuveNklLptWcalFNb5PrVOJU4wcEn6OlkvxkZYzgX/ewGwQJHND6
         1IHw==
X-Received: by 10.68.97.229 with SMTP id ed5mr13679840pbb.37.1374176156306;
        Thu, 18 Jul 2013 12:35:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ep4sm15256574pbd.35.2013.07.18.12.35.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:35:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <842D3E63-9E6B-45F0-A7F6-03082C4D067F@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230730>

Kyle J. McKay wrote:

> That change was made as a result of this feedback:
>
> On Jul 6, 2013, at 17:11, Jonathan Nieder wrote:
>> Kyle McKay wrote:
>>
>>> The temp_is_locked function can be used to determine whether
>>> or not a given name previously passed to temp_acquire is
>>> currently locked.
>> [...]
>>> +=item temp_is_locked ( NAME )
>>> +
>>> +Returns true if the file mapped to C<NAME> is currently locked.
>>> +
>>> +If true is returned, an attempt to C<temp_acquire()> the same
>>
> [snip]
>
>> Looking more closely, it looks like this is factoring out the idiom
>> for checking if a name is already in use from the _temp_cache
>> function.  Would it make sense for _temp_cache to call this helper?
>
> So I think the answer is it does not make sense for _temp_cache to
> call this helper.

Thanks for looking into it.

Sorry for the confusion.  The point of my question was an example of a
way to make sure the internal API stays easy to understand.  But it
seems to have backfired, and this is a small enough isolated change
that I think it's okay to say "let's clean it up later".

> Will release a v4 in just a moment with that single change reverted.

Thanks.
