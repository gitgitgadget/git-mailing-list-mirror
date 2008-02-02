From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn segmetation fault
Date: Sat, 2 Feb 2008 11:03:32 -0500
Message-ID: <20080202160332.GA25945@dervierte>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 17:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLKqg-0000gY-3X
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 17:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759529AbYBBQDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 11:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756555AbYBBQDh
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 11:03:37 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:39817 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbYBBQDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 11:03:36 -0500
Received: by an-out-0708.google.com with SMTP id d31so368749and.103
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=8X0AjVfkVpelO5CtbHu6RdwT1bRe8BGWm353jlW067o=;
        b=a6+LuWQPyojnfaG660TAj3PKzwcuf5Q1a2cqSLTHtxjBCbE4VXCfcehProIJI2rOpeyZ6LLdW3OncVQu095jwonRxuATq/Gg0t13wB24cZkqIPzA2X78AUei5MEFJ14OB0txU5MOqKBPndQv4dgsKcydzey44D03SglzVG6141I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=R+Kx861PtSCw2BdHzz5juHnsqA+6uM/D+DMz7anM9tOgrkxF2nU+6aadhy/fes/ZkvuaoXsoAwTMC/iE+d9iNfHJDR3kzhw/iyDDZKLgSEnFFhtPrXVAA5Ghw5/wumSRMw+kObfIOjs72yN6DUCPZOE0RCJKpX1wBeLLaNPA9o4=
Received: by 10.100.110.15 with SMTP id i15mr10262800anc.76.1201968215213;
        Sat, 02 Feb 2008 08:03:35 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 8sm1750544agd.30.2008.02.02.08.03.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 08:03:34 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id D7476321E; Sat,  2 Feb 2008 11:03:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A3E9A8.1060102@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72284>

On Fri, Feb 01, 2008 at 07:55:20PM -0800, Wink Saville wrote:
>> Can you show the contents of .git/config ?
>>   
[...]
> [svn-remote "svn"]
>        url = https://async-msgcomp.googlecode.com/svn/trunk
>        fetch = :refs/remotes/git-svn

There's your problem.  The url line should only contain the SVN root.
If you change it thusly:

    [svn-remote "svn"]
        url = https://async-msgcomp.googlecode.com/svn
        fetch = trunk:refs/remotes/git-svn

It will no longer segfault.  I had the same issue with a repository of
my own.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
