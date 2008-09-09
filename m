From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 17:02:46 -0600
Message-ID: <51419b2c0809091602g35b9aa2g8202c46a4f603cdd@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
	 <e06498070809091029j1e450c43i276c5a69376da3ab@mail.gmail.com>
	 <51419b2c0809091319j2f29b6e1n752cba305c7c1cf6@mail.gmail.com>
	 <e06498070809091450y3bb7ba1cs8b86ea31b4e37bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCFX-0006jG-86
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbYIIXCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbYIIXCs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:02:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:12407 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYIIXCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:02:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2102526rvb.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gKp/SkdUUm0BDaGHB3St3L9ZslGSIpL2uZF3rjhEjlo=;
        b=SfTLLGliT6hKXivC4tSOQXGFKN6MrkoqQQ2bTEs5qFCO9KTFvpFoxZtps4bwK7YIJb
         UdF8+nJTRiPGOGLX0Mbjj+mz3czw9RNWVPj1/WxFz7v4jRqA8nALvTgJVkPMR5SMmow5
         mP41cdUxe3xTd6WSk2L6sIfLVbzp+jQM6e77k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oDLYLUlyyGv5Ra+LsdevQ+7OsPW8h11WyB9Ivkycl4HsbjN+tkwUHMKpx+AwVDDiww
         fZozvmy+xgyvOmdV3ZTQEY4GB6PBGsjrO/IosbyzS7GE+Z5rnLbaHN2tEjsG5+ODLvyn
         tLbnidUw4IjiGhrgchpzHDhir+C6qdRir6CYE=
Received: by 10.140.226.14 with SMTP id y14mr264205rvg.123.1221001366638;
        Tue, 09 Sep 2008 16:02:46 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Tue, 9 Sep 2008 16:02:46 -0700 (PDT)
In-Reply-To: <e06498070809091450y3bb7ba1cs8b86ea31b4e37bd8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95454>

On Tue, Sep 9, 2008 at 3:50 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
> On Tue, Sep 9, 2008 at 4:19 PM, Elijah Newren <newren@gmail.com> wrote:
>> it), but it's fairly straightforward to say any of:
>>
>>  eg revert --since HEAD~3  # Undo all changes since HEAD~3
>>  eg revert --in HEAD~8     # much like git revert HEAD~8, but no
>> commit by default
>>  eg revert --since HEAD foo.py  # Undo changes to foo.py since last commit
>>  eg revert foo.py               # Same as above
>>  eg revert --in trial~7 bar.c baz.  # Undo changes made in trial~7 to bar.[ch]
> [...]
>> Are these kinds of "reverting data" really so different that there
>> should need to be different commands, or that some of these operations
>> shouldn't be supported by the simple revert command?  Sure, most users
>> most of the time will probably use the "eg revert FILE1 FILE2..."
>> form, but I didn't see the harm in supporting the extra capabilities.
>
> The harm I see in trying to support every possible use case is that it
> makes it exponentially more difficult to fully understand the tool.
> Using yap as an example, I think it should be easy enough for a user
> to read the help blurb for every command and understand what it does
> and when to use it (this is easy for me to say as the author, but I
> think it would hold true for a "typical SCM user.")   Having a mode
> the seems to act like another SCM (revert --since) seems great at
> first blush.  The user will see that and think, "Wonderful, this will
> work just like svn and I don't have to think about it."  As I mention
> in another email, that's all well and good until the user runs "git
> diff" and makes a liar of you.  In svn, there would be no diff,
> because the files all match their respective upstream versions.  In
> git, you would see changes because the file no longer matches the last
> commit.  Now your user is confused because his mental model was
> violated.

Um, no, git diff won't make a liar of me -- it'll come up empty as
expected.  :-)  My suggestion for revert does make it a logical
extension of svn's, and includes git revert's behavior (with two minor
tweaks).  See my follow up post to Junio's elsewhere in this thread.

> Obviously, there is a trade-off here between power and usability.  As
> shown by the Hole Hawg[1], there is a limit to the amount of power it
> is useful for the average user to have.  The git community has already
> admitted this by dividing the git command set into two classes:
> plumbing, and porcelain.  "The plumbing," you say, "is very powerful,
> but you shouldn't have to use it."  My contention is that there is a
> class of users that is not well served by the current definition of
> porcelain.  It is that class of users that I have tried to target with
> yap.

Fair enough.  I too had to make decisions on what to focus on as well
in Easy Git.  Since my goal was more along the lines of "make it easy
to learn how to use git, and particularly easy to transition to and
from git and eg" that gives me a much different frame of reference
than interoperating with svn (which I essentially ignored).  I thought
that this particular case didn't add much complexity (and potentially
even removed it elsewhere), but that may just be my frame of
reference.

yap looks pretty cool; I'll have to take a look sometime.
