From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch
 submodules too
Date: Wed, 6 Oct 2010 18:22:43 -0500
Message-ID: <20101006232243.GA30302@burratino>
References: <4C9351A7.7050609@web.de>
 <4C9359D4.2030109@viscovery.net>
 <4C935D77.3080008@web.de>
 <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
 <4C953DE5.6020900@web.de>
 <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
 <4C963D00.9050207@web.de>
 <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
 <4CAB8DDF.8080004@web.de>
 <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:25:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dN0-0002PY-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab0JFXZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 19:25:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51072 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0JFXZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:25:52 -0400
Received: by gxk9 with SMTP id 9so46708gxk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Aai6Sn4Vt0DqOIowduhvNdX4XoTZwCMCbJo/XwkyX0I=;
        b=EA5xAmmRvW2C0M0+/TJNEMYjEbs7VEO9vLFptsNJokEuQFAIxjRkdCAUtuzCeTzZJI
         G6PwZsR1HOxxrwDSXm7FC2F9cWvdhLv3glsin79pWMzmCtDKRmASYFUdzJ1WPNFimffR
         j1RNP+4gLv0yVPaOADkI07JH8Pl7CDgqvzl8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bIli152iOoxXmO59QGJ8vnMvGG6Dw8vq8OfmESdfahR0ZwdGxWXyOvJuZ25u7FIGxV
         LQmiPX9LwiXcQgfueXlTQnTSINUSYGOOQ7u4ojpEfy4Pj3OBjSOstop5u+K/waw+7hE8
         twPI5Ansv0WXkZOtnS4SqyXPVLeX/WSLNdnL8=
Received: by 10.151.21.18 with SMTP id y18mr20536ybi.379.1286407551384;
        Wed, 06 Oct 2010 16:25:51 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm1691495yba.10.2010.10.06.16.25.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:25:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158353>

Kevin Ballard wrote:

> After thinking on it a bit, I think the best solution is to add a switch
> --submodules to fetch which will also fetch all submodules, but otherwise
> fetch will fetch no submodules.

For what it's worth, for my (odd) use cases, what would be most practical
is

	[remote "foo"]
		fetch = ...
		submodules = ...

I could care less about the defaults. :)

Rationale: I shouldn't have to explicitly use --submodules to get
everything I need to hack before dropping connectivity, but I also
don't want to pay the penalty of fetching, say, git-gui when I don't
need it.
