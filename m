From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] gitk: Import msgcat for translation support
Date: Sat, 28 Jul 2007 09:53:28 +1000
Message-ID: <18090.34168.705811.872887@cargo.ozlabs.ibm.com>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 04:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEcDZ-0002l8-0O
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 04:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055AbXG1Cjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 22:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbXG1Cjk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 22:39:40 -0400
Received: from ozlabs.org ([203.10.76.45]:52559 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416AbXG1Cji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 22:39:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 172A3DDE28; Sat, 28 Jul 2007 12:39:37 +1000 (EST)
In-Reply-To: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53988>

Christian Stimming writes:

> Import tcl's msgcat package to have the [mc...] procedure for  
> translation available.

I would prefer

if {[catch {
    package require msgcat
    # rest of your new stuff
}]} {
    proc mc {str} {
	return $str
    }
}

so that everything still works if msgcat isn't available.  In other
words I don't want to introduce a possible regression by increasing
gitk's requirements.

Paul.
