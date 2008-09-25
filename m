From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 12:30:10 +0200
Message-ID: <200809251230.11342.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 12:31:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kio8D-0004Ip-Q1
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 12:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbYIYKaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYIYKaZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 06:30:25 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:24172 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYIYKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 06:30:24 -0400
Received: by ey-out-2122.google.com with SMTP id 6so111545eyi.37
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=pUZq3GDdpUhBpnE3jcoqasuQttukKLT189e4UWRQ0r8=;
        b=EzUeT5yZ8HASilDXnuX0xGFxgmUU66UOjWwMoAS3l9owZZ4uHTwcl7Awi74P8jeE8P
         rtmhOOsUXkBkqop/Mi2tKLqp6/VXgp43aMAF2nnkmgtx240e8AcGc6dFYnanJgOSWc0n
         IAQ6MRK6MH8cdmG/DbInGblb4lLrp38Yjtxhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=ZXXCb7UOdsFb+Fy3ZkL6eAWlMQydDhZlmnzTZO5D8qalJdNxvF8Ba3VmTJbJgWapHd
         T2V26Ykd+PKTATLI+KIlUb7EVZMHgn7+oZ8vu2MxWHpvHg9OZw/mUlETUhYFXZgeG+73
         3kgOW+J9RkUXavBceAkF+t/jyvIebw0N12PeI=
Received: by 10.103.228.15 with SMTP id f15mr5723468mur.14.1222338620263;
        Thu, 25 Sep 2008 03:30:20 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id s10sm707730muh.12.2008.09.25.03.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 03:30:17 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96744>

This is yet another series of planned gitweb features. It expands more
on new user-visible features than on improving gitweb code (therefore
for example using Git.pm/Git::Repo, gitweb caching, and list form of
open for pipelines are not mentioned here).

Which tasks / features are most requested?  Which tasks should be done
first?  What do you have on your gitweb TODO list? 

All comments appreciated. Thanks in advance.


* Support for FastCGI (via CGI::Fast or FCGI).

  Unfortunately I don't use FastCGI.  This has to be done in a very
  un-intruisive way, and without performance penalties for "ordinary"
  CGI and mod_perl.

  Suggested: input reading and validation refactoring.

* Optional information about load stats

  Add an option to display information about how much time it took to
  generate page, how many git commands were called, and possibly other
  metric; if page was cached, write when it was generated, and how much
  time till timeout.  This probably would require additional perl
  modules, and it should be conditional on those modules.

* AJAX sorting of tables

  Implement sorting tables (projects list, fork list, heads, tags) in
  browser using JavaScript, like tables in Wikipedia (if possible). 
  This would reduce server load, too.  Of course there would be fallback
  to server-side sorting.

* Committags support

  Support expansion of "tags" in commit messages, like gitweb now does for
  (shortened) SHA-1, converting them to 'object' view link.  It should be
  done in a way to make it easy configurable, preferebly having to
  configure only variable part, and not having to write whole replacement
  rule.

  Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
  Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protecting of
  email addresses, "rich text formatting" like *bold* and _underline_,
  syntax highlighting of signoff lines.

* Project categories support; and/or support for tags, tag clouds,
  removing tags, grouping tags, tags suggestions; and/or support for Trove
  categories (like on Freshmeat, or SourceForge, or Savane/GForge).

* Syntax highlighting for "blob" view
  (in general: blob output filter)

* New log views (formats)

  New log-like views could include: 'log' view with path limiter,
  'whatchanged' like view with list of changed files, 'mbox' format (aka
  'plain' format) to be used by git-am, etc.

  This would I think require changes to log showing infrastructure.

* Enable showing blob size in 'tree' view (optional)

* Graphical log (like gitk, qgit, tig, or git-browser)
  perhaps also graphical view of forks like in GitHub

* Enable transparent compression for HTTP output
  (for performance reasons it makes sense to do it only for cached output)

* Side by side diff (like Wikipedia/MediaWiki), and/or side by side
  comparison (see e.g. Codestriker web review tool).

* Tree blame (when, at what commit and by whom current version of file or
  directory was generated).  This view can be seen in tree/directory view
  of such SCM web interfaces as ViewVC, or GitHub.

* Searching for projects, optionally with paginating projects list page

* Graphical diffstat/dirstat in 'commit' view for merge commits.

* Enhancing gitweb output with RDFa and/or microformats, to make it
  easier to parse unambiguously by machine, for example find fetch
  URL, find push URL, find homepage, parse dates, etc.

* Support for other outline format (XOXO perhaps), and other outlines,
  perhaps also in OPML.

* Etags based anchors to function definitions, i.e. something like
  version-aware source code browser like LXR Cross Referencer (in
  Perl), cscope, Bonsai Project or OpenGrok (unfortunately CDDL
  licensed, and in Java). Should we use Exuberant Ctags
  (http://ctags.sourceforge.net)?

* Optional support for remotes and remote-tracking branches;
  and perhaps support for showing alternates (see forks support)

* Support for patch management interfaces (StGit, Guilt, TopGit), like
  gitk and QGit now have; option to show unapplied patches stack etc.

* AJAX incremental blame, if cached version does not exist

* Better snapshot names, for example <project>-<tag> for tag
  snapshots, perhaps <project>-<branch>-<date> for branch tip
  snapshots, etc.  Ensure that <filename>.<suffix> expands to
  <filename> (see also snapshots of subtrees).

* ...

-- 
Jakub Narebski
Poland
