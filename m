From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] let pack-objects do the writing of unreachable
	objects as loose objects
Date: Wed, 14 May 2008 23:06:10 +0200
Message-ID: <20080514210610.GA11109@steel.home>
References: <alpine.LFD.1.10.0805140132500.23581@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 14 23:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwOCQ-0005TK-2D
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 23:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYENVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 17:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbYENVGQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 17:06:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:61260 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbYENVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 17:06:15 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyzu0g==
Received: from tigra.home (Facc3.f.strato-dslnet.de [195.4.172.195])
	by post.webmailer.de (mrclete mo56) (RZmta 16.34)
	with ESMTP id 501bd5k4EJj2GD ; Wed, 14 May 2008 23:06:11 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4B180277BD;
	Wed, 14 May 2008 23:06:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0B9FF56D28; Wed, 14 May 2008 23:06:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805140132500.23581@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82150>

Nicolas Pitre, Wed, May 14, 2008 07:33:53 +0200:
> @@ -67,7 +68,7 @@ static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
>  
>  static int non_empty;
>  static int reuse_delta = 1, reuse_object = 1;
> -static int keep_unreachable, include_tag;
> +static int keep_unreachable, unpack_unreachable, include_tag;

If the options are incompatible anyway, why not

enum
{
    NO_UNREACHABLE,
    KEEP_UNREACHABLE,
    UNPACK_UNREACHABLE,
};

static int unreachable_handling, include_tag;

?
