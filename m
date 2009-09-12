From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv6 10/14] Teach notes code to free its internal data
 structures on request.
Date: Sun, 13 Sep 2009 00:21:38 +0200
Message-ID: <200909130021.38296.johan@herland.net>
References: <200909121752.07523.johan@herland.net>
 <1252771728-27206-11-git-send-email-johan@herland.net>
 <7vmy50f1mf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:25:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmb2E-0001df-SV
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZILWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbZILWVj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:21:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57597 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751770AbZILWVi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 18:21:38 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003C1Q45ZG80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 00:21:41 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0060KQ42IV30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 00:21:41 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.12.220923
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <7vmy50f1mf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128303>

On Saturday 12 September 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > There's no need to be rude to memory-concious callers...
> 
> Will squash this in.
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Sat, 12 Sep 2009 11:34:24 -0700
> Subject: [PATCH] notes.[ch] fixup: avoid old-style declaration
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  notes.c |    2 +-
>  notes.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/notes.c b/notes.c
> index 008c3d4..9ed2c87 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -161,7 +161,7 @@ void get_commit_notes(const struct commit *commit,
>  struct strbuf *sb, free(msg);
>  }
> 
> -void free_commit_notes()
> +void free_commit_notes(void)
>  {
>  	free(hash_map.entries);
>  	memset(&hash_map, 0, sizeof(struct hash_map));
> diff --git a/notes.h b/notes.h
> index 41802e5..d1dd1d1 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -7,6 +7,6 @@
>  void get_commit_notes(const struct commit *commit, struct strbuf *sb,
>  		const char *output_encoding, int flags);
> 
> -void free_commit_notes();
> +void free_commit_notes(void);
> 
>  #endif

Thanks,

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
