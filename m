From: Lars Johannsen <mail@lars-johannsen.dk>
Subject: Re: parsecvs fails
Date: Thu, 25 May 2006 16:04:37 +0200
Message-ID: <20060525140437.GA19919@mail.Lars-Johannsen.dk>
References: <cc723f590605250432r7dd0b75xe5ff17b11da06e3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 25 16:04:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjGSC-0002gA-WA
	for gcvg-git@gmane.org; Thu, 25 May 2006 16:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWEYOEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 10:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWEYOEm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 10:04:42 -0400
Received: from 0x503e3922.hsnxx4.adsl-dhcp.tele.dk ([80.62.57.34]:28039 "HELO
	box4.last-soft.dk") by vger.kernel.org with SMTP id S1030188AbWEYOEl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 10:04:41 -0400
Received: (qmail 26667 invoked by uid 503); 25 May 2006 14:04:37 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Aneesh Kumar <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <cc723f590605250432r7dd0b75xe5ff17b11da06e3c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20740>

On (25/05/06 17:02), Aneesh Kumar wrote:
> The tagging used by the repository given below is quiet complex.
> But it can be used as a test case for all the cvs to git converter.
> Even ViewVC and ViewCVS doesn't work with this repository.
> 
> Any help in converting it to git ?
> 
> rsync -av rsync://ci-linux.cvs.sourceforge.net/cvsroot/ci-linux/ci/ 
> ci-linux/ci/
> 
> -aneesh

 Well it seems like most of your ,v files contains tags refering to version 1 
 and yet the first version in the files is 1.1
 So to fix for parsecvs ( and maybe for viewcvs) i think you need to fix
 all symbols at 'top of file' for all ,v files. Change from v1 to v1.1
 with something like sed ',/@#/s/:1*$/:1.1/;,/@#/s/:1;*$/:1.1;/'
 

-- 
Lars 
