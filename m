From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/safe and kha/experimental updated
Date: Wed, 19 Mar 2008 02:38:32 +0100
Message-ID: <20080319013832.GB28781@diana.vm.bytemark.co.uk>
References: <20080319012804.GA28781@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	Angus Salkeld <ahsalkeld@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5pw-0005me-6B
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966212AbYCSVXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966202AbYCSVXM
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:23:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3458 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966194AbYCSVXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:23:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jc5cS-00043k-00
	for <git@vger.kernel.org>; Wed, 19 Mar 2008 21:14:44 +0000
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JbnGC-0007Wp-00; Wed, 19 Mar 2008 01:38:32 +0000
Content-Disposition: inline
In-Reply-To: <20080319012804.GA28781@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.94.4
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	diana.vm.bytemark.co.uk
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED 
	autolearn=disabled version=3.0.3
X-Already-Filtered-By: kha@treskal.com, 2008-03-19 01:38:37 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77557>

On 2008-03-19 02:28:04 +0100, Karl Hasselstr=F6m wrote:

> plus a new and shiny "stg reset" prototype!

It works like this:

  1. Every StGit command that modifies anything writes the new state
     to a log. The log is a git branch called <branchname>.stgit.

  2. When you've done something you regret, find the state in the log
     you want to return to and just say (for example)

       $ stg reset master.stgit~3

     Resetting is recorded in the log just like everything else, so to
     undo a reset you just did, simply say

       $ stg reset master.stgit^

There are lots of things that have to be ironed out before it's done,
especially the UI, but it's ready for folks to play with and comment
on.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
