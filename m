From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list --merge-order hangs
Date: Thu, 9 Jun 2005 00:17:27 +1000
Message-ID: <2cfc40320506080717585bf939@mail.gmail.com>
References: <42A69550.1030105@gorzow.mm.pl>
	 <2cfc4032050608002258e58897@mail.gmail.com>
	 <2cfc403205060800337e1ecca0@mail.gmail.com>
	 <2cfc4032050608020215152887@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 06:43:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgEsM-0007Zk-6m
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 06:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVFIEqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 00:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVFIEqc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 00:46:32 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:47151 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262265AbVFIEq0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 00:46:26 -0400
Received: by rproxy.gmail.com with SMTP id i8so633577rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 21:46:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h9lR1e/LMQBK0RyBfGiRXYtVVFEwRyAKUqpIIiAutOJmtPb6Qfeetc0B5SHcAXzSdmBILx/2hAIcvK337GgLYuv0F0XTT+O7n/eiVSNSNjosqEFoHVEAAUYkC8AHPpTTIZv2VA9Ob7KF2qL9YfVNko/GSuvATsF+saPv6CqaZkA=
Received: by 10.38.186.20 with SMTP id j20mr3716114rnf;
        Wed, 08 Jun 2005 07:17:27 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 07:17:27 -0700 (PDT)
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <2cfc4032050608020215152887@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, I reproduced exponential behaviour when a commit with no parents
is merged near the head of the kernel and a ^ argument is specified.

Fortunately a work-around is a one line change - a patch will be
forthcoming shortly.
The workaround will still require a full-graph scan but that is linear
rather than
exponential so is tolerable.

A better solution which will not require a full-graph scan will be
delivered in a future
patch.

Thanks for the report.

jon.
