From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: timestamps not git-cloned
Date: Sun, 30 Nov 2008 06:44:38 +0530
Message-ID: <2e24e5b90811291714s4388289bwa4b2e22ff1f75a83@mail.gmail.com>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com>
	 <20081129085406.GA20428@foursquare.net>
	 <20081129092231.GA32630@cuci.nl>
	 <200811291117.01655.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Chris Frey" <cdfrey@foursquare.net>, jidanni@jidanni.org,
	dhruvakm@gmail.com, git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 30 02:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6axF-0008P6-KA
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 02:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYK3BOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 20:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYK3BOl
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 20:14:41 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:57358 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbYK3BOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 20:14:40 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1288031tic.23
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 17:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BUmfQk5kFORnzBJcxXdmzjP5w99/rKVCY+WCiBGdBG4=;
        b=xjK3quDDtFXy1HmlXhnHOUwybs8/StwvmrJXIzKzgsKT6OIU8IwlBeQFy+vuiAcPBh
         FyR4PEFlvU7+OAgDJP/vAVzo5UzDgKjLHKD+sTBln5zA2pUfPCZUF5bAScuZCZvcc2c+
         F9oH5yxLZeg5Uypk7CUdku/rnlb775+wBXW4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=f4dGO6/k+CLaSAHTFzn0EnEdz64xWUbqBRZlNnNX6iH/uUL04PPno4poJXgcun3l8T
         9NV9loG2VQrNNyz5326vNHQHW7RqcEUqAwO4vSTTRvXB2yLkHhjLkFPi/mL9joe2H+lO
         GpNxZQYz2dd5/1AYCrmPNmhtheUOklJeECDIo=
Received: by 10.110.15.9 with SMTP id 9mr14092826tio.27.1228007678851;
        Sat, 29 Nov 2008 17:14:38 -0800 (PST)
Received: by 10.110.60.15 with HTTP; Sat, 29 Nov 2008 17:14:38 -0800 (PST)
In-Reply-To: <200811291117.01655.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101943>

On Sat, Nov 29, 2008 at 3:46 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Stephen R. van den Berg wrote:
>> Chris Frey wrote:
>> >If this is the important bit, perhaps git-archive could be changed
>> >to create tarballs with file timestamps based on their commit dates.
>>
>> Based on the principle of least surprise, I'd consider this a rather good
>> idea.
>
> Unless I'm missing something, this would make git-archive rather more
> expensive than it is now: Tree objects do not record any timestamps,

How many people use git-archive and how many times a day do they use
it?  For example, kernel.org seems to put out linux-2.x.y.z.tar.bz2
once every 2 to 7 days.

The overhead of this new option (and certainly it should be an option,
not the default) should be measured not against the old running time,
but against the frequency of usage of the tool.  Look at it on those
time scales, it may not be a big deal.

By all accounts, this overhead will not affect the "giterate" [meaning
git-literate ;-)] people too much.
