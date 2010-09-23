From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 10:59:46 -0700
Message-ID: <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: msysgit+bncCOPdven-DxCpq-7kBBoEY-0pnA@googlegroups.com Thu Sep 23 20:00:34 2010
Return-path: <msysgit+bncCOPdven-DxCpq-7kBBoEY-0pnA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pw0-f58.google.com ([209.85.160.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCpq-7kBBoEY-0pnA@googlegroups.com>)
	id 1Oyq5x-0000Zr-De
	for gcvm-msysgit@m.gmane.org; Thu, 23 Sep 2010 20:00:33 +0200
Received: by pwi4 with SMTP id 4sf599154pwi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Sep 2010 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:mime-version:received
         :reply-to:in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tLvZR4d7tvA7GWkTYDFxBjL5L5pwTf/bZGtxFNtjwlU=;
        b=HYWpZVxEQoMMLIIxFcAj98RvKWLSL7SR2KmMfAs/T/r+UpnLy1I45qAVq2bRePUEiz
         zwJgpS79rVCc5E/33xX1dCr0RN+x6SQxB24ns6Tp3pb10yFMYVrpAvm1uHfYwlPXZ8ob
         Lsm/SXVwGkRvMOmiZpcUZRPrlfJ2L9Jw/RFWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=4emiHOa54his9Pp7lThSI7BI9px/Eq2qjRw/mfHL2SgbKU8KmAX9DiZN9hwuUrG3w9
         6eUgwbCuPQPCxSXIXFe0+WHgwBg+7/hCiaWCBqBHuPDOh2rJ3dQA5YhFrnbZere/FJ0N
         7yo6ds/pv1OUbsGO3ft24YUlKI9BVl80dAGZo=
Received: by 10.115.101.24 with SMTP id d24mr199124wam.6.1285264809397;
        Thu, 23 Sep 2010 11:00:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.115.67.12 with SMTP id u12ls1168170wak.3.p; Thu, 23 Sep 2010
 11:00:08 -0700 (PDT)
Received: by 10.115.14.6 with SMTP id r6mr388409wai.7.1285264808756;
        Thu, 23 Sep 2010 11:00:08 -0700 (PDT)
Received: by 10.115.14.6 with SMTP id r6mr388408wai.7.1285264808732;
        Thu, 23 Sep 2010 11:00:08 -0700 (PDT)
Received: from mail-pw0-f41.google.com (mail-pw0-f41.google.com [209.85.160.41])
        by gmr-mx.google.com with ESMTP id j18si1364639wan.1.2010.09.23.11.00.07;
        Thu, 23 Sep 2010 11:00:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.41 as permitted sender) client-ip=209.85.160.41;
Received: by mail-pw0-f41.google.com with SMTP id 6so800410pwj.14
        for <msysgit@googlegroups.com>; Thu, 23 Sep 2010 11:00:07 -0700 (PDT)
Received: by 10.142.212.14 with SMTP id k14mr1412851wfg.132.1285264807532;
 Thu, 23 Sep 2010 11:00:07 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Thu, 23 Sep 2010 10:59:46 -0700 (PDT)
In-Reply-To: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.41 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156892>

On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Since open() already sets errno correctly for the NULL-case, let's just
> avoid the problematic strcmp.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

I guess I should add a comment as to why this patch is needed:

This seems to be the culprit for issue 523 in the msysGit issue
tracker: http://code.google.com/p/msysgit/issues/detail?id=523

fetch_and_setup_pack_index() apparently pass a NULL-pointer to
parse_pack_index(), which in turn pass it to check_packed_git_idx(),
which again pass it to open(). This all looks intentional to my
(http.c-untrained) eye.

The code in mingw_open was introduced in commit 3e4a1ba (by Johannes
Sixt), and the lack of a NULL-check looks like a simple oversight.
