From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK BUGFIX)] gitk: Allow safely calling nukefile from a run queue handler.
Date: Mon, 11 Aug 2008 10:15:19 +1000
Message-ID: <18591.33943.93992.177637@cargo.ozlabs.ibm.com>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu>
	<200808091313.52528.angavrilov@gmail.com>
	<217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu>
	<200808091441.50444.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Jaeger <christian@jaeger.mine.nu>, git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 02:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSL5M-00018p-2U
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 02:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYHKAP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYHKAP3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 20:15:29 -0400
Received: from ozlabs.org ([203.10.76.45]:53301 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbYHKAP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 20:15:29 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D6E7FDDE1B; Mon, 11 Aug 2008 10:15:27 +1000 (EST)
In-Reply-To: <200808091441.50444.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91906>

Alexander Gavrilov writes:

> Originally dorunq assumed that the queue entry remained first
> in the queue after the script eval, and blindly removed it.
> However, if the handler calls nukefile, it may not be the
> case anymore, and a random queue entry gets dropped instead.
> 
> This patch makes dorunq remove the entry before calling the
> script, and adds a global variable to allow other functions
> to determine if they are called from within a dorunq handler.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Thanks, applied.
