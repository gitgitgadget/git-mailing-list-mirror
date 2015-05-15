From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 19:55:34 -0400
Message-ID: <20150515235534.GA31000@flurp.local>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
 <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
 <xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
 <5556582C.3010409@gmail.com>
 <xmqqmw15fu5m.fsf@gitster.dls.corp.google.com>
 <CAPig+cSjHyh5eO6KWYMo_OxUmDQWP9TnnuaBvnBGWVDh7pesOQ@mail.gmail.com>
 <xmqqegmhfpeb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?S=E9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 01:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtPTK-0008Ng-UL
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 01:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422989AbbEOXzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 19:55:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36806 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbbEOXzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 19:55:44 -0400
Received: by iepk2 with SMTP id k2so134176144iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lDNVij3QAwaOB/A9slqx0KS5mYzf6Krj+75BD5J6trk=;
        b=yq2GYmhESdgt3GKwNqjptirtCGNbBnHbC9kAZvdVhuB/N7hwAJqb4xqb1H3CX5anDd
         /1jTp7KQDeGBPgOu3zKTkV4jPL/w5PwEqdJ90Jq3CsytvIGmdcY542dcnVSqClTvq1TJ
         r5ohUPuB9sVF2EMrfG0Li7oJ94ThHFI5O0sCaRxMxEqI/b6ilyIsXMVlQmrRbYgI3LY/
         36LNLRyrLPV3BJ9YyDeSIiMus2C7a53pHOMRwXoRFEcqKAjZ8FkxFDiH+wH+4EZb/JCp
         wepaHKNU7VoKnvxmY5gVKENDbyKhvGUeCBE0beGsl380vScF2ViWRLhnd5RasVy03bNe
         uCrA==
X-Received: by 10.50.72.8 with SMTP id z8mr1465883igu.36.1431734144100;
        Fri, 15 May 2015 16:55:44 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id d4sm218705igl.1.2015.05.15.16.55.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 16:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqegmhfpeb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269192>

On Fri, May 15, 2015 at 03:26:52PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, May 15, 2015 at 4:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> I was just pointing out that you did not even have to have patch
> >> 1/5.
> >
> > Is that entirely accurate? The machinery (Makefiles, cmd-list.perl)
> > does have to be updated at some point to skip the "common" block which
> > get added in patch 2/5.
> 
> That is true, but if "# List of known git commands" instead of
> [commands] were used as the separator line, 1/5 wouldn't have needed
> any change to the Makefile.
> 
> Of course, if you need to add lines that would appear as junk to the
> old parser (e.g. the grouping info), at that point you would of
> course need to tell the parser to skip them.

Right. Preparing the machinery for the the upcoming "common" group
was actually the intent of patch 1/5 in the proposal[1]. Introducing
the [commands] header at that stage was merely a rather ugly
implementation detail of that goal, and I wasn't particularly happy
about suggesting it due to its ugliness. Unfortunately, the 1/5
commit message didn't clarify the matter. So, your observation of the
seeming pointlessness of patch 1/5 (which adds the [commands] header
for apparently no good reason) is quite understandable.

A more properly focused commit message (along with your suggestion to
scan for a comment or other separator) might help to salvage 1/5.
Perhaps something like this:

--- >8 ---
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/5] command-list: prepare machinery for upcoming "common
 groups" section

The ultimate goal is for "git help" to classify common commands by
group. Toward this end, a subsequent patch will add a new "common
groups" section to command-list.txt preceding the actual command list.
As preparation, teach existing command-list.txt parsing machinery, which
doesn't care about grouping, to skip over this upcoming "common groups"
section.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/cmd-list.perl | 4 ++++
 Makefile                    | 5 +++--
 command-list.txt            | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..5aa73cf 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -38,6 +38,10 @@ sub format_one {
 	}
 }
 
+while (<>) {
+	last if /^### command list/;
+}
+
 my %cmds = ();
 for (sort <>) {
 	next if /^#/;
diff --git a/Makefile b/Makefile
index 25a453b..5ed0acf 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,7 +2454,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2462,7 +2462,8 @@ check-docs::
 		esac ; \
 	done; \
 	( \
-		sed -e '/^#/d' \
+		sed -e '1,/^### command list/d' \
+		    -e '/^#/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/command-list.txt b/command-list.txt
index 54d8d21..609b344 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,4 +1,5 @@
-# List of known git commands.
+# do not molest the next line
+### command list
 # command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
-- 
2.4.1.260.ga2776d4

--- >8 ---

[1]: http://article.gmane.org/gmane.comp.version-control.git/268756
