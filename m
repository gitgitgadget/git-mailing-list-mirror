From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Fri, 5 Nov 2010 16:41:59 -0500
Message-ID: <20101105214159.GA4457@burratino>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
 <1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
 <7v4oci11k6.fsf@alter.siamese.dyndns.org>
 <20101020004533.b64d446c.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Fri Nov 05 22:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEU3G-0003Id-E0
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 22:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0KEVmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 17:42:20 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64712 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0KEVmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 17:42:19 -0400
Received: by qyk12 with SMTP id 12so3144045qyk.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lyI4BOJbbH/u45kBlzy0I7WupZpfSS1AvNq8I0Co6l0=;
        b=kyxCmhNzVEHGY3dfcb8Hbm00AJUFU5uFDppovo3K1RkpHiJ82bY1q2WAu4pS+7vQiN
         YxKewF+JdBicbj6vE1tJDyACo9ZKhbBzn1XhmqwvXSU7oT1q2OCx550fiUILyC2NHPOC
         tArNUmy2OGOM93E2Ny/HZbr3ysCD2Q3EO0GkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zj4Ur+9xLipuVaWprH8uk7PYtrPhztuxxJkuKwZAOPcE+eWG6+aau5ew8Qj6WMJoEq
         +afVKayliO0p0FrsDJZPn/6QTp1pw+Ccv8Vu+q8/bQeZLpWYfg/xMrkbS+Aese4oo+Zp
         NQ4LRHph5H2K030jodOlvtGYZaJL97iSKqV40=
Received: by 10.229.96.136 with SMTP id h8mr2413329qcn.184.1288993339310;
        Fri, 05 Nov 2010 14:42:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm1787547qcb.3.2010.11.05.14.42.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 14:42:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101020004533.b64d446c.ospite@studenti.unina.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160823>

Hi Antonio,

Antonio Ospite wrote:
> Junio C Hamano <gitster@pobox.com> wrote:

>> You are breaking the && chain here.
>
> Some other tests do that as well, the last line is a command by
> itself not and-chained with the git-send-email invocation. I guess the
> logic behind this is that the test succeeds if the _last_ command
> succeeds. If this is wrong then some other tests are affected too.

Yes, breaking the && chain is never a good thing.

See:

 - t/README: "Chain your test assertions"
 - v1.5.4~20 (t9001: add missing && operators, 2008-01-21)
 - git log --grep=&&

Hope that helps,
Jonathan
