From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Sun, 23 Nov 2008 08:10:59 +0100
Message-ID: <49290203.7060808@op5.se>
References: <cover.1226759762.git.marcel@oak.homeunix.org>	<1227389614-10946-1-git-send-email-marcel@oak.homeunix.org> <m31vx3l94x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 08:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L499J-0001e0-Ft
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbYKWHLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 02:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYKWHLZ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 02:11:25 -0500
Received: from mail.op5.se ([193.201.96.20]:38101 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYKWHLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 02:11:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C7BE11B80052;
	Sun, 23 Nov 2008 08:06:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5nosooJJ6ay; Sun, 23 Nov 2008 08:06:17 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id DFF751B8004E;
	Sun, 23 Nov 2008 08:06:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <m31vx3l94x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101566>

Jakub Narebski wrote:
> "Marcel M. Cary" <marcel@oak.homeunix.org> writes:
> 
>> * Change "git rev-parse --show-cdup" to print a full path instead of
>>   a series of "../" when it prints anything
> 
> But that is contrary to the _name_ of option. It is --show-cdup, as
> in "show cd up". And I think your change will break a few scripts.
> 
> I think you should use "git rev-parse --work-tree" for full path
> to working directory:
> 
>     --show-cdup
>         When the command is invoked from a subdirectory, show the path
>         of the top-level directory relative to the current directory
>         (typically a sequence of "../", or an empty string).
> 

AFAIR, it was introduced to make test-builds of really large projects in
really deep directories with a ton of symlinks leading to the path work a
lot faster.

The thing to remember about git and its UI is that it was evolved from
users' actual needs. Very, very little of what is in the UI can be reworked
without breaking something for someone, so it's (almost) always better to
add a new option. For this, I'd suggest "--show-absolute-worktree-path" if
that's what it does. Since it's an option primarily targeting scripts, I'm
not too worried that it's half a mile long.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
