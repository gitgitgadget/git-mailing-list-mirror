From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Possible diff regression in v1.7.6-473-g27af01d
Date: Mon, 24 Oct 2011 11:38:51 +0200
Message-ID: <201110241138.51448.trast@student.ethz.ch>
References: <1319448227.70497.YahooMailNeo@web29402.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"marat@slonopotamus.org" <marat@slonopotamus.org>,
	"rctay89@gmail.com" <rctay89@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Franz Schrober <franzschrober@yahoo.de>
X-From: git-owner@vger.kernel.org Mon Oct 24 11:39:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIGzm-0000Xj-1x
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 11:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab1JXJiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 05:38:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2780 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526Ab1JXJix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 05:38:53 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 24 Oct
 2011 11:38:49 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 24 Oct
 2011 11:38:51 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1319448227.70497.YahooMailNeo@web29402.mail.ird.yahoo.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184169>

Franz Schrober wrote:
> Hi,
> 
> I am using git to manage some patches on top of the actual upstream files, but noticed that the result of git-format-patch changed between 4bfe7cb6668c43c1136304bbb17eea1b3ddf0237 and 27af01d552331eacf1ed2671b2b4b6ad4c268106
> 
> I've attached two input files (I tried to provide a minimal example... I am not sure if a smaller example is possible but at least both files are smaller than 10 lines) and the results with version 1.7.6.3 and and 1.7.7. The diffs were created using: git diff anonymized_orig anonymized_new
> 
> My .gitconfig file is empty.

I'm not sure why you call this a regression.  For the benefit of
people who hate saving attachments, you used

  $ paste anonymized_orig anonymized_new  | xclip
  0       1
  0       2
  0       0
  0       3
          4
          5
          6
          7

the old diff was

  --- a/anonymized_orig
  +++ b/anonymized_new
  @@ -1,4 +1,8 @@
  -0
  -0
  -0
  -0
  +1
  +2
  +0
  +3
  +4
  +5
  +6
  +7

and the new diff is

  --- a/anonymized_orig
  +++ b/anonymized_new
  @@ -1,4 +1,8 @@
  +1
  +2
   0
  -0
  -0
  -0
  +3
  +4
  +5
  +6
  +7
 
So the new diff correctly represents the change, and on top of that is
shorter (by only one line, admittedly).  What makes it a regression?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
