From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH] Fix integer type mismatch on 64-bit systems
Date: Mon, 4 Jun 2007 08:47:34 +0200
Message-ID: <2c6b72b30706032347m6a67fcf7h6b56c1d1078c1ffd@mail.gmail.com>
References: <20070603211206.GA16445@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 08:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv6Lv-00073u-BF
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXFDGrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 02:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbXFDGrg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 02:47:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:1103 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbXFDGrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 02:47:35 -0400
Received: by nz-out-0506.google.com with SMTP id n1so917509nzf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 23:47:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=puW7q2+cwtI/n62xv8lOT2OKpjg5kZKpKEs4xjaX389CSC/NsYhkEkBuUYuVWlnFWTTmDxs0jvFiOrmtooCh9tLMQlxHbsKOAgTmikwCGZfnHHMFgpyZdqBj3/Q8aytqHMO1KYSOGAv8hXOpLKvKoWdk2354EH4qL9iM6DkgMgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ub7LPuoN7diAYuswYLS6OaWDy4yh7bOOHrMIa4PQ78m9wGorWn7ll3hvlzQHChKE3jBWsygWlI2Dakp09TII1aLbYI854h4hFPtJmMnFlnxKxJojXcQAyUjerzTm3s3qA/jfs84fujP+UdgEv96ch7qN1CTn31qiJiRJWu0UekI=
Received: by 10.114.73.1 with SMTP id v1mr4557091waa.1180939654282;
        Sun, 03 Jun 2007 23:47:34 -0700 (PDT)
Received: by 10.114.26.20 with HTTP; Sun, 3 Jun 2007 23:47:34 -0700 (PDT)
In-Reply-To: <20070603211206.GA16445@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49070>

On 6/3/07, Steven Grimm <koreth@midwinter.com> wrote:
> fprintf wants an int parameter for the field width of a "%.*s" expression, but
> the code was passing a size_t instead. This potentially broke systems where
> sizeof(size_t) != sizeof(int). And even on systems where it did't break,
> it still caused a compiler warning.

Thanks, I also fixed another such occurrence.

BTW, in good git spirit you are encouraged to sign off your patches. :)

-- 
Jonas Fonseca
