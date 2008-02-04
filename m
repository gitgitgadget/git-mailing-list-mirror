From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 03/11] Use new compress helpers in fast-import
Date: Sun, 3 Feb 2008 20:41:20 -0500
Message-ID: <20080204014120.GF24004@spearce.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com> <1201952156-6764-2-git-send-email-mcostalba@gmail.com> <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 02:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqLR-0003Cr-4K
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbYBDBl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbYBDBl3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:41:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55978 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbYBDBl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:41:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqKh-0001A7-2V; Sun, 03 Feb 2008 20:41:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ADC1C20FBAE; Sun,  3 Feb 2008 20:41:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72446>

Marco Costalba <mcostalba@gmail.com> wrote:
> diff --git a/fast-import.c b/fast-import.c
> index a523b17..b6bb84c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -997,13 +998,13 @@ static int store_object(
>  	unsigned char *sha1out,
>  	uintmax_t mark)
>  {
> -	void *out, *delta;
> +	unsigned char *out, *delta;
>  	struct object_entry *e;
>  	unsigned char hdr[96];
>  	unsigned char sha1[20];
>  	unsigned long hdrlen, deltalen;
>  	SHA_CTX c;
> -	z_stream s;
> +	int out_size;

This really should be a size_t, shouldn't it?
  
-- 
Shawn.
