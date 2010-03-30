From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: mirror git repos: rsync vs. --mirror
Date: Tue, 30 Mar 2010 23:00:44 +0100
Message-ID: <3a75d1efc7cf125d84b8e02b7dabf7aa@212.159.54.234>
References: <robbat2-20100330T205331-531407911Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwjUS-00024M-Fl
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0C3WAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:00:47 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:47276 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035Ab0C3WAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 18:00:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 1ED46819C5B5;
	Tue, 30 Mar 2010 23:00:42 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 1287B20C6C7;
	Tue, 30 Mar 2010 23:00:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id I7SF1fZcqa68; Tue, 30 Mar 2010 23:00:44 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 79F2C20C65C;
	Tue, 30 Mar 2010 23:00:44 +0100 (BST)
In-Reply-To: <robbat2-20100330T205331-531407911Z@orbis-terrarum.net>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143608>

On Tue, 30 Mar 2010 20:54:09 +0000, "Robin H. Johnson"
<robbat2@gentoo.org>
wrote:
> I'm trying to see about the state of automated mirroring git
> repositories between different systems, eg. a private backend and a
> public frontend, and ran into a catch between two possible options, each
> with a downside. If there are other means besides these, I'm all ears
> for them.

You can mitigate the git caveats somewhat ...

> git clone --mirror && git fetch:
> --------------------------------
> How:
> - Setup with: "git clone --mirror URL"
> - Cronjob with: "git fetch"
> Benefits:
> - Extremely fast
> - Light on traffic
> Caveats:
> - Branches and tags deleted in master persist in slaves :-(
> - Seperate gc/repack needed on slaves.
> 
> The traffic vs. deleted branches/tags is the main tradeoff here, esp. as
> repos get larger.
> 
> Can git-fetch perhaps be made to delete the branches/tags?

I don't think that fetch can do it, but "git remote prune origin" will.
You could also add "git gc --auto" to your cron script to deal with the
repacking - I don't think fetch already does that ...

-- 
Julian
