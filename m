From: david@lang.hm
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 21:58:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705182154540.6938@asgard.lang.hm>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
 <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
 <Pine.LNX.4.64.0705181742470.20116@asgard.lang.hm> <20070519035856.GB3141@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 19 07:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpH3y-0003xz-JM
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbXESFA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 01:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbXESFA7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:00:59 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:37872
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbXESFA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 01:00:58 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4J4xeAH011192;
	Fri, 18 May 2007 21:59:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070519035856.GB3141@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47713>

On Fri, 18 May 2007, Shawn O. Pearce wrote:

> david@lang.hm wrote:
>> when a person browsing a hostile website will allow that website to take
>> over the machine the demand is created for 'malware filters' for http, to
>> do this the firewalls need to decode the http, and in the process limit
>> you to only doing legitimate http.
>>
>> it's also the case that the companies that have firewalls paranoid enough
>> to not let you get to the git port are highly likely to be paranoid enough
>> to have a malware filtering http firewall.
>
> I'm behind such a filter, and fetch git.git via HTTP just to keep
> my work system current with Junio.  ;-)
>
> Of course we're really really really paranoid about our firewall,
> but are also so paranoid that any other web browser *except*
> Microsoft Internet Explorer is thought to be a security risk and
> is more-or-less banned from the network.
>
> The kicker is some of our developers create public websites, where
> testing your local webpage with Firefox and Safari is pretty much
> required...  but those browsers still aren't as trusted as IE and
> require special clearances.  *shakes head*

this isn't paranoia, this is just bullheadedness

> We're pretty much limited to:
>
> *) Running the native Git protocol SSL, where the remote system
> is answering to port 443.  It may not need to be HTTP at all,
> but it probably has to smell enough like SSL to get it through
> the malware filter.  Oh, what's that?  The filter cannot actually
> filter the SSL data?  Funny!  ;-)

we're actually paranoid enough to have devices that do man-in-the-middle 
decryption for some sites, and are given copies of the encryption keys 
that other sites (and browsers) use so that it can decrypt the SSL and 
check it. I admit that this is far more paranoid then almost all sites 
though :-)

> *) Using a single POST upload followed by response from server,
> formatted with minimal HTTP headers.  The real problem as people
> have pointed out is not the HTTP headers, but it is the single
> exchange.

> If you really want a stateful exchange you have to treat HTTP as
> though it were IP, but with reliable (and much more expensive)
> packet delivery, and make the Git daemon keep track of the protocol
> state with the client.  Yes, that means that when the client suddenly
> goes away and doesn't tell you he went away you also have to garbage
> collect your state.  No nice messages from your local kernel.  :-(

unfortunantly you are right about this.

David Lang
