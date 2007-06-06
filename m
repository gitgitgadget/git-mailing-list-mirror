From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: Allow gvimdiff to be used as a mergetool
Date: Tue, 5 Jun 2007 22:45:45 -0400
Message-ID: <20070606024545.GA32603@thunk.org>
References: <11810938823594-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 04:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvlXQ-0000SD-B1
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 04:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXFFCqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 22:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbXFFCqM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 22:46:12 -0400
Received: from thunk.org ([69.25.196.29]:50640 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbXFFCqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 22:46:11 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HvleX-0003QS-O9; Tue, 05 Jun 2007 22:53:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HvlWr-000225-KA; Tue, 05 Jun 2007 22:45:45 -0400
Content-Disposition: inline
In-Reply-To: <11810938823594-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49238>

Dan, your patch didn't add a gvimdiff check to the code which
determins which merge tool to use if one isn't specified in the config
file:

if test -z "$merge_tool" ; then
    if type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
	merge_tool="kdiff3";
    elif type tkdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
	merge_tool=tkdiff
    elif type xxdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
	merge_tool=xxdiff
    elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
	merge_tool=meld
    elif type opendiff >/dev/null 2>&1; then
	merge_tool=opendiff
    ...

Was this interntional?

Regards,

						- Ted
