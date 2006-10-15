From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Ideas for new "stats" view in gitweb
Date: Sun, 15 Oct 2006 17:17:18 +0200
Organization: At home
Message-ID: <egtjda$8qg$1@sea.gmane.org>
References: <egdge3$t12$1@sea.gmane.org> <egj1g6$bk6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 15 17:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ7k1-0000FV-SE
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 17:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWJOPRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Oct 2006 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWJOPRT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 11:17:19 -0400
Received: from main.gmane.org ([80.91.229.2]:5527 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750867AbWJOPRS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 11:17:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZ7jk-0000Dw-PW
	for git@vger.kernel.org; Sun, 15 Oct 2006 17:17:12 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 17:17:12 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 17:17:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28916>

Jakub Narebski wrote:

> Jakub Narebski wrote:
>=20
>> =A0* Graph of number of changed files in given branch; probably shou=
ld be
>> =A0 =A0cached.
>=20
> See for example StatCVS and FishEye
>   http://www-128.ibm.com/developerworks/java/library/j-statcvs/
>   http://statcvs.sourceforge.net/statcvs-stats/
>=20
>   http://fisheye.codehaus.org/browse/activecluster

See also StatCVS-XML (http://statcvs-xml.berlios.de) and SvnStat
(http://svnstat.sourceforge.net), both derivatives of StatCVS, with
a few plots/charts added. If you know other graphical SCM statistics
tools, please mention them.

Would additional "stats" view help? Does some bit of stats help (well,
besides diffstat in commitdiff; perhaps later graphical diffstat in
gitweb)?

=46or example all (I think) above projects include plot of "size" (usua=
lly in
lines of code) of repository versus time, sometimes split into few top
authors or few top subdirectories; sometimes limited to some subdirecto=
ry or
even to some file only, together with the plot of "commit volume" (usua=
lly
number of commits per unit, e.g. number of commits per day, but it coul=
d be
numbers of files changed and/or number of lines added/deleted) vs time.
Tags are marked on the time scale. This supposedly helps to realize if
project/part of project/individual file is in development, refactoring =
or
maintenace stage. And graph with different top authors plotted using
different lines visualises which were active during which point of proj=
ect
history. I'm not sure what "commit volume" plot tells us.

Next there are various tables and plots gathering statistics about auth=
ors:
lines of code + percentage, numbers of changes (commits) + percentage,
average number of lines per change, ratio of modifications to adding ne=
w
code. Git has git-shortlog for creating similar summary. That probably
helps to realize who takes what part in development of project. And the=
re
can be similar tables, charts and plots but with module/subdirectory/fi=
le
instead of author. For example top files with respect to size, changes,
or number of revisions in history.

Then there are IMVHO not very useful (except for satisfying idle curios=
ity)
histograms of activity (either number of commits, or number of changed
lines) per hour of day, or per day of week, or per month of year (in ol=
der
projects).


There are some other plots, charts, tables, graphs... Please do tell wh=
ich
ones would be good to have in gitweb.

BTW. we most certainly would have to use some cache I guess... and we h=
ave
just removed the need for temporary files for creating diffs...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
