From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 00/11] refs backend pre-vtable
Date: Mon, 09 Nov 2015 16:28:21 -0500
Organization: Twitter
Message-ID: <1447104501.20147.3.camel@twopensource.com>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:28:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvtzP-0003AJ-7a
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 22:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbKIV2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 16:28:25 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36426 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbbKIV2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 16:28:24 -0500
Received: by qgad10 with SMTP id d10so156128728qga.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 13:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=edGmoPSs/WUSQfbB9QXJ8cnJPphdG9JppGhjmNPMeEQ=;
        b=D6h2dGn3zqb6RfpIb4VdqrY1ageKbjjSNGSaSi8hQVB5LiIEO1oTm/OeUmgEncL158
         Yb1mZ9Y/Kb2RD4k3Z65lfEszcknGNgA1VJB9+0MIJO8Los51Z6E9/M53ljmckqXcPs9D
         UTiXdodkL+vxuPdoXyK0Ao1FslPLnNt1l9RJCYbGqdBemWELoTA/1rTeB5yBtgNxtySv
         sT9Lc930709eH3c/Y0+vXd9EOJhZrQCO53/idwYiRn2aV/9bbbmaOkQeEZI8qc6bIjRb
         /ml/p5R4sr5T0YmadS2UdLyVmoi+QmDMR6JPnmGnLxKJh1gGSK9+2xRdh+DmP//956lw
         6AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=edGmoPSs/WUSQfbB9QXJ8cnJPphdG9JppGhjmNPMeEQ=;
        b=K+OD6LICaXlnOP7x9XJm3opwGEgEqFuFxKDqIQxlDU6H+K0gCdy+R6KAWwL7QZXEkR
         vd2sIdt3kfEvIHTux2LItI5Rjdz+N8KeDmcLa5cvKNt/thuTAXv+Wv8zgrLRGkSIHSAB
         26pZD6FYyEa+T88/tqi0PUfsJayQFjwD9m/uWNgtV/jr6pI8q0kVF6FO9nQ2TeoMl1Z3
         b128LIK2lPZLTrpsIbsF14zzMSff0PFjwltzy8EN8pN0IuRhnMMSlDYoLy9rVKaiHPjp
         TM5LZ7J/UczHnqoS7iqBi++9kAGnAN0CnoGWkljseSX2dlfnmeRiUkyH5DcOauWHr6f0
         QKXw==
X-Gm-Message-State: ALoCoQnvQ9ks/5Yb/6cg05FeQgQ1D48TQLCTYyArk7eE7J/NYuGwjg3aOYCSPDEJXviiwcaz2M0N
X-Received: by 10.140.98.182 with SMTP id o51mr89476qge.2.1447104503001;
        Mon, 09 Nov 2015 13:28:23 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 138sm5652244qhp.26.2015.11.09.13.28.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 13:28:22 -0800 (PST)
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281084>

On Mon, 2015-11-09 at 18:03 +0100, Michael Haggerty wrote:
> This is another reroll of the pre-vtable part of the refs-backend
> patch series dt/refs-backend-pre-vtable. v6 [1] proved cumbersome
> because it conflicted messily with lf/ref-is-hidden-namespace [2]. The
> conflicts were partly due to the motion of code across files but, even
> worse, due to the change of order of function definitions between old
> and new files.
>
> So I have heavily "optimized" this reroll for reviewability and to
> minimize conflicts with other work in the area. The only such work
> that I know of is lf/ref-is-hidden-namespace, which can now be merged
> with this series *without conflicts*.

Modulo Ramsey's comments, this works for me.  AIUI, Ronnie's original
patchset was written the way it was to avoid merge conflicts.  Because
of the changes in the interim, it turns out not to quite work that way.
So it's totally OK with me to write it this new way.
