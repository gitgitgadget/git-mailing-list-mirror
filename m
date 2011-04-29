From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] gitweb: Improve ctags, introduce categories
Date: Sat, 30 Apr 2011 01:53:06 +0200
Message-ID: <201104300153.09304.jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com> <7v8vuswxqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFxUy-0005Ho-01
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 01:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab1D2XxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 19:53:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33195 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1D2XxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 19:53:18 -0400
Received: by fxm17 with SMTP id 17so2786617fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 16:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=B447jeup71gLSWw06i/a/jAn7Mrxlk3ERDWYEp8sjhQ=;
        b=iRx+fo570xD9ou1Li5RwGtz0Q5HTN5BxIrJSmxw//OI8ZRsuIw+Y8+rVZ1otx3pHdR
         DSQqRAjg15ea+7DELDOQkA4rfGGgVqSt2Zk6gj01SVOg212BuF66gtRgBmRGVfyl8hdc
         1VWu4S1LQ6L995fV0Sz1j11qqSCrfvfNhPUxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T9MlT/E9tJ3MQx0VMaYjXnOcqRb1c6lxsUdfWjU8awc4hqWe7k2++8MTxVq6jPGBCy
         09b1ZVHm6gK2zdWrliyZytrOT2HY1nI7AazASznuxWqLa9yN0X+2bLqydnbWeR3BNCu6
         Iyo7FK/XegYWDP3FVUCDQ0JVUsSym5DY7lpW8=
Received: by 10.223.97.219 with SMTP id m27mr632006fan.81.1304121197046;
        Fri, 29 Apr 2011 16:53:17 -0700 (PDT)
Received: from [192.168.1.13] (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id j18sm1031889faa.42.2011.04.29.16.53.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 16:53:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vuswxqs.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172513>

Junio C Hamano wrote:

> A tangent. It is curious why [PATCH 2/6] alone ended up with an encoded
> "Subject" header, like this:
> 
>   Subject: =?UTF-8?q?=5BPATCH=202/6=5D=20gitweb=3A=20Change=20the=20
>    way=20=22content=20tags=22=20=28=27ctags=27=29=20are=20handled?=
> 
> The message actually has the above as a long single line, as can be seen
> at http://article.gmane.org/gmane.comp.version-control.git/172479/raw
> 
> Just being curious.
> 
> The headers suggest that sending MUA was git-send-email speaking to gmail
> SMTP.  Did we introduce bugs to send-email recently?

This is git-send-email from git version 1.7.3 (not most recent).

What might be important, and what you can't get from mail itself, is that
patch was generated using git-format-patch, but UTF-8 characters in body
of email were introduced during editing it, and were not present in commit
message (sorry, bad practice).  So git-send-email asked about encoding,
and I chosen default UTF-8

  The following files are 8bit, but do not declare a Content-Transfer-Encoding.
      mdir.7/0002-gitweb-Change-the-way-content-tags-ctags-are-handled.txt
  Which 8bit encoding should I declare [UTF-8]? <ENTER>

Though subject itself does contain only 7bit US-ASCII, so there is no need
for encoding it (with quoted-printable, as Subject appears before 
Content-Encoding and MIME-Version headers).

-- 
Jakub Narebski
Poland
