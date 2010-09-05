From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH/RFC] Restructure some of the checkout opts.
Date: Sun, 5 Sep 2010 08:54:14 -0400
Message-ID: <20100905125414.GA3230@localhost.localdomain>
References: <9f6f4947af20df9dc0ebd8915dcdb9b5f756d35d.1283688482.git.jaredhance@gmail.com>
 <4C838BE9.5000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 14:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsEjp-0000nX-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 14:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0IEMyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 08:54:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43412 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0IEMyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 08:54:20 -0400
Received: by qwh6 with SMTP id 6so3180799qwh.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R1Jxo1jtKLUfUi1uv8maP85NAV5KItmq7vcBMyOTyLU=;
        b=XnNfGvXZ99Uh2FaQFgGIBXGXfV47N4oGdUNasLo/FqXAZ19n4ioeVyOanNDXANokwK
         ES1N7QHQDAqW9lwpzn/enrG02yf65GFNt9rg15l7UCI/3NlOdMVSsihJYwHuLV4vnME8
         Rq0xSJfMR8krFUAMHOZua/zui6pIOL26lgQk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=boGBtjhkkzsfp6UJt9ZKjmULqiaul6o9WLUr8G6VmTFhxkN2jgrh86wgmaqeCFROeP
         lkV80P9FF1bevaEXdFVarAeL4axHspXAn6L1e46atpbHqA1aqTXoJ+gJbh3EUXkvTbhl
         TmgG7pB3Z9tX20/8XbZAj0jzsy85nIQYPiG1I=
Received: by 10.229.237.130 with SMTP id ko2mr2539615qcb.121.1283691259364;
        Sun, 05 Sep 2010 05:54:19 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-213-29.cinci.res.rr.com [174.101.213.29])
        by mx.google.com with ESMTPS id r1sm4402321qcq.34.2010.09.05.05.54.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 05:54:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C838BE9.5000006@web.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155454>

On Sun, Sep 05, 2010 at 02:24:09PM +0200, Jens Lehmann wrote:
> Am 05.09.2010 14:09, schrieb Jared Hance:
> > Previously, most opts in `builtin.checkout.c' had been an instance of
> > `struct checkout_opts'. It appears that some of the opts that were
> > perhaps added later were not in the struct. Move them into the struct
> > in order to maintain consistency.
> 
> Hm, they aren't used outside of cmd_checkout() (as the other members
> are), so maybe it is ok that they aren't in the struct?

I guessed that this was the reason that they were overlooked, but it
seemed a little odd that every other opt was stored in the struct and
it just seemed to be more consistent to have _everything_ in the
struct.

It also makes it more clear that they opts, whereas before, you might
think they weren't at a first glance because they weren't in the
struct like the others.

I'll leave this to you guys to decide what to do with it.
