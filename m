From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] technical-docs: document tree-walking API
Date: Mon, 03 Aug 2009 23:00:59 -0700
Message-ID: <4A77CE9B.2060102@gmail.com>
References: <1249359201-7672-1-git-send-email-bebarino@gmail.com> <7v4oso87fy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYD5K-0003oR-6B
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbZHDGA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbZHDGA6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:00:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:24546 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbZHDGA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:00:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so664361rvb.5
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=btpHMqctr19OYoNsJXptvDfGJtoQuY6gr/S1jYCxTt0=;
        b=x8z0eNwrkuPLk7K3w+anFanM2Hfgce7seDoHxVGQvygGO4LJaeeILCmh+AM2Ky54Kk
         oAG0AjxvGk16UxGnDLWtNQayuAHFsp7m4xEUkpBRSZxGAdDNFBDbZuPIGj27rm1SlFdt
         IkeLviPbqGrnYnvvk9Bgv7cbywlnfF+vT/3Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=HosPIQI0zeQiqFPrMCLV3qS6qRWTCfD1g0W+DlFVYJmFHKT0Gdz2JohQd3UC+1Xfr0
         aq9QcDdO34jWu4Zcfa6JrVkccOs8irnA1kUzwVMImvZuqzquKeVZorySh0n4Ptv0xiiw
         vck9MfbwCTaf/C5xXa/LqZKWn4QAUhvWTuO4s=
Received: by 10.140.165.21 with SMTP id n21mr4767994rve.237.1249365658721;
        Mon, 03 Aug 2009 23:00:58 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id l31sm286068rvb.4.2009.08.03.23.00.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 23:00:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090801)
In-Reply-To: <7v4oso87fy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124751>

Junio C Hamano wrote:
> I think the primary author is Linus for this API, but once you finished
> the documentation, I do not think "authors" section is particularly
> needed (git knows who the code came from reasonably well anyway).  The
> names of people in these stub documents were there for people like you;
> see 530e741 (Start preparing the API documents., 2007-11-24).

I'm ok with dropping the Authors section then.

>
> It might be a bit misleading to say that the path member of struct
> name_entry is a "pathname".  It is _one_ path component, and by stringing
> multiple struct traverse_info's (each of which has one struct name_entry)
> together with their prev pointer, make_traverse_path() can reconstruct the
> full pathname from the toplevel down to the level you have traversed into.
> We may want to say "path component" to clarify the distinction.

This sounds reasonable for the traversing section. I'm a bit confused
about how it would work for the walking section though. I don't get the
notion of path components there because the API is focused around one
level of a tree. Maybe it should just be called the entry's name in that
case?
