From: Peter Simons <simons@cryp.to>
Subject: Re: Emacs git-mode feature request: support fill-paragraph correctly
Date: Tue, 27 Jan 2009 15:07:26 +0100
Organization: private
Message-ID: <878wow7sgx.fsf@write-only.cryp.to>
References: <87tz7mth3g.fsf@write-only.cryp.to> <873af59fkm.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 15:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRoch-0002FJ-Qj
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 15:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZA0OHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 09:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZA0OHh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 09:07:37 -0500
Received: from main.gmane.org ([80.91.229.2]:57872 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbZA0OHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 09:07:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LRobG-0005WN-DC
	for git@vger.kernel.org; Tue, 27 Jan 2009 14:07:34 +0000
Received: from p54bd14fe.dip0.t-ipconnect.de ([84.189.20.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 14:07:34 +0000
Received: from simons by p54bd14fe.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 14:07:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd14fe.dip0.t-ipconnect.de
Cancel-Lock: sha1:SHqk6OWWnDNKd9f8ErORKtQOaWA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107347>

Hi Alexandre,

 > diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
 > index 3c37d0d..e314c44 100644
 > --- a/contrib/emacs/git.el
 > +++ b/contrib/emacs/git.el
 > @@ -1331,6 +1331,7 @@ Return the list of files that haven't been handled."
 >  					 (log-edit-diff-function . git-log-edit-diff)) buffer)
 >  	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
 >        (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
 > +      (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
 >        (setq buffer-file-coding-system coding-system)
 >        (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))

that patch has the desired effect (tested with GNU Emacs 22.3.1 and
GIT 1.6.1). Thank you very much.

Now, I'd be hugely in favor of applying that change to the repository
so that future versions of GIT have it.

Take care,
Peter
