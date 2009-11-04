From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of   
 Pthreads API
Date: Wed, 04 Nov 2009 23:50:28 +0100
Message-ID: <4AF20534.2030004@gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com> <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 04 23:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ogY-0002TJ-8F
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbZKDWu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbZKDWu0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:50:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:56146 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbZKDWuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 17:50:25 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2096117fga.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 14:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8drFDO9eB+b9hCrmviAA1uyf0YmTEHKTa6AISE4zOqg=;
        b=lY52FYQm6oEuY0BLRcq+NQqPlcROvEccTbH4stRHRh35gI4qe3fFdFOOSt8QTx1PdJ
         wYT5NhtOKRqb80lCIvMQEJeDgjBynv68gloNUHc4X4fBuCZKucFkO7z0FpSU4j0/8ZSP
         LCkbIb6s8Z3jXsw4nrTICkeWrom+U2L7S1cVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MK1ryocLw88bTUBozn0cnzwCmpGOi/mkTsV//lPOenw2Aph27wnTOa5mM15OALR/1H
         fG6oSQLbIG5W0u3oapMNdzcZDkwYL8qH2VwpX3YBgIc3/MJE8UirVdKobHg2DoxEeZjl
         YMz/uqTg1uD3U9+reV/PLsZnDB79XNeuY4E3I=
Received: by 10.87.69.28 with SMTP id w28mr4338925fgk.46.1257375030126;
        Wed, 04 Nov 2009 14:50:30 -0800 (PST)
Received: from macendru.local (14-mi2-10.acn.waw.pl [85.222.57.14])
        by mx.google.com with ESMTPS id d4sm2621644fga.16.2009.11.04.14.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 14:50:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132165>

Erik Faye-Lund pisze:
> Couldn't the windows version of pthread_create have a wrapper
> function, that corrected the calling convention, much like the
> function run_thread that start_async in run-command.c has?

Can't be done without allocations. I'd have to pass to that wrapping
thread function an address of original function *and* an original
argument, and there's no way to pack that as one void*.

--
Andrzej
