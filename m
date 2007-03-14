From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 00:14:55 +0100
Message-ID: <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcgN-0000aG-5t
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbXCNXO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbXCNXO5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:14:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:22976 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964800AbXCNXO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:14:56 -0400
Received: by nf-out-0910.google.com with SMTP id o25so434375nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:14:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E4I+d8g/aqNaSdPO6lToCZsIMeOUwJo4HRhDa6mjWxTdv10uQtz85MJ0nK4ZamwOQjybhTyNeE8Jev+vmx8wlMrAlsMU51HJR/NycPah8p7kjAbik0u6NoynJa144VrkwQ0+ihfFwFvZt8B/jVMZdclbu1nqqwIk3l0QbGCc5yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HkHEFAVhvJlXf1V+XVpQLUBYdmklxMATo0AcMl9opUH8NhZilOPaLWc1iHVx8KIXl9y81wdtXs9U6H+8UohNEf4pYAhoIzVVYBuxy1YiaQDvvkcqexIYZf0Tc2pKnLiXIXiRmJmPwUT9DdAVYoZKxlqXxYrRO/V3QsTh8qX1mxw=
Received: by 10.78.160.2 with SMTP id i2mr1544632hue.1173914095463;
        Wed, 14 Mar 2007 16:14:55 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 16:14:55 -0700 (PDT)
In-Reply-To: <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42248>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> This adds the command line option 'quiet' to tell 'git diff-*'
> that we are not interested in the actual diff contents but only
> want to know if there is any change.  This option automatically
> turns --exit-code on, and turns off output formatting, as it
> does not make much sense to show the first hit we happened to
> have found.

Now I'm happy :)

~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20

real    0m0.137s
user    0m0.117s
sys     0m0.020s
~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16 v2.6.20

real    0m0.006s
user    0m0.000s
sys     0m0.007s
