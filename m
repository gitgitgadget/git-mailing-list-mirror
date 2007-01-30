From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 12:29:10 -0600
Message-ID: <17855.36470.309129.391271@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<epo1tn$9sl$1@sea.gmane.org>
	<17855.35845.922009.364704@lisa.zopyra.com>
	<20070130182237.GC26415@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxjQ-00032o-Pb
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbXA3S3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbXA3S3V
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:29:21 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60198 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030196AbXA3S3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:29:21 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UITHH28669;
	Tue, 30 Jan 2007 12:29:17 -0600
In-Reply-To: <20070130182237.GC26415@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38183>

On Tuesday, January 30, 2007 at 13:22:37 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> Ok, well, I certainly did not issue git clone --bare, it was just a
>> plain ol' clone:
>> 
>> % git clone /repos/git/project
>> 
>> and no checkout ensued.  Can I fix this somehow?  I've tried the clone
>> several times with no success.  Is there anything I can check in the
>> source repo (the above /repos/git/project) to see why it would not be
>> working?
>
>I've seen this happen if HEAD in the source repository does not point
>at a branch, or points at a commit which doesn't exist.  Though I
>usually also see an error about how HEAD isn't a valid object name...

Hmm.

% cd /repos/git/project
% ls
branches  description  HEAD   info     refs
config    FETCH_HEAD   hooks  objects  remotes
% cat HEAD
ref: refs/heads/master
% cat FETCH_HEAD
2ed7b6f672963bab4bad713a71967f683fe01163                branch 'topic' of git://source/public/project
2ed7b6f672963bab4bad713a71967f683fe01163        not-for-merge   tag 'fbdev_ref_1' of git://source/public/project

This repository was created like this:

% mkdir /repos/git/project
% cd /repos/git/project
% git --bare init-db --shared
% GIT_DIR=. git fetch git://xiphi/public/project topic:topic


Bill
