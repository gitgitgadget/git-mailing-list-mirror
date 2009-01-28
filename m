From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and 
	w/o patch on stdin
Date: Wed, 28 Jan 2009 13:26:51 -0500
Message-ID: <76718490901281026i45c26cb0r978f795a50dede19@mail.gmail.com>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
	 <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
	 <76718490901280840g7d36aa96u3d0f98a709ac9fde@mail.gmail.com>
	 <7v3af3thyj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	sverre@rabbelier.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSF98-0000IS-DS
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbZA1S0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZA1S0x
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:26:53 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:32583 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZA1S0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:26:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7068553rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+fo/mhU/64EeCdqrd367Kua1zyJ8VY2bi+eiC6P+Qbo=;
        b=eGiiXuPhfBXXkGZyHpjpSSvmlXK671cMMTxbP8g5xwGr7xogD0kvBnXOCwRnohGudf
         pcr66y1EDEo++Y0CNDgMcQ1pQYV+lUtFKL57fdYZqBqY90D0fToIDbjvtrVpzl8XJ8o/
         qotvVrXwrHdq335OuY1TuyHC9vpRolCuNQJFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vHOBSrDdKgUSZx536Dq168LXpdeX/TH6OWDlK+tmk15j32JiJONcv4ldSCn7GrNlqM
         TFZ8Qb6FlNx5mqPkcYB3z+kA1M6M34E2788gbglglCJqXqRFICKQ5oUTam6jLOxOeiaP
         /xMGvvxZVs1EWoM12VzkW6j7j4QYb+KZ+bK3Q=
Received: by 10.141.194.21 with SMTP id w21mr2682819rvp.230.1233167211311; 
	Wed, 28 Jan 2009 10:26:51 -0800 (PST)
In-Reply-To: <7v3af3thyj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107561>

On Wed, Jan 28, 2009 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Another approach we've taken in other places to avoid the "Huh?" that
> triggered this thread is to do something like:
>
>        if there is no argument
>        then
>                if reading from tty
>                then
>                        echo >&2 "Reading from terminal, waiting for input..."
>                fi
>                process stdin
>        else
>                for arg
>                do
>                        process $arg
>                done
>        fi
>
> Unfortunately, this will invalidate your "check -t 0 and error out" patch,
> but some people may find it easier to work with and more friendly.

Well perhaps we should just deal w/ctrl-c only and ignore the terminal
check altogether.

j.
