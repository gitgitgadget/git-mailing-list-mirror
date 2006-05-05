From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 13:50:24 -0700
Message-ID: <7vmzdww60f.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	<7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
	<7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
	<7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051431390.24505@localhost.localdomain>
	<7vac9wxom0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051605340.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 05 22:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7Fv-0001ZF-L0
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWEEUu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWEEUu0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:50:26 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37599 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751772AbWEEUu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 16:50:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505205025.EUQD25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 16:50:25 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605051605340.6713@iabervon.org> (Daniel
	Barkalow's message of "Fri, 5 May 2006 16:33:55 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19641>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 5 May 2006, Junio C Hamano wrote:
>
>> But "binaryness" affects only certain operations that extract
>> the data (e.g. diff and grep) and not others (e.g. fetch).
>> Also, it makes sense to being able to retroactively mark a blob,
>> which was not marked as such originally, is a binary.  So I do
>> not think it should be recorded in the object header.
>
> Why do you think it makes sense to retroactively mark a blob with things 
> like binariness or MIME type? To the extent that the information is not 
> possible to extract from the blob contents, it seems to me to be a 
> permanent aspect of the blob. And I could see having blobs with the same 
> content but different type information (that one is a ZIP archive, while 
> this one is a OpenDocument file), and tools may care how they were 
> specified, and the user would want to be able to track how they had 
> historically been marked, if the system allows them to be marked at all.
>
> Of course, there's still the issue of how this info is generated for a new 
> blob; I think it should live in the index for tracked files and come from 
> a .gitignore-style file for new files. (For that matter, there could be a 
> .gitmetadata file, which would handle "ignore" as well as binary and 
> whatever other info you want to produce about your not-previously-tracked 
> files.)

I think Nico's solution (compromise?) is the right and most
practical one.
