From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 12:28:05 -0800
Message-ID: <20141203202805.GB6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGX1-0007hP-Ga
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbaLCU2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:28:11 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46587 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaLCU2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:28:10 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so14466894ieb.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=awinQJ7Kh9D/6ezpGqS9oMA6K72IaOXasu61N4rysbg=;
        b=X5yidsty0Nb/Gacgn7xKuxNI07vIYrCJ+m4LphteZHlwQJ4bsNUt8zP4nvEqClEhz5
         11wGSvRGoxyyKSaa6Tw3htQ4d6Unb49B2Oi4nCM8jB7Coeq+7k0siU2R8G3kw7AhBOWa
         UEqGLG4ypH4CbEtrmqDuD67zezna+Jn+sl4toHlRaAONSPARt5b4nXO2BTss51maCcL2
         qPpAss9W34EwCfo+D0BgwWewxwUwqabJfZpX0LGIztS3bfVxT5L7qkyS3+MvQ07P+rxk
         jT/GTWeZNm5P2dP7Xo9h5YeP4NmE9/bSbbL0uWrvtwaB+1ljwhHuUcwHeN35y0tk0KwD
         HJLQ==
X-Received: by 10.50.18.68 with SMTP id u4mr31561826igd.36.1417638489628;
        Wed, 03 Dec 2014 12:28:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id 15sm4558349ioo.15.2014.12.03.12.28.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 12:28:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260689>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -extern int copy_fd(int ifd, int ofd);
>> +extern int copy_fd(int ifd, int ofd, struct strbuf *err);
>
> It is not limited to this single function, but what contract do we
> envision this "error messages are given back to the caller via
> strbuf" convention should give between the callers and the callee?

Good point.  I'll add a Documentation/technical/api-error-handling.txt
describing die(), error(), warning(), and the strbuf-based method.

Thanks,
Jonathan
