From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 10:16:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211013270.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Junker <mjscod@web.de>, Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jan 21 19:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1D0-0007Y5-51
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbYAUSQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYAUSQv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:16:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38614 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbYAUSQu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 13:16:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIGBQN016037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 10:16:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIGA2o013321;
	Mon, 21 Jan 2008 10:16:10 -0800
In-Reply-To: <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71302>



On Mon, 21 Jan 2008, Peter Karlsson wrote:
> 
> It is relevant because the Mac OS file system stores file names as a
> sequence of Unicode code points, in a (apparently slightly modified)
> normalized form, whereas Git prefers to see file systems that store
> file names as a sequence of octets, which may, or may not, actually map
> to something that the user would call characters.

No. The *only* issue is that git doesn't normalize.

You can think of git as a UTF-8 namespace all you want, and it will work 
together wonderfully with OS X. 

Git just doesn't force-normalize the names.

> You apparently prefer the text-as-sequence-of-octets, which I tend to
> dislike because I would have thought computer engineers would have
> evolved beyond this when we left the 1900s.

Some of us just know what we're doing, and have been working with UTF-8 
for a long time. It's not about sequence-of-octets, it's about not 
corrupting the data.

You think data should be changed behind peoples backs, potentially causing 
corruption due to unintended conversions. And I don't.

You can call me "left behind in the 1900s", but that's apparently because 
you don't understand the issues. Data corruption wasn't something that 
magically became ok just because we switched into a new century.

			Linus
