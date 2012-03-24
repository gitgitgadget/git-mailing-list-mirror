From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sat, 24 Mar 2012 14:17:09 +0100
Message-ID: <201203241417.10478.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 14:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBQqs-00076V-LA
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 14:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab2CXNRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 09:17:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41622 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab2CXNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 09:17:15 -0400
Received: by wibhj6 with SMTP id hj6so2874764wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iKns/K/BeuLTt9cZxKLMo5lsHaSqm3PaVCinA6DI/O8=;
        b=WFZnn5Q99OL1sMPm8vu/+0o0sLLp+rH+9xar095SWwPQV8juRNDZXCO+fSEuyQ1uAb
         akWeTsvhO2gmUI0bzcC+14lCF611sTT8M7yyxIa+aUg7LAuqiOsIyH9z6T2jKALC+SwU
         uK960/j/opH+XiUqQJMQDveQw9cErFL4eRDEr8qncfZmqTNBSFOitQf/vBZOJjwYxlcb
         d6WY3bn6ZNah3rkY5KHzkGd3ZYoFry5G3lg9BNUzlDdyHkMHGhd8fuz/iZ+R5zhXv10i
         r0ihoLOcKwIzIirKbQ2/X8H1gbeF4zoq/4w1t0MMbso/7ASCsw/iIUFsRhhd6OOq0TuF
         vy2Q==
Received: by 10.180.104.137 with SMTP id ge9mr4843221wib.20.1332595033713;
        Sat, 24 Mar 2012 06:17:13 -0700 (PDT)
Received: from [192.168.1.13] (epw177.neoplus.adsl.tpnet.pl. [83.20.64.177])
        by mx.google.com with ESMTPS id fl2sm37588457wib.4.2012.03.24.06.17.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 06:17:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193826>

On Sat, 24 Mar 2012, Chaitanyaa Nalla wrote:

> Hello everyone,
>=20
> =A0I am Chaitanya Nalla, a final year undergraduate student from Indi=
a and I
> am pretty much interested in doing the project "Adding javascript lib=
rary /
> framework in gitweb" suggested by respected Jakub.  I have good exper=
ience
> in javascript libraries like jQuery, Dojo etc. As per the goals of th=
e
> project I will use the efficient, concise, cross browser compatible
> frameworks where ever needed.

JavaScript library / framework is required not only to cover difference=
s
between web browsers in DOM manipulation, event handling and Ajax with
XmlHttpRequest, but also add features which are still[1] lacking from
JavaScript such as handling cookies, formatting strings, date manipulat=
ion,
etc.

Currently gitweb uses hand-crafted micro-library in `gitweb/static/js/l=
ib/`
Using existing JavaScript library, be it jQuery (most popular), Dojo,
MooTools or YUI (probably too much for gitweb) will give us, as you sai=
d,
well tested code, and new abilities like client-side sorting of tables
which we would be able to use in further work.

[1] http://www.nczonline.net/blog/2011/10/03/when-web-standards-fail-us=
/

>                                Also I am planning to create a local l=
ibrary=20
> version with support for configuration and a good documentation.

I don't quite understand what you mean here.  The JavaScript code speci=
fic
to gitweb would have to be modified to use chosen JavaScript library, b=
ut
I wouldn't say it is "local library".  I'd rather we use stock JavaScri=
pt
library, which would allow us to leverage existing CDNs like (for jQuer=
y)

  http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
  http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js
  http://code.jquery.com/jquery-1.7.2.min.js
=20
We probably would ultimately need to be able to serve local fallback co=
py
(but this might be out of scope of GSoC project).

This gitweb-specific JavaScript code (files in `gitweb/static/js/`)
is IMVHO quite well documented using JSDoc.

> Using the DOM features of JavaScript and traversing the whole documen=
t
> object is quite cubersome and error prone, so I want to replace them =
using
> well tested libraries that are cross browser compatible.

I think there is missing "using hand-crafted code" in this sentence
to make it sense.

>=20
> Emulating onprogress in XMLHttpRequest :
>=20
> jQuery and YUI provide only statuses success and error.

Right.

> Even MooTools provide progress but are constrained to some browers
> only.

To be more exact MooTools support 'onprogress' event handler only if
web browser supports it.  Not all do (e.g. older browsers), that is why
there is need for emulation using timers.

> It can be handled by using $.ajax Transport utility .

You mean in jQuery here, isn't it?  It would be a bit different, I thin=
k,
in MooTools or YUI.

C.f. http://stackoverflow.com/questions/5652229/javascript-framework-wi=
th-or-easily-extendable-with-support-for-xmlhttprequest

> I will also take care progressive enhancement, by carefully implement=
ing the
> basic functionality of the gitweb so that what ever may be the browse=
r
> version and type, internet connection the basic functionality will no=
t
> disrupted.

Errr... "progressive enhancement" is about using client-side scripting
in such way, that even if web browser doesn't support JavaScript
(e.g. text browsers such as lynx, elinks or w3m), or has JavaScript
turned off or blocked, we would get a basic functionality.

Note also that "progressive enhancement" part applies only to writing
new features, and this is strictly 'as time permits' part, I think.
But I thin that you would need to lay more complete proposal, i.e.
what features are you planning to add.=20

--=20
Jakub Narebski
Poland
