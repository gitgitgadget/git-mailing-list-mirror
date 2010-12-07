From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git reset and ctime
Date: Tue, 07 Dec 2010 10:14:12 -0500
Message-ID: <1291734852.3162.12.camel@drew-northup.unet.maine.edu>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
	 <20101204005131.GB15906@burratino>
	 <1291657037.30271.17.camel@drew-northup.unet.maine.edu>
	 <20101206175102.GC6272@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ghazel@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 16:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPzH7-0002dH-F2
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 16:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab0LGPQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 10:16:12 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:52780 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0LGPQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 10:16:11 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB7FEGCU010418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Dec 2010 10:14:16 -0500
In-Reply-To: <20101206175102.GC6272@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB7FEGCU010418
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1292339659.33033@KvD7+WCl6oyRWCFJBRt7SA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163078>


On Mon, 2010-12-06 at 11:51 -0600, Jonathan Nieder wrote:
> Drew Northup wrote:
> > On Fri, 2010-12-03 at 18:51 -0600, Jonathan Nieder wrote:
> 
> >> Interesting.  Setting "[core] trustctime = false" in the repository
> >> configuration could be a good solution (no performance downside I can
> >> think of).
> >
> > It is worth noting that many file-based backup systems which do "online"
> > backups (such as in use where I work) restore the atime by default at
> > the expense of the ctime (logic being that the atime may have had value
> > and the ctime changes either way--which may or may not be true) on unix
> > style filesystems.
> 
> So have you tried putting "[core] trustctime = false" in /etc/gitconfig?
> This is exactly what the setting is for, after all.

I hadn't yet, but it works like a charm.

> Ideas for making this easier to find (FAQ on the git wiki?  advice from
> porcelain when ctime-only changes happen?) would be welcome, of course.

I'll have a look over that way a bit later. 

I'm also going to have to have a look at the src.rpm for this particular
packaging of git and find out why it didn't create a
skeleton /etc/gitconfig (without much in it) in the postinstall script.
(I'm using the Dag Wieers / rpmforge one on my desktop.) It makes a lot
more sense to send along a patch then randomly demand that he change
it--he may have had a decent reason for not doing so.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
