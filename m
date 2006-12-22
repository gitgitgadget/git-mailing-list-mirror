From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks/commit-msg: add example to add Signed-off-by line to message
Date: Fri, 22 Dec 2006 09:28:07 +0000
Message-ID: <200612220928.08921.andyparkins@gmail.com>
References: <7vejqufonm.fsf@assigned-by-dhcp.cox.net> <200612210924.17357.andyparkins@gmail.com> <7v64c47abv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 22 10:28:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxghR-0006Ow-JY
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946005AbWLVJ2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWLVJ2Q
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:28:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:46747 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946005AbWLVJ2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 04:28:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2920339uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 01:28:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A1GXPEDOXROohlgk9DVgYs4EYHJw2XcOqlWFdTpXvHp5TwCBmmPBwXdPC+ELgjXr2/KA3Ezb155WUShZ11VuD1AFUt6PHlmqyzglu/fko3eVqKuzzLINDRjnLDaC4gYC58kZmMDMuKSt6Dsx454FD1vaW1+PAkNkl6eLnQQMoqA=
Received: by 10.67.103.7 with SMTP id f7mr474680ugm.1166779694013;
        Fri, 22 Dec 2006 01:28:14 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id j1sm15391998ugf.2006.12.22.01.28.11;
        Fri, 22 Dec 2006 01:28:13 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7v64c47abv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35153>

On Friday 2006 December 22 05:45, Junio C Hamano wrote:

> I suspect this sed script is quite wrong.  Did you test it?

I plead not guilty; cut and pasted from Johannes.  In it's defence; I've been 
using it since he gave it to me without trouble.  My patch is wrapping it a 
little differently, but the sed is certainly the same.

Amazingly it does work though...

>  * quoting with dq means you are losing one level of backslash
>    to the shell and sed is not seeing them.

Unusual.  It doesn't seem to apply to non-recognised escapes:

$ echo "\1\(\)\+$/"
\1\(\)\+$/

>  * one-or-more regexp '+' is typically not found in sed.

Seems to be in mine (GNU sed version 4.1.5).

$ echo "xxxxxx" | sed -n 's/\(x\+\)$/MATCH/p'
MATCH

> off that new change as well, I think.  So checking the last
> instance of the existing signed-off-by line, ignoring earlier
> ones, may be more preferrable.

Accepted.

Notwithstanding the fact that it seems to be working for me; I'll fix the 
problems you highlight and re-patch.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
