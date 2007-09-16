From: david@lang.hm
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 13:36:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161321360.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <20070916155913.GB30476@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Sep 16 22:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX0rE-0006Gx-LL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 22:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbXIPUgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXIPUgl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 16:36:41 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:48832
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbXIPUgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 16:36:40 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GKa8jT025528;
	Sun, 16 Sep 2007 13:36:08 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070916155913.GB30476@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58344>

On Sun, 16 Sep 2007, Jan Hudec wrote:

> On Sat, Sep 15, 2007 at 18:30:53 -0700, david@lang.hm wrote:
>> 1. whatever is trying to write the files with the correct permissions
>>    needs to be able to query the permission store before files are
>>    written. This needs to either be an API call into git to retreive the
>>    information for any file when it's written, or the ability to define a
>>    specific file to be checked out first so that it can be used for
>>    everything else.
>
> You seem to be forgetting about the index. Git never writes trees directly to
> filesystem, but always with intermediate step in the index. So the API
> actually exists -- simply read from the index.

Ok, this sounds promising.

looking into one approach here.

assume for the moment that at write time an external program gets called.

this program reads the file contents from stdin and gets it's other 
information from git as command line parameters
   parameters I can think it would need are
    path to write the file to
    length of file
    name of the permission file
    id of the commit this is part of (possibly)

how does this program access the contents of the permission file in the 
index?

David Lang
