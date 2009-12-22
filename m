From: Craig Moore <craigtmoore@googlemail.com>
Subject: Trouble with 'make prefix=/usr info'
Date: Tue, 22 Dec 2009 15:50:25 +0000 (UTC)
Message-ID: <loom.20091222T164442-704@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 16:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN74w-0002ZR-9l
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 16:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZLVPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 10:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbZLVPzM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 10:55:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:40115 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbZLVPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 10:55:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NN74j-0002Uk-Rd
	for git@vger.kernel.org; Tue, 22 Dec 2009 16:55:05 +0100
Received: from craig-tower.elis.UGent.be ([157.193.206.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 16:55:05 +0100
Received: from craigtmoore by craig-tower.elis.UGent.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 16:55:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 157.193.206.178 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.15) Gecko/2009102719 Red Hat/3.0.15-3.el5_4 Firefox/3.0.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135581>

Hi,

I'm getting the following error when I make the info target:

$ make prefix=/usr info
make -C Documentation info
make[1]: Entering directory `/local/software/git-1.6.5.7/Documentation'
make[2]: Entering directory `/local/software/git-1.6.5.7'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/local/software/git-1.6.5.7'
    DB2TEXI user-manual.texi
Usage: jw [<options>] <sgml_file>
where <options> are:
  -f|--frontend <frontend>:      Specify the frontend (source format)
                                 (default is docbook)
  -b|--backend <backend>:        Specify the backend (destination format)
                                 (default is html)
  -c|--cat <file>:               Specify an extra SGML open catalog
  -n|--nostd:                    Do not use the standard SGML open catalogs
  -d|--dsl <file>|default|none:  Specify an alternate style sheet
                                 (default is to use the default stylesheet)
  -l|--dcl <file>:               Specify an alternate SGML declaration
                                 (usual ones like xml.dcl get detected
automatically)
  -s|--sgmlbase <path>:          Change base directory for SGML distribution
                                 (usually /usr/share/sgml)
  -p|--parser <program>:         Specify the parser if several are installed
                                  (jade or openjade)
  -o|--output <directory>:       Set output directory
  -u|--nochunks:                 Output only one big file
                                 (overrides the stylesheet settings)
  -i|--include <section>:        Specify a SGML marked section to include
                                 (should be marked as "ignore" in the SGML text)
  -w|--warning <warning_type>|list: Control warnings or display the allowed
warning types
  -e|--errors <error_type>|list: Control errors or display the allowed error types
  -h|--help:                     Print this help message and exit
  -V <variable[=value]>:         Set a variable
  -v|--version:                  Print the version and exit
make[1]: *** [user-manual.texi] Error 1
make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentation'
make: *** [info] Error 2

I can see that the error is likely related to the fact that it enters the
Documentation directing, then exits the Documentation directory, and then tries
to build the user-manual.texi file in the root directory (however, that file is
in the Documentation directory, which it just left). I've tried to track down
and change where it exits the Documentation directory, but I've had no success.

I would appreciate any recommendations you might have. I've already been able to
install git, but I couldn't install the 'info' target because of this error.

Thanks,
Craig
