From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: [PATCH] Add an "-i" option to git-reset, to confirm a reset.
Date: Sun, 16 Dec 2007 13:26:53 -0800
Message-ID: <94ccbe710712161326q7360d910ld9442e73630d46af@mail.gmail.com>
References: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
	 <Pine.LNX.4.64.0712160332140.27959@racer.site>
	 <94ccbe710712151946u22f02a8fkbc3c4cbc96ee22f5@mail.gmail.com>
	 <7vwsrejta3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:27:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J411V-0004Lu-BA
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760697AbXLPV0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 16:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760701AbXLPV0z
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:26:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:2305 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760697AbXLPV0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 16:26:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2892063wah.23
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EMC+GNvwoNhf2juVM+xl2Mph9OPzLUOAcUBtOVrltxY=;
        b=inGqGn77HUr6Dh2BThi8oBG6l6ZsXGnkUYlNQ+XnHtblCE2tJvgCr4O3PImul88RVDjZZXPpPUJT6hgroMbOEX91o1dXl6ikLXOUKljIz/J+ibcA8rqBfqxZEFCj80axL4nbNnjFhzOwPfJHdG/9M6vV/zb/PveJqpH0c/L4B28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jTBqiG2zpvMBK+XbIAIghwyeoMBSFfJA9kD3eIRhFV/2DtK5bjmxJoyPcwvRNjUqiVcG/Uzk3nRqjaQnckUroV79werYbKPq7woMNgryFxR0MlB4VjQkbUSn08+edo3qyNSVmHnY37QnY5eBtdcinFOh7x1NK3GUqZG4Lnb7Ov0=
Received: by 10.115.47.1 with SMTP id z1mr1877599waj.117.1197840413621;
        Sun, 16 Dec 2007 13:26:53 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Sun, 16 Dec 2007 13:26:53 -0800 (PST)
In-Reply-To: <7vwsrejta3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 9e31d4483e40201e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68492>

On Dec 16, 2007 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Kelvie Wong" <kelvie@ieee.org> writes:
>
> > On Dec 15, 2007 7:35 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > ..
> >> I am slightly negative on this patch.  Not only do I think that it is both
> >> easier and more natural to run diff/status/an-alias to see what a reset
> >> would do, but the patch only handles the index_file part (missing the --
> >> <file> part AFAICT).
>
> I am in principle very negative on additional option that does the same
> thing as what the users on odd occasions can run a separate command
> themselves to achieve, and I think "reset -i" falls into that category.
>
> And I am negative on this "-i" not just because I think that would be
> only in "odd occasions" (i.e. rare), but because I think it would not
> help much.  Either you are sure about resetting, in which case you would
> not even use "-i" option (and not get this safety), or you are unsure,
> in which case you can do "git status" or whatever commands that are
> already available.
>
> > w.r.t. the style, you were referring to just the array initializers
> > right?  Or was there something else I did that doesn't look right?
>
> I spotted only two classes.
>
> +
> +       /* Show the user what is about to be reset, and in more detail, if they
> +        * like. */
>
>         /*
>          * Show the user what is about to be reset, and in more detail,
>          * if they like.
>          */
>
> +       if(confirm_reset) {
>
>         if (confirm_reset) {
>

I guess this is just for people like me who are used to the "M-x
vc-revert" function in emacs, which shows you exactly what changes get
reverted before doing so.

But I guess it is quite trivial to make an alias to do the same when
invoking git-reset (or checkout) directly.

-- 
Kelvie Wong
