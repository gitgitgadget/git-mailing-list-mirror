From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Add scripts to generate projects for other buildsystems (MSVC
 vcproj, QMake)
Date: Thu, 24 Sep 2009 08:05:10 +0200
Message-ID: <4ABB0C16.4030103@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <72888219-5bab-4964-9faf-0d40b4770e2c@o35g2000vbi.googlegroups.com> <alpine.DEB.1.00.0909232236490.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhSN-0008Hm-Na
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 08:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZIXGFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZIXGFP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 02:05:15 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:62056 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZIXGFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 02:05:14 -0400
Received: by ewy27 with SMTP id 27so1482527ewy.40
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=D+fVAkr5gNH7HFWkj9lr1CoSJ8zHIjLB/tEs7+iss/Q=;
        b=vUAq2VTbBPRhZThX8VR1uDe5O5WJ0af5c+s9MjEvDHUp3ZN/84iR9MuB/2iWlvFGIN
         VPBV9Qyr9mICDnDRzLcDEymlzTjzlhDeKzdscJzFsLVgvGFSK1O1YSRr6t1XIKtudYPO
         qJyyxUaRw41vulchvxtir7/7dB9ylf1PiJ6tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=m//n+b6HlLRcKcoozEMAPzfrQ4qGubJmlMFEfkW3NR9ZNGzz/hu16eLvBfw/5fPtVX
         VvQ9HvpQ7Wz07DJn4MAXMlcD1FWGafNfprfZgsl0hyQ4TtMpUeDCcTQ9Dbd1VoFNoh7R
         RHiCm9Um9/Dxq8+ht9KW24gBBBhTGyUc3Zl7o=
Received: by 10.210.6.8 with SMTP id 8mr7137298ebf.41.1253772317027;
        Wed, 23 Sep 2009 23:05:17 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm1397730eyz.34.2009.09.23.23.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Sep 2009 23:05:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0909232236490.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129021>

Johannes Schindelin said the following on 23.09.2009 22:37:
> Hi,
> 
> On Wed, 23 Sep 2009, Sebastian Schuberth wrote:
> 
>> On Sep 16, 10:20 am, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>>
>>> These scripts generate projects for the MSVC IDE (.vcproj files) or
>>> QMake (.pro files), based on the output of a 'make -n MSVC=1 V=1' run.
>>>
>>> This enables us to simply do the necesarry changes in the Makefile, and you
>>> can update the other buildsystems by regenerating the files. Keeping the
>>> other buildsystems up-to-date with main development.
>> I know I'm a little late with my comments as this patch set has
>> already been merged to master. However, for future reference I'd like
>> to point out that something similar could be archived by using e.g.
>> CMake, and only maintaining the CMake project file. I'm not suggesting
>> to actually switch to CMake at this time, but I wanted to point out
>> that a guy called Pau Garcia i Quiles already seems to have created a
>> preliminary CMakeLists.txt file for Git [1], and also tried to build
>> Git for Windows using his CMake-generated MSVC project files.
>>
>> [1] "CMake-ifying git", http://www.elpauer.org/?p=324
> 
> We actually discussed this, and I challenged Pau to provide a recipe (a la 
> /src/openssl/release.sh) that builds, installs and commits CMake.
> 
> There was no response after that challenge.

Also, the buildsystem scripts I added to contrib/buildsystem is made 
in such a way that creating a CMake generator would be very little 
overhead. And since it's very unlikely that any other buildsystem will 
replace the default Makefile anytime soon, I think that is the way to 
go, to generate files for all the other buildsystems based on the 
output of the Makefile. Not optimal, sure, but follows main development.

Note that the contrib/buildsystem scripts could need a major overhaul 
by a Perl guru, as they are currently tuned only for Windows 
consumption (and Msys Perl being the only Perl distribution tested).
But they work as intended for the use-case in mind.

--
.marius
