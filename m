From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 03 Aug 2006 11:21:11 -0700
Message-ID: <7vfygdr888.fsf@assigned-by-dhcp.cox.net>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org>
	<20060803153403.GA30729@buici.com> <eat5qp$3sr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 03 20:22:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8hot-0002zU-La
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 20:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWHCSVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHCSVN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 14:21:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11672 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964788AbWHCSVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 14:21:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803182112.CHPV18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 14:21:12 -0400
To: git@vger.kernel.org
In-Reply-To: <eat5qp$3sr$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	03 Aug 2006 17:48:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24741>

Jakub Narebski <jnareb@gmail.com> writes:

> Marc Singer wrote:
>
>> That isn't enough.  I did something like that when I was exploring the
>> script.  While the change *does* eliminate the 403 error, it doesn't
>> make the rest of the script work properly.  All of the links return to
>> the same page that lists the projects.
>
> Strange... PATH_INFO is used _only_ if 'p' parameter is not set. And all
> links use 'p=$project', not PATH_INFO...
>
> Are you sure you did changes mentioned in earlier post?

Well, more importantly, why would we do something like this in the first 
place?

Wouldn't it be a lot better to just rip out PATH_INFO stuff,
especially since all pages the script generates use ?p=$project 
to pass that information around and never uses PATH_INFO?
