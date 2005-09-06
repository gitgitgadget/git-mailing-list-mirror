From: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Tue, 06 Sep 2005 13:42:24 -0700
Message-ID: <431DFF30.7010009@linuxmachines.com>
References: <430A84D1.2050206@linuxmachines.com> <7v1x4lz118.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 22:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECkEL-0004PD-HB
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 22:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVIFUjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 16:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVIFUjm
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 16:39:42 -0400
Received: from [64.71.148.162] ([64.71.148.162]:48277 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750896AbVIFUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 16:39:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id 9BBBC6EFCC;
	Tue,  6 Sep 2005 13:42:24 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 24595-02; Tue, 6 Sep 2005 13:42:24 -0700 (PDT)
Received: from [192.168.36.10] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id D25476EFCB;
	Tue,  6 Sep 2005 13:42:23 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x4lz118.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8145>

On 08/22/2005 10:15 PM, Junio C Hamano wrote:
> Jeff Carr <jcarr@linuxmachines.com> writes:
> 
> 
>>Something simple like the perl script at the bottom would be useful for
>>showing files that haven't been added via git-update-cache --add already.
> 
> 
> If I am not mistaken, you just reinvented:
> 
>     $ git ls-files --others
> 
> in a very expensive way.  Notice your `find . -type f` that does
> not prune .git directory upfront.
> 
> Also you may want to take a look at:
> 
>     $ git ls-files --others --exclude-from=.git/info/exclude

Yes, you are right -- I did reinvent the above poorly :)

I also was using a perl script to parse the output of git-whatchanged to
set the datestamps on the files to the last modified time. If I remember
correctly, there was some threads at the beginning of git about how
datestamps were not accurate so there was no point in setting them(?) Or
maybe I mis-understood. In any case, sometimes it is useful for me
because I just want to look at what files I changed today or yesterday
or something to that effect. Sometimes in the kernel/Documentation
directories it is useful because you can see what documentation was
done/changed this year. Sometimes that's nice if you are looking for new
things you might not know much about; recently I was digging around in
the I2C stuff to try to figure out if I could read the right temperature
sensor on the smbus on a machine. Anyway, I'll just use that but perhaps
there is also a "correct" way to keep timestamps?

BTW, for what it's worth, you can't package git under debian sarge
because asciidoc doesn't support "-b xhtml11". I pulled it from sid and
it packaged it fine. Just an FYI. I emailed the asciidoc maintainer for
what it's worth.

Thanks a lot,
Jeff
