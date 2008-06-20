From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: git svn --add-author-from implies --use-log-author
Date: Fri, 20 Jun 2008 14:31:32 +0100
Message-ID: <485BB134.9080203@mircea.bardac.net>
References: <20080620113147.GC27940@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Skolmli <fredrik@frsk.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 15:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gl2-0007Kr-D1
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYFTNdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbYFTNdc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:33:32 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:57236 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbYFTNdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:33:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so286763and.103
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 06:33:30 -0700 (PDT)
Received: by 10.100.122.8 with SMTP id u8mr5454353anc.103.1213968810726;
        Fri, 20 Jun 2008 06:33:30 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id i49sm2509243rne.9.2008.06.20.06.33.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 06:33:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080620113147.GC27940@frsk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85645>

Hi,

Fredrik Skolmli wrote:
> when running git svn dcommit --add-author-from on a git-svn repository,
> --use-log-author is not implied by itself. This causes the rewritten history
> to not show the author in the way most users would expect it to be, "Name
> <email@domain.tld>", but instead "<user@uuid>".
> 
> Instead of forcing people to write "svn dcommit --add-author-from
> --use-log-author", is it a bad move to imply the last argument, making the
> history look more user-friendly to start with?

The documentation mentions that these 2 parameters are for init and, 
like other parameters, I had the feeling they will affect either the 
"init" process or the entire existance of the repository. Now that I 
look better, I see that there is no "config" note next to them.

 From my point of view, they should be repository config options, 
affecting all commits. I can't see a reason for having only sometimes
--add-author-from. If you want to commit information about the authors 
in regards to a SVN repository, you'll always want that option to be on. 
If you want to have authors properly identified when getting something 
out of the SVN repository, you'll always want to have --use-log-author on.

I would also like some option to stop pushing a commit if it doesn't 
have any From/Signed-off-by line in it.

Mircea

P.S. I am very curious why using From and not Signed-off-by. I had the 
feeling that Signed-off-by is being used to also mark the path of a 
patch. Also, is there a centralized list of all the ways a patch can be 
"marked"

--
http://mircea.bardac.net
