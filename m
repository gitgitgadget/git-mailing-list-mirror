From: Max Pollard <ajaxsupremo@yahoo.com>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 13:40:14 -0800 (PST)
Message-ID: <743519.95328.qm@web45916.mail.sp1.yahoo.com>
References: <7vr6g0mip2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJyCK-0003n8-F3
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbYA2VkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYA2VkT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:40:19 -0500
Received: from n4d.bullet.mail.tp2.yahoo.com ([203.188.202.147]:48813 "HELO
	n4d.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751285AbYA2VkS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 16:40:18 -0500
Received: from [202.43.196.225] by n4.bullet.mail.tp2.yahoo.com with NNFMP; 29 Jan 2008 21:40:16 -0000
Received: from [217.12.4.214] by t2.bullet.tpe.yahoo.com with NNFMP; 29 Jan 2008 21:40:16 -0000
Received: from [216.252.122.216] by t1.bullet.ukl.yahoo.com with NNFMP; 29 Jan 2008 21:40:15 -0000
Received: from [69.147.65.172] by t1.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 21:40:15 -0000
Received: from [127.0.0.1] by omp507.mail.sp1.yahoo.com with NNFMP; 29 Jan 2008 21:40:15 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 261786.5939.bm@omp507.mail.sp1.yahoo.com
Received: (qmail 96299 invoked by uid 60001); 29 Jan 2008 21:40:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=31o+mjY4CQ8SSyaj+osAK3B0U5+ulSKkhUUBunoGlG4YaU5fY1pqw52/fo4JOOj+2KZd5AblTkD0b01cHk9FVYCLS5VTkwxQrQpqeY5+CbAA97cMiRTI/GUxUykn3XuaPWwrTBI8uwjCcntiLN0/5RaWS960kDpkH3ZegWaqDJA=;
X-YMail-OSG: I0s_wy4VM1nPJooKdkihsGcjwLRhZIb.64mAGUq_abaRtTPKYQDBpiu_HKYUVsj_G7QTwuSQDu5zdp3xpX74WFDM1A--
Received: from [66.122.195.143] by web45916.mail.sp1.yahoo.com via HTTP; Tue, 29 Jan 2008 13:40:14 PST
In-Reply-To: <7vr6g0mip2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72000>


--- Junio C Hamano wrote:

> Max Pollard writes:
> 
> > ...  So -C -C is the answer, with --name-status or --stat to
> > actually show the result.
> 
> The real "answer" part in that example is not -C -C.  Obviously,
> you would need double-C aka --find-copies-harder, because you
> did not change a.txt when creating b.txt, so it is still needed.
> 
> But the essential part of the answer is "not giving b.txt as the
> pathspec, so that whatever _other_ file that could have been
> copied into it is still visible when the command works".
> 
> If you say "git log --name-status -C -C -- b.txt", you would be
> back to square one.

Aha, point taken.  In this case, looks like I can do:

    $ git log -C -C --full-diff --name-status/--stat/--summary -- b.txt

as Sean has suggested to get the copy information back.  Or are you saying that
even with "--full-diff" I can lose copy information in some cases?


MP



      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
