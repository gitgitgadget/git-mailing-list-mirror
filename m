From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 12:51:08 +0530 (IST)
Message-ID: <577436.59080.qm@web95004.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8W3-0002Uv-Bg
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYIOH1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 03:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYIOH1v
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:27:51 -0400
Received: from n1a.bullet.mail.in2.yahoo.com ([203.104.19.38]:20365 "HELO
	n1a.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752104AbYIOH1u convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:27:50 -0400
Received: from [202.86.4.170] by n1.bullet.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 07:27:48 -0000
Received: from [203.104.18.50] by t1.bullet.in.yahoo.com with NNFMP; 15 Sep 2008 07:27:48 -0000
Received: from [127.0.0.1] by omp111.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 07:27:48 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 20110.19060.bm@omp111.mail.in2.yahoo.com
Received: (qmail 59229 invoked by uid 60001); 15 Sep 2008 07:21:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=blDWjqW2XSZdTayylpZH3GmvVGbnFqPyEWeAimvgPD2FdLr1frpMC79owBVJE0DU4zfHPZ31Z+OyIw89ia7Gm3umz18JDsuCqh66dDOHeZDvVk8E5FQKzPTbYvWLLIZmfWYdtXDjckMkwti25XR0L5otzUJdfosxnK3/2TS+GsY=;
X-YMail-OSG: ST1ASoAVM1mMWvqgOJDBo1JSom54Zh4GTH4C2GWK11MpKWENw2SBZ4u.jKitGREWp07PBBsHlhWgQxgmVeEkX2uWcW.qdI75XlATqTp_sXhiqr6kXvkh6XpOx_pC5Ag-
Received: from [202.3.112.9] by web95004.mail.in2.yahoo.com via HTTP; Mon, 15 Sep 2008 12:51:08 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95886>

Hello,



----- Original Message ----
> From: David Brown <git@davidb.org>
> To: dhruva <dhruva@ymail.com>
> Cc: GIT SCM <git@vger.kernel.org>; Junio C Hamano <gitster@pobox.com>; Simon Hausmann <simon@lst.de>
> Sent: Monday, 15 September, 2008 12:05:21 PM
> Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
> 
> On Mon, Sep 15, 2008 at 11:56:22AM +0530, dhruva wrote:
> 
> >8. The git diffs is now not aware of the change in RCS keyword
> >9. You try to submit your local changes back to p4
> >10. Applying your local changes as patch sets will fail with missing hunks 
> tracking RCS keyword changes
> 
> It sounds like you are trying to apply these as patches to a tree
> which doesn't have RCS headers.  As far as I can tell, P4 completely
> ignores whatever the $Id: ...$ headers happen to be expanded to at the
> time of checking.  You can put garbage there, and it check in fine.

I think I now understand this better. If git-p4 is always collapsing the RCS keywords, it should not see it even while it is applying a patch. What bugs me is I got repeated hunk failures during 'git-p4 submit'. It always pointed to RCS keyword. I see it trying 'git-p4' trying to apply the patch and it fails. In the .rej file, I see the expanded RCS keyword (even without my patch that makes it optional). I then started doubting if I had done a 'p4 sync -f' which will bring in files with RCS keywords expanded. If that was the case, git would have found changed files that I have not committed.

I am a bit lost here, I will try to use this for some more time and see if I see such issues (with and without my git-p4 changes).

Thanks for making me look deeper!

-dhruva



      Download prohibited? No problem. CHAT from any browser, without download. Go to http://in.webmessenger.yahoo.com/
