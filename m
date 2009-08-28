From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 08/14] Test for WIN32 instead of __MINGW32_
Date: Fri, 28 Aug 2009 10:15:10 +0200
Message-ID: <4A97920E.20601@gnu.org>
References: <cover.1250860247.git.mstormo@gmail.com> <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com> <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com> <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com> <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com> <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com> <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com> <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com> <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgwcs-00014v-9g
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZH1IP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbZH1IPZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:15:25 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:46876 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZH1IPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:15:23 -0400
Received: by ewy2 with SMTP id 2so1911339ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cM19r7iWmU62Zokdt560uSxIdn7bE5KUl37bJ9QZzI8=;
        b=juQPq+7xB0g3b6iFVhR3HaGuf9/rEo8aeqmLmJ7WwSqE2AzwgmRItS04q6A3EY6XYB
         QDkiAsefmwqXygYvSlkZnP2hwovQCYYaieXmLJ68pH5RJALDf8y9ovKqU1VbgyRWApIh
         c9ABzFMrbTMREacNBaBR6EY3+mnwCcvZV3fSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=n37aATW8mbOhH6Z/uyPnIuLswB3c3I8dcQR+WeUYBWZk/Q6+3zrnaLCA3AR1WKnl05
         KAyTMxfK3V18aoC/KOb/4zmbd0uGPD8d0dE2+wtPWorrekBeoCtQZqY5i/Kw4LUazGmX
         9UoCnNxBxmzAWzdKwZaG15r01oKCvRnIaFVOc=
Received: by 10.211.147.10 with SMTP id z10mr864829ebn.61.1251447324019;
        Fri, 28 Aug 2009 01:15:24 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 7sm1503134eyb.26.2009.08.28.01.15.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 01:15:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127277>

Since you are doing this, you may as well change patch 3 from

+#if (defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4) || 
defined(_MSC_VER)

to this:

#if defined WIN32 && (!defined (__GNUC__) || __GNUC__ < 4))

Paolo
