From: Jamil Djadala <djadala@datamax.bg>
Subject: how to union 2 repos
Date: Mon, 26 May 2008 13:08:24 +0300
Organization: Datamax
Message-ID: <1211796504.20622.26.camel@bee.datamax.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 12:55:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0aM4-00012w-PX
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 12:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbYEZKyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 06:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbYEZKyL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 06:54:11 -0400
Received: from bee.datamax.bg ([82.103.104.54]:41990 "EHLO bee.datamax.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbYEZKyK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2008 06:54:10 -0400
X-Greylist: delayed 2743 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 May 2008 06:54:10 EDT
Received: from jambo by bee.datamax.bg with local (Exim 4.69)
	(envelope-from <djadala@datamax.bg>)
	id 1K0Zcu-0007zw-9I
	for git@vger.kernel.org; Mon, 26 May 2008 13:08:24 +0300
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82917>

Hi all

quote from core-tutorial:
######### begin quote
Note
You could do without using any branches at all, by keeping as many loca=
l
repositories as you would like to have branches, and merging between
them with git pull, just like you merge between branches. The advantage
of this approach is that it lets you keep a set of files for each branc=
h
checked out and you may find it easier to switch back and forth if you
juggle multiple lines of development simultaneously. Of course, you wil=
l
pay the price of more disk usage to hold multiple working trees, but
disk space is cheap these days.
########## end quote


I still can't realize how to  union 2 git repositories with linear
history, into 1 repo with 2 branches.
i try git-rebase, but results are unexpected.

i have 2 repos with history, assuming initial commit in both repos are
same:

1:
a-b-c-d-e-f
2:
a-B-C-D-E-F


i want repository with this history:

a-b-c-d-e-f
 \B-C-D-E-F


i try following:
1. copy objects from other repo :
git-fetch ../other/.git +master:otherMaster
history after this command is 2 unconnected chains:
a-b-c-d-e-f  a-B-C-D-E-F
2.Then i try following:
git-rebase --onto a f F

but results are strange
(git, complain about merge errors, history is like:

x-x-x-x-x-x-----------x
 \x-x-x    \x-x-x-x-x

)

=EF=BB=BFcan someone help me how to do this ?



Thanks in advance

--=20
Jamil Djadala <djadala@datamax.bg>
Datamax
