From: =?utf-8?b?Wm9sdMOhbg==?= =?utf-8?b?RsO8emVzaQ==?= 
	<zfuzesi@eaglet.hu>
Subject: Re: [ANNOUNCE] Git 1.7.1.rc1
Date: Sun, 11 Apr 2010 15:57:28 +0000 (UTC)
Message-ID: <loom.20100411T174751-103@post.gmane.org>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 17:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0zXj-0002vj-1B
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 17:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0DKP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 11:57:42 -0400
Received: from lo.gmane.org ([80.91.229.12]:43704 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab0DKP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 11:57:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O0zXX-0002uB-5h
	for git@vger.kernel.org; Sun, 11 Apr 2010 17:57:39 +0200
Received: from catv-80-99-198-72.catv.broadband.hu ([80.99.198.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 17:57:39 +0200
Received: from zfuzesi by catv-80-99-198-72.catv.broadband.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 17:57:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.99.198.72 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144654>

Hi,

Junio C Hamano <gitster <at> pobox.com> writes:
> 
> Jens Lehmann (2):
>       Let check_preimage() use memset() to initialize "struct checkout"
>       Teach diff --submodule and status to handle .git files in submodules
> 

This breaks git-status on Windows, if repository has submodule(s).
"fatal: chdir in start_command() not implemented"

It comes from run-command.c line 345:
if (cmd->dir)
  die("chdir in start_command() not implemented");

Commit (eee49b6ce4b7b3fed28794676c67ad3609f658ac) message says:
"While at it, is_submodule_modified() was cleaned up
to use the "dir" member of "struct child_process" instead of setting the
GIT_WORK_TREE and GIT_DIR environment variables."

Z.
