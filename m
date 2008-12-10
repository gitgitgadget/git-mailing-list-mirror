From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] make sure packs to be replaced are closed beforehand
Date: Wed, 10 Dec 2008 10:36:05 +0100
Message-ID: <81b0412b0812100136j6ae4f3few2ab00a475643b538@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <4923FE58.3090503@viscovery.net>
	 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
	 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
	 <49241AEF.1080808@viscovery.net>
	 <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
	 <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
	 <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
	 <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
	 <493F71B7.60804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LALVb-0004Vd-0m
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 10:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbYLJJgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 04:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYLJJgI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 04:36:08 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:4143 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbYLJJgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 04:36:07 -0500
Received: by rv-out-0506.google.com with SMTP id k40so338111rvb.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y8RuqMbCbEBu4/tDjmfCZy5T1uXedxKraETpqcXIm5I=;
        b=eIfJQ6j1BaGmaRGjvI9AY3Sy3WnsRTzTeNv2txIWl5lMB0/My8Nr65tH5uVSONmd5f
         ZFGIOSIV3sXQ4JTXzTN60ugzlQOCmkP00MooRRe5U+E4WG7H5eCD5am7tp3H/lb9JrYp
         MMNd5s9DX9Uxbu3nSkWGitcepbe9HdUdNL/Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QLxTxoYPGB86Rk12sVs0LcgYU7IHgUPBU8cMdoSrmPLqtjTn84vThwc5Y84kITAIWU
         bLsoJ/LqZ9KDwOBxRt/MzeTRyjlOY2qkNzO7Ai3L2072mHgARp1xLrWZoNYyJWj5hY+I
         OfJ3GwrWVK5DdTcwrdeWZwF4RoSlPwMp3xBcE=
Received: by 10.114.191.1 with SMTP id o1mr800853waf.209.1228901765977;
        Wed, 10 Dec 2008 01:36:05 -0800 (PST)
Received: by 10.114.74.15 with HTTP; Wed, 10 Dec 2008 01:36:05 -0800 (PST)
In-Reply-To: <493F71B7.60804@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102679>

2008/12/10 Johannes Sixt <j.sixt@viscovery.net>:
> Nicolas Pitre schrieb:
>> Especially on Windows where an opened file cannot be replaced, make
>> sure pack-objects always close packs it is about to replace. Even on
>> non Windows systems, this could save potential bad results if ever
>> objects were to be read from the new pack file using offset from the old
>> index.
>>
>> This should fix t5303 on Windows.
> ...
>> OK, here it is at last.  Please confirm it works on Windows before Junio
>> merges it.
>
> I can confirm that this patch fixes t5303 on Windows (MinGW).
>

And it does that for me, FWIW.
