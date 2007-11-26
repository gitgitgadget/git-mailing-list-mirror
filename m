From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:57:50 +0100
Message-ID: <20071126195750.GD25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <854pf8243i.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwk67-0006j7-VZ
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbXKZT6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbXKZT6G
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:58:06 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:32984 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404AbXKZT6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:58:04 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E094E76DA0;
	Mon, 26 Nov 2007 20:58:01 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id HRTJNpthvT67; Mon, 26 Nov 2007 20:57:58 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 23AF476D94;
	Mon, 26 Nov 2007 20:57:55 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Iwk5W-0006u1-VR; Mon, 26 Nov 2007 20:57:50 +0100
Content-Disposition: inline
In-Reply-To: <854pf8243i.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66105>

On Mon, Nov 26, 2007 at 20:34:25 +0100, David Kastrup wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > On Mon, 26 Nov 2007, David Kastrup wrote:
> >> Get rid of plumbing at the command line level.
> >
> > We can't get rid of plumbing.
> 
> What about "at the command line level" did you not understand?

Which part of we neither can nor want did you not understant?

The availability of plumbing is really big part of a reason why git is so
good and has so many scripts and tool built on top of it. Bzr and hg boast
with their ability to add plugins, but git ability to use plumbing simply
beats that hands down, because the plugins are python-only and writing them
requires understanding the internal API, while git plumbing can be used from
any language and can usually be understood by running it interactively a few
times.

That's why we don't want (and really can't because there is a huge amount of
code in various languages using it) to get rid of plumbing at the command
level. What we may do is hide it from the casual user.

To do that, we'd want to get rid of the git-* commands and links in bin
(remove the builtins altogether and move the non-builtin to libexec -- that
seems to be the plan for 1.6 or 1.7 already) and than hiding the plumbing
from --help and completion hides it from the user.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
