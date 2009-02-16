From: Jason Spiro <jasonspiro4@gmail.com>
Subject: Improving CRLF error message; also, enabling autocrlf and safecrlf by default
Date: Mon, 16 Feb 2009 02:45:43 +0000 (UTC)
Message-ID: <loom.20090216T022524-78@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 03:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtW4-0008Nn-Bz
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbZBPCqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZBPCqA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:46:00 -0500
Received: from main.gmane.org ([80.91.229.2]:34940 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbZBPCp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:45:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYtUX-0007zu-HH
	for git@vger.kernel.org; Mon, 16 Feb 2009 02:45:53 +0000
Received: from CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com ([99.226.154.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:45:53 +0000
Received: from jasonspiro4 by CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:45:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.226.154.227 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110116>

Hi,

Thanks for writing git.  It's a darn useful tool.  But one thing:

One of the pre-commit hooks detects trailing whitespace:

if (/\s$/) {
bad_line("trailing whitespace", $_);
}

Unfortunately, when I try to check in a file with DOS (CR+LF) line endings, 
this hook triggers on every line.  This happens on Cygwin.  I haven't checked, 
but I bet it happens on other platforms as well, as long as this hook runs.

But the error message "trailing whitespace" doesn't clearly tell me what's 
wrong.

1.  Could you please modify Git so that, when such a problem happens, it 
instead prints an message saying that the file has CR+LF line endings, and that 
Git does not allow this?

2.  In addition, could you please enable the core.autocrlf and core.safecrlf 
options by default in the next version of Git?

P.S.  I hereby release the contents of this e-mail message to the public 
domain.

Thanks in advance,
--
Jason Spiro: software/web developer, packager, trainer, IT consultant.
I support Linux, UNIX, Windows, and more. Contact me to discuss your needs.
+1 (416) 992-3445 / www.jspiro.com
