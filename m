From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge"
 during a merge
Date: Wed, 26 Feb 2014 12:48:43 -0800
Message-ID: <20140226204843.GN7855@google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
 <1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
 <vpq8usxenul.fsf@anie.imag.fr>
 <CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlPT-00063m-3u
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbaBZUsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:48:50 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42877 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbaBZUsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:48:50 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so1493822pab.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8GVzBUOBbpP738yuFhdcGlQzCXYje6/PEkpPN3K9VYA=;
        b=arIGCVixJFe1AejaHEAySxPKAhreMfqiT5N5jyRBxcVLnPtf4dKtCBKTGCmYwrE77b
         AHz2ncXAmYaoZPHgqWE8bHbYmxygtwNczvmeI03Npekf4QqBRePc0ylmBMY/dBuMamLs
         FvuAED1B61eb4fmG8K2JRrugExSzZ3aMIcMu707CXXQjl9w7S8RW+4sCRdDMJ1TfjeEg
         knKDGv/IUL/JD0BKvznNVz9YKss83O5Mur/pkgEnUA+GoG2jUcg5k5uoN80fEX7kwFX+
         0ib25uyBccYuAx90my/nRs4fCmPETk4EoRHAaPvxfwbADiFO815tAAdSYLaGDIiYn7pu
         TZXQ==
X-Received: by 10.68.221.42 with SMTP id qb10mr9032891pbc.65.1393447729660;
        Wed, 26 Feb 2014 12:48:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sx8sm14421825pab.5.2014.02.26.12.48.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 12:48:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242765>

Andrew Wong wrote:

> Yeah, this breaks compatibility, but like I said, during a merge, I don't
> see a good reason to do "git reset --mixed", and not "git reset --merge".

Yeah, in principle if it had a different behavior, then plain "git
reset" could be useful during a merge, but as is, I tend to use the
form with a path ("git reset -- .") to avoid losing MERGE_HEAD.

I really don't like the idea of making "git reset" modal, though.  I'd
rather that reset --mixed print some advice about how to recover from
the mistake, which would also have the advantage of allowing scripts
that for whatever reason used "git reset" in this situation to
continue to work.

Thanks,
Jonathan
