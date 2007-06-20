From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 1/3] Accept root <tree-ish> in 'git-svn commit-diff'
Date: Wed, 20 Jun 2007 12:20:59 +0300
Message-ID: <4678F17B.8010902@gmail.com>
References: <11821688443683-git-send-email-ynvich@gmail.com> <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com> <20070620062548.GA25840@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, J.Sixt@eudaptics.com, masterdriverz@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 11:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0wMs-00076e-U3
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 11:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbXFTJUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 05:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXFTJUT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 05:20:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:48163 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbXFTJUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 05:20:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so298019ugf
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 02:20:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IaLsjmYM+YjNLPV2EMI/U92dhZEK2htGC5YpU61tNhxA0gdebVXSTj6dfIVIJoPBnnG+m4P9QaYLx1pF5w1TAv6bCawf+1csc22yfXpx6IFxfLeLrN5+79440nPIIb9y0Jfr0fOlo+0zGtQTZVMKmNOwnT1iKNWv/+8txh4WzYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eigRZV7FiXQPuh0WRl5gU0ldse+o9XFf+IgjssvmGVfGI2g20obfPsaTffvqlUj01HA0uSrUt5BzaBprA6rbRyO//YNeOTTKERSsJx4G1NzwCYw/AaWv3qZiK1QZ46n8VAgBkvQQvbHpgulnCEW+Z8VIrmCn1CcSj57LZLzAPKs=
Received: by 10.78.149.15 with SMTP id w15mr168800hud.1182331214243;
        Wed, 20 Jun 2007 02:20:14 -0700 (PDT)
Received: from ?10.20.82.249? ( [212.98.161.164])
        by mx.google.com with ESMTP id z28sm153899hub.2007.06.20.02.20.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jun 2007 02:20:13 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <20070620062548.GA25840@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50553>

Eric Wong wrote:
>> -	push @diff_tree, $tree_a, $tree_b;
>> +	if ($tree_a eq '0000000000000000000000000000000000000000') {
> 
> You can make this more legible by using '0' x40 instead of repeating
> 40 '0' characters.  Also, it might be a good idea to support --root
> directly for git-svn so the user won't have to type 40 zeroes in the
> command-line :)
> 
Sorry, I am not a perl expert or even user.

I did try to process '--root' in 'git-svn', but in vain. And I can 
explain, why 40 '0'. That is the only reference to root commit as an 
object that I managed to find in git - in the output of 'git-rev-list'.

If 40 '0' is not good, then it may worth to introduce a shorthand for 
it, just as we have one for 'HEAD'. 'NULL' or 'ROOT' may be. If this is 
implemented in 'git-rev-list', there will be no need to change 'git-svn' 
at all.
