From: "Jasper St. Pierre" <jstpierre@mecheye.net>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Fri, 23 Jul 2010 10:25:57 -0400
Message-ID: <AANLkTikRFCmE8BeB6G107cz6ZPxWtq=j-PmmX59pR5zj@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch> <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 16:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJCj-0003pk-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 16:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab0GWO0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 10:26:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64181 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab0GWO0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 10:26:18 -0400
Received: by wyf19 with SMTP id 19so258524wyf.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 07:26:17 -0700 (PDT)
Received: by 10.216.177.140 with SMTP id d12mr3626951wem.37.1279895177290; 
	Fri, 23 Jul 2010 07:26:17 -0700 (PDT)
Received: by 10.216.79.68 with HTTP; Fri, 23 Jul 2010 07:25:57 -0700 (PDT)
In-Reply-To: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151534>

Yep. http://www.ietf.org/rfc/rfc2396.txt defines '+' as a reserved char=
acter,
but doesn't give a purpose for it. www-form-encoded replaces space with=
 '+'
but in a URL it can mean anything it wants.

On Fri, Jul 23, 2010 at 10:10 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Jul 23, 2010 at 13:18, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>
>> doesn't say much about + and the only escaping defined is the usual
>> %xx style. =A0So is there a standard that mandates this, or was it j=
ust
>> a well-meaning but unnecessary backwards incompatible change?
>
> + and %20 are as far as I know only interchangable in *query strings*=
,
> so having to clone 'git://git.gnome.org/gtk%2B' where you could
> previously clone 'git://git.gnome.org/gtk+' is a bug. Git shouldn't b=
e
> changing that + to a %20.
>
> I haven't followed why we need to escape + to %20 at all, even in the
> query string. E.g. curl(1) doesn't do that before sending requests to
> Apache, which can handle either one. The + v.s. %20 duality is always
> handled at the server AFAIK.
>
