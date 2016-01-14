From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 00/21] refs backend reroll
Date: Thu, 14 Jan 2016 11:25:52 -0500
Organization: Twitter
Message-ID: <1452788752.16226.17.camel@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	 <xmqqbn8qqqfi.fsf@gitster.mtv.corp.google.com>
	 <20160114092614.GA8533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkin-0001dO-O6
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbcANQZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:25:57 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35662 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbcANQZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:25:55 -0500
Received: by mail-qg0-f49.google.com with SMTP id o11so486470937qge.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=9+x3zxhA12+Lr0kazrRHHxFTVP/+v7caekLAP3uGY7Y=;
        b=E6foYLiIFPUdLwno1hLndR9Z4CJ88LQPVZWzZzcbw6pFfJBSNPvoXNMW/8O0cWvbu1
         oSRPDH6LkknedJAnvi4WrjFpYhQBVHP4BJcWfP1VgdFQOLGL0yr2H4gLVb7pdA0ex9z1
         UwGFsfHtZ82baUJHpFV+TcoOsOAjrQBWirOzazfiX/AftQH5Pw7MIueTEg/xeGxENy6A
         tAQ6LaGR2AHeqcTdEpTLwjNylC2XMxnI4zg/vDpZ5sEOV5SXBB28ESDROFZLlvkw9PO1
         FkqkikAX20WYdmA9DqzS1xpUpa2fjIcvpyslXpE5hu++3pCnj+RGKyC2R+W3Qyr4tMLb
         wmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=9+x3zxhA12+Lr0kazrRHHxFTVP/+v7caekLAP3uGY7Y=;
        b=OGLCT9EfFYLQiFJHgLsHOSLi1PXIpZpfWreQ9SOKmJi2DkDpK6ExGw4ykPxXp/Y4Ny
         T57XbCt1Jaw3A9JcP6UzRsFZRixu8a0T0eF64jQ08USvayTr/gdciSjhruUZ6H0JKsIx
         XpcEH5YF09/zXJcqsC+0N1jKoZGL/f6whcd+GoZDPZkf5OIYRgClhsEu/PrpJq2gtQZo
         8rNhVgPmOXEHj+idzGTRdI4DBz31T5Ec+YAJNUQ1sdYHYQUR74zBgI2VnT+6y7ULyNuz
         cVyjZ+CodIQlHcoafHRUKTkjGWbvI5p0ubVhj2gwDSspuvat+UdDymRsKGpUM2SMVL/d
         zNYw==
X-Gm-Message-State: AG10YOR0Tbuapqa4/MnEbzEuTWvvqqgG4d9itbR3bEuLu5Evp+mtc8MP3y8o32NL+KT+1A==
X-Received: by 10.140.224.199 with SMTP id u190mr2773712qhb.33.1452788754614;
        Thu, 14 Jan 2016 08:25:54 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id y127sm2759019qky.4.2016.01.14.08.25.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:25:53 -0800 (PST)
In-Reply-To: <20160114092614.GA8533@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284035>

On Thu, 2016-01-14 at 04:26 -0500, Jeff King wrote:
> On Tue, Jan 12, 2016 at 04:22:09PM -0800, Junio C Hamano wrote:
> 
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > This version incorporates many changes suggested by Michael
> > > Haggerty,
> > > Junio, Jonathan Nieder, Eric Sunshine, and Jeff King. I think I
> > > have
> > > addressed of the comments that were sent to me.  Those that I
> > > chose
> > > not to incorporate, I responded to on the mailing list.
> > > 
> > > Thanks for all of the feed back so far.
> > 
> > Unfortunately this did not compile for me X-< and with a trivial
> > fix-up, I found that this overlaps with Peff's recent fixes to the
> > locking of symbolic refs.  So for today's integration run, I
> > punted.
> > 
> > I still will push out this topic to the broken-out repository I
> > keep
> > here:
> > 
> >     https://github.com/gitster/git
> > 
> > It's just 'pu' will not have this latest incarnation, but has the
> > older one.
> 
> I took a look at David's changes. The conflicts come from "refs:
> resolve symbolic refs first". I'm not sure I fully understand all
> that
> is going on in that patch, but it looks like after it, we are less
> likely to handle ENOTDIR and d/f conflicts for symrefs, as we skip
> that
> whole code path for REF_ISSYMREF.

We only get into the symref part of that codepath if there's already a
symref present, meaning that d/f conflicts can't happen.

> The rest of the conflicts are related to the fact that all of the
> initial resolution is pulled out of lock_ref_sha1_basic(), and the
> caller is supposed to do it. So I think if create_symref() is going
> to
> call lock_ref_sha1_basic(), as in my series, when combined with
> David's
> it should also be calling dereference_symrefs(). That uses a
> ref_transaction, which we don't have in create_symref() right now,
> but
> it makes sense that we would ultimately want to push symref updates
> through the same transaction/backend system.

I don't think that's quite true.  create_symref *always* creates
symrefs, and never creates underlying refs.  So it calls
lock_ref_sha1_basic(), but since type_p is NULL, it doesn't go into the
resolved-symlinks path; instead, we get into the original codepath.

> So sorry, I don't have a quick resolution to this. I'm hoping David
> can
> make more sense of it than I did.

I was totally convinced that we were doomed, but I think the stupid
resolution basically works, with some minor tweaks.  I'm going to re
-review that patch and resend the series (then go out of town until
Tuesday).

We will need to apply your new d/f conflict check to the LMDB backend's
symref code (presently, it fails your new test), but I'm going to punt
on that for now since d/f conflicts don't cause problems for the LMDB
backend and this is a relatively minor case.  I've added a TODO to the
code.
