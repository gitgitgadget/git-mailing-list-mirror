From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] Infinite loop in git send-email if ran non-interactively.
Date: Wed, 25 Mar 2009 17:23:55 +0100
Message-ID: <vpq4oxh8tb8.fsf@bauges.imag.fr>
References: <vpqiqlyj64o.fsf@bauges.imag.fr>
	<76718490903250904q3ca9f20ak7288e49e226bb9fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVzP-0002NE-CQ
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761800AbZCYQ1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760882AbZCYQ1c
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:27:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:64905 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758145AbZCYQ1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:27:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2PGNtmB001905
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Mar 2009 17:23:56 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LmVtT-00051Q-70; Wed, 25 Mar 2009 17:23:55 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LmVtT-0007Mt-4a; Wed, 25 Mar 2009 17:23:55 +0100
In-Reply-To: <76718490903250904q3ca9f20ak7288e49e226bb9fb@mail.gmail.com> (Jay Soffian's message of "Wed\, 25 Mar 2009 12\:04\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 25 Mar 2009 17:23:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114619>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Mar 25, 2009 at 5:36 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Hi,
>>
>> I've been hit by c1f2aa45b (send-email: add --confirm option and
>> configuration setting) running git send-email from a cron job.
>
> BTW, can you provide the details on how you are invoking send-email?

patches=$(git format-patch [...])
[...]
git send-email --to "$to" --from "$from" $patches

> Have stdin/stdout/stderr been redirected?

stdout and stderr are redirected to a file. stdin is not (I don't know
exactly what cron sets it to).

> What arguments are you giving it? And is this Vixie cron?

The "cron" package in Debian etch (oldstable now).

Thanks,

-- 
Matthieu
