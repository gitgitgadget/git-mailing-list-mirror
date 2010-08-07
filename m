From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Fri, 6 Aug 2010 17:18:29 -0700
Message-ID: <20100807001829.GQ25268@spearce.org>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com> <AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com> <AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com> <AANLkTingdhx5osnbiLVMyWaauCf1TRiMzcSC76gQRp9B@mail.gmail.com> <AANLkTimEFjRuuO+GnAV7PGe0oPi-Qh37iLS6o3Q8Undw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhX7W-0003Kx-KV
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0HGASe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 20:18:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64874 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab0HGASc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 20:18:32 -0400
Received: by pvg2 with SMTP id 2so157674pvg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:18:32 -0700 (PDT)
Received: by 10.114.12.14 with SMTP id 14mr14774665wal.23.1281140312454;
        Fri, 06 Aug 2010 17:18:32 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id n32sm3831156wag.23.2010.08.06.17.18.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 17:18:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimEFjRuuO+GnAV7PGe0oPi-Qh37iLS6o3Q8Undw@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152830>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> 
> Ah, by packing it tighter using bitfields. There are two fields that
> act as boolean, but they use at least one byte each. And enum
> object_type, I recall, uses 4 bytes (int), while it only needs 5 bits
> (4 bits is enough if OBJ_BAD is not counted). No downsides I know of.

Actually, object type is 3 bits in the pack file.  So unless its
using some additional magical values, 4 bits is sufficient to get
you 3 bits and the -1 bad value.

-- 
Shawn.
