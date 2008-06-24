From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:21:17 +0200
Message-ID: <200806241421.17670.jnareb@gmail.com>
References: <200806241322.14224.jnareb@gmail.com> <willow-jeske-01l5PFjPFEDjCfzf-01l5p7eVFEDjCZRD> <willow-jeske-01l5pWdEFEDjCjLX>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7UV-0002rX-OV
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759517AbYFXMRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757840AbYFXMRx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:17:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12933 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbYFXMRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:17:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so2812nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=L1urInBXzStm0NP8QmjWnnTpVhN1EmY7gnUg4Xv5vxs=;
        b=LQxKoZ8+XNZC3rqT2tTOqw98MFNkexPj77xd4ikc681HgkQvWh+dkfRlRngGuUqhrQ
         8Fk3yfsAZR3J7LxWPZsh95rvVYmyIEUNtCbwKWWjdxejuGd8U4r9DcrsK0gyPtKNwk3h
         2cN7nXPdvXI0X4tp6XIRxcLFyZw9pO6mULP3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nswcqg39U2ZGpewRaBrZW208fBEm2yeG2B4OViJq35+zYw3urlpRDOjAL5tpI7b+Ig
         yLXmufo5yaLxLsdR7NzyFmg6rwQIQflYlm45irVZaRvyRWfaKOUifBHHJK2poRBRR6yO
         IGNwobLdHE5tbT1fmekXwxlHg6aT/Zr+buNtY=
Received: by 10.210.87.14 with SMTP id k14mr113819ebb.60.1214309870122;
        Tue, 24 Jun 2008 05:17:50 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.249])
        by mx.google.com with ESMTPS id d23sm43944985nfh.11.2008.06.24.05.17.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 05:17:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <willow-jeske-01l5pWdEFEDjCjLX>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86041>

David Jeske wrote:
> -- Jakub Narebski wrote:
>>
>> If they are using '-f', i.e. force, they should know and be sure what
>> they are doing; it is not much different from 'rm -f *'.

By the way, reflog (even if expired) would protect you in this
situation; I have checked wrongly that it does not (chronological
vs. reverse chronological order, and not paying attention to
timestamps).

> Sure, no problem. I don't want the ability to "rm -f *". [...]

It is very useful command when deleting larger number of files;
I have "alias rm='rm -i'", and confirming every single file quickly
gets annoying.

> Just like a normal user on a unix machine doesn't run 
> around with the power to rm -f /etc all the time, even though they may be able
> to su to root.

Example was about "rm -f *", i.e. removing contents of current directory;
you should be careful when doing it, for example if you are in currect
repository.
 
Some older versions of UNIX supposedly could hose every hidden file you own
upwards if you did "rm -rf .*", as they matched '..' (parent directory)
against '.*'.

> Let me guess, you're always running euid==0. :)

No.  I almost never login as root, using 'sudo', 'sudo su -', or relying
on applications asking for root credentials if required (for example when
installing new version of git).

Let me guess: no sharp knives in kitchen? ;-P
-- 
Jakub Narebski
Poland
