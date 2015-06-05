From: Ed Avis <eda@waniasset.com>
Subject: Re: Suggestion: make git checkout safer
Date: Fri, 5 Jun 2015 18:46:41 +0000 (UTC)
Message-ID: <loom.20150605T203544-871@post.gmane.org>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org> <20150603194756.GB29730@vps892.directvps.nl> <loom.20150604T124827-124@post.gmane.org> <5570B1AC.2060108@web.de> <loom.20150605T113129-339@post.gmane.org> <CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com> <xmqqd21arq0n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 20:47:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0weL-0005q8-Ru
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 20:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbbFESrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 14:47:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:46848 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbbFESrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 14:47:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z0wdv-0005We-5J
	for git@vger.kernel.org; Fri, 05 Jun 2015 20:46:59 +0200
Received: from dsl-217-155-72-22.zen.co.uk ([217.155.72.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 20:46:59 +0200
Received: from eda by dsl-217-155-72-22.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 20:46:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.155.72.22 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270871>

I'm not attached to the wording changes posted earlier.  As I said, it is
only a starting point.

I do feel that 'git checkout PATH' is rather a dangerous operation, and
moreover a surprisingly dangerous one, since 'git checkout BRANCH' is
careful not to lose local changes, as are other common commands like
'git pull'.  In the documentation patch I tried to highlight the
distinction between the two rather different, and perhaps even
Jekyll-and-Hyde-like, modes of this command.

But rather than adding heavyhanded and redundant warnings to the
documentation it would be better for the command not to be quite so
sharp-edged.  There is already a --force option for one mode, which could
easily be made to apply to the other too (so local changes will not be
discarded unless --force is given).  Is the only argument against it that
'git checkout is intended to overwrite changes'?  That seems a little
circular since the question is whether its intended behaviour could change
to something a little safer.  Surely a sensible Huffman-coding of git
commands would give longer and harder-to-type names like 'git checkout
--force .' to relatively dangerous operations?

Or indeed, split out the two different modes into two separate commands.
The job of reverting file contents seems like something for 'git clean'.

I've said all I have to say but I would like to ask, in the hope of becoming
a better git user: if 'git checkout .' is not a safe way to restore missing
files in the working tree, what is the recommended way to do that?

Thanks all for your comments and guidance.

-- 
Ed Avis <eda@waniasset.com>
