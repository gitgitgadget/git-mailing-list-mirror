From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Building Git on Tru64
Date: Thu, 15 Apr 2010 14:24:58 -0700 (PDT)
Message-ID: <m34ojcfly1.fsf@localhost.localdomain>
References: <1271358589.19032.1370170305@webmail.messagingengine.com>
	<r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
	<1271360809.25304.1370186353@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Daniel Richard G." <skunk@iSKUNK.ORG>
X-From: git-owner@vger.kernel.org Thu Apr 15 23:25:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2WYl-0002ck-OZ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 23:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab0DOVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 17:25:05 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:58152 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107Ab0DOVZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 17:25:02 -0400
Received: by bwz25 with SMTP id 25so2201380bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=YZ2VWMdbkWQZr2NReydRQ73lWcl8sH5938fXrJ4W8HA=;
        b=ALdKTYhykpxPrRgpvE1uGcNb6v14AChwyj+EPsfCjRIxv4tY10weBaHuZKvdq2eLF2
         OO5wi0+7sHwEi/+RtRmq5vMz+tfquM8VIC9YUH5kcFZ8xDShL/6U22ZvgBEyqDJLxBfv
         u7jyfVuvtYrFQ86yWL3X3do/ItdbkgTGM6f6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=osZxcoBObTlG/YmKHLbjECXx2E2fS6MAuBsqwtxk0TymwI4k/qggAOwtpJxmpEmOeY
         RephLAR/bWl4aD76o0iRnZagNV/ADum8s+pKt+6vESCq1m6G0YKZq7O1niZNxzeInBkx
         YpxWtUsiieRy5VqYXlrUT/9yZ53m8A/vpxhzI=
Received: by 10.103.64.25 with SMTP id r25mr442298muk.68.1271366699064;
        Thu, 15 Apr 2010 14:24:59 -0700 (PDT)
Received: from localhost.localdomain (abvv243.neoplus.adsl.tpnet.pl [83.8.219.243])
        by mx.google.com with ESMTPS id i7sm10294724mue.34.2010.04.15.14.24.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 14:24:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3FLP749000996;
	Thu, 15 Apr 2010 23:25:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3FLOtJL000983;
	Thu, 15 Apr 2010 23:24:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1271360809.25304.1370186353@webmail.messagingengine.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145026>

"Daniel Richard G." <skunk@iSKUNK.ORG> writes:

> On Thu, 2010 Apr 15 21:29+0200, Alex Riesen wrote:
> >
> > That one may be better handled at one place (git-compat-util.h?) with
> > something like:
> >
> >   #ifdef Tru64
> >   #define MAP_FAILED ((void *)MAP_FAILED)
> >   #endif
> 
> I agree with the sentiment, but you can't have a macro refer to itself

It can.  From (cpp.info)

  3.10.5 Self-Referential Macros
  ------------------------------

  A "self-referential" macro is one whose name appears in its definition.
  Recall that all macro definitions are rescanned for more macros to
  replace.  If the self-reference were considered a use of the macro, it
  would produce an infinitely large expansion.  To prevent this, the
  self-reference is not considered a macro call.  It is passed into the
  preprocessor output unchanged.

  [...]

     One common, useful use of self-reference is to create a macro which
  expands to itself.  If you write

       #define EPERM EPERM

-- 
Jakub Narebski
Poland
ShadeHawk on #git
