From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sun, 4 Nov 2007 11:37:43 +0100
Message-ID: <e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 11:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iocrf-0002tc-Hf
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 11:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbXKDKho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 05:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbXKDKho
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:37:44 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:36174 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbXKDKhn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:37:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1231293rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HCRuaU3hnuHfQjCCpo3xJ4XRkd9wPvAjgWaRlv6XIIQ=;
        b=BWM2UBwbRLER4MV+4L0tP4A8PA0+q9ry9FmAFlgrGOQ0oaoJW6YS9ov/p+REgF7mK2XuJRvjFxMU7oeaKx911aIRfH+y7BJR4rx4t7+mgZoLrl4GU6wmsWXpKzTPvbq9CrhmXGn7Gu7disCYiUf2bI1PL9dW1t+VHlyPbO7MJY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O7qeVWPMyN/CK4vVnBWnXXLY8P4ZasOvuqqIDAvk1liYNIGYCBjP732hJF8XBMoQ40driugWTSau+gWzrKCWgu2aECqM2ebvjCCZJYRQLNh8LpwLSWbamieLq4QJP67TPQXPUlDSa+pPDKkAZkC2N6NVlbyA5Qyd+MFF+VCORyw=
Received: by 10.140.188.10 with SMTP id l10mr1806567rvf.1194172663269;
        Sun, 04 Nov 2007 02:37:43 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 02:37:43 -0800 (PST)
In-Reply-To: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63378>

On 11/4/07, Paul Mackerras <paulus@samba.org> wrote:
>
>      set vnextroot($view) 0
> -    set order "--topo-order"
> +    set order "--early-output=50"

But --early-output does not imply --topo-order, I guess...

I would think you need _both_ in git log:

git log --early-output --topo-order <...remaining stuff...>

Am I missing something?

Marco


P.S: Why did you choose not let git log (i.e. Linus) to handle the
default number of commits?

"--early-output=50" instead of just "--early-output"

I would say, he added this feature mainly for his personal use, so why
don't let him to tweak git-log defaults to his wishes ;-)
