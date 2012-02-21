From: Julian Reschke <julian.reschke@gmx.de>
Subject: Re: HTTP error 511 [Was: Secure (https) proxy authentification]
Date: Tue, 21 Feb 2012 10:28:33 +0100
Message-ID: <4F4363C1.90902@gmx.de>
References: <009e3177ab4b0f3de7ea47fa17118458.squirrel@arekh.dyndns.org>    <689660A9-8EAD-4EE6-8B4D-401E73F13941@bblfish.net>    <4ec05cf797322715a960743aeec0a48b.squirrel@arekh.dyndns.org> <39d91a07ae0beb19a734e52496ab5700.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: squid3@treenet.co.nz, ietf-http-wg@w3.org,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Daniel Stenberg <daniel@haxx.se>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 10:28:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzm1g-0000Go-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab2BUJ2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 04:28:43 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:43822 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752853Ab2BUJ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:28:41 -0500
Received: (qmail invoked by alias); 21 Feb 2012 09:28:39 -0000
Received: from p3EE270E3.dip.t-dialin.net (EHLO [192.168.178.36]) [62.226.112.227]
  by mail.gmx.net (mp001) with SMTP; 21 Feb 2012 10:28:39 +0100
X-Authenticated: #1915285
X-Provags-ID: V01U2FsdGVkX18azykwktcaZz7EvwJEtgRZ7a2s+eISPTARoNvR9U
	BQMa6MLQe2F12k
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <39d91a07ae0beb19a734e52496ab5700.squirrel@arekh.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191147>

On 2012-02-21 09:58, Nicolas Mailhot wrote:
>
> Le Dim 19 f=C3=A9vrier 2012 11:22, Nicolas Mailhot a =C3=A9crit :
>
>> 511 is exactly what I need. I was not aware of it. Is it simplemente=
d in any
>> browser yet? Where should I point the browser writers to get it impl=
emented?
>>
>> http://tools.ietf.org/id/draft-nottingham-http-new-status-04.txt ?
>
> I take that back. 511 is almost exactly what we need. However, when I=
 pointed
> the authors of some of the tools that pass through our proxy to it (c=
url, git)
> they told me they could not parse html code in their tools, so they r=
eally
> need a location (or similar) field containing the address of the
> authentication portal to communicate it to the user. Without this fie=
ld, they
> can only stop with 'Network authentication is needed' instead of 'Ple=
ase open
> <url>  in your browser to proceed'.

Yes. The definition of status code 511 did not attempt to solve more=20
problems than that.

> http://article.gmane.org/gmane.comp.version-control.git/191085
> http://article.gmane.org/gmane.comp.version-control.git/191087
> http://article.gmane.org/gmane.comp.version-control.git/191086
>
> (the nearest thing there is in the spec is the url in meta, but it's =
only in
> the example, not mandatory, and no one will write code for something =
they can
> not be sure will exist)
>
> We'd like to support those tools properly as their users' previous cl=
umsy
> attempts to navigate our current non-standard redirection method resu=
lted in
> internal security investigations.
>
> It is a problem in our setup as we only block some URLs (others are a=
llowed
> transparently without auth), and we use several proxy farms in differ=
ent
> physical sites (to avoid spofs). So just opening any url in a browser=
 won't
> trigger an authentication request (the url may not be blocked, or the=
 browser
> may pass through a gateway where the user IP is already authorized, w=
hile
> git/etc tried to access through another one).
>
> Could you please revise the error 511 definition to add such a field =
?

The specification has already been approved, so it's too late to make=20
more than editorial changes.

Best regards, Julian
