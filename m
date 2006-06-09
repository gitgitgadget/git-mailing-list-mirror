From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Failed git commands and StGIT
Date: Fri, 9 Jun 2006 22:05:47 +0100
Message-ID: <b0943d9e0606091405o79002a79id02e8fdd3936a345@mail.gmail.com>
References: <20060609183623.GJ11941@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 23:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FooAx-0001Sh-VP
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWFIVFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFIVFs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:05:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:9578 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965208AbWFIVFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 17:05:48 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1181930nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 14:05:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AP0rWL06aCgZqoNDL96HabdZXW4PGdInjcW5bSNDJ/LNNgi93o7OQeoRN1uMJF+65P6W3eiUA2QuqOcgQNy7fH+jNFQlVWc0s87kp3oCFHSSP7SCOVsFB7bDpkyycQE3MkT8g2fHXKzdeLgV0zmwjY+Fb45yTH6ylzweR8KQFmU=
Received: by 10.36.251.6 with SMTP id y6mr509423nzh;
        Fri, 09 Jun 2006 14:05:47 -0700 (PDT)
Received: by 10.36.250.61 with HTTP; Fri, 9 Jun 2006 14:05:47 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060609183623.GJ11941@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21559>

On 09/06/06, Petr Baudis <pasky@suse.cz> wrote:
>   a user at #git just came with a problem with stg refresh - it turned
> out that he did not have his environment set up properly, but what is
> troublesome that stg refresh just said that "git-commit-tree failed" and
> did not show the actual error message - looking at the code, you
> probably want to keep fd 3 on the parent process' stderr, that is use
> open2, not open3.

I also found this annoying but I was too lazy to fix it. To not
capture the stderr is easy (just change pass false as the 2nd argument
to popen2.Popen3) but there is a duplicate of error messages from both
GIT and StGIT. The other option is to add a '--verbose' option to most
of the commands. I'll have a look at it this weekend.

Thanks.

-- 
Catalin
