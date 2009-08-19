From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [msysGit] Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Wed, 19 Aug 2009 12:59:02 +0200
Message-ID: <4A8BDAF6.5060805@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de> <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302> <4A8BA9EC.9000006@storm-olsen.com> <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 12:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdit4-0004kp-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 12:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbZHSK7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 06:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZHSK7H
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 06:59:07 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40585 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZHSK7G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 06:59:06 -0400
Received: by fxm17 with SMTP id 17so3714601fxm.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DSYC5AHtBcJHSUsgBssvUApg1XrTEft6x3WWXcug3Qg=;
        b=AAMcFsD5nXMUmIAFKeMTK7rzWYClMipchiC+QpjcWCYxSdhyZ4Ni9jFuMcUwV96xlB
         wWBUGYBwpY8E8t00f7gzjjWZayvANLQSkxi6G1G+svKYfrPBBL7TogZfREuCBziNnI5K
         LSAtjfJRRoxewYhGOq3lt27t28breyjQw8B+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=J7I58dCXEyvlJCPoKeOsa43WisuOih3hQdwL+rv0AUmdZ9wfiqcNUD2le6yPaFb9e9
         TaI56rgO1qVOQ1alsCJdZxz1t/lbVxdPkthaFgmXuoSC3jTbx/fwAyn6lZ0ATXwcTRKP
         9zJon0r9ChyERJIwnTgXnGeewZmhuN6nDQrOQ=
Received: by 10.204.152.27 with SMTP id e27mr4793672bkw.192.1250679546214;
        Wed, 19 Aug 2009 03:59:06 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 1sm8129345fks.41.2009.08.19.03.59.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 03:59:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126534>

Johannes Schindelin said the following on 19.08.2009 10:29:
> Hi,
> 
> On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:
> 
>> The full IDE support is secondary, first because you *can* use the IDE 
>> already, and second because it'll be harder to whip something up which 
>> guarantees that the vcproj support stays in-sync at all times and won't 
>> lag behind.
> 
> I think the point of Frank's patches is to make Visual Studio users 
> comfortable with Git.  You cannot ask those to use a build process or an 
> IDE they are not used to.
> 
>> Of course, if someone has a huge itch to restructure the current 
>> Makefile; factoring out the files into a file which can simply be 
>> included in the current Makefile, and easily parsed by a script, or 
>> included by CMake, then that can be done in parallel and possible added 
>> to git mainline before the MSVC support patches from Frank.
> 
> I still think it would be possible to use a combination of a 
> Makefile rule and GNU make features to spit out a list of targets and 
> their dependet .h and .c files.

Ok, but you would still have to rely on GNU Make in this setup, and it 
would have to generate the common_cmds.h before you can even compile 
with the MSVC IDE.

--
.marius
