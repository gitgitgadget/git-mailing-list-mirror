From: Miles Bader <miles@gnu.org>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 18:56:49 +0900
Message-ID: <87fx2li36m.fsf@catnip.gol.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<m3633hdw9u.fsf_-_@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 11:57:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5c6p-0000G7-EF
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 11:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab0DXJ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 05:56:57 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:57583 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0DXJ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 05:56:56 -0400
Received: from 218.231.253.147.eo.eaccess.ne.jp ([218.231.253.147] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1O5c6U-0006gv-Dh; Sat, 24 Apr 2010 18:56:50 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id D64C7DF93; Sat, 24 Apr 2010 18:56:49 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <m3633hdw9u.fsf_-_@localhost.localdomain> (Jakub Narebski's
	message of "Sat, 24 Apr 2010 02:40:39 -0700 (PDT)")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145663>

Jakub Narebski <jnareb@gmail.com> writes:
> I'd like for 'git commit -a' to *fail* if there are staged changes for
> tracked files, excluding added, removed and renamed files.  If you
> have some staged changes you would get an error message:
>
>   $ git add tracked-file
>   $ git commit -a
>   fatal: There are staged changes to tracked files
>   hint: To commit staged changes, use 'git commit'
>   hint: To commit all changes, use 'git commit -f -a' 

That's bad because of the dual nature of "git add" -- someone may
normally use "-a" most of the time to commit changes, but has really no
choice other than git add to add a new file, So with this change, their
normal (and reasonable) habits would suddenly result in failure.

I think it's sort of annoying that "git add" has such a dual meaning
(instead of, for instance, having separate "add" and "stage" commands)
-- it's one of the more confusing things about learning about git
-- but oh well, it's unlikely to get changed at this point....

-Miles

-- 
Defenceless, adj. Unable to attack.
