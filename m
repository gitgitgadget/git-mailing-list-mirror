From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH] Implement unstage and reset modes for git-add--interactive
Date: Sat, 25 Jul 2009 06:58:22 +0900
Message-ID: <20090725065822.6117@nanako3.lavabit.com>
References: <200907231041.32567.trast@student.ethz.ch> <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch> <7vocrakpbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSnJ-0000nN-1x
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbZGXV7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbZGXV7E
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:59:04 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58427 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563AbZGXV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:59:03 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E6D7811B7ED;
	Fri, 24 Jul 2009 16:59:02 -0500 (CDT)
Received: from 8926.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id QUN5FYZBVNI2; Fri, 24 Jul 2009 16:59:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GxeTjzp0i8PwNPgQei6rVMvnDswgm0AO14CJr/qEAaKdAImA7eCcqKcBPcCq1qjEqLZd0xfw/HNPQgo1thQqNIOX1yIyIoq0DTHzvWNS1JT9nRqtgHFbLcyP2s6EFeFgtNWxO++nUAN53M2hjAHYiMJbaJ5lF2UICggoOjGqkC4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vocrakpbo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123952>

Quoting Junio C Hamano <gitster@pobox.com>

> "resetting index entries selectively" makes perfect sense.  So do
> "checking out index entries selectively" and "adding to index
> selectively".

Are you saying that you are fine with the concept of Thomas'es patch series but you don't want to see different words used to name these operations?

In other words, do you mean the following would be a pair of better companions to "git add -p $file" than Thomas'es discard and unstage?

 - "git checkout -p $file" and "git checkout -p $commit $file" that let you view the patch to bring the file in the working tree to the version in the index (or the commit) and selectively apply that to the working tree and the index, to implement "discarding changes selectively".

 - "git reset -p $file" and "git reset -p $commit $file" that let you view the patch to bring the version of the file in the index to the version in the HEAD (or the commit) and selectively apply that to the index, to implement "undoing changes made to the index selectively".

I think it preserves the UI consistency better to enhance checkout and reset than adding new commands to do conceptually the same thing. Unfortunately I don't know how hard the necessary change will be, because these two commands are now implemented in C...

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
