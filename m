From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 15:19:39 +0100
Message-ID: <40aa078e0911040619m7ca6350bw659a95a17a56be2d@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <4AF175E8.7020400@viscovery.net>
	 <16cee31f0911040614p2d58c418m29e66ac825b12986@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5giB-00009m-3B
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbZKDOTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756270AbZKDOTg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:19:36 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33617 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbZKDOTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:19:35 -0500
Received: by bwz27 with SMTP id 27so8914439bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 06:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+ptuTfoNb9ehB5ApfCeBgAPFTYaFcWjzL6N5PYq5epU=;
        b=LfovECiSV2uq4Q+T4QuvIjdIrKvbsNcWQSaTJ+a6jJ4XCD75/0yqcTt+vA6hdYEAs1
         BEI/ljq/vUsB/7h45JZXOFtTVmdPbl1qt255P+Eyp/otqX0yc3geUBGuI0USPqGtaWJ2
         AoHbE/kC7Y+csjtcC+p91sGhRIsZ3DD0+/DBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=EsEE04KU7LE1DgVTB/lxtcjk6YPVtPfyMeqxxPmT8tveMeVUCnfa157oxkWiSQKr7D
         kgy4uWdhBtscHMuc++aEgWQLltia3kjEbV0x5DTxVTOQOHI81bxQRUrhe2NUizu3lvYK
         oK3APOZqpPp7VW61wLcOjN/rXq5UzrzuIH1kY=
Received: by 10.204.153.220 with SMTP id l28mr1533633bkw.86.1257344379333; 
	Wed, 04 Nov 2009 06:19:39 -0800 (PST)
In-Reply-To: <16cee31f0911040614p2d58c418m29e66ac825b12986@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132087>

On Wed, Nov 4, 2009 at 3:14 PM, Andrzej K. Haczewski
<ahaczewski@gmail.com> wrote:
> 2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
>
>>> +static __inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
>>
>> What's wrong with 'static inline int ...' (without the underscores)?
>>
>
> Forgot to answer. 'inline' is avaliable in C++ only (on MSVC at
> least), while '__inline' is MS extension for C and C++.

You don't need it:
compat/msvc.h:9:#define inline __inline


-- 
Erik "kusma" Faye-Lund
