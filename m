From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 22:15:07 +0400
Message-ID: <20140428181506.GA20059@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <535e91e6c69eb_4565148331047@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:15:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer1N-0003SK-I4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbaD1TN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:13:28 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:35610 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbaD1TNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:13:24 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Weq55-0005EI-Az; Mon, 28 Apr 2014 22:15:07 +0400
Content-Disposition: inline
In-Reply-To: <535e91e6c69eb_4565148331047@nysa.notmuch>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247394>

On Mon, Apr 28, 2014 at 12:37:42PM -0500, Felipe Contreras wrote:
> > +CC = $(CROSS_COMPILE)cc
> 
> Nice.

Actually, not. You still have to override CC because it is
$(CROSS_COMPILE)*g*cc. Any thoughts how to handle this?

> > -	RC = windres -O coff
> > +	RC = $(CROSS_COMPILE)windres -O coff
> 
> I don't think this is the best.
> 
> We should probably have this in the Makefile:
> 
>   RC = $(CROSS_COMPILE)windres
> 
> And then config.mak.uname should have
> 
>   RCFLAGS += -O coff

Okay, will do in v2.
