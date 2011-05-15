From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Sun, 15 May 2011 15:07:17 -0700
Message-ID: <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 00:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLjTS-0002eo-Mb
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 00:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab1EOWHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 18:07:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56817 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1EOWHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 18:07:37 -0400
Received: by vws1 with SMTP id 1so2777351vws.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 15:07:37 -0700 (PDT)
Received: by 10.52.179.67 with SMTP id de3mr2511570vdc.153.1305497257065; Sun,
 15 May 2011 15:07:37 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 15:07:17 -0700 (PDT)
In-Reply-To: <1305495440-30836-5-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173679>

On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
> The new --max-object-count option behaves similarly to --max-pack-size,
> except that the decision to split packs is determined by the number of
> objects in the pack, and not by the size of the pack.

Like my note about pack size for this case... I think doing this
during writing is too late. We should be aborting the counting phase
if the output pack is to stdout and we are going to exceed this limit.

-- 
Shawn.
