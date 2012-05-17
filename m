From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local cache for git objects
Date: Thu, 17 May 2012 13:47:41 -0700
Message-ID: <xmqqk40a7cwi.fsf@junio.mtv.corp.google.com>
References: <CALnNMuHdNFktUkp+Vdc=ooTJ9ay_BJftAJ_toVaBDA5EOzt9ww@mail.gmail.com>
	<1337285744-ner-2739@calvin>
	<CALnNMuE=YQsXK-kiRUntNU_0s7s6ONgBk92dZN4UD0Va+qqF+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Bartosz =?utf-8?Q?G=C4=99za?= <bartoszgeza@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 22:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV7bx-0004SW-9e
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab2EQUrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 16:47:43 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:36702 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab2EQUrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 16:47:42 -0400
Received: by qabg24 with SMTP id g24so306336qab.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 13:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=C13jmOR27pS0tmmdzHexxr9o0FHN+7NFCP1U7J2M7wA=;
        b=RoQ/e63bWokoeIfZ0k/zYakCvMTGBXMSWgpbuk9xgiNj5iXO2zLh9R4gH93oPncE9i
         cwweB9ocgwVKdPrFQoXMU4S3fX2jllo+naiJ/ZVgOpnAURHDkGk8SHGotDpE5A/jKJKr
         qoOK3EtsWmLPHFfUvwsMiqQy1j1dz6X8fR1OH+KgSbIoqWznNN7SQZYGf7rL4n2BLPoi
         +PRcqYFmvCKV5Ux4sVXldhqtGrjia2Dxa5KLceMe6KLG7u2lcjarmT0q9OmsBoqEKXZj
         BNihagUKUNPt79jcxIVws5/UuxESSphJbdOukJiIJDA3DA7cbIysWFCALVP22W2tMKMb
         4ELQ==
Received: by 10.101.138.4 with SMTP id q4mr3952759ann.7.1337287662047;
        Thu, 17 May 2012 13:47:42 -0700 (PDT)
Received: by 10.101.138.4 with SMTP id q4mr3952753ann.7.1337287661985;
        Thu, 17 May 2012 13:47:41 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id b8si5931235yhn.6.2012.05.17.13.47.41
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 17 May 2012 13:47:41 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id DBF731E004D;
	Thu, 17 May 2012 13:47:41 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 844D9E25F4; Thu, 17 May 2012 13:47:41 -0700 (PDT)
In-Reply-To: <CALnNMuE=YQsXK-kiRUntNU_0s7s6ONgBk92dZN4UD0Va+qqF+Q@mail.gmail.com>
	("Bartosz =?utf-8?Q?G=C4=99za=22's?= message of "Thu, 17 May 2012 22:36:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkxCqoM1/yuQ5/vzLHi//AlKEBtYZMYHuYV7oYnNAWH8RFdhzoSVCaNHitBRjjd3ou3GQP0ezgGrQN96lTdulWhTiV4ri2nnrwUKM/++6l/fyfLBCw2wxDmO0i/RiSQbysVksZVNIpVvfKaNPk/1FIqr0N/fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197929>

Bartosz G=C4=99za <bartoszgeza@gmail.com> writes:

> Reference is read only (?)
> I'd like to set up one global cache repository and forget.
> Later as I fetch any objects they are stored there for fast future ac=
cess.

Somebody needs to keep the "global cache" up to date, and that has to b=
e
somebody who has access to cron(7) on your system, and you will be a
good candidate to do so.  So as part of the procedure to "set up one
global cache repository and forget (about it)", make a bare clone and
then set up a scheduled task to periodically "git fetch" from its
origin, and then you are pretty much done, no?
