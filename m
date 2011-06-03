From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 1/4] Refactor for_each_ref variants to use for_each_ref_in and avoid magic numbers
Date: Fri, 03 Jun 2011 01:33:21 -0700 (PDT)
Message-ID: <m3wrh3wc0x.fsf@localhost.localdomain>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSPow-000454-Nx
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 10:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab1FCIdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 04:33:25 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51921 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab1FCIdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 04:33:24 -0400
Received: by wwk4 with SMTP id 4so4890262wwk.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=KKklPV0Skvqae6Vkzq/LDTaijMVLFJbBhbT1VaXAlIo=;
        b=au8Xl2aHlugA9PmHkBZ/1PDenmnGHYdbEIwUHnwwZnyX4z4ThYQ4LGOc/NI3ChYZum
         FuZM2p6avv8iYjJwQ9isqv2anoqDC1Aj5prccuajnR5hu9GUJelsvQcpdzeyVsYKmZhu
         oQLZ3yXnTaRVGRI3c3MxFzuX1ayjyyyXsVvvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=w0Iy9dEZTOwnxB9Ln+saJ5fJC+oLTjJl+3PEtofFr/2wEJ8ObKzrM4Xqp47GRSfgMT
         MoprGBMIB/ZbYSXorYjuZYP1EriizfRk98xqNyapsJCU4gmtAub7Ridoi8hhPSnlOiE3
         0b4LdbFwrnEeOkc4hYS+lCA0Tk2FYa6PN2Zus=
Received: by 10.227.11.148 with SMTP id t20mr1600867wbt.98.1307090002799;
        Fri, 03 Jun 2011 01:33:22 -0700 (PDT)
Received: from localhost.localdomain (abwo192.neoplus.adsl.tpnet.pl [83.8.238.192])
        by mx.google.com with ESMTPS id o38sm874688wba.54.2011.06.03.01.33.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 01:33:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p538Wltc014364;
	Fri, 3 Jun 2011 10:32:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p538WVkl014360;
	Fri, 3 Jun 2011 10:32:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1306887870-3875-1-git-send-email-jamey@minilop.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175002>

This patch series would surely benefit from a cover letter...

Jamey Sharp <jamey@minilop.net> writes:

> From: Josh Triplett <josh@joshtriplett.org>
> 
> Several variants of the for_each_ref functions call do_for_each_ref with
> both a fixed string prefix and the hardcoded length of that prefix.
> Furthermore, for_each_ref and for_each_ref_submodule passed "refs/" but
> a length of 0, which caused do_for_each_ref to ignore the "refs/".
[...]

-- 
Jakub Narebski
Poland
ShadeHawk on #git
