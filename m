From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Confused about `git gc`
Date: Tue, 09 Jun 2009 03:45:40 -0700 (PDT)
Message-ID: <m3ljo14r61.fsf@localhost.localdomain>
References: <4A2E1D37.9010909@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDyrv-0000X1-SE
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 12:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119AbZFIKpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759021AbZFIKpl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 06:45:41 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:34301 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668AbZFIKpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 06:45:40 -0400
Received: by ewy6 with SMTP id 6so5053713ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=caOtotq7QJr1GHuCe0H5kd9Ur5jhPsVnvoYfmYoUvh0=;
        b=J+RQDA0YfUC0zEG3F0ZQdPUO+QeD+cE+oZIpXkHgHCJsklFunKuWyLAaBVOl+yorbY
         XF9IbPQHCv8Z1M9eHapDIejrwgR7Bszur5GCWvjXQnj7BA/IRB6MhDrmVhM5QJtzXtmX
         JbaOxDk3QI42VhThGk/1yxa7RzqI6fVXmHrNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=oqtDU19ZDdloVyYH7qSl8+94iljsFq/Q/x+7dw5Ii+uJA9C4TrlT0RtZZI4ZY9cjJv
         R9DY0jJXwXUTC1J1BYEwX5T58Fvko3p38nvVTyNkRiDxXhIbn34DabW+E9IQkZz7vlVo
         mwM06Qf6rhuu6/wxrs2vKJ3t8Wkzn7Rh/TC34=
Received: by 10.210.29.17 with SMTP id c17mr5609323ebc.64.1244544340898;
        Tue, 09 Jun 2009 03:45:40 -0700 (PDT)
Received: from localhost.localdomain (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id 28sm110128eyg.44.2009.06.09.03.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 03:45:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n59AoXNB008498;
	Tue, 9 Jun 2009 12:50:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n59AoUqj008495;
	Tue, 9 Jun 2009 12:50:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A2E1D37.9010909@ubicom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121165>

Yakup Akbay <yakbay@ubicom.com> writes:

> Looks like I didn't quite understand the actual role of `git gc`. I
> just thought that `git gc` would remove all unreferenced objects
> during the unpack-pack process. However, I'm not seeing the result
> what I was expecting from `git gc`.
> 
> I'm adding an object into the database, which is ignored by git. Then
> I expect the object to be removed after `git gc`. But, it's still
> there.

[...]
> What am I overlooking?

You are probably overlooking the safety introduced to "git gc" to make
it safer against concurrently run git operations, namely the fact that
it would not remove new loose objects (it would remove loose objects
only when they are old enough).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
