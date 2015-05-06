From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: remove credential helpers from porcelain
 commands
Date: Wed, 06 May 2015 12:26:42 +0200
Message-ID: <20150506122642.Horde.JpisdKtEAos7MJrZqzdelw4@webmail.informatik.kit.edu>
References: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
 <20150505200607.GB12067@peff.net>
 <xmqqzj5id7v7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 12:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpwXb-0006Pf-8b
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 12:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbbEFK0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 06:26:55 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55439 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbbEFK0v convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 May 2015 06:26:51 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YpwXN-0002fm-SF; Wed, 06 May 2015 12:26:45 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YpwXK-0005MF-Gf; Wed, 06 May 2015 12:26:42 +0200
Received: from x590c4d6e.dyn.telefonica.de (x590c4d6e.dyn.telefonica.de
 [89.12.77.110]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 06 May 2015 12:26:42 +0200
In-Reply-To: <xmqqzj5id7v7.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1430908005.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268465>


Quoting Junio C Hamano <gitster@pobox.com>:

> Jeff King <peff@peff.net> writes:
>
>>> However, if you think filtering out 'credential-*' is the way to go=
, I'm
>>> happy to reroll.
>>
>> I'd actually be fine with just marking all credential-* as "credenti=
als
>> helper". I think we have staked out the "git-credential-foo" namespa=
ce,
>> so anybody putting something unrelated in there deserves what they g=
et.
>> And it makes one fewer list to keep up to date.
>>
>> I _do_ have other git-credential-foo's that should be ignored (and a=
re
>> not in your list), but I am probably the only person in the world (t=
hey
>> are due to me experimenting with the credential helper code :) ).
>
> Let's do this on top of the "typofix helper" one, as there was
> another show-stopper typo.  I could also amend the log message
> and declare that we now squat on git-credential-<anything>, but
> I do not think it is necessary.
>
> diff --git a/contrib/completion/git-completion.bash =20
> b/contrib/completion/git-completion.bash
> index fdf0ddc..af78212 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -665,13 +665,8 @@ __git_list_porcelain_commands ()
>  		checkout-index)   : plumbing;;
>  		commit-tree)      : plumbing;;
>  		count-objects)    : infrequent;;
> -		credential        : credentials;;
> -		credential-cache) : credentials helper;;
> -		credential-gnome-keyring) : credentials helper;;
> -		credential-netrc) : credentials helper;;
> -		credential-osxkeychain) : credentials helper;;
> -		credential-store) : credentials helper;;
> -		credential-wincred) : credentials helper;;
> +		credential)       : credentials;;
> +		credential-*)     : credentials helper;;
>  		cvsexportcommit)  : export;;
>  		cvsimport)        : import;;
>  		cvsserver)        : daemon;;

Yeah, that's it.

Best,
G=C3=A1bor
