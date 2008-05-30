From: Petr Baudis <pasky@suse.cz>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 17:07:13 +0200
Message-ID: <20080530150713.GG593@machine.or.cz>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 17:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26DA-0008GY-Gb
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYE3PHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYE3PHR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:07:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35754 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbYE3PHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:07:16 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B7FA31E4C035; Fri, 30 May 2008 17:07:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4840166C.3030903@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83306>

On Fri, May 30, 2008 at 04:59:56PM +0200, Lea Wiemann wrote:
> Jakub Narebski wrote:
>> IIRC the policy usually is that one can install packages
>> from main (base) repository for Linux distribution used on server,
>
> libcache-memcached-perl is in Debian stable; that's fair enough I think.  
> Cache::Memcached::Fast doesn't seem to be in Debian as of now, but I 
> wouldn't worry about performance unless it comes up.

Still, please make this optional. It is fine for gitweb not to do any
caching in the bare setup, but you should be able to get the simple
version running without any external dependencies.

>>>> By the way what do you think about adding (as an option) information
>>>> about gitweb performance to the [HTML] output,
>> I'd try to add it when I'd have a bot more of free time
>
> I'd probably wait with this until I've written the Perl Git API.

Hmm, it shouldn't depend on that in any way, should it?

use Time::HiRes qw(gettimeofday tv_interval);
my $t0 = [gettimeofday];
...
print "<p>This page took ".tv_interval($t0, [gettimeofday])."s to generate.</p>";

I wonder what oldest Perl versions do we aim to support? If <5.8, we
need to be more careful about Time::HiRes. It would be useful to
document this with a use perl statement at the top of the script.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
