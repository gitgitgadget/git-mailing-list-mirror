From: Jakub Narebski <jnareb@gmail.com>
Subject: What's in my gitweb StGit queue (12 Jan 2009)
Date: Mon, 12 Jan 2009 02:52:29 +0100
Message-ID: <200901120252.29585.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMC08-0002JF-RJ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbZALBwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZALBwg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:52:36 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:57088 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZALBwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:52:35 -0500
Received: by ewy10 with SMTP id 10so11269993ewy.13
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 17:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6iI5ZSOSJ9IG0Rs3QkQ8maG5xmRE3Re22Axeq2N4N3c=;
        b=cZDs7r16EsbairbZi0ES/2EN+LX229Rc1h1Y2bHlvYPb3MaNwwL9cbsufY49zm/pQr
         nseB6gfdkVIAl98ogu+T3HS+AgZjLzl/9UwvTrVBD+Q0qWgIzfy6zI9vyhCJHi0Ywziz
         NT0buL1phMBMyOGk2qFwwqytJSXXq2TBbzlbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=DzWDfExi2JZsBdU6VhSUi8jy/jIu951eEFwYkalYudIKSqUjXa01+ZDszZCzSzw/dQ
         WR8tJ+xfX/03fiOsr14WQfWVrNVmuCpH9vS0E0hfvUbvhM4YYAEM91paeMvGHrRCI3xZ
         yJXkZu1fWzDPzLtLRCCgSwZ0L5qMW/HBMA9QM=
Received: by 10.210.60.3 with SMTP id i3mr1071413eba.115.1231725153276;
        Sun, 11 Jan 2009 17:52:33 -0800 (PST)
Received: from ?192.168.1.11? (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id z37sm18747510ikz.0.2009.01.11.17.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 17:52:32 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105274>

Starting from the bottom of the stack; all but first two are
unapplied, and might not apply without conflicts.

I wrote it down among others to get comments which features would you
like to see first.  If you plan on working on some feature listed here
yourself, ask and I can send a patch as it is now.

* gitweb: Document that gitweb deals with bare repositories

  This was sent to git mailing list with the comment that I could not
  find best way of phrasing it. But I think it is worth applying,
  anyway. But on the other hand side it can wait, too.

* gitweb: Incremental blame (proof of concept)

  This patch was sent to git mailing list as an RFC. It is resend
  (with some corrections and additions) of patch by Petr Baudis, which
  in turn was tweaked up version of Fredrik Kuivinen. I think it
  should be split into three or four patches:
   - gitweb: Add optional "Generated in ..." info to footer
   - gitweb: Incremental blame
   - gitweb: Colorize output during incremental blame
   - gitweb: Use incremental blame if JavaScript is enabled

* gitweb: Fix nested links problem with ref markers (WIP)

  This is currently more of notification of a bug, than a feature.
  The problem is that some browsers in strict mode actively forbid
  nested links (which is not allowed according to (X)HTML standard),
  and they move inner link to just outside outer link element,
  breaking layout in the case of page header for 'commit' action and
  other views.

  I have just send email about this issue.

* gitweb: Separate features with no project specific override

  Currently both per-project features like 'snapshots' (which can be
  configured to be overridable by project repository config), and
  global features like 'search' or 'forks' (which does not support
  project specific overrides) are both put in %feature hash.

* gitweb: Extend project_index file format by project description

  Change format of $projects_list file by making it possible to add
  optional project description, and make 'project_index' output new
  format, with description.  This is to have all project info for
  project list page in one place.

* gitweb: open files (e.g. indextext.html) in utf8 mode

  TO BE DELETED. I think it was (independently?) sent and accepted
  already.

* gitweb: Project search

  TO BE DELETED. There is implementation by Pasky in gitweb already.

* gitweb: Paginate project list

  This patch was sent to git mailing list together with the one above
  in one series, but now it will probably conflict due to the changes
  in the area.  It was perhaps a bit overcomplicated because of trying
  to calculate only _minimal_ set of information needed for sorting
  (or searching) for all projects, and filling all info only for
  _displayed_ projects.

  Probably would have to be preceded by patch which makes selection of
  what is displayed (searching projects, selecting tags, hiding forks)
  be explicit and not happen at display time.  Otherwise we will have
  less items per page than it should be.

* gitweb: Remove commit title from comitdiff_plain body

  This name is not entirely correct, as this commit is about making
  commitdiff_plain view to look more like "git show --format=email".
  It is a bit obsoleted by 'patch' view (in cooking); further
  discussion is required about this patch, for example if
  commitdiff_plain view should perhaps be dropped.

* gitweb: Uniquify usage of subroutine prototypes

  Truth to be told this patch is mainly because imenu support for
  CPerl mode in GNU Emacs trips from time to time on 
  "sub S_ISGITLINK($) {"

* gitweb: Redirect to appropriate view if 'a=' parameter is missing
* gitweb: Simplify object type detection in git_object()
* gitweb: Make 'object' action implicit by using no action URL

  This series of patches is about the fact that gitweb currently has
  two ways of filling 'action' parameter: one if it is missing by just
  deciding based on type of object what to put in $action, without
  changing URL; and the one used for generic 'object' view when we do
  full HTTP redurection (and change URL).  Those patches try to unify
  this area a bit.

* gitweb: Use list form of 'open "-|"' pipeline

  Gitweb uses list form of open, which has the double advantage of not
  invoking shell (one fork less) and not having to shell escape
  parameters... with the exception of a few places where output of git
  command has to be filtered (pipelined) to other command.  Currently
  only snapshot uses that (to compress tarball from git-archive); in
  the future syntax highlighting would also use the same mechanism.
  This patch is very much work in progress / research in motion.

* gitweb: Try harder in parse_tag; perhaps it was given ambiguous name

  This is companion to the patch which is already in gitweb making git
  use full ref names, i.e. 'refs/tags/v1.6.0', and not 'v1.6.0' for
  h/hb. Well, companion in the sense that it does the other side of
  this issue: whet to do if we have ambiguous refs, and not generating
  always unambiguous refs.  The problem is with "git cat-file tag <ref>",
  when <ref> is both tag and non-tag ref... but perhaps this should be
  resolved in-core.

* gitweb: Change division of gitweb pages into parts
* gitweb: CSS cleanup (WIP)

  This patch series tries to uniquify page division, and simplify CSS
  for gitweb to not have to repeat rules, to not have to use class to
  not break layout, etc.

* gitweb: Try to sanitize mimetype for 'blob_plain' view

  Defensive programming: use 'text/plain' for files which are text and
  can be viewed in a browser, and are not among a few 'text/*' mimetypes
  universally recognized by web browsers (e.g. 'application/x-perl'
  should be shown as 'text/plain').  Alternate solution would be to
  use own mime.types (gitweb has configuration option for this).

* gitweb: Add an option to show size of blobs in the tree view

  This probably has to be a %feature bacause of performance impact:
  make use of the fact that 'git ls-tree -l' can show sizes of blobs.
  Thsi feature is inspired by cgit.

* gitweb: Enable transparent compression for HTTP output

  IIRC the consensus was that it usually doesn't make sense to use it,
  but perhaps with caching... Is %feature. Requires quite modern Perl
  with PerlIO::gzip, but fallback on no-compression if it does not
  exists.

-- 
Jakub Narebski
Poland
