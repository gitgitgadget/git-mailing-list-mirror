From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Wed, 19 Aug 2009 00:02:34 +0200
Message-ID: <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com> <4A8AED8B.9080604@gmail.com> <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@storm-olsen.com>, "Johan 't Hart" <johanthart@gmail.com>,  Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com, git@vger.kernel.org,  lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Aug 19 00:02:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWlR-0001u6-SE
	for gcvm-msysgit@m.gmane.org; Wed, 19 Aug 2009 00:02:46 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so5342190qyk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=+kj/xcsHWr77l2CwedAPFmViOD14ZFk5XZZBwpsJnA4=;
        b=bTNCLjqrhIagXYN4n7KOGadN+6nd9SGNoi3zsJKFfEnqL27Do1IRiDv+YESHBcureV
         SXviMoDJ/S9O3uMmfKb+ydC3njliurlh7ARy4koY4Gh7aueYzabZ9qHM9ChUvRMc6izT
         ZAE+eQ4KHIz02DKL1h5pZVRjAZ9+h/vPBBAMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=r91SYBZQrxPnePwEtiZkoooGbFApgwH2gEvo4+HgkGN18hFI0m6H8t38P59IQ7JQDd
         9RcWueusPedRgJYhdY/kWn1DUoVih6nceKyVupCDkrPVtwVjh4rbOrHVYsXx1j32jpPr
         o6YMifJ/llf/ZGgvSAJcDL56/UYfqnJEkKV+w=
Received: by 10.220.83.100 with SMTP id e36mr208102vcl.19.1250632960147;
        Tue, 18 Aug 2009 15:02:40 -0700 (PDT)
Received: by 10.230.109.224 with SMTP id k32gr6527vbp.0;
	Tue, 18 Aug 2009 15:02:36 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.17.101 with SMTP id r37mr1053796vca.17.1250632955622; Tue, 18 Aug 2009 15:02:35 -0700 (PDT)
Received: by 10.220.17.101 with SMTP id r37mr1053795vca.17.1250632955592; Tue, 18 Aug 2009 15:02:35 -0700 (PDT)
Received: from mail-yx0-f188.google.com (mail-yx0-f188.google.com [209.85.210.188]) by gmr-mx.google.com with ESMTP id 18si450606yxe.0.2009.08.18.15.02.34; Tue, 18 Aug 2009 15:02:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.210.188 as permitted sender) client-ip=209.85.210.188;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.210.188 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-yx0-f188.google.com with SMTP id 26so5164717yxe.4 for <msysgit@googlegroups.com>; Tue, 18 Aug 2009 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=XCDjyFZJlPD7VxEiCzZpciGC0AeFoO7eawlXadFJc6I=; b=tSZb3PzB2NIzImRUxN1NPgxVhSN/NuqkhWBXUhqKDYkOS65d/Y7gVrfGqleL11UJ+Y wuXVOV7XiaCxbR/7yoDcX1S4xo3AY3Xv7J/mSy6lvRQIlhSM+RAecj+TK9SxLiprm/A/ G868XG52xi8//EU6lMLC+RFlyRTz/vhJseDVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=kerr1QW4Y2RGff5aLoHp+MHhprXfbmrRMU5jrb6PrvrOz2tRPAJeKhAnaPqUp2/F/x QjA00uFNEYXDSI8u836qn8+GHWMRJB3LI9QKeG3/EoqywXEy0MhW0W6p+C1SMtjxeLEJ 3UnvrZXEeQrXQ3PJPn1wyKjCczk0Qu0A1HbFs=
Received: by 10.90.226.13 with SMTP id y13mr4206835agg.107.1250632954181; Tue,  18 Aug 2009 15:02:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126472>


On Tue, Aug 18, 2009 at 11:53 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> debuggin, and Visual Studio's feature to move to the next/previous compile
> error.

Nope, you're still able to skip through the erros (with F4) as ususal.
I've been using a sed-script to translate gcc-style errors to
msvc-style errors for makefile projects before with great success. In
this case, the errors are already in msvc-style, so that part should
really not be any issue.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
