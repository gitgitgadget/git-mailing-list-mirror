From: Olaf Hering <olaf@aepfle.de>
Subject: Re: let git grep consider sub projects
Date: Wed, 8 Oct 2014 08:59:47 +0200
Message-ID: <20141008065947.GA22318@aepfle.de>
References: <20141007082914.GA2729@aepfle.de>
 <xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com>
 <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com>
 <5434DE29.2010200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:59:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XblE3-0004Jk-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 08:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbaJHG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 02:59:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:43815 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbaJHG7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 02:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1412751588; l=586;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=X2Z/6+rEV2PSZOwvOQSy7lq8my0=;
	b=jC/ZONdNGz24XntvvlT8zgGFZT1MbGzqrXTWJLETHutOsBrQeYg802e7ls/QfQ7tsec
	Dh7h0t87ynybHF8juKnh8xP6MF/8ID3i6Vcm+xo7rJx8Tv8YILSZq9LmShtGaPQ0zwqGk
	lHOeN9DohZvuoesktkEzLrYIOHAWi5L1f3Y=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfstVolSR8Cl8fNabDQrlSrQo8jPq2gOVbkBPuE3yQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:11b7:1201:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.10 AUTH)
	with ESMTPSA id f04237q986xmAek
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Wed, 8 Oct 2014 08:59:48 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id AFD5F5016D; Wed,  8 Oct 2014 08:59:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5434DE29.2010200@web.de>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, Jens Lehmann wrote:

>    git foo && git submodule foreach --recursive git foo

Looks like a submodule is yet another thing, or I have to learn what a
submodule is:

olaf@bax:~/xen $ find . -name .git
./.git
./tools/qemu-xen-dir-remote/.git
./tools/qemu-xen-traditional-dir-remote/.git
./tools/firmware/seabios-dir-remote/.git
olaf@bax:~/xen $ git submodule foreach --recursive git show
olaf@bax:~/xen $

xen does essentially 'git clone $url1 dir/url1-dir;git clone $url2
dir/url2-dir'. So the top level .git does not really know about
dir/*-dir.

Olaf
