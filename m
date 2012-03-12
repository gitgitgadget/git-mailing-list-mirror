From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 17:53:56 +0100
Message-ID: <20120312165356.GD12405@1wt.eu>
References: <20120312002046.041448832@1wt.eu> <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 17:54:33 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S78W1-0004VZ-2t
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 17:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2CLQyR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 12:54:17 -0400
Received: from 1wt.eu ([62.212.114.60]:63189 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060Ab2CLQyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 12:54:13 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CGrujx014035;
	Mon, 12 Mar 2012 17:53:56 +0100
Content-Disposition: inline
In-Reply-To: <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192907>

On Mon, Mar 12, 2012 at 05:41:49PM +0100, Thomas Rast wrote:
> [+cc Junio because of backwards-compat issues]
> 
> Willy Tarreau <w@1wt.eu> writes:
> 
> > On Mon, Mar 12, 2012 at 08:20:04AM -0700, Greg KH wrote:
> >> 
> >> I don't see a -b option to 'git am' in the manpage, am I missing
> >> something here?
> >
> > It's in the master tree only right now, and the option is "--keep-non-patch"
> > (could have been shorter). Currently rebuilding to test it :-)
> 
> Exactly.
> 
> The problem with -b is that it's a backwards-compatibility shorthand for
> --binary, which used to pass --allow-binary-replacement (or --binary) to
> git-apply.  However, that option was obsoleted in 2b6eef9 (Make apply
> --binary a no-op., 2006-09-06) and has been a no-op for over 5 years.
> It has also not been documented since cb3a160 (git-am: ignore --binary
> option, 2008-08-09).
> 
> So perhaps we can safely claim -b for --keep-non-patch, like so:

Yes I do think so, especially since 5 years ago, git commands were
called hyphenated like "git-am" instead of "git am". So I don't think
there's any risk in reusing the option.

Regards,
Willy
