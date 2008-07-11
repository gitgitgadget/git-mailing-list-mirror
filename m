From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: [GitStats] Bling bling or some statistics on the git.git repository
Date: Fri, 11 Jul 2008 23:04:31 +0200
Message-ID: <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@gmail.com>
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHPo4-0002RP-Fy
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbYGKVEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYGKVEe
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:04:34 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:43915 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027AbYGKVEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:04:33 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1371944yxm.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XwfTRYWxOHYP6tsD4wRvss6F71DGn5iUihIkgjASdlY=;
        b=mO8wl0dbIA21tUS2T//WNEoQzsGqufoHBFfGOC+4vDaAmtR61FXkbfVWj4oCdZSNv+
         HurbNnZ9rmDX5l7rpmv2trDSZ1CeZSP00dSQoua/N96YAQnlb/UKY2WsUSRDujAQygCU
         GkSFr0MUntevQqmz6MxnuZjXUGW8VOiHNZ/QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=V6uessMGkcpDnig5OzbZMc4binci87Z6YZZPnctnfFkJwcisfXd6/XZ1yyUFRPukb1
         6DTjpM2TQMhkBLOI6M123f1Z463oevihnwAwO3hyQaLDceSrptQTamVUqY2Bm3DpxhU4
         d7tNiPm+yjlrIpCvIEFgswleRiPFypMZZRaJs=
Received: by 10.151.112.10 with SMTP id p10mr16579713ybm.129.1215810271843;
        Fri, 11 Jul 2008 14:04:31 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 14:04:31 -0700 (PDT)
In-Reply-To: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88174>

[I sent this mail earlier, but I think vger rejected it due to the
size of the attachments, I have uploaded them instead now, they can be
found at:
http://alturin.googlepages.com/activity_per_author.txt
http://alturin.googlepages.com/full_activity.txt ]

Heya,

Today I sat down and finished the activity aggregation code. Now it is
possible to generate the attached files with the following commands:
$ stats.py author -e --id=an > activity_per_author.txt
$ stats.py author -a  > full_activity.txt

The first one calculates the activity of all developers on a per-file
basis and dumps it into the file. The "--id=an" switch sets the
grouping field to "%an" (see man git-log), since the default (%ae) is
not that helpful for git.git (I don't know people by their e-mail, I
know them by their name). This was already possible (with "author
-d"), but before one had to pick a specific developer, now it will
show for _all_ developers.This is interesting stuff, although for a
huge project like git it's a bit much to take in. What is probably
more interesting is the second command, it shows how much change a
file has had in it's existence.
I temporarily modified the code to output %04d instead of %4d so that
I could do the following:
$ stats.py author -a  > full_activity_sortable.txt

A few highlights from the sorted file:

$ cat full_activity_sortable.txt | sort | tail -n 20
0170:  2721+  1060- = refs.c
0172:  4369+  2004- = builtin-pack-objects.c
0177:   345+   233- = GIT-VERSION-GEN
0178:  2855+  2121- = commit.c
0178:  4779+  2227- = fast-import.c
0179:  2677+  1400- = read-cache.c
0185:  5661+  2056- = builtin-apply.c
0186:  3269+  1255- = revision.c
0213:  1884+   460- = Documentation/config.txt
0232:  2257+  1621- = Documentation/git.txt
0236:  3990+  1991- = contrib/fast-import/git-p4
0281:  2753+  2220- = git.c
0333: 10259+  7150- = git-gui.sh
0338: 11337+  6187- = git-svn.perl
0338:  5755+  3159- = sha1_file.c
0397: 10230+  9599- = diff.c
0412: 23248+ 20257- = gitk
0432: 10580+  4502- = gitweb/gitweb.perl
0490:  1412+   619- = cache.h
0977:  4703+  2705- = Makefile

$ cat Makefile | wc -l
1482

For some reason you people can't seem to make up your mind about a
file that's not even 1500 lines in size ;). With almost a thousand
edits so far, it's been edited so many times it could've been written
from scratch three times (except that the amount of lines deleted
doesn't match). Also interesting to note is that the "external" files
such as gitweb, gitk, git-gui and git-svn make up the bulk of all
changes. The two contenders from the native git camp are diff.c and
sha1_file.c which both have a lot of LOC. This information is
interesting for GitStats as it might help determine which files have
had a lot of change, and which files are not touched a lot.

A note is in order here, this data was mined with "git log --num-stat"
so things like moving files and copying files are not accounted for. I
thought about using git-blame to gather this info before, but it is
not the right tool for the job. If anyone else has any idea's on what
would be better please let me know and I'll happily dig into it :).

--
Cheers,

Sverre Rabbelier
