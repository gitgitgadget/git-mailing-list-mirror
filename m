From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 14:53:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161445380.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org> <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
 <7vbqc25mgi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 23:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX24E-0001YB-H5
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXIPVyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 17:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXIPVyI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:54:08 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:52531
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbXIPVyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:54:06 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GLrkB0025738;
	Sun, 16 Sep 2007 14:53:46 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vbqc25mgi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58355>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> my initial thoughts were to have git do all it's normal work and hook
>> into git at the point where it's writing the file out (where today it
>> chooses between writing the data to a file on disk, pipeing to stdout,
>> or pipeing to a pager) by adding the option to pipe into a different
>> program that would deal with the permission stuff. this program would
>> only have to write the file and set the permissions, it wouldn't have
>> to know anything about git other then where to find the permissions it
>> needs to know.
>>
>> it sounds like you are suggesting that the hook be much earlier in the
>> process,...
>
> Well, you misread me or what I said was confusing or both.  I
> was suggesting totally opposite.  Let git do all its normal
> work, and then call your hook to munge the work tree in any way
> you want.

so you are saying, have git write everything out as-is and then call a 
program afterwords to do things? essentially a post-checkout hook?

such a hook is useful in many situations, and would allow for the workflow 
where you have /etc, /etc.git, and write scripts to move things back and 
forth between them.

so I do think that this is a capability that would be useful to git 
overall.

however, for the specific use-case of maintaining /etc I don't think that 
it's as good as having a hook at write time.

David Lang
