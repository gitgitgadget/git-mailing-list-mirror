From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Wed, 8 Jun 2016 10:21:33 -0400
Message-ID: <20160608142132.GA32299@LykOS.localdomain>
References: <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net>
 <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
 <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
 <20160607221325.GA21166@sigill.intra.peff.net>
 <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
 <20160607222908.GA25631@sigill.intra.peff.net>
 <CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAeMW-000723-Im
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 16:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423730AbcFHOVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 10:21:36 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34082 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423546AbcFHOVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 10:21:35 -0400
Received: by mail-qk0-f171.google.com with SMTP id s186so4789742qkc.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oCKGQcojoSZC85KyWTIRaml16AsZv/leywDYMiOUl4Q=;
        b=FSplGcs4xS3PC/3SVqY2ufWGlHCU9S7lP3sN+1/6IB1FkJiO/bSuvxw1PEQgzpbW6F
         yRxWCX/z0jLUoadBQvJWtzcqJaKlokhSsdEaObCimeC1rUqr4qtc5ypwTaKMqGMJiq9X
         GidtXHwE06nj4UJBkTWfMCTKmm0qOheLt8m0Sk9fcNddCOVp9UaM6hmY4dDGiC3GchfI
         T/Y7CIfqBFG/rnwYvwxOh/P0MFMb6h2dsKVenEUv6UyxHHRvgcAYYzluETnveB955UiO
         wPHLZ/4i5XjJRdugNgcjs+tqQSrwnoU90fOuqlU4FBg+70URfbO5leh0wilcGqyYt/Y9
         YShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oCKGQcojoSZC85KyWTIRaml16AsZv/leywDYMiOUl4Q=;
        b=CNAGLHO0eyGoTcM0+sMDwSmdWgwhzlrLJct3isJucNNFrxPGRrSFQ4yKXpTiFpt+r3
         /MZykrbbleoLz9dNxVd1H3ZTQHlZZaQDGjo//tc4KKRlN9n0jG3atBD+uV8+i/vMXWt2
         6X6oyIGwFVd+2lIWwj5WczskQdWzUmBelqMKFv7X98WZSklk+al5XtFYgqjJolzUmaLF
         lPghyZPCRf1O5TKnPHnC9lO7PXQC++MJqeLRh63TKHewGSoZSA8/uhPkEMHaL9HL9ah6
         KPKpoIQ9NYLWae9oMa57zFUfb4C17TgU6aQ/Vdy9RIg6vUKBDzVzRzuONHZWuf4aI58/
         lFsA==
X-Gm-Message-State: ALyK8tKh+xo2LHUENBR3UgodvaIbJKk2Q5QfcU1iapBF5QHb31HR+Zd6++qpD0AokcJf7886
X-Received: by 10.55.101.68 with SMTP id z65mr5102598qkb.80.1465395694170;
        Wed, 08 Jun 2016 07:21:34 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id l206sm338509qhc.48.2016.06.08.07.21.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2016 07:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296799>

On Tue, Jun 07, 2016 at 03:35:07PM -0700, Junio C Hamano wrote:
> On Tue, Jun 7, 2016 at 3:29 PM, Jeff King <peff@peff.net> wrote:
> > or even:
> >
> >   git tag --show-tag-name foo/v1.0
> >
> > when refs/remotes/foo/v1.0 exists?
> >
> > The rule right now is generally that "git tag" takes actual tag names.
> 
> Ahh, I forgot about that. Yes, indeed the command does not work
> like other Git commands, which would just let generic revision parser
> to accept an object name from anywhere. Probably it was a mistake,
> because "git tag --verify $T" may find refs/tags/$T but that may not
> necessarily mean "git checkout $T^0" would give you that exact
> tree state, but it is too late to change now.
> 

Sorry I'm trying to follow this. Would it be best to then have

    verify-tag [--check-name=tagname] (tag-ref|tag-name|sha1)?

and

    tag -v [--check-name] (tag-name)

Or would --format still work better?

Thanks!
-Santiago.
