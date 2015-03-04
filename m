From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 22:05:03 -0000
Organization: OPDS
Message-ID: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu><20150220072924.GC8763@peff.net> <vpqpp94exb5.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Stefan Beller" <sbeller@google.com>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 23:04:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTHPN-00027c-PX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 23:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbCDWEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 17:04:45 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:52935 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752197AbbCDWEo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 17:04:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BEGAA6gPdUPF8vFlxagwJSWocmuXiFawQCgSNOAQEBAQEBBQEBAQE4IBuECgUBAQEBAwgBAS4eAQENFAsCAwUCAQMVAQslFAEEGgYHAxQGARIIAgECAwGIIgnEIpNXAQEIAQEBAQEdixKEOzODHoEUBYV1hD+FT16DBYIYhGyLdYMbg0CCJRyBUD4xAYJCAQEB
X-IPAS-Result: A2BEGAA6gPdUPF8vFlxagwJSWocmuXiFawQCgSNOAQEBAQEBBQEBAQE4IBuECgUBAQEBAwgBAS4eAQENFAsCAwUCAQMVAQslFAEEGgYHAxQGARIIAgECAwGIIgnEIpNXAQEIAQEBAQEdixKEOzODHoEUBYV1hD+FT16DBYIYhGyLdYMbg0CCJRyBUD4xAYJCAQEB
X-IronPort-AV: E=Sophos;i="5.11,343,1422921600"; 
   d="scan'208";a="27513542"
Received: from host-92-22-47-95.as13285.net (HELO PhilipOakley) ([92.22.47.95])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 04 Mar 2015 22:04:42 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264789>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
Sent: Friday, February 20, 2015 9:39 AM
> Jeff King <peff@peff.net> writes:
>
>>   - Matthieu, who also cited time constraints
>
> Just to clarify: last year we were co-mentoring with Ram. I ended up
> having a lot of time and did most of the work (not blaming Ram, and I
> enjoyed the experience). I'm still motivated to co-mentor, but this 
> time
> the co-mentoring has to be more balanced (or unballanced to the other
> mentor ;-) ).
>
>>   - Junio, who contributed some project ideas, but who in the past 
>> has
>>     declined to mentor in order to remain impartial as the maintainer
>>     who evaluates student results (which I think is quite reasonable)
>
> Yes, as a mentor I did appreciate having Junio as impartial
> maintainer/reviewer. And he did for sure contribute even without being 
> a
> mentor!
>
> From your list, it seems we can target 1 or 2 slots. I'd say it's 
> still
> worth applying, but if we don't find more mentors then perhaps it 
> would
> make sense to say so explicitely in
> http://git.github.io/SoC-2015-Ideas.html so that students looking for
> organization know that we'll have very few slots.
>
> -- 
Hi,
Given the mention of the GSoC ideas list, I thought it worth writing out 
one of my little ideas..


A possible idea is to add a date based variant of shallow clone :

  'git clone --date <when> ...'

in the same vein as the existing depth (shallow) clone.

On the wire advertise a 'shallow-date' capability, passing a signed big 
integer as the unix time for the shallow cut-off point (i.e. future 
extensible to cover a very wide date range), with optional(?) date+depth 
hysteresis (clock skew) parameters.

Command line interface to use existing date/time formats, (and possibly 
revision dates?).

Extend 'git fetch' to include the --date <when> option.

Ensure that 'git push' continues to work with and between 
shallow/shallow-date clones.

Update the documentation in line with the capability.

Document any migration plan (if required)

Why
===

This capability would eliminate the existing confusion over the --depth 
parameter as different branches may require different depths to reach a 
"common" start point.

Extra points for an easy method of '--unshallow-date <new_when>' to 
remove 'old' commits that the user may no longer need locally. 
(unshallow may not be the right term...)

--
Philip
