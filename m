From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 11/42] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 09:53:22 -0700
Message-ID: <20140515165322.GB27279@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-12-git-send-email-sahlberg@google.com>
 <20140515002738.GH9218@google.com>
 <CAL=YDWk8uZzJyex0YoBx81KhJZjS99qW1nV2AOe=rZhgoYRAcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyuR-0006yQ-T1
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbaEOQx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:53:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51014 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbaEOQxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:53:25 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1311104pad.30
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b5Q6scghjVQnFpR4iUQy7O/fGr5ikMDGX+Q45QaHbds=;
        b=gN0lgC+0zxSSgo3KwkVhBAUIjVbLvouY886mCaBiWF2GOEBtUdYXWuLG2Z/yV8kOeH
         7AvKwLmffdlPbza66TUuyUA7DiHiNQenP5+N2oBPFGKxJwRT6wA+lvrlzTxdA2Ar9tDI
         8mtmuHq8u+i9ZGu3JjPiFzzGmytsMNe3ZS1EYHmM0OcXWWllt20LbLnE80kIEVMAlyGF
         +rqu0Efx0eq42cSqn6scsCUhtR1xeTXMUs9xy96EQJT/123e1Y/lhKCso/A3eY8liUTq
         L4rfNs9iRiod9x9NT2B19gtt/ZsVBcvUboexpt0VGhIZhCYHcSuJvZ1m5ihysxSwO9si
         EzRg==
X-Received: by 10.68.143.231 with SMTP id sh7mr13699296pbb.7.1400172805069;
        Thu, 15 May 2014 09:53:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oe4sm9995198pbb.33.2014.05.15.09.53.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 09:53:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWk8uZzJyex0YoBx81KhJZjS99qW1nV2AOe=rZhgoYRAcg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249115>

Ronnie Sahlberg wrote:

> Instead of the suggestions above, would you accept an alternative
> approach where I would
> add an err argument to ref_transaction_begin() instead?
>
> For a hypothetical mysql backend, this could then do something like :
[...]
> fatal: refs/heads/master: cannot update the ref: failed to connect to mysql database ...

Yes, sounds like a good thing to do.

Thanks,
Jonathan
