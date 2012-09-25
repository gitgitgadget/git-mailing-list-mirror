From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: A generalization of git blame
Date: Tue, 25 Sep 2012 23:19:54 +0100
Organization: OPDS
Message-ID: <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <xmeng@cs.wisc.edu>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:19:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGdTv-0003KT-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 00:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab2IYWTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 18:19:46 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:46905 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888Ab2IYWTp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 18:19:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqwNAH8tYlBZ8rU+/2dsb2JhbABFDos8sg0BAQKBDIEJghsFAQEEAQgBAS4eAQEVEQYCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBAwiHYwqofJBei1ciKih4gzlgA4gihUaYJoIsPA
X-IronPort-AV: E=Sophos;i="4.80,486,1344207600"; 
   d="scan'208";a="551686064"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip06ir2.opaltelecom.net with SMTP; 25 Sep 2012 23:19:43 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206379>

From: <xmeng@cs.wisc.edu>
> I have been developing my git tool (based on the git internal API) 
> that
> can find out all the commits that have changed a line for better
> authorship.
>
> The reason is for my binary code authorship research, I use machine
> learning to classify code authorship. To produce training data, I 
> start
> with a source code repository with well-known author labels for each 
> line
> and then compiling the project into binary. So, I am able to know the
> authorship for binary code and then apply some machine learning
> techniques.
>
> To get ground truth of authorship for each line, I start with 
> git-blame.
> But later I find this is not sufficient because the last commit may 
> only
> add comments or may only change a small part of the line, so that I
> shouldn't attribute the line of code to the last author.

I would suggest there is:
- White space adjustment
- Comment or documentation (assumes you can parse the 'code' to decide 
that it isn't executable code)
- word changes within expressions
- complete replacement of line (whole statement?)

Custom & practice is the likely decider.

>                              Of course, there
> must be some debates on who can be the representative of a line of 
> code.
> So what I would like to do is find out all the commits that have ever
> changed a line, then I can try different approaches to summarize over 
> all
> these commits to produce my final authorship label (or even tuple).
>
> I was wondering whether there have been similar debates over accurate
> authorship in this community before and whether there may be other 
> people
> interested in this work.

I'd suggest looking at the various 'diff' formats, such as character 
diff, word diff, and line diff for discussions.

>
> Thanks
>
> --Xiaozhu
>
Philip 
