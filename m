From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:41:25 +0200
Message-ID: <4A8AE7C5.7050600@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <7vtz05dq0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSgk-0004zY-R6
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485AbZHRRla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759435AbZHRRla
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:41:30 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54700 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759434AbZHRRla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:41:30 -0400
Received: by ewy3 with SMTP id 3so1789721ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=4gniIoeVvvHDuRRWW4PkPWVY1NNqYP7p0KurENOrGMI=;
        b=LfRYVoNmC608sd605jyQR/j6Y4TL3g8chl4AxeWi1xlOYDF8AbqNzJvL3gSAyLs4qe
         37jfc/XOD4qxcMqhAxloDFTNFJhl8hVQ/GPxmp5DZ1youkBXMDwouwk5ZUico6CzZnTX
         PSFScpqrdsR1CVZGi5DbjX8UvTzv/fxONwbNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=cq1aZ+o19Wucv8kM+dc4BXMm81bj+mwckbfvctCxUNJK6VI+SQHEoXq28lmkNfuIrh
         kqMhALRerf3L1tFgLM5aRsXXphKMywGnlqjMu9gc2UG2RMzI/sj6Wp99ffmw7d6Ic1K2
         uV7l12Ik/FBnfoe141yBGavuj7Un4ItHXqUHw=
Received: by 10.210.82.2 with SMTP id f2mr4881619ebb.34.1250617290215;
        Tue, 18 Aug 2009 10:41:30 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 7sm539384eyg.47.2009.08.18.10.41.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:41:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <7vtz05dq0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126427>

Junio C Hamano schreef:
> Since use of make implies use of shell, this makes me wonder if it would
> make sense to go one step further by giving msvc users a thin shell
> wrapper mcvc-cc that turns bog-standard cc command line into whatever cl
> uses.

Just using the msvc toolchain for building git misses the whole purpose 
of what VC is used for. MSVC would be used because of the IDE, not for 
the compiler IMO. msysgit already has a nice toolchain, using gcc, to 
build git. I think there is no reason to use MSVC for that purpose.

The purpose of CMake was to build an .vcproj file to be used by the IDE, 
not for a batch process that builds git with the VC toolchain. Users 
could than hack git with the IDE from MSVC. And ofcource git should then 
also be compilable by MSVC's cl.exe, because the IDE is not capable of 
using another toolchain then its own...
