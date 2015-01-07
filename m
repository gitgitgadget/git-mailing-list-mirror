From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 6 Jan 2015 17:27:03 -0800
Message-ID: <27162E6E-742C-455D-A005-220B7A8B38CF@gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c> <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c> <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com> <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com> <xmqqtx03pxzf.fsf@gitster.dls.corp.google.com> <A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com> <xmqqoaqbmpmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fOy-0006tX-C3
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbAGB1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:27:07 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57980 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbbAGB1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:27:06 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so1343649pad.9
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 17:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=x2jltk2LodO8QgwUouiF0g0Y8eMtuANKHC7AHoaXnMw=;
        b=zPU699YbfpBpNZPFP74JEaoaqVWr0HIukhG2IVfmUAI6P82wRHTd0PVztofxfVS8e8
         duuV8/Rnge9l4KVsTj4VBtO7dLfK0fyTzGQdpyqDOJM5Cf1tcgjc88I9XghyDi9niYe8
         +TEHmDGh4T3PqWVGzy/JLerZlzPKTqZHbRlQUiAZPdGoTfDXPmag9CQhwYaxRbLNk5kS
         rw1ydOkfQ4c0jIfXU3pQ/E2VZISkSjCmuC0M/18dqR9pDr1Bo5nAbEmjBzeQRtiCAbcT
         /MWzBoOddeZAPcru2PX9BLYEHQD+aQfULjG9lfaE3Bn6dUVsjpAQlml+dSMzWhf/oyjF
         WjkQ==
X-Received: by 10.66.159.67 with SMTP id xa3mr523933pab.13.1420594025864;
        Tue, 06 Jan 2015 17:27:05 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nu5sm87534pbb.79.2015.01.06.17.27.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 17:27:05 -0800 (PST)
In-Reply-To: <xmqqoaqbmpmj.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262125>

On Jan 6, 2015, at 15:54, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> A whitelist solves issue (1) but is no help for issue (2) unless some
>> additional additional part of the refs namespace were to be also
>> whitelisted.  Perhaps something like refs/x-<anything>/... in the  
>> same
>> vein as the various IETF standards for experimental names.
>
> Your (2) is about people who are _experimenting_, no?
>
> Why can't they use refs/notes/x-<anything>/* while doing so, and
> when that matures and proves useful to wider public we can make it
> more official by whitelisting refs/<that-thing> in addition to
> refs/notes/, and the problem is solved, no?

I supposed if that's the best that can be done.  The problem is then  
that if you set notes.displayRef to refs/notes/* to see all relevant  
notes, don't you end up seeing these experimental, not-meant-for-end- 
user-consumption notes if they are somewhere under refs/notes/ ?  My  
glob specs are a little fuzzy, maybe it's refs/notes/** that gets  
everything under it?
