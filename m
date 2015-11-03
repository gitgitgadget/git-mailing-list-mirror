From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Tue, 3 Nov 2015 10:07:24 +0100
Message-ID: <20151103090724.GA6354@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-2-git-send-email-k.franke@science-computing.de>
 <xmqqfv0odnoc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtXjq-00083z-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 10:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbbKCJRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 04:17:49 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:54531 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbKCJRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 04:17:45 -0500
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 04:17:45 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 649EE4927;
	Tue,  3 Nov 2015 10:07:25 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7LriOWwF0vGQ; Tue,  3 Nov 2015 10:07:24 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id E2FE842B9;
	Tue,  3 Nov 2015 10:07:24 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id CB709A7964; Tue,  3 Nov 2015 10:07:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqfv0odnoc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280786>

On 2015-11-02 14:46, Junio C Hamano wrote:
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
> > Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> 
> Please add these only when you are doing the final submission,
> sending the same version reviewed by these people after they said
> the patch(es) look good.  To credit others for helping you to polish
> your patch, Helped-by: would be more appropriate.

Sorry about that.

However, may I suggest that Documentation/SubmittingPatches could do with a
little rewording in this respect?

> Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
> "Tested-by:" lines as necessary to credit people who helped your
> patch.

"Helped-by:" isn't even mentioned.

> > +static void init_curl_proxy_auth(CURL *result)
> > +{
> > +	env_override(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
> 
> Shouldn't this also be part of the #if/#endif?

The idea here was to have as little code as possible within the #if/#endif, as a
matter of principle. It may be a little construed in this case, but supposing
there's some subtle bug with env_override, or a future change introduces one,
having it occur only for certain CURL versions would tend to make it harder to
track down.

> and this code would be:
> 
> 	if (remote)
> 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);

Good catch.


Cheers,
Knut
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
