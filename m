From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Fri, 09 Jun 2006 20:49:51 -0700
Message-ID: <7v8xo5lleo.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
	<7virnam435.fsf@assigned-by-dhcp.cox.net>
	<7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606091743410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 05:50:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FouU3-000074-65
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 05:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFJDtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 23:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFJDtx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 23:49:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2228 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932328AbWFJDtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 23:49:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610034952.NDBR6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 23:49:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091743410.5498@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 9 Jun 2006 17:46:04 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21591>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 9 Jun 2006, Junio C Hamano wrote:
>>
>> This lets you say:
>> 
>> 	[core]
>> 		sharedrepository = 075
>
> I really think it's better to express this as some more traditional 
> number.
>
> I had to think about what 075 meant, while saying
>
> 	[core]
> 		sharedrepository = 0644
>
> just makes sense more or less automatically (and yes, for directories, the 
> read bit should obviously be expanded as an execute bit).

Or probably use the umask notation, 007 for traditional shared
repositories and 002 for gitweb exported ones.  With your
notation, people would start wondering what the distinction
between 0755, 0644, and even 0254 is (there isn't any).

Having said that, I do not think the distinction is that
important; I would rather make the core.sharedrepository = true
to mean an equivalent of "chmod go+rX" (it does "chmod g+rX"
currently).
