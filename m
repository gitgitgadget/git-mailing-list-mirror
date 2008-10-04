From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to list versioned files with modification status
Date: Sun, 5 Oct 2008 03:09:22 +0400
Message-ID: <20081004230922.GL21650@dpotapov.dyndns.org>
References: <20081004131256.586a5fbf@smartavionics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@smartavionics.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 01:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmGGy-0001Qc-JT
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 01:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbYJDXJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbYJDXJa
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 19:09:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:15094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbYJDXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 19:09:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1477032fgg.17
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BczHi+s/Hhxds/18nNtKwrMNju242sAfDtJWCrpF0+k=;
        b=FxQdezAp7EQ+TaMmuSyQQQX6H+GKEZ49+gjKtGjSEfXd+TVJCxfpYfx9HlDDCbpdHu
         it/X3XQaUBTEgc1vW4WMbn/Fh+w1qAAsn6czU1ppu5LFqEbn3SANWqndkOgeAwzfWWH3
         LXR4fsFCtJ8NzVEFD/qp5EfNHcMo5B9eEa/Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wVlR8MMhSsM2AyFs+3wLExnpnZ89UjVkdLVEQ4nknOI++g+/nLgkbd2hk51PLJFoyl
         FK6LB+LH5+TbWciH9KAIDte1JXBRPLm5Av0fJ/jaHX1apqPPuq6EKrjLVZjf2IKP4jHS
         4taFIL2Gu7tqHoEy6U2RuYbA+7VYXwwrXzg+M=
Received: by 10.86.1.1 with SMTP id 1mr2837301fga.61.1223161767619;
        Sat, 04 Oct 2008 16:09:27 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id 4sm8697814fgg.4.2008.10.04.16.09.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 16:09:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081004131256.586a5fbf@smartavionics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97486>

On Sat, Oct 04, 2008 at 01:12:56PM +0100, Mark Burton wrote:
> 
> I would like to be able to easily find those files in a git tree that
> don't have pending modifications. Although ls-files can list the
> files that are modified, it can't list those that aren't

Well, it is a rather unusual task to have a special option devoted
to it, and you always combine a few commands together like that:

comm -3 <(git ls-files|sort) <(git ls-files -m|sort)

Dmitry
