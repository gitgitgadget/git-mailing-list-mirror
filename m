From: david@lang.hm
Subject: Re: metastore
Date: Tue, 2 Oct 2007 13:18:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710021314370.24697@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-868213797-1191356304=:24697"
Cc: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcoBm-000416-OA
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbXJBURq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbXJBURq
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:17:46 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:50031
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbXJBURp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:17:45 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l92KGt1N023442;
	Tue, 2 Oct 2007 13:16:55 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <85lkalz3iv.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59725>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-868213797-1191356304=:24697
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 2 Oct 2007, David Kastrup wrote:

> David Härdeman <david@hardeman.nu> writes:
>
>> On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>>> also sprach David Härdeman <david@hardeman.nu> [2007.09.19.2016 +0100]:
>>>> But I agree, if any changes were made to git, I'd advocate adding
>>>> arbitrary attributes to files (much like xattrs) in name=value
>>>> pairs, then any extended metadata could be stored in those
>>>> attributes and external scripts/tools could use them in some way
>>>> that makes sense...and also make sure to only update them when it
>>>> makes sense.
>>>
>>> So where would those metdata be stored in your opinion?
>>
>> I'm not sufficiently versed in the internals of git to have an
>> informed opinion :)
>
> I think we have something like a length count for file names in index
> and/or tree.  We could just put the (sorted) attributes after a NUL
> byte in the file name and include them in the count.  It would also
> make those artificially longer file names work more or less when
> sorting them for deltification.

the problem with this is dealing with the attributes outside of git 
(especially when the filesystem can't store the attributes nativly, 
specificly including things like owners when not running as root)

this is one of the reasons for talking about useing a seperate file for 
the attributes (the other being the ability to minimize the impact to 
git-core of tracking attributes)

David Lang

--680960-868213797-1191356304=:24697--
