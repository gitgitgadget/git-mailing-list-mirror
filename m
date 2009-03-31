From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH] Add warning about known issues to documentation of	cvsimport
Date: Tue, 31 Mar 2009 19:10:14 +0200
Message-ID: <49D24E76.60904@pelagic.nl>
References: <20090323195304.GC26678@macbook.lan> <49C7F233.9050205@pelagic.nl> <20090330221729.GB68118@macbook.lan> <49D1ABD0.8070707@pelagic.nl> <20090331162103.GA72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohV9-0004x9-NZ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739AbZCaRKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbZCaRKT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:10:19 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:56925 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753124AbZCaRKS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 13:10:18 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 09A6958BD89;
	Tue, 31 Mar 2009 19:10:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090331162103.GA72569@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115287>

Heiko Voigt wrote:
> On Tue, Mar 31, 2009 at 07:36:16AM +0200, Ferry Huberts (Pelagic) wrote:
>> Heiko Voigt wrote:
>>> On Mon, Mar 23, 2009 at 09:33:55PM +0100, Ferry Huberts (Pelagic) wrote:
>>>> maybe you can also add remarks about autocrlf and safecrlf?
>>>> both need to be off
>>> From my experience thats not necessarily true. You can use
>>> autocrlf=input to repair broken revisions were crlf's have been
>>> mistakenly committed into the repository. And if I remember correctly
>>> safecrlf helps if you want to make sure that no information gets lost.
>>>
>>> So when importing from a nice correct cvs repository you would expect
>>> safecrlf to not stop your import. And I suspect there are actually cvs
>>> users that were very careful with their lineendings who would use it.
>>>
>>> cheers Heiko
>> If you look at this thread:
>> http://thread.gmane.org/gmane.comp.version-control.git/110152/focus=110358
>> you'll see why I said it. I did some testing to prove my statement.
> 
> Well, from that thread I see my statement supported. It is not true that
> they *need* to be off. Maybe a statement that certain crlf settings are
> exclusive would be good, but I agree that should go into the config
> documentation.
> 
> The main point I see here is that the User may not be aware that such a
> conversion is applied so something like this could help.
> 
> cheers Heiko
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index e1fd047..d4e7fd4 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -40,6 +40,11 @@ probably want to make a bare clone of the imported repository
>  and use the clone as the shared repository.
>  See linkgit:gitcvs-migration[7].
>  
> +Note: All revisions are imported using the index so settings of
> +core.autocrlf and core.safecrlf are applied. This way you can change or
> +safety check the import. If you do not want this make sure these options
> +are both set to false.
> +
>  

I can agree with this. However,
I still think that this is too weak a statement and a bit too cryptic:
the import will/can actually fail when a crlf conversion is performed,
even though safecrlf is not set to true. At least that was the case I
was talking about in the thread. I don't know the current situation, I
haven't tried it since 'cause I just use it with both set to false :-)
I discussed a patch for this but never got around to implementing it
since I'm now busy with ignore functionality for EGit.

cheers.

Ferry
