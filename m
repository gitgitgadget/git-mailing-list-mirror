From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Compiling git with -Werror
Date: Fri, 27 Apr 2012 11:58:45 +0200
Message-ID: <87bomd338q.fsf@thomas.inf.ethz.ch>
References: <4F9A6AB0.1050504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:59:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNhx7-0000XB-M3
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 11:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760097Ab2D0J6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 05:58:51 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:24631 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2D0J6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 05:58:48 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 27 Apr
 2012 11:58:43 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 27 Apr
 2012 11:58:45 +0200
In-Reply-To: <4F9A6AB0.1050504@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 27 Apr 2012 11:45:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196463>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Is there some other mechanism to set strict CFLAGS parameters for the
> build without confusing ./configure?

As mentioned on IRC, you can put

  CFLAGS = -g -O2 -Wall -Werror -Wdeclaration-after-statement

in config.mak.  The Makefile includes that if it exists, so it is a good
place to gather your custom settings.

One trick I like to do in every Makefile is

  O = 3
  CFLAGS = -g -O$(O) -Wall <blah>

That way 'make O=0' does a build suitable for debugging.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
