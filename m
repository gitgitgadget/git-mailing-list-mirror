From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 12:15:51 -0600
Message-ID: <20120308181551.GA17838@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 19:16:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hsn-00015L-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 19:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab2CHSQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 13:16:04 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62064 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756599Ab2CHSQB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 13:16:01 -0500
Received: by obbuo6 with SMTP id uo6so966541obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AvNKF4fkHYOnxj8r4w+L51z8X/kosid6vbwUXw7bykw=;
        b=0auYKqMqE7VkAkjYm2WKZzvhrx460WprAYy5o1LoYH6L6VgqajdDI9sXCc8qncx9u7
         ky+aNSC4fxYg/9IgFExJoQdLpyZeearHTC4B6xuSs0v/7JiH9aSORindMLVCJrcrj9O3
         UEt3GH/dS9cDjjyVriZetDhFkaEAWbxWuTLv7flMi0m7IWE2Z01/uBHuYppB7cvPrbS6
         rmHxU00AtXQ5hUU8EgB/Ft0HlinCpoLg8BW3u7NeZ8sAAuxl1qJtWoxK5iyG18iBepy3
         2P73y7qhH9wdJqn+/dVwIUSMhHNlyD9D1NFFwkv7kJeUXHaE404kT8FtjdqrnmTLOK3W
         pG4A==
Received: by 10.60.28.229 with SMTP id e5mr3216679oeh.63.1331230561061;
        Thu, 08 Mar 2012 10:16:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a6sm1284835oea.13.2012.03.08.10.15.59
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 10:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192627>

Hi,

Junio C Hamano wrote:

> So what do you guys want to do with topic?  My gut feeling is that
> this is not a new regression and can wait until the next cycle.

Yes, I think you are very right.

. I have a vague fear that my "allow filecopy to copy from root" patch
  on top of David's is missing some handling of the empty src case,
  along the same lines as 8fe533f6 (fast-import: treat filemodify with
  empty tree as delete.

. After looking closer at David's patch, it does not seem to handle
  'ls <tree> ""' carefully enough.  It probably needs something
  like Dmitry's [1].

So please backburner this, and we can try for something better by
next cycle.

Thanks for a sanity check.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/179426/focus=179425
