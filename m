From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 9 Nov 2012 17:29:27 +0100
Message-ID: <20121109162919.GA922@book.hvoigt.net>
References: <cover.1352431674.git.wking@tremily.us> <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us> <7v390jqlep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWrSn-0006H4-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab2KIQ3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:29:39 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:39697 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab2KIQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:29:38 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TWrSU-0007IX-9X; Fri, 09 Nov 2012 17:29:30 +0100
Content-Disposition: inline
In-Reply-To: <7v390jqlep.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209228>

Hi,

On Thu, Nov 08, 2012 at 11:34:54PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> 
> > By remaining agnostic on the variable usage, this patch makes
> > submodule setup more convenient for all parties.
> 
> I personally do not think "remaining agnostic on the usage" is a
> good thing, at least for any option to commands at the higher level
> on the stack, such as "git submodule".  I am afraid that giving an
> easier way to set up a variable with undefined semantics may make
> setup more confusing for all parties.  One party gives one specific
> meaning to the field, while another party uses it for something
> slightly different.
> 
> I would not object to "git config submodule.$name.branch $value", on
> the other hand.  "git config" can be used to set a piece of data
> that has specific meaning, but as a low-level tool, it is not
> _limited_ to variables that have defined meaning.

I think we should agree on a behavior for this option and implement it
the same time when add learns about it. When we were discussing floating
submodules as an important option for the gerrit people I already started
to implement a proof of concept. Please have a look here:

https://github.com/hvoigt/git/commits/hv/floating_submodules

AFAIK this does not yet implement the same behaviour the gerrit tools
offer for this option. The main reason behind that was because I do not
know the typical workflow behind such an option. So I am open to
changes.

Maybe you can use or base your work on this implementation for submodule
update.

Without submodule update using this option I think it would be better to
implement this option in the tool you are using instead of submodule add.
Everything else feels incomplete to me.

Cheers Heiko
