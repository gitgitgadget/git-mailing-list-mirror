From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 12:12:52 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191202480.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com> 
 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm> <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903181645440.16753@asgard.lang.hm> <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0903190129110.4560@asgard.lang.hm> <alpine.DEB.1.00.0903191119340.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkNhR-0007H9-Fm
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbZCSTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZCSTNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:13:09 -0400
Received: from mail.lang.hm ([64.81.33.126]:49144 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbZCSTNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 15:13:08 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2JJCq39031699;
	Thu, 19 Mar 2009 11:12:52 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903191119340.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113808>

On Thu, 19 Mar 2009, Johannes Schindelin wrote:

> On Thu, 19 Mar 2009, david@lang.hm wrote:
>
>> all three formats mentioned here (OOXML, ODF, SVG) are XML-based formats
>> and a single flexible XML merge driver could potentially handle all
>> three (as well as other formats). for that matter, the ODF specs cover
>> multiple types of data, and I suspect that appropriate conflict markers
>> for text could well end up being different than the ones for
>> spreadsheets.
>
> You are misunderstanding me.
>
> The fact that all three are XML based has nothing to do with the _real_
> goal of the project.
>
> IOW a user trying to 3-way-merge ODF files could not care less if the
> underlying technical details involve having an extra merge driver for XML
> files or not.
>
> The user cares about the ease of use, about the user interface.  That is
> what I want to focus on.
>
> And if we end up with a beautiful XML merge driver at the end of the
> summer that nobody uses, I will be not only a little disappointed.
>
> So let's look at the _nature_ of the data at hand, i.e. text, marked-up
> text, images (we could include UML, which is also XML-based, and where the
> XML merge driver is as relevant for the user experience as for the
> others), and how to make it _easy_ to resolve merge conflicts there.

but don't you want to be able to auto-merge as much as possible before you 
have to go to _any_ user interaction? (the best user interface is one you 
don't need to use)

it's only after the merge drive decides that it can't do the merge that 
you would have to move on to manually resolving conflicts.

when you _do_ move on to resolving conflicts, it's not a good approach to 
write a GUI tool to deal with each datatype (git does not need it's own 
ODF text document editory, spreadsheed editor, graphics editor, etc). it 
may end up being nessasary for some document types, but that's a last 
resort. it's far better if the conflict markers can be inserted in such a 
way that the normal tools for dealing with that file type can be used.

git doesn't provide (or mandate) what editor is used to resolve conflicts 
in text files today, it should not do so for other file types either 
(again, except as a last resort)

the only way to start from the GUI and not create a merge driver first is 
to either have a custom GUI that accepts files 'corrupted' with the 
existing conflict markers, or work on a GUI that works with both of the 
sources as entire files, with no conflict markers or assistance from git.

David Lang
