From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Fri, 25 Apr 2014 12:39:47 -0400
Message-ID: <535A8FD3.2070409@bbn.com>
References: <E1WdOZY-0006ck-F9@iramx2.ira.uni-karlsruhe.de> <20140425073724.GA9384@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, sitaramc@gmail.com,
	git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	G?bor Szeder <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 25 18:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdjAQ-0005Hj-P6
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaDYQj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:39:58 -0400
Received: from smtp.bbn.com ([128.33.0.80]:27174 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbaDYQj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:39:57 -0400
Received: from socket.bbn.com ([192.1.120.102]:41146)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WdjAD-0003PF-Ks; Fri, 25 Apr 2014 12:39:49 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E56CB3FFFC
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140425073724.GA9384@xs4all.nl>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247071>

On 2014-04-25 03:37, Simon Oosthoek wrote:
> (though tbh, I think you'd have to be in an automated situation
> to check out a branch that is basically a command to hack your
> system, a human would probably figure it too cumbersome, or too
> fishy)

You can get in trouble by cloning a malicious repository and cding to
the resulting directory.  See:

    https://github.com/richardhansen/clonepwn

for a (benign) demonstration.  (Note the name of the default branch in
that repository -- it's not master.)

> 
>>>> + # not needed anymore; keep user's
>>>> + # environment clean
>>>> + unset __git_ps1_upstream_name
>> 
>> We already have a lot of stuff in the user's environment beginning
>> with __git, so I don't think the unset is necessary.
> 
> If people rely on the string being set in their scripts, it can be
> bad to remove it. But if it's new in this patch,

The variable is new.

> I don't see the need to keep it. Cruft is bad IMO.

Agreed, although I am willing to remove those three lines if that is the
collective preference.

-Richard
