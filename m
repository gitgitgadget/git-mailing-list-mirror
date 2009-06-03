From: Ben Willard <benwillard@gmail.com>
Subject: Re: [PATCH 2/2] blame: Fix corner case when a directory becomes a
	file
Date: Wed, 3 Jun 2009 08:40:45 -0400
Message-ID: <20090603124045.GB3151@ben-laptop>
References: <cover.1243969358.git.benwillard@gmail.com> <4a257d91.0407560a.04d2.ffffe775@mx.google.com> <7vr5y1bw4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 14:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBpm4-0007ej-VL
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 14:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZFCMkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 08:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZFCMks
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 08:40:48 -0400
Received: from mail-qy0-f104.google.com ([209.85.221.104]:51820 "EHLO
	mail-qy0-f104.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbZFCMks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 08:40:48 -0400
Received: by qyk2 with SMTP id 2so1799547qyk.33
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uFSZH9k+871QGgQwkQa+BoQ270Pp0USwXxkEtl4NESU=;
        b=kgWNsua2k3y0jnxfDSB0i4Ca9JeONMgEwEESseILc0WMPByydJCO7+JjUKJmDzqH76
         PhKXdSnSIgclxWYjGNWdLAR3MWucUv9PxsQpEgrcySDNwWqOCo78so1/Hi7WiGCE84BQ
         9U6EjvD8ANKszIpoyKZPRoRMorPigPE1QU1E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sU17ml8XjiSBUkuXtlid3HUH5VZxBcHYf0maVimI3U2+eK8Qmiy9oHK4dVbQLKkhgY
         G42S3ZiMtQDT9M84u9bUBV/DNyAkoHhjVIxKWW0hVSr0qOIU7ijLmP6R92sxopv/wITi
         MqC3IMGNlpD6YsMNKn3jCRXZArs/9zQ5q52bw=
Received: by 10.224.37.134 with SMTP id x6mr874149qad.154.1244032849037;
        Wed, 03 Jun 2009 05:40:49 -0700 (PDT)
Received: from ben-laptop (rn--cgr-1-1-a38.uwaterloo.ca [129.97.253.234])
        by mx.google.com with ESMTPS id 7sm1802755qwf.5.2009.06.03.05.40.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 05:40:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr5y1bw4l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120607>

On Wed, Jun 03, 2009 at 12:43:22AM -0700, Junio C Hamano wrote:
> Thanks.
> 
> Your problem analysis is almost correct but the solution is wrong.

Ah, I guess it was more complicated than I thought.

> By the way, I'd rather not see people waste a whole _new_ test script when
> there are existing test scripts availble for the command.

I'll remember that for next time.

> -- >8 --
> Subject: [PATCH] blame: correctly handle a path that used to be a directory
> ...

I tested this patch and it works.

Thanks Junio,
--
Ben
