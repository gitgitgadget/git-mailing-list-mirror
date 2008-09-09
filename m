From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 11:37:40 -0500
Message-ID: <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Elijah Newren" <newren@gmail.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd6Er-00069k-Ag
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 18:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYIIQhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYIIQhm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 12:37:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:58960 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYIIQhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 12:37:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so252019ywe.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 09:37:40 -0700 (PDT)
Received: by 10.151.44.15 with SMTP id w15mr112638ybj.12.1220978260244;
        Tue, 09 Sep 2008 09:37:40 -0700 (PDT)
Received: by 10.150.57.11 with HTTP; Tue, 9 Sep 2008 09:37:40 -0700 (PDT)
In-Reply-To: <200809091538.13961.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95404>

On Tue, Sep 9, 2008 at 8:38 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Elijah Newren wrote:
>> On Mon, Sep 8, 2008 at 10:25 PM, Govind Salinas
>> <govind@sophiasuchtig.com> wrote:
>> > On Mon, Sep 8, 2008 at 8:05 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
>>
>> > I had some very different ideas along the lines of reducing the number of
>> > commands (where the commands do something similar just DWIM rather
>> > than force me to remember or read docs on different commands), making
>> > commands look similar to commands from other SCMs (revert should do
>> > what it does for me in all the other SCMs that I have used, which is to
>> > checkout the HEAD copy into the working directory)
>>
>> Your description of revert in various systems isn't quite accurate; it
>> isn't necessarily HEAD, since most systems (at least bzr and hg) can
>> also revert files to revisions earlier than HEAD.  In fact, questions
>> of how to do that have come up several times on this list, so you
>> wouldn't want to exclude that case.  Also, the revert behavior of git
>> (minus perhaps the default auto-commit) comes in pretty handy too
>> sometimes, and I can't easily find it in other systems (I suspect many
>> just drop back to diff + patch to handle the case that git provides).
> [...]
>
> By the way, I think the fact that in different SCMs meaning of
> "$scm revert" and of "$scm reset" differs widely caused Mercurial
> to adopt "hg backout" for creating a commit which reverts changes
> (cherry-pick -R), and "hg rollback" to undo last commit.
>

My take on this comes from my own personal experience with "revert"
commands, the fact that "how do i undo my working dir changes" is
the most common question I see on the list and that I have heard
others with the same complaint.

I will concede that revert usually means both "discard current working
dir changes" and "undo a previous change" in different circumstances.
However, the number of times that "how do i discard my working
dir changes" comes up on the list leads me to believe that you get
the most out of using revert for this, since it is something that should
be familiar to a user and undoing a previous commit is more rare.

Of course, this is where I would use a DWIM-ism.
"pyt revert -r commitish" would generate a reverse patch but
"pyt revert <paths>..." would checkout from HEAD.  "pyt revert" would
just "git reset --hard".

-Govind
