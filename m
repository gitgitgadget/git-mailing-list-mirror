From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 21:27:21 +0700
Message-ID: <fcaeb9bf0711280627h1ac216bbr98dc986b82a54423@mail.gmail.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	 <Pine.LNX.4.64.0711261340470.27959@racer.site>
	 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	 <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	 <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	 <Pine.LNX.4.64.0711281355460.27959@racer.site>
	 <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
	 <85lk8ia1nw.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Benoit Sigoure" <tsuna@lrde.epita.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNt9-0006YB-5q
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbXK1O1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbXK1O1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:27:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:2503 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbXK1O1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:27:23 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1412193nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5TQIoWiv25iOuyF5Q6yRLWgKcQDzbbEQj6vOflzfbLk=;
        b=OuksrO4Lr4mYRKYjGlcyoQCR94l6+zpCNzGUh47GXDVA3ZqYBZeheB+0DNNeotPtsPnOYgoVn7YMn8KQ391WYPTBkOpgzosYWu8aUHpHFGPQth+/+cG8wONDwgM46KVqFUGvLwuCnaJK7kKtI6yFJ96o7L47B/DtGKbxAca0Z1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fv1ajz0ewGihw8qSnOD7L3hXm+NtPJbQDERYRwnqV4igp36Ko4Wnm2C0ZBw3OSziS4w38q47Fm9qFaWPTS9rp2OSwomymvO2nS4UrboziTFGE/PcsRKYBwTToekLM5w3X8kyfQo+LSE9dAk0vdHZP/6VPPUTMb0Ec5wgz6278lg=
Received: by 10.86.76.16 with SMTP id y16mr5007319fga.1196260041733;
        Wed, 28 Nov 2007 06:27:21 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 06:27:21 -0800 (PST)
In-Reply-To: <85lk8ia1nw.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66343>

On Nov 28, 2007 9:24 PM, David Kastrup <dak@gnu.org> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On Nov 28, 2007 8:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> It might be POSIX, but there are shells that do not like the
> >> expression 'export VAR=VAL'.  To be on the safe side, rewrite them
> >> into 'VAR=VAL' and 'export VAR'.
> >
> > Why leave test scripts behind?
>
> Good keyword: how about starting the basic tests by testing for shell
> features that are known and accepted to be used in git?
>
> That way, we get direct feedback when feature assumptions are
> problematic with some shells.

Uh.. I meant there are "export VAL=VAL" usage in test scripts and they
should be fixed as well. Anyway your idea is nice.
-- 
Duy
