From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC PATCH] commit: Warn about encodings unsupported by iconv.
Date: Tue, 21 Oct 2008 08:17:54 +0200
Message-ID: <20081021061754.GA4656@blimp.localdomain>
References: <1224537918-14024-1-git-send-email-angavrilov@gmail.com> <7vmygy233r.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 08:19:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsAaM-0007V4-Du
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 08:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYJUGSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 02:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbYJUGSB
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 02:18:01 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:36812 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYJUGSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 02:18:00 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE81oFiq
Received: from tigra.home (Fa998.f.strato-dslnet.de [195.4.169.152])
	by post.webmailer.de (fruni mo27) (RZmta 17.14)
	with ESMTP id k00248k9L4O3u9 ; Tue, 21 Oct 2008 08:17:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 871A8277C8;
	Tue, 21 Oct 2008 08:17:54 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4508436D27; Tue, 21 Oct 2008 08:17:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmygy233r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98760>

Junio C Hamano, Tue, Oct 21, 2008 02:39:36 +0200:
> I actually have an alternative approach to suggest.
> 
> How about adding a new i18n.commit-reencode-logmessage option (boolean),
> and when it is set, we actually re-encode from i18n.commitencoding to
> "utf-8" before creating the commit object (and obviously we do not store
> "encoding" header in the resulting commit)?  When the conversion fails, we
> know it failed, so the warning you added does make sense in that context.

Maybe make the option a string, and allow to choose the target
encoding (not only utf8, but anything user wishes)?
