From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 17:16:28 +0530 (IST)
Message-ID: <263224.61965.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: David Brown <git@davidb.org>, GIT SCM <git@vger.kernel.org>,
	Simon Hausmann <simon@lst.de>
To: Tor Arvid Lund <torarvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 13:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfCYP-0000Xg-9h
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 13:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbYIOLqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 07:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbYIOLqb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 07:46:31 -0400
Received: from n2a.bullet.mail.in2.yahoo.com ([203.104.19.40]:41295 "HELO
	n2a.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752870AbYIOLqb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 07:46:31 -0400
Received: from [202.86.4.170] by n2.bullet.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 11:46:28 -0000
Received: from [203.104.18.50] by t1.bullet.in.yahoo.com with NNFMP; 15 Sep 2008 11:46:28 -0000
Received: from [127.0.0.1] by omp111.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 11:46:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 381048.12888.bm@omp111.mail.in2.yahoo.com
Received: (qmail 9306 invoked by uid 60001); 15 Sep 2008 11:46:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=m6fCLxWenzg8FKraS5N4RW7ffDFlF6yIUnkYqYrZ2RXIcJdPdHsb04hHwB5StSrDGTQq91bTLdIDc8KEaQOR9NrIQ6eC0t22t8Mq4WpTbyUvRTjBKI2gQ/KnvdgXXDn0VBgHIjYDbgKewt93+EQzu0PQPG7TOHzelJcTqyUMGx8=;
X-YMail-OSG: PHQD_OUVM1nlTyiPZ9lAety3_iMO6fckep14O4vWHBXacx4l4UYZrD3ykkNwL5iEimHMjyE_vf09exDL2dy24m5XsYwvp8Q1wHfcccNnbACr3ywWmmzwyUf7Ho15jkY-
Received: from [202.3.112.9] by web95002.mail.in2.yahoo.com via HTTP; Mon, 15 Sep 2008 17:16:28 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95899>

Hi,
 I am going to use the patched version for sometime to see if the problem (RCS hunk) arises again. From a pure SCM interconnect perspective, it might still be good to have keyword expansion as an option. With this being an option, the data in git and p4 are same.



----- Original Message ----
> From: Tor Arvid Lund <torarvid@gmail.com>
> To: Junio C Hamano <gitster@pobox.com>
> Cc: David Brown <git@davidb.org>; dhruva <dhruva@ymail.com>; GIT SCM <git@vger.kernel.org>; Simon Hausmann <simon@lst.de>
> Sent: Monday, 15 September, 2008 4:32:32 PM
> Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
> 
> On Mon, Sep 15, 2008 at 9:43 AM, Junio C Hamano wrote:
> > David Brown writes:
> >
> >> ...  As far as I can tell, P4 completely
> >> ignores whatever the $Id: ...$ headers happen to be expanded to at the
> >> time of checking.  You can put garbage there, and it check in fine.
> >> ...
> >> I guess it isn't a problem to make this optional in git-p4, but I
> >> don't think this patch is solving the right problem.
> >
> > Hmm.  I do not do p4, but what I am guessing is that there probably is a
> > configuration switch on the p4 side that lets you check in files with
> > "$Id: garbage $" in them, while dhruva hasn't turned that switch on.
> 
> Hmm.. I thought this was not a p4 problem. I think however, that
> "git-p4 submit" tries to do git format-patch and then git apply that
> patch to the p4 directory. In other words, I believe that git apply
> fails since the file in the p4 dir has the keywords expanded, while
> the patch does not. I haven't done any careful investigation, but If
> my assumption is true, it sounds like dhruvas patch should work...

Your assumption is true (from my understanding of the code). My doubt is, even the files in p4 folder will be from git with no RCS keyword expanded. The patch application must ideally be clean! I am confused here.

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
