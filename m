From: Deskin Miller <deskinm@umich.edu>
Subject: Re: multiple-commit cherry-pick?
Date: Wed, 5 Nov 2008 22:24:37 -0500
Message-ID: <20081106032437.GA27237@euler>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 04:26:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxvVY-0007oG-BB
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 04:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYKFDYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbYKFDYq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 22:24:46 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:49002 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYKFDYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 22:24:46 -0500
Received: by rn-out-0910.google.com with SMTP id k40so344830rnd.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=glKCj3B+AB8VUlRrT7+tdKj39E2PjzFF7/xmfl7q8iw=;
        b=xV7iZkrz5h1dFH3j+O1j4OP5GDeJJRDeXYaUIMQeXm5MsyckBeH5UcXFtYMBRPsBvC
         oErZZfaUhs9CbuK5UiwZ/L/DLFfzHaGNV8i0Zn/vPv2qfrRta0HSQNkTAkGG7Me5XrTY
         pwSeTxaWxVEVU2TsKbt0vikai6NO1aygqUt+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=N5ccxYDlfzLGeLETuoFx1Mt8t1Yiy4EwW2kg05k88Z0EPAnzbbDjQtfTMN6iMQbeXA
         +y2akmtOGVIl4i0oPSMy9qrjOM+6Y9+G8AG3iASjAAAcUy9u9878RTE/MQQiPNCtVxGH
         SyR1nl+1xMQL2aFO1DMx0IsbqSTJcOSt2OX7k=
Received: by 10.64.7.5 with SMTP id 5mr1675000qbg.86.1225941884254;
        Wed, 05 Nov 2008 19:24:44 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s27sm723627qbs.12.2008.11.05.19.24.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 19:24:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100211>

On Thu, Nov 06, 2008 at 11:45:27AM +0900, Miles Bader wrote:
> Is there any easy way to cherry pick a _range_ of commits from some other
> branch to the current branch, instead of just one?
> 
> I thought maybe git-rebase could be coerced to do this somehow, but I
> couldn't figure a way.

Rebase is exactly what you want.  Given something like this:

o--o--o--A--B--C--o--o--X
    \
     o--o--D

where you want A, B, C to go on top of D:

$ git checkout -b newbranch C
$ git rebase --onto D ^A

newbranch will have <...> --D--A--B--C

Hope that helps,
Deskin Miller
