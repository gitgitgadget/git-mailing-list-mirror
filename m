From: Jakub Narebski <jnareb@gmail.com>
Subject: What's cooking in gitweb (20 Sep 2008)
Date: Sun, 21 Sep 2008 01:38:00 +0200
Message-ID: <200809210138.01874.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	"J.H." <warthog19@eaglescrag.net>,
	"Gustavo Sverzut Barbieri" <barbieri@profusion.mobi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 01:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhC2t-0008Dq-5e
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 01:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbYITXiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 19:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYITXiO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 19:38:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:44826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYITXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 19:38:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so957861fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=uGsOi2Cyl7LY6LRhRStgsFWaTc9BRZJuhhd2nPzrO40=;
        b=Kk2xWtD9nLIRZ/WTZIRiBvm+j9y4laUZSqG6e8CgmnlriIsgv0VnyMtN0oe/9CvCOD
         meKGfvCWeKEcSO7u1xNNdX6T6xMeJoHRdItvKDTfA89dCbR6EeTs+jVcZ8ClwH1othyi
         lLNty6astHck+cDEFoB7plL7SSTFVNkFJeifE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=DZF5CWr5FBiV+lKsINdJnFKqQ762G2+LDlIxvFy/TtulFR0N2Xe+YGES8Z/kaZGnEY
         VnKbbKznuG051/dQfwL2+L9VE7GIwblqOaROBNDXfPWPiVAI0fCxvep8zvbVIiFNzq94
         7fnoKHXrVI2Xd+jAsf2+mGJC/EjRDTnGdgw0g=
Received: by 10.86.79.19 with SMTP id c19mr3457557fgb.67.1221953889894;
        Sat, 20 Sep 2008 16:38:09 -0700 (PDT)
Received: from ?192.168.1.11? (abvc201.neoplus.adsl.tpnet.pl [83.8.200.201])
        by mx.google.com with ESMTPS id 4sm3882803fge.8.2008.09.20.16.38.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 16:38:08 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96378>

This is short summary of not-applied (and not ready to be applied)
gitweb patches, in reverse chronological order, with most recent
entries on top (first). Patches which probably should be resend, now
that we are after 1.6.0 release

Junio, what about "[PATCH] avoid gitweb uninitialized value warning"
(http://thread.gmane.org/gmane.comp.version-control.git/95028)? This
is pure bugfix (well, warning fix, and failrly rare one, but warning
which goes to web server logs).

$gmane=thread.gmane.org/gmane.comp.version-control.git


1. "gitweb pathinfo improvements" by Giuseppe Bilotta
   Message-ID: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
   http://$gmane/94779

   Table of contents:
   ==================
    * [PATCH 1/5] gitweb: action in path with use_pathinfo
    * [PATCH 2/5] gitweb: use_pathinfo filenames start with /
    * [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
    * [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
    * [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri

   Need some refinement, especially with respect to _generating_
   path_info URLs inside gitweb.  Some patches (2 and 5) does not
   need correction, and probably should be sent as separate series.
   Author promised to resend series, if I remember correctly.


2. "[PATCH] gitweb: shortlog now also obeys $hash_parent" by Giuseppe Bilotta
   Message-ID: <1218204731-9931-1-git-send-email-giuseppe.bilotta@gmail.com>
   http://$gmane/91666

   Very good idea, but for the following two caveats.  The name
   '$commit_hash' is a bit strange to mean also revision range; passing
   "a..b" to parse_commits()... well, it is a good solution, but for me it
   feels a bit hacky.  But this is not something serious.

   More importnat fact is that I'd very much like for _all_ log-like views
   (perhaps with exception of feeds: Atom and RSS) to implement this
   feature.  This could be done by either doing it all in the same commit,
   doing commit series changing 'shortlog', 'log' and 'history' separately,
   or what I would prefer actually, to refactor generation of log-like views
   to use single worker/engine subroutine.


3. "[PATCH 1/1] Add "git" link to the end of project line on the
   project_list page." by John 'Warthog9' Hawley
   Message-ID: <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net>
   http://$gmane/91305
   See also: http://$gmane/90778

   As it was said in the commit message (which should be line-wrapped by
   the way) it makes the assumption that each repository is available from
   unique location.  Both per-repo cloneurl and gitweb.url, and per
   instllation @git_base_url_list allow for multiple repository URLs.

   The problem of course is _which_ of those to choose for the targer of
   'git' links on projects list page.  And I don't think adding yet another
   prefix to generate $project URL is a good dolution; better to simply
   use first of URLs, and mention it both in comments in gitweb, and in
   gitweb/README.  Perhaps simply use first entry in @git_base_url_list.

   Commit message could be improved too.


3. "Re: [PATCH 0/3] Git::Repo API and gitweb caching" by Lea Wiemann
   Message-ID: <48A9CEC0.2020100@gmail.com>
   http://$gmane/92726
   Demo: http://odin3.kernel.org/git-lewiemann/

   Result of "gitweb caching" Google Summer of Code 2008 project.
   This is second resend of gitweb patch; the patches adding Mechanize
   test of gitweb output, and Git::Repo api had more revisions (reviews)
   on git mailing list.

   Quote (perhaps it is simply not possible...):
   > I unfortunately didn't end up being able to split up the third patch
   > (use Perl API in Gitweb, and add caching layer), since the two changes
   > are too intricately linked to be properly separated (I actually tried
   > splitting it two times, two different ways, and it just didn't work).

   Those patches, in particular the gitweb one, needs some review I think,
   as they affect quite a bit of code.


4. "[PATCH 0/2] gitweb use sections" by Gustavo Sverzut Barbieri
   Message-ID: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
   http://$gmane/90553
   Demo: http://staff.get-e.org/

   Patches overview:
   ==================
   * [PATCH 1/2] gitweb: sort projects by path.
   * [PATCH 2/2] gitweb: add section support to gitweb project listing.

   What I'd like to have for first patch is at least estimating
   performance hit (if there is any), and an example where original old
   code sorts paths wrongly.

   Nevetheless I think it is a good idea to have.  I didn't reviewed the
   code though...


-- 
Jakub Narebski
Poland
