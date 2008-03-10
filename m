From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Mon, 10 Mar 2008 19:38:08 +0100
Message-ID: <200803101938.09300.jnareb@gmail.com>
References: <200803091459.21354.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYmtn-0002yL-OG
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 19:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYCJSiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYCJSiP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 14:38:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14192 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYCJSiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 14:38:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so4945618ugc.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ya8QOGZ95oUWiN0huufXAY9gzcgy3OEgtybEudU2qiE=;
        b=YBCOsLKTfuD3DPdoboNgevi6UFTGGZ3pMuxJPG8gJ21AzDQF7b/LzolT1KKyOVVctpxc+TCBGcfGx8QlTfMIBETrObK/LHpLsTmRu5VSTM7iD3L/xyKGwLEtkwsnqFKEsnR9BtJbQgm8M7WBMJNPPijSUZl3EiuFw+ABfRTnRqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=x6DrUF2r+6s686Yf8p1ugCPW3/tmTSYlMPYPBnrkb1R7SSSy1oENUaSI2UhiHG+xzNG6WElveumfAcy/dgKltNpwvq0zK+Cgzq1fSYc/rp4/hAJ80XTwRrVQmWLzWQpixAJH5w/qWloADSTNGqbdzrIC/QdLgtcqqX3DTgvaJ50=
Received: by 10.66.233.14 with SMTP id f14mr4066460ugh.84.1205174292844;
        Mon, 10 Mar 2008 11:38:12 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.230.40])
        by mx.google.com with ESMTPS id e23sm31106006ugd.56.2008.03.10.11.38.10
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 11:38:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200803091459.21354.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76750>

On Sun, 9 Mar 2008, Jakub Narebski wrote:

> When reading "Distributed Revision Control with Mercurial" to
> see how Mercurial differs from Git, in the chapter 14 "Adding
> functionality  with extensions" there is description
> (in section 14.1) of one  interesting extension,
> namely 'inotify' extension. 

By the way, when browsing list of available Mercurial extensions
http://www.selenic.com/mercurial/wiki/index.cgi/UsingExtensions
inotify extension was single extension which doesn't have less
or more direct equivalent in Git, or cannot be easy done in Git.

See the table below for details:

Mercurial extension | git equivalent (or proposal)
--------------------+------------------------------------
acl                 | update-paranoid contrib hook
alias               | alias.<cmd> config
bisect              | git-bisect
bugzilla            | possible as hook
children            | possible command, cf. git-name-rev
convert (!)         | <possible, would be nice to have>
extdiff             | diff.external / GIT_EXTERNAL_DIFF
fetch               | git-pull (sic!)
gpg                 | signed tags
graphlog            | <possible, see: tig, git-forest>
hgk (*)             | gitk
imerge              | see git-mergetool
keyword expansion   | check possible gitattributes
mq                  | Guilt, StGit
notify              | post-receive-mail contrib hook,
                    | default update hook
graphviz            | <can be done>
send                | <possible, wrapper around git-bundle>
rdiff (!)           | <a trick for local repo in GitTips>
localbranch (*)     | git-branch, git-checkout
parentRevspec (*)   | rev^, rev^1 or rev^2, rev~n
patchbomb           | git-send-email
record              | git add -i, git commit -i
transplant          | git-rebase
win32ext            | core.autocrlf config
churn               | see git-shortlog
purge               | git-clean
cvscommit           | see git-cvsexportcommit, git-cvsserver
config              | compare git-config
digest              | see git-ls-remote for bundle
diffstat            | git diff --diffstat, default for git-pull
easy*               | see tig
forest              | git-submodule
hgcia               | CIA hook mentioned on GitWiki
inotify (!!!)       |

Footnotes:
==========
(*) Directly inspired by git feature
(!) No direct equivalent, would be quite a work to add
(!!!) No equivalent, don't know if possible

-- 
Jakub Narebski
Poland
