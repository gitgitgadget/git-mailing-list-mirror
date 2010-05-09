From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Sun, 9 May 2010 03:43:25 -0500
Message-ID: <20100509084325.GA9801@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033223.GF7958@progeny.tock>
 <20100509070022.GC23717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 09 10:42:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB25o-0000QE-6L
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 10:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab0EIImZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 04:42:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44041 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab0EIImX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 04:42:23 -0400
Received: by vws3 with SMTP id 3so775758vws.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ROtBTfqjAVYNvUA7McfVH9MzM7LHsDG8UJAlKKdvG40=;
        b=oLcPriV6w8xmefuxPGpPRyDFRR0ejDdRkz0nxTWBOa5kGesLeC8jMsMtomfyCbjHit
         SiGLlbf/8rzY2VBiT9gUDol8j9l2ybKKiAejGc8kVLpgri7rc44new+irYe6S4W2yg6p
         p+/UH10OIMpZhsckTUtsZTsN2tRl4I/s6SxIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tyzhQ0v8VLk7E4D5pMXoR8AQf0aDZoMfbbojP+oso9oD60DBTuhLuAzQz07Zg8DCNL
         XnG8jGc/zY1sjQeRNAxrLL6VVAW95IovgaqZssjFM5USTQlbsiYtYYjwmg+Tu8ehwEgA
         5iiVbQbafDVYMrW9MCh/ObjIpYfveXM1YMZVo=
Received: by 10.220.108.34 with SMTP id d34mr1928775vcp.130.1273394542322;
        Sun, 09 May 2010 01:42:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id s9sm30720446vcr.3.2010.05.09.01.42.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 01:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509070022.GC23717@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146714>

Jeff King wrote:

> Hmm. Both this and 4/8 rewrite bits of the configuration copied from
> config.txt in an earlier patch. Do any changes need to be propagated
> back to config.txt (and no, I didn't read and think carefully, so the
> answer may be "no, they are now diverging intentionally")?

Thanks for bringing this up.  I think some of the changes ultimately
ought to be propagated back to config.txt.  I copied the text anyway
because as long as the differences are in short-term memory, I find it
easier to manipulate two similar files than one file with ifdefs in
it; so it seemed like a reasonable strategy to let these diverge for a
few weeks and then merge them with ifdefs again.

Some divergence is needed imho so that the text can say things like
=E2=80=9Csee the Options section earlier in this page=E2=80=9D.

Longer term, I suspect I would like a gitconfig.5 page that functioned
something like the main commands list, which could avoid some
duplication.  But this is something to be considered carefully: right
now it is very easy to start with knowing there is some configuration
for what you want to change (conflict hunk format, say) and find it by
searching the descriptions in git-config.1; if we split that file up,
that won=E2=80=99t be so easy.

  CONFIGURATION SECTIONS

  We separate the configuration into <...>.

  Core settings

      [core] (see "Core configuration", below)
          <some blurb about core commands here...>

      [user]
          Default identity to attribute new commits to.

      [url "baseaddress"] (see git-remote(1))
          Short names to use for a long, frequently-used URL.

      [alias] (see "Aliases")
          User-defined git commands that alias other git commands
          with options.

      [gc] (see git-gc(1))
          Automatic repository repacking settings.

      [http] (see git-remote-http(1))
          Tweaking HTTP transport behavior.

      [i18n] (see git-commit(1))
          Commit log encoding and display encoding.

      [notes]
      [notes "rewrite"] (see git-notes(1))
          Display and propagation of commit notes.

      [rerere] (see git-rerere(1))
          Whether to save successful merge resolutions for later
          reuse.

  Output format

      [advice] (see "Advice Options")
          Whether to display optional help messages that may
          dwarf regular output.

      [color] (see "Colored output")
          Which commands should use colored output.

      [color "gitcommand"] (see "Colored output")
          What colors to use for a particular sort of output.  The
          relevant command name is generally the most prominent git
          command which produces that output.

      [format] (see git-log(1))
	  How to display commit metadata by default.  This section is
          shared with git-format-patch(1) configuration.

      [pager] (see "Paginated output")
          Which commands should paginate their output.

  Repository setup

      [branch "branchname"] (see git-branch(1))
          Where `git pull` should pull from for each local branch.

      [remote "reponame"] (see git-remote(1))
          URL and branches for a named remote repository.

      [remotes] (see git-remote(1))
          User-defined collections of remote repositories that are
          often fetched from or pushed to together.

  Helper programs

      [web] (see git-help(1))
          Web browser to use for 'git help --web' and 'git instaweb'.

      [merge "mergedriver"] (see gitattributes(5))
          Low-level format-specific helper for merging files.

      [browser "webbrowser"] (see git-web-browse(1))
          How to invoke a given web browser.

      [man "manpager"] (see git-help(1))
          How to invoke a given man pager.

      [difftool "diffvisualizer"] (see git-difftool(1))
          How to invoke a given diff frontend.

      [mergetool "mergeresolver"] (see git-mergetool(1))
          How to invoke a given interactive 3-way merge helper.

      [guitool "guihelper"] (see git-gui(1))
          How git gui should invoke this helper when selected from
          the "Tools" menu.

  Default behavior of commands

      [add]		git-add(1)
      [am]		git-am(1)
      [apply]		git-apply(1)
      [branch]		git-branch(1)
      [clean]		git-clean(1)
      [commit]		git-commit(1)
      [diff]		git-diff(1)
      [difftool]	git-difftool(1)
      [fetch]		git-fetch-pack(1), git-fetch(1), git-pull(1)
      [format]		git-format-patch(1), git-log(1)
      [gc]		git-gc(1)
      [gitcvs]		git-cvsserver(1)
      [gui]		git-gui(1)
      [help]		git-help(1), git --help
      [imap]		git-imap-send(1)
      [init]		git-init(1)
      [instaweb]	git-instaweb(1)
      [interactive]	git-add--interactive(1), git add -i
      [log]		git-log(1), git-show(1), git-whatchanged(1)
      [mailmap]		git-shortlog(1)
      [man]		git-help(1)
      [merge]		git-merge(1), git-mergetool(1)
      [mergetool]	git-mergetool(1)
      [notes]		git-notes(1)
      [pack]		git-gc(1), git-repack(1)
      [pull]		git-pull(1)
      [push]		git-push(1)
      [receive]		git-receive-pack(1)
      [repack]		git-repack(1)
      [sendemail]	git-send-email(1)
      [sendemail "profile"]
			git-send-email(1)
      [showbranch]	git-show-branch(1)
      [status]		git-status(1)
      [tar]		git-archive(1)
      [transfer]	git-fetch-pack(1), git-receive-pack(1)
