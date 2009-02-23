From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Mon, 23 Feb 2009 08:29:57 +0100 (CET)
Message-ID: <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl>
References: <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
    <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
    <20090220152849.GA3826@coredump.intra.peff.net>
    <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
    <20090220172918.GB4636@coredump.intra.peff.net>
    <499F3B9B.3020709@pelagic.nl>
    <20090223000840.GA20392@coredump.intra.peff.net>
    <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
    <20090223065615.GA24807@coredump.intra.peff.net>
    <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
    <20090223071056.GA29241@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbVHt-0000yM-GK
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbZBWHaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbZBWHaA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:30:00 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:51209 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752455AbZBWH37 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 02:29:59 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 14AB158BDCE; Mon, 23 Feb 2009 08:29:57 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 23 Feb 2009 08:29:57 +0100 (CET)
In-Reply-To: <20090223071056.GA29241@coredump.intra.peff.net>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111114>

On Mon, February 23, 2009 08:10, Jeff King wrote:
> On Mon, Feb 23, 2009 at 08:09:03AM +0100, Ferry Huberts (Pelagic) wrote:
>
>> > But won't that now import CRLF's into your new git repo? Especially on
>> > Windows, where (IIRC) cvs gives you files with CRLF by default?
>>
>> Yes it would. But sadly that's the only way to make sure that the import
>> will work (without serious manual intervention).
>> I found this out the hard way.
>
> Wouldn't setting autocrlf=true, safecrlf=true do the import you want?
> Then you could reset autocrlf to input after import but before checkout
> time.

No. As I demonstrated in my testing setup the combination of autocrlf=true
and safecrlf=true ALWAYS makes the import NOT work (for repositories that
have CRLF files). In my own experience I also found that the combination
of autocrlf=input and safecrlf=true ALWAYS makes the import NOT work for
PRATICAL repositories. That lead me to the conclusion to require
safecrlf=false. From the discussion and arguments from you it appeared
that that wouldn't be enough. Therefore I think that we have to require
autocrlf=false (which makes git ignore the safecrlf setting).

Ferry
