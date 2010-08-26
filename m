From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Thu, 26 Aug 2010 11:04:42 +0530
Message-ID: <20100826053439.GB9407@kytes>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes>
 <20100825205416.GB2319@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:36:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoV8v-0007Fv-Lu
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab0HZFgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:36:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45869 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0HZFgk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:36:40 -0400
Received: by iwn5 with SMTP id 5so1269813iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BNJcTvc1XZu/JpkB7MVk3Xv+lkBAkCkE/++xN7K51DA=;
        b=OGVXwA0FxeAvTCIFzAUy9zMSgaaWYCxYy5X66SbhvpxjZU7QSGDnIhpu8/d/rQpFpH
         fdWT1UF6clJzRVaUfi2ujFUcNwxUex/3fNkt1qWXtFixMznjHRf78Zd1NwreMIiRXTOp
         qVxEfzc1RPujTiOHiQxFUma6HjJoZVTotnrxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=weanvTj+MgJrEI9QMw3iZt7LfvbBGciD0JOGM45T7Xxj9lsEexb0JSi0bzOzYtH3sZ
         /0YABD3AdHSpGB26rlILS+5BIDh7iqAPN4JhjvYZi6GR6oAM8N/Z+Je0EHV0jUKjLUcx
         sRjKYGmYvGF3VgAR95SuEeUs+mF+tXti5zA0A=
Received: by 10.231.19.197 with SMTP id c5mr10859563ibb.91.1282800999685;
        Wed, 25 Aug 2010 22:36:39 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2123026ibb.8.2010.08.25.22.36.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:36:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100825205416.GB2319@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154509>

Hi Jonathan and Junio,

Junio C Hamano writes:
> I am not very impressed by the counting.  It probably makes more sense to
> count only what we are actually going to process and emit, i.e. always use
> no-merges (do we even support format-patch on a merge?).  

Frankly, I think the patch looks like an ugly hack myself. No,
format-patch doesn't support merge commits at all.

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > Ramkumar Ramachandra writes:
> 
> >> The second patch clarifies the meaning of the `-<n>` option. We should
> >> also probably force the mutual exclusivity of `-<n>` and <revision
> >> range> to avoid confusion.
> [...]
> > Do you see value in this patch or is it just unnecessary baggage?
> 
> I see value in avoiding confusion.  Maybe one solution would be to make
> format-patch use --no-merges by default.

Good idea. I'll write a patch. Do we also want people to be able to
turn off `--no-merges`? If so, how?

-- Ram
