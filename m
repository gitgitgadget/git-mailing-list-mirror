From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Fri, 24 May 2013 22:54:35 +0530
Message-ID: <CALkWK0moMOBUZqqSe521qfa7q8xe0Z5sN10ZRQpPaTu8EuxuDw@mail.gmail.com>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
 <1369381324-10206-3-git-send-email-artagnon@gmail.com> <7vd2sgb9r8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:25:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufvk5-0003fv-Az
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab3EXRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:25:18 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64869 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3EXRZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:25:15 -0400
Received: by mail-ie0-f171.google.com with SMTP id e10so195102iej.30
        for <git@vger.kernel.org>; Fri, 24 May 2013 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=grIHPJHc/amOyghhFixba63n+cg6NSIPCgex3fkuFWo=;
        b=a9CO68ujNfa4PF48WIeghcuvEjmag1g0oZZkzTOPjhReWWdbGYvj1p9PwfWEeyFdHG
         iJmGvz73uH85AH7wRx6KWnZxwl42wRUOjGBxgZzrnYUwf7cAQ1oZl6KYxM9oAe7gY4IB
         3d7EELBqq/dsT2OrYnekbmyrNTynRj2eBJKKtDLm/xyXFNfGUIikhnxagNLwhZUiXWxK
         NY4t76XTk7wgcEuepWYIaQ6R+2+LtNNUszPb3BVWno1kwEzLE+HKT9InC1b7ez+l8m82
         TY8OHWJ7tLrEuLrZJXR0izfushztqQhE4tr4FbSUsRd+ZAU4fm19m4ORfINVLQhUZ4Q3
         sVRA==
X-Received: by 10.50.66.197 with SMTP id h5mr83561igt.63.1369416315509; Fri,
 24 May 2013 10:25:15 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 10:24:35 -0700 (PDT)
In-Reply-To: <7vd2sgb9r8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225383>

Junio C Hamano wrote:
> What is this meant to update?  I recall rewriting this part on
> purpose.

I was being verbose to show that I handle the detached HEAD case too,
which I missed last time.

> Even though it appears unusual and invites confusion, it is very
> consistent to say '' when the user asks for @... as we say 'master'
> when the user asks for master@...; "inconsistent" is a very bad
> label for it.

The inconsistency refers to these two:

>>   # on branch master
>>   $ git show @{10000}
>>   fatal: Log for '' only has 7 entries.

>>   # detached HEAD case
>>   $ git show @{10000}
>>   fatal: Log for '' only has 2005 entries.

Is the commit message unclear?
