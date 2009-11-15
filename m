From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: PEBKAC or bug: unable to create path-like branch names
Date: Sat, 14 Nov 2009 21:02:27 -0800
Message-ID: <20091115050227.GD5934@penguin.codegnome.org>
References: <20091115020605.GE15966@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 06:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9XhX-0001hk-F5
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 06:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZKOF03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 00:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZKOF03
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 00:26:29 -0500
Received: from que11.charter.net ([209.225.8.21]:44287 "EHLO que11.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbZKOF02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 00:26:28 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2009 00:26:28 EST
Received: from imp11 ([10.20.200.11]) by mta31.charter.net
          (InterMail vM.7.09.02.04 201-2219-117-106-20090629) with ESMTP
          id <20091115050233.GSID1847.mta31.charter.net@imp11>
          for <git@vger.kernel.org>; Sun, 15 Nov 2009 00:02:33 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
	by imp11 with smtp.charter.net
	id 5H2W1d00k1x8DgP05H2Xzt; Sun, 15 Nov 2009 00:02:33 -0500
X-Authority-Analysis: v=1.0 c=1 a=Fqhl-99eDMQA:10 a=XAp8FidPmn3MsDcnCpoA:9
 a=7Plf3_CqZ4y6zw8U5lYA:7 a=IbcJrlwZQ-VjB1f33FSWqmD-rKMA:4
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id E076237CBC; Sat, 14 Nov 2009 21:02:28 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Sat, 14 Nov 2009 21:02:28 -0800
Content-Disposition: inline
In-Reply-To: <20091115020605.GE15966@cl.cam.ac.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132909>

I want to create a nested feature branch, but git keeps complaining if I
nest more than one level deep:

    $ git checkout -b dev/feature/foo
    error: unable to resolve reference refs/heads/dev/feature/foo:
    Not a directory
    fatal: Failed to lock ref for update: Not a directory

Based on my reading of the manual pages, it seems like I should be able
to nest branch names as long as it conforms to certain rules. I read
git-branch(1), which points me to git-check-ref-format(1), which seems
to say that the rules are being followed.

On the other hand, running:

    $ git check-ref-format foo; echo $?

always results in a non-zero error code, even with a literal 'foo' as a
branch name, so clearly it isn't saying what I think it's saying.
*shrug*

Can someone provide a little clarity here?

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
