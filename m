From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 13:22:56 +0200
Message-ID: <200809301322.58280.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809301048.40046.jnareb@gmail.com> <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 13:24:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkdL2-0006wY-RY
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYI3LXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbYI3LXJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:23:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:62035 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbYI3LXG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:23:06 -0400
Received: by nf-out-0910.google.com with SMTP id d3so841982nfc.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yVLGiWtaqQy2m2ajmkmBS1wbud+/qzn8chd+AYz0FV8=;
        b=IZprqomBfJ4+GwbBYdczuGHwN3ohaet4vEtaJ4BnjCzdBOonQWCPwoqo763hOmZFlb
         tJD790ize6YHcuxBXyeWvWf4bw+2VeQ6/zKCctvR61AZEYp9VSyF1v+88DdZKGEYbFpN
         FYhw3s5u2HEHTHUQhWxLsTzYrAwCeEPa1a5ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nnHUserAdkZTpA4XuqEhEo7AJ51ssTVRntZrLDwlFAyDC7f7Qe3vqyzXKSzg3INrmv
         XnFPgbQ5nq88r8WxcYbAt8s+pTF6hzpYN9vaZpw4Sj8P7/T8ehLBdCtIxJtGFoCHschP
         4tPiP88vrnAjfapW3EgxufqLJE8TDaGm39duM=
Received: by 10.103.11.7 with SMTP id o7mr4701987mui.103.1222773785006;
        Tue, 30 Sep 2008 04:23:05 -0700 (PDT)
Received: from ?192.168.1.11? (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id j9sm4729502mue.3.2008.09.30.04.23.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:23:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97102>

On Tue, 30 Sep 2008, Giuseppe "Oblomov" Bilotta wrote:
> On Tue, Sep 30, 2008 at 10:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:

> > Or we could just scrap and revert adding href(..., -replay=>1).
> > There is much trouble with getting it right and performing well,
> > and it is less useful than I thought (at least now).
> 
> Dunno, the idea in itself is not bad. We just have to get it right ;)

It is not easy to get it right, especially that there are multivalued
parameters like @extra_options, see e.g. commit 7863c612
 
> In a way, I actually think that -replay=>1 should be the default, I
> suspect it makes sense in most cases.

Well, -replay=>1 was meant to be used for "alternate view" links, like
for example 'next page' link, or 'raw view' link, or 'sorted by' link;
it would be stretch and feature abuse to use it for "item" links, like
entries in 'tree' view, or commits in log-like views, or changed files
links in 'commitdiff' and 'blobdiff'  views.

I guess it would be half the cases, not most cases.
-- 
Jakub Narebski
Poland
