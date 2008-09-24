From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 17:32:06 +0200
Message-ID: <81b0412b0809240832g52a2f83cx69125895cc7f88b2@mail.gmail.com>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
	 <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
	 <20080923165247.GO21650@dpotapov.dyndns.org>
	 <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
	 <20080924140358.GX21650@dpotapov.dyndns.org>
	 <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com>
	 <20080924150231.GO3669@spearce.org>
	 <81b0412b0809240809y4daa990cl5494d7b7398353f0@mail.gmail.com>
	 <20080924151653.GQ3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	"Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:34:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiWMh-0001Cl-2v
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYIXPcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbYIXPcJ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:32:09 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:61133 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYIXPcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:32:08 -0400
Received: by el-out-1112.google.com with SMTP id z25so595728ele.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WbZLK2Cf0zRAbkhoEI6xllrSvZ4V2jAl6YxYmgy7Tl0=;
        b=fM8RI9K7/3WXV/MZ+/Hnfnnhk4Z1VBaZppAx00Gv4gEZ5H9Ua62DUnQBK3u8w3edxE
         Zl7668wrhhvd7fNIlEXA2jJX6xt0XGjiofcJtu2zw69/39o0JgBfvJop07V+p/U350wB
         9Lhw1SpTqORLcfzakrl/zskFQCoPRErt7m0uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aT2Jr6fn4ZgEmBlFFnR04EG0w22Aqp3Xkz3SmgQ75gUlkcW26TWrr3DzjgCypdTiXp
         Pqz7Tbfjoe+JDhQrkpUV5fHC36Npi/WX4dKSEECiG+oWhVOBrv4Ws+gcgr4QFsRip77J
         R3KMXR4M6Os8n5CbyOmDCs/VWK+mAs0WI4ACc=
Received: by 10.151.45.2 with SMTP id x2mr11260538ybj.34.1222270326998;
        Wed, 24 Sep 2008 08:32:06 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 08:32:06 -0700 (PDT)
In-Reply-To: <20080924151653.GQ3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96651>

2008/9/24 Shawn O. Pearce <spearce@spearce.org>:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>> 2008/9/24 Shawn O. Pearce <spearce@spearce.org>:
>> >
>> > However Dmitry pointed out that he has cases where this faster
>> > function doesn't work correctly, and it was path specific. Some
>> > areas of the filesystem work, others don't, on the same system.
>>
>> Huh?! What are they? What paths require cygwin's handling
>> which aren't handled already? (the absolute paths are handled).
>
> Cygwin lets you mount a filesystem at a different part of the
> filesystem.

Ewwww... Yes, you're right. Disgusting feature. Just when I
thought Cygwin cannot get any worse...
Config parameter looks like the only way to workaround that.

> Sort of like Linux's mount -t bind (IIRC).

Except that in Linux the binding is part of the filesystem namespace,
not a special knowledge of some stupid library.
