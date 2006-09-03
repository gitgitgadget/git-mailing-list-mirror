From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bogofilter is my emails
Date: Sun, 3 Sep 2006 16:09:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609031550330.27779@g5.osdl.org>
References: <20060903040222.GB29756@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 01:09:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK162-0005nI-Gl
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 01:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWICXJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWICXJn
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 19:09:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932101AbWICXJm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 19:09:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k83N9dnW022450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 3 Sep 2006 16:09:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k83N9c5D001291;
	Sun, 3 Sep 2006 16:09:38 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060903040222.GB29756@spearce.org>
X-Spam-Status: No, hits=-0.485 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26393>



On Sun, 3 Sep 2006, Shawn Pearce wrote:
> 
> I'm not quite sure how to fix either message to get them to the list.
> Neither email was a patch so I'm not going to try resending them
> but I'm certainly a little curious as to how my email writing style
> twice tripped bogofilter's spam switch.

I'm surprised and disgusted that vger started using bogofilter.

Last I saw, the bogofilter approach was totally bogus, using purely 
single-word frequencies (or, more strictly, a "does word X exist or not", 
where X has often gone through what a linguist would probably call a 
"lemmatizer", ie something that turns different forms of the same word 
into its canonical word, aka "lemma") for its "bayesian" filtering.

Maybe they've enhanced it enough since, but it certainly used to be not 
only fairly easy to fool, since it at least originally didn't take any 
account at all of any more complex structure. 

There's even some papers about how the bayesian thing does not work well 
(even when extended to do some phrases and with lemmatization) if the 
cut-off is hard.

I think the bogofilter is probably an acceptable input as _one_ of many 
rules for a real spam-filter (ie as one of many spamassassin rules), but 
not for what vger does.

Hard rules at mail acceptance are much better if they use some really hard 
datum. For example, checking that the sending site actually also receives 
email, and that it resolves back to itself. That's one thing that OSDL 
does, for example, and it means that you can only send me email if your 
machine is actually designated as a MX gateway. That cuts down on a _lot_ 
of spam.

(I'd love to speak of the details, but I wouldn't know. Kees Cook set it 
all up at osdl, and I can just say that it works beautifully.)

		Linus

-- 
VGER BF report: U 0.720981
