From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH v2 2/3] Fix memory leak in apply_patch in apply.c.
Date: Sat, 3 Mar 2012 10:05:33 -0500
Message-ID: <20120303150533.GA4812@gentoo.cinci.rr.com>
References: <cover.1330785363.git.jaredhance@gmail.com>
 <e631bb2059c800f9d49eed51cfa5ba4d04106a2e.1330785363.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 16:05:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3qWk-0000k0-Mm
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 16:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab2CCPFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 10:05:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40080 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2CCPFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 10:05:36 -0500
Received: by iagz16 with SMTP id z16so3563821iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 07:05:36 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.42.153.10 as permitted sender) client-ip=10.42.153.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.42.153.10 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.42.153.10])
        by 10.42.153.10 with SMTP id k10mr2231833icw.24.1330787136301 (num_hops = 1);
        Sat, 03 Mar 2012 07:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iQwkGemfTOXAcJV5SI1O/F20auUFCm/mxF30S7Q4VdI=;
        b=AdCFjJuhi02xvAQRYl/WNSj1vpT2x3v/sXX1AezqG6Jyn6TaD8y+ZHDdawUOwIkrVw
         RwRsE1DQIhitZporzaOKwA4Tp9hXTpOufNqLwJ5MCU9KoaQvRUS9hA8MjgEr90e5mjSc
         V4ld35jzyTwn0lOoF07QDPrSY06QTUE4sC8GKpLY58TKEkuL7NuY/iYF7TrG1xO3kY7b
         H1JAmR0EgmHdSa/JXPYdQOr1YC8osRKvb0IEoODZOHiM1PGgdG0btvRamrVfNTOE3UF3
         SixOMz7bGl2N3zx+X7LUyEMH2peyh492VjuhMhgEUqpyrN3mMT9qs4/DVxz85bP/MsVf
         9liQ==
Received: by 10.42.153.10 with SMTP id k10mr1831585icw.24.1330787136262;
        Sat, 03 Mar 2012 07:05:36 -0800 (PST)
Received: from gentoo.cinci.rr.com (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id v3sm3636820igw.6.2012.03.03.07.05.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 07:05:35 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e631bb2059c800f9d49eed51cfa5ba4d04106a2e.1330785363.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192116>

I just realized I'll probably need to resend this one due to stylistic
errors (not using space with loops and if...).

Hopefully if there are no other mistakes I can just send in a purely
cosmetically changed version to Junio.
