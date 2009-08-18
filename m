From: Jakub Narebski <jnareb@gmail.com>
Subject: git find (was: [RFC PATCH v3 8/8] --sparse for porcelains)
Date: Tue, 18 Aug 2009 08:25:53 +0200
Message-ID: <200908180825.55289.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <2729632a0908171734p16d6ee7dm5f62848f7625ffbc@mail.gmail.com> <fcaeb9bf0908171843x6ab0763dqff7e8aea0443c374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 08:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdI2D-0004WT-4X
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 08:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbZHRGS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 02:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbZHRGS5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 02:18:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31391 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZHRGS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 02:18:56 -0400
Received: by fg-out-1718.google.com with SMTP id e12so515394fga.17
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a8HuGb3m4LqU1Rwspk84szuDdy6S8nWww7Q2ZZU2d9Y=;
        b=bbpWWm7X4FwVK4PwP8HvgZJLayfUAmcwBY5rAPg5bvIgnrC6FmxhWC1LVFMFNOnH2j
         JoloQGPsxqTrIruJm6YA8YAsmVlMMKBM/I+q9/3T2MIrcJge1lsDHezXrgRifNvvX+CN
         34Y+5DQVFPcC9La3/iCI/HD58rGOL38o8SlPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KE6/UBhyyvjpNTiTX3JAjzRx3VwPmeP8rrqM0XgSQoNUSuTDdw3adUQVcD8Id0mySZ
         YTFY46k+g0y7K2TOkrtlMmVEUPTMbWvWrZvP4Bd0q5xHE8mErz5t4LAPz0yPC0zEKqsw
         OwEo5aEBR3uv0OKxFXxY3JsftKHK2NMDwm06s=
Received: by 10.86.12.35 with SMTP id 35mr2963626fgl.20.1250576336980;
        Mon, 17 Aug 2009 23:18:56 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id d4sm6419939fga.0.2009.08.17.23.18.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 23:18:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0908171843x6ab0763dqff7e8aea0443c374@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126352>

On Tue, Aug 18, 2009, Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 18, 2009 at 7:34 AM, <skillzero@gmail.com> wrote:

> > I would like it to git grep to not search paths outside the sparse
> > area (although --no-sparse would be nice for git grep in case you did
> > want to search everything). The main reason I want sparse checkouts is
> > for performance reasons. For example, git grep can take 10 minutes on
> > my full repository so excluding paths outside the sparse area would
> > reduce that to a few seconds.
> 
> That's a porcelain question that I'd leave it for now. FWIW you can do
> something like this:
> 
> git ls-files -v|grep '^H'|cut -c 2-|xargs git grep
> 
> /me misses "cleartool find"

Well, I also think that it would be nice and useful to have "git find"
in addition to current "git grep".

-- 
Jakub Narebski
Poland
