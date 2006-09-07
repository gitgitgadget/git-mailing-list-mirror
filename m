From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: Add git-archive [take #2]
Date: Thu, 7 Sep 2006 19:26:13 +0200
Message-ID: <cda58cb80609071026m216bcc19jcf43023381fd17e7@mail.gmail.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	 <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	 <44FED12E.7010409@innova-card.com>
	 <7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	 <7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	 <44FFD00E.5040305@innova-card.com>
	 <7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
	 <450019C3.4030001@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	"Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 07 19:26:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLNdr-0007PE-Ra
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 19:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWIGR0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWIGR0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 13:26:16 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:3051 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422661AbWIGR0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 13:26:15 -0400
Received: by qb-out-0506.google.com with SMTP id p36so846763qba
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 10:26:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oXlVJFaDiMijsIEgS7iGMcrDiYMFb25WwqWJrdroEl1Chyll29+tY1L7XrDSJQ71PK4Vb1RZIJdQ0irzNVa+vPJML0qCZoOx0T9OuKr2nwF/ygpDo9Myn0qPSD+ocXK5o8Zx1O7dFLSoylKTNUHkLmAAWtlVXxLmJOFRyegI6Ps=
Received: by 10.70.87.11 with SMTP id k11mr1019753wxb;
        Thu, 07 Sep 2006 10:26:14 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Thu, 7 Sep 2006 10:26:13 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <450019C3.4030001@innova-card.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26646>

2006/9/7, Franck Bui-Huu <vagabon.xyz@gmail.com>:
>
>   4/ Progress indicator support. Junio wants to mimic upload-pack for
>      that. But it will lead in a lot of duplicated code if we don't
>      try to share code. Can we copy that code anyways and clean up
>      later ?
>

BTW, could we move the side-band code into git_connect() function and
adding to it a new parameter like:

int git_connect(int fd[2], char *url, const char *prog, int side_band)
or
int git_connect(int fd[2], char *url, const char *prog, flags)

Hence it automatically spawns a side-band process in the client side
and it also sends an extended option for git-daemon to ask for using
side band for server services.

-- 
               Franck
