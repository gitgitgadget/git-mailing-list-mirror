From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 5 Mar 2007 18:16:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
 <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC4B55.3090505@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 05 18:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGni-0005DC-Rp
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbXCERQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbXCERQi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:16:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:47265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752805AbXCERQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:16:38 -0500
Received: (qmail invoked by alias); 05 Mar 2007 17:16:36 -0000
X-Provags-ID: V01U2FsdGVkX1/SWp494znS6mCVipiYz1U3DW8yUQiunMB8MrqaNX
	u0OlxSYqtdDqhF
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EC4B55.3090505@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41462>

Hi,

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> > Well, you make a good case there. I am only mildly concerned that this 
> > might not work on some obscure platforms (including Windows and 
> > SunOS), and that we are not even realizing that because you do not 
> > check the return value of sscanf().
> 
> I check that the %n's are written to, instead.

Yes, you also check real_ref instead of checking if dwim_ref() returned 0. 
I feel a little bit uneasy about that, since there is no guarantee that 
these values are left untouched, whereas the return value is guaranteed to 
behave as expected.

I also feel a little uneasy about having to parse a format in order to 
parse a string, when you know what that string should look like. For 
example, you could make the code even more compact by asking 
"(p = strstr(value, "/*:refs/remotes/"))".

But if other people do not feel as uneasy about these issues as I do, I 
certainly will not reject your patch.

Ciao,
Dscho
