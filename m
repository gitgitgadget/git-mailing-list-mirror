From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 01:57:51 +0100
Message-ID: <200702010157.51452.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 01:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCQFf-0005qi-NH
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbXBAA4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbXBAA4c
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:56:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:45794 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161150AbXBAA4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 19:56:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so334798uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 16:56:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZQt1vEkLcg3muiw7mxJE4qCxII01NVzMZTbFTAGVSAF8EzszsRyNO3DbFj8iApb9R4rArM9nf+X0K8B1r4K2wt6ZcaaoA/aGpyaIqeaFxmpr5uwG3JMg+h7VhFSjtwPxS3KRGi4NX52PEDJKE+21W5SCZ0hcP61Z5V7En9G6VeE=
Received: by 10.67.89.5 with SMTP id r5mr1856664ugl.1170291390738;
        Wed, 31 Jan 2007 16:56:30 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id m1sm1849831ugc.2007.01.31.16.56.30;
        Wed, 31 Jan 2007 16:56:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070201003429.GQ10108@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38317>

Matt Mackall wrote:
> On Thu, Feb 01, 2007 at 12:58:42AM +0100, Jakub Narebski wrote:

>> Sidenote 1: it looks like git is optimized for speed of merge and checkout
>> (branch switching, or going to given point in history for bisect), and
>> probably accidentally for multi-branch repos, while Mercurial is optimized
>> for speed of commit and patch.
> 
> I think all of these things are comparable.

Hierarchical tree objects in git optimize for speed of merge and checkout
IMVHO, as you need only to check out one hash to know if you have to
descend into subdirectory, or if given subdirectory haven't changed.
Flat manifest file in Mercurial (and also "filename buckets") makes
commits faster, I think.

>> Sidenote 2: Mercurial repository structure might make it use "file-ids"
>> (perhaps implicitely), with all the disadvantages (different renames
>> on different branches) of those.
> 
> Nope.

How it is so, if the blobs (file contents) are stored filename hashed?
IIRC hg has some scheme to deal with renames, but it is file-id (file
identity) based AFAIK.

-- 
Jakub Narebski
Poland
