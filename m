From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Fri, 4 Feb 2011 09:54:02 +0100
Message-ID: <1jw5s11.1s3ezsbcgy9c0M%lists@haller-berlin.de>
References: <AANLkTimOLPVp0EdhTsrPcF7gtykh3o-yE7KimBSJwfY3@mail.gmail.com>
Cc: gitster@pobox.com (Junio C Hamano), git@vger.kernel.org
To: jaysoffian@gmail.com (Jay Soffian),
	Matthieu.Moy@grenoble-inp.fr (Matthieu Moy)
X-From: git-owner@vger.kernel.org Fri Feb 04 09:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlHQq-0003Po-Tv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 09:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1BDIyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 03:54:10 -0500
Received: from mail.ableton.net ([62.96.12.117]:32788 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1BDIyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=Y+DAMgBEwsP/dWpmR9qsjMkTyUtvLLWvuO5UF9tNXrA=;
	b=iFjTkXkPAglvhHiTb7xt6GiPcKlwUtoCmRURfdAjGdbqCSV56a69GmZkkCjEatw/LK6bbCKln2Yne6MU6o7oI8DYRzWpOgGI0O82/oxPSjAFSnbUMwkFP8cfGCacUu2kfLmQqW5rbNiCSu52qnvp0daw7mxbpelvl/B9NQBjEgk=;
Received: from [10.1.15.236]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PlHQY-0004M3-AK; Fri, 04 Feb 2011 09:54:02 +0100
In-Reply-To: <AANLkTimOLPVp0EdhTsrPcF7gtykh3o-yE7KimBSJwfY3@mail.gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.6 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166027>

Jay Soffian <jaysoffian@gmail.com> wrote:

> 1. Deprecate --track and --no-track (remove from documentation and
> usage). I wonder if anyone ever uses them?

I use --no-track quite frequently, and I always find it unfortunate that
I have to (sometimes I forget).  I need it when I want to create a new
local branch off of master, and my local master is not up to date, but
I'm too lazy to bring it up to date because I have some other branch
checked out currently; so I do

  $ git fetch
  $ git checkout -b new_branch origin/master

This will by default make origin/master the upstream branch of
new_branch, which is never what I want.

To avoid the problem, I would have to

  $ git checkout master
  $ git pull
  $ git checkout -b new_branch

I guess I would like a config setting of
branch.autosetupmerge=onlyifnamematches or some such.

I realize this is probably not related to the discussion of whether or
how --set-upstream should be fixed; I just wanted to comment on your
question.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
