From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 19:17:35 -0500
Message-ID: <53697b9f6b978_1b76e132f05d@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 07 02:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whpik-0002Iy-R6
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 02:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaEGA2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 20:28:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60566 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaEGA2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 20:28:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so301056obc.33
        for <git@vger.kernel.org>; Tue, 06 May 2014 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EkDuEpPFlKmezzXl6LW8hUxm0EU5Bq9N2WEDFq9qGxk=;
        b=kH+0ZAN2qt5MF2kgFZB1pb+6MAgzhlrUuMo+peMoHsjc9xBXrVb2TwnMu/UNjcUH1h
         RVlZUCdCgMCRFS77qxkHPg4OzOAtLLPqRtYHU3Rhs0AZL58Ps1FhoNQrcziWvaBO+OXV
         o48R9ee9fZBSjX3GuTAm/yLTJYH5F2DKlSksFljeKpP/qG1XF8WlPtxwSQ6kSKlxwbuc
         4cC7TizFycTQ9p9Zk78Fhi0LEzH0Pu0GHuQxlIYL3SXqFFg42xauCBwlsC1MmafwkYsD
         BNKrzInVI3RPbZdGP/n5pRBnDorkX9yrN1fUihfjV1hrXzbVCp0uQbdXsbqbZ/Ro91eO
         twvQ==
X-Received: by 10.60.73.39 with SMTP id i7mr12278173oev.51.1399422501957;
        Tue, 06 May 2014 17:28:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zc8sm30490217obc.1.2014.05.06.17.28.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 17:28:20 -0700 (PDT)
In-Reply-To: <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248274>

Junio C Hamano wrote:
> I _think_ it probably is OK for git-imerge.git/Makefile to peek into
> our Makefile, e.g.
> 
>     $ cd git-imerge.git
>     $ make GIT_SOURCE_DIR=../git.git install
> 
> to learn where imerge should install its subcommand implementation and
> documentation.  It might even want to borrow the test framework by
> using $GIT_SOURCE_DIR/t/test-lib.sh or somesuch.

Since Git's test framework heavily tied to git.git, sharness[1] is the
only sensible option. It might not have all the latest features of Git's
test framework, but it's standalone.

[1] https://github.com/mlafeldt/sharness

-- 
Felipe Contreras
