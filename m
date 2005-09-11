From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sun, 11 Sep 2005 00:58:05 -0700 (PDT)
Message-ID: <20050911075805.3984.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 09:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEMjM-0001uz-IZ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 09:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVIKH60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 03:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVIKH60
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 03:58:26 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:4718 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964820AbVIKH6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 03:58:25 -0400
Received: (qmail 3986 invoked by uid 60001); 11 Sep 2005 07:58:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zB3FBiXEo7ImP5s48SGTk+fJdFIyK1LvBJv9WEIRj4IVJJb7ht8KzBMkzVKinW49Hv5m8VRP41wVIQv4xGopoFhDTGjhIkpN1OEdWFca5RD+O6LQJLaMP1O59qMkwOS8QcMvvJEaIcVGW1UzqeU8EKeW0Y5mUfJrISWcVDm5jag=  ;
Received: from [151.42.200.67] by web26306.mail.ukl.yahoo.com via HTTP; Sun, 11 Sep 2005 00:58:05 PDT
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8272>

Sven Verdoolaege wrote:

>
>ReachList doesn't seem to be defined anywhere.
>

It is defined in annotate.h as a typedef:

class ReachInfo {
public:
	ReachInfo() {};
	ReachInfo(SCRef s, int i, int t) : sha(s), id(i), type(t) {};
	~ReachInfo() {};
	QString sha;
	int id, type;
	QStringList roots;
};
typedef QValueVector<ReachInfo> ReachList;


then used in annotate.cpp:

 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/
#include <qapplication.h>
#include "git.h"
#include "annotate.h"

.....

void Annotate::run(SCRef file, SList shaHist, AnnotateHistory& ah) {

	QString d, diffTarget;
	QStringList tmp;
	int pos, removed = 0, annID = 0;
	ReachList rl;
....

Please, what compiler version and qt dev libraries do you have?

But in any case it is very strange..... really I have no idea now.....I have to think
about it....


Marco


P.S: Due to a subtle but nasty bug that I found too late I have upgraded the release to
qgit-0.94.1 I strongly suggest to upgrade.

I am very sorry for this. 



	
		
______________________________________________________ 
Yahoo! for Good 
Watch the Hurricane Katrina Shelter From The Storm concert 
http://advision.webevents.yahoo.com/shelter 
