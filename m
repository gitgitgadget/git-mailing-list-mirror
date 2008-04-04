From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Thu, 3 Apr 2008 20:49:54 -0400
Message-ID: <p06240804c41b28150d6a@[63.138.152.125]>
References: <p06240804c41942f6276e@[192.168.1.114]>
 <200804030905.46425.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 02:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jha9F-00042Z-DQ
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 02:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbYDDAud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbYDDAud
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 20:50:33 -0400
Received: from deanbrook.org ([66.160.189.173]:56597 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755227AbYDDAuc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 20:50:32 -0400
Received: from 72.173.30.166 ([72.173.30.166]) by deanbrook.org for <git@vger.kernel.org>; Thu, 3 Apr 2008 17:50:25 -0700
In-Reply-To: <200804030905.46425.tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78789>

At 9:05 AM +0300 4/3/08, Teemu Likonen wrote:
>Stephen Bannasch kirjoitti:
>
>> I've just created a git-svn clone from a svn repo accessed locally
>> with a file:/// path.
>>
>> Unfortunately the local svn repo is just a copy of the main svn repo
>> normally accessed with http or https (served through Apache). I was
>> having problems cloning the main svn repository (more details below)
>> so I archived the remote svn repository and copied it to my local
> > hard drive.
>
>2. Convert your repo again:
>
>$ mkdir repo ; cd repo
>$ git svn init --rewrite-root=3Dhttp://... file:///...
>$ git svn fetch
>
>This way you'll create new Git repo from file:///... url but commit
>messages will have git-svn-id's url pointing at http://... . After tha=
t
>set the correct remote url to .git/config:
>
>[svn-remote "svn"]
>	url =3D http://...

Thanks Teemu,

That took a while but worked.

I also removed the rewriteRoot line from config after editing the url.

I think I might have achieved the same effect more quickly with Bj=F6rn=
's suggestion to use:

  git-filter-branch --msg-filter

to:

> >Use filter-branch to change all git-svn-id lines in the log entries.

But it wasn't clear to me how to change the git-svn-id lines.
