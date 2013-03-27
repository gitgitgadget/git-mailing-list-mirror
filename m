From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 18:06:31 -0500
Message-ID: <20130327180631.6a1a7a47@hoelz.ro>
References: <20130327122216.5de0c336@hoelz.ro>
	<20130327182345.GD28148@google.com>
	<20130327172909.532a30b6@hoelz.ro>
	<20130327224735.GJ28148@google.com>
	<20130327175358.53903fae@hoelz.ro>
	<20130327225656.GK28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:07:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzQs-0008Q8-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab3C0XGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:06:34 -0400
Received: from hoelz.ro ([66.228.44.67]:40378 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab3C0XGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:06:34 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 27239280F3;
	Wed, 27 Mar 2013 19:06:33 -0400 (EDT)
In-Reply-To: <20130327225656.GK28148@google.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219353>

On Wed, 27 Mar 2013 15:56:56 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Rob Hoelz wrote:
> 
> > My mistake; I had not seen it!  I thought you may have found a bug
> > in my implementation, so I wanted to double check. =)
> 
> Well, I had found an unfortunate consequence of the implementation
> that uses an unnecessary copy. :)
> 
> Will follow up to the updated patch.
> 

I actually wanted to talk about the copy thing.  I realize that this
could have been avoided by simply saving a pointer to the old string
and performing a comparison, but I figured if the implementation for
alias_url were changed in the future to use realloc or something, it
could potentially return the original char * with its contents
altered.  So, by copying the string, we can avoid strange bugs in the
future.

-Rob
