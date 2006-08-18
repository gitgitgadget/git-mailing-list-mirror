From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 17:52:46 -0400
Message-ID: <9e4733910608181452x65ca937aqbfde55caa98ff6da@mail.gmail.com>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 23:52:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GECGo-0007Gl-F7
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWHRVwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWHRVwr
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 17:52:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:52329 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWHRVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 17:52:46 -0400
Received: by nz-out-0102.google.com with SMTP id 14so107919nzn
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 14:52:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ugq9kt4OlY2gB7KzUd9PK4GJqzQJc2OAfHvhpQTNyO7YlPZFpVCKIspC+I0lllgyrgVDFtlqhJEQkQzQCan98dmIbn27eYrm5iL8odR2odbcsvo771nCo3xzrnmXtAvOHNRDslFKpG3Y/8fg10SSHj6XEoXhLSY/wp8pDyufsLk=
Received: by 10.65.211.16 with SMTP id n16mr4388207qbq;
        Fri, 18 Aug 2006 14:52:46 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Fri, 18 Aug 2006 14:52:46 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25698>

On 8/18/06, David Rientjes <rientjes@google.com> wrote:
> I'd like to solicit some comments about implementing support for md5 as a
> hash function that could be determined at runtime by the user during a
> project init-db.  md5, which I implemented as a configurable option in my
> own tree, is a 128-bit hash that is slightly more recognized than sha1.
> Likewise, it is also available in openssl/md5.h just as sha1 is available
> through a library in openssl/sha1.h.  My patch to move the hash name
> comparison was a step in this direction in isolating many of the
> particulars of hash-specific dependencies.

If I have two repositories each with 100M objects in them and I merge
them, what is the probability of a object id collision with MD5 (128b)
versus SHA1 (160b)?

This is not that far fetched. I know of at least four repositories
with over 1M objects in them today.

-- 
Jon Smirl
jonsmirl@gmail.com
