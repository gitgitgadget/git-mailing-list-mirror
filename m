From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 4/4] Documentation: spell 'git cmd' without dash throughout
Date: Sun, 10 Jan 2010 13:21:21 +0100
Message-ID: <201001101321.23728.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch> <9516c897017ec420403bb7f687fb8962de42cb7c.1263081032.git.trast@student.ethz.ch> <20100110025641.GB1083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwnW-0001Tr-Gv
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab0AJMVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552Ab0AJMVa
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:21:30 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:26731 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab0AJMV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:21:29 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:21:28 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:21:23 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100110025641.GB1083@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136574>

Jonathan Nieder wrote:
> >  110 files changed, 584 insertions(+), 584 deletions(-)
> 
> But yikes!  Did you do this by hand or by some automated process?

The (now-refined) bottom line is

  perl -i -pe "s{'git-((?"'!'"cvsserver|upload-pack|receive-pack|shell|upload-archive)[a-z-]+)}{'git \$1}g" Documentation/*.txt
  git checkout -- Documentation/RelNotes*
  git add -p

I really stepped through all of them with 'git add -p', but my eyes
probably got tired rather quickly.

> A 'git-apply' snuck in. ;-)

Indeed, and (as you can see in the update I sent a few minutes ago) I
missed a lot more, because I originally had a regex that only scanned
for 'git-cmd' and 'git-split-cmd', missing the 'git-three-word-cmd'
and 'git-cmd --with-option' forms.  Thanks for pointing that out.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
