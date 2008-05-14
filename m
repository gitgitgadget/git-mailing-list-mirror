From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 19:24:01 -0400
Message-ID: <482B7491.30608@gmail.com>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home> <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local> <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org> <20080513001252.GB29038@spearce.org> <alpine.LFD.1.10.0805132005550.23581@xanadu.home> <7vy76dperf.fsf@gitster.siamese.dyndns.org> <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de> <alpine.LFD.1.10.0805141247560.3019@woody.linux-foundation.org> <alpine.LFD.1.10.0805141314440.3019@woody.linux-foundation.org> <alpine.LFD.1.10.0805141626070.
 23581@xanadu.home> <alpine.LFD.1.10.0805141333050.3019@woody.linux-foundation.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Juergen Ruehle <j.ruehle@bmiag.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 15 01:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwQLM-0001eh-8Z
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 01:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbYENXYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 19:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYENXYM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 19:24:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:35443 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbYENXYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 19:24:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so80557ywe.1
        for <git@vger.kernel.org>; Wed, 14 May 2008 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=mTQXPOqAshSyu2+3mWKfwP33BX4eHHXUidpvgtSzcyY=;
        b=g7H/IPGnoPOuxPItNcym1y95I5XMLIy6lMjZZOqmHD6uVZBf6Z0h5/CTPUtVORgWXq6rxIHEdi3KCko2WKLt4fQ3kn3qB2GPogQG+2rt8hSSSRkxgtjFz2X53DsIO6x3HbixzyTDlKZVCQPL5Zn2dfNjAYY8mt8hCrBuS3sxzJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TI5Qzmd3Y2GC+cS19t03V8NcYHx5itZ89H4TgA7U1k8pWROkI1XlCRYlPqy72TafxPLkEI/hDkmFjIB+oC5oQoT+5LmyTAM7SRQisJity+duIZ3MKUI6A8hh5ithRRPW5FGCOXfpp1vaFXWB1JX78zbpO6745PUwPqWcB7IYbXU=
Received: by 10.150.11.2 with SMTP id 2mr1702756ybk.10.1210807447691;
        Wed, 14 May 2008 16:24:07 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 33sm233634yxr.3.2008.05.14.16.24.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 16:24:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.LFD.1.10.0805141333050.3019@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82161>

Linus Torvalds wrote:
> 
> On Wed, 14 May 2008, Nicolas Pitre wrote:
> 
>> On Wed, 14 May 2008, Linus Torvalds wrote:
>>
>>> Of course, the more aggressively we prune, the more we end up having to 
>>> depend on the fact that a commit that is in a pack that is marked "keep" 
>>> must *always* have everything that leads to it in that pack or others also 
>>> marked "keep". We effectively have that already (because we've always 
>>> pruned away the commits early), but it's a thing to keep in mind whenever 
>>> we prune even more aggressively.
>> I wonder if this is a good thing.  Such a rule would effectively put 
>> restrictions on how objects like big blobs could be distributed amongst 
>> many .keep packs.  I just wish we're not painting ourselves in a corner.
> 
> You can distribute big objects arbitrarily among many .keep packs, but 
> what you can *NOT* do (and which has _always_ been a bug to do) is to have 
> a *.keep pack that refers to objects that are not in a .keep pack!
> 
> So keep<->keep you can do anything you want, and distribute objects any 
> way.
> 
> But a keep pack must only refer to objects in itself or in other keep 
> packs.
> 
> Because otherwise, if we ever hit an object in a keep pack, we'll stop 
> even looking further when we use --unpacked. And that has always been true 
> (admittedly only for "commit" objects, but those are the ones that most 
> commonly refer to other objects, so ..)

Sounds like git-fsck needs to start checking for this.
