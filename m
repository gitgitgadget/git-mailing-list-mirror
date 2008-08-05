From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [Q] Finding the commit that removed a symbol?
Date: Tue, 5 Aug 2008 12:47:35 +0100
Message-ID: <57518fd10808050447h2df6da07vb001ed8862076992@mail.gmail.com>
References: <200808051343.07370.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 13:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQL1q-0000MD-8X
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 13:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477AbYHELrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 07:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757937AbYHELrh
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 07:47:37 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:22911 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbYHELrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 07:47:36 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1429075ywe.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kMH9vMHgzZIyKy4xZnAAT1pwhNEp4iN/dHDsrRRKG60=;
        b=WJuE7B7wyIWUK+iqZZQm+4NZaFtRBn/IHxrtanfTc/LjP5FJMq7xyBN3QKL2oYevD9
         meWLNZroA8vPl/nmVtNfHwtArtzjG43M3hyUuRG+5doQ7bU4E2u5EMj598Gz8EVs+MBO
         p7gc2wSQgfMw0jTym/2KqQXv/6NIARY/x/xFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=hd68u1NaJcesxRooC3yoFIp7RO8iOZW93iaoqqwbzPFmWKD7uq0HIgSB7R0h9nIb5O
         0+QG7QRxV1Go81ZpM6Ow5LnQpxD66DGZgOTUcoql/ed5GbiuSw0J8466yusDbN56Cj/9
         TGyb9bRtroiC2Db9w2qbiYG5COCkCWmBw1Ebg=
Received: by 10.151.48.15 with SMTP id a15mr1298426ybk.58.1217936855303;
        Tue, 05 Aug 2008 04:47:35 -0700 (PDT)
Received: by 10.150.229.10 with HTTP; Tue, 5 Aug 2008 04:47:35 -0700 (PDT)
In-Reply-To: <200808051343.07370.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: c1497af30b0ceccd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91437>

On Tue, Aug 5, 2008 at 12:43 PM, Brian Foster
<brian.foster@innova-card.com> wrote:
>
>  I'm a bit puzzled as to how to do find a commit which
>  removed a symbol.  This is not a 'bisect' per se (or at
>  least I don't think it is ?); I know exactly what I am
>  looking for, but am not quite sure how to find it.
>
>  I know that between tags A (older) and B (younger)
>  a certain symbol S, defined in file F, vanished.
>  A:F has S; B:F does not.  (There are many commits
>  affecting F between A and B, albeit most don't involve
>  S per se.)  S isn't mentioned in any commit comments,
>  else I could search the output of:   git log A..B -- F
>
>  Actually, using gitk(1) =97 gitk A..B -- F =97 I've found
>  what I'm looking for, so I guess what I'm now wondering
>  is if there's a better/easier/faster(/non-GUI ?) way of
>  doing this?   (My git-newbie-ness may be showing here!)
>

You probably want git log -S'MySymbol'
