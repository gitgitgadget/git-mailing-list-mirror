From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Wed, 02 Mar 2011 18:31:28 +0100
Message-ID: <4D6E7EF0.5040106@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com> <4D6E4246.5080407@drmicha.warpmail.net> <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pupx0-0000Td-K9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 18:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab1CBRe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 12:34:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58815 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753859Ab1CBRe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 12:34:56 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5B42B22F4A;
	Wed,  2 Mar 2011 12:34:55 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 02 Mar 2011 12:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TUOOYD5BuK+NfGplfWupFjbWrC4=; b=UHYPFM6RwxGhc7Ek0nSMDzhwP8gn02BFC0CA9sYKWqCSiVgi933pDjpNsuYmx5niGnRv1vO8IygOjl9dyJex6OeOczTMaHbTJfpOs4QaCjACb/gTSNcRx/2Ij5R4WQoYE+B7J5bvF2jpwGM/LB5QXGO2tclOhyo4Nq2OlemGz9I=
X-Sasl-enc: 2yxkjro032PygJCefl+l2HDc1ekgkg6/rJVk1qZERwdH 1299087294
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C548444D6D;
	Wed,  2 Mar 2011 12:34:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168326>

Junio C Hamano venit, vidit, dixit 02.03.2011 17:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> [*] I keep forgetting that some people may have files whose names begin
>> with ":". They are ambiguous now already with "treeish pathspec"
>> commands, but not with "pathspec" commands. The latter would change.
> 
> Just to make sure I understand that they have easy workarounds:
> 
>  - If you have a path foo/:bar, you can say
> 
>    git log master -- foo/:bar
> 
>    because ':' signals the magic and gets stripped only when it is at the
>    beginning (i.e. not affecting foo/:bar); and

Yes.

> 
>  - For :boz at the root level, you can say
> 
>    git log master -- '\:boz'
> 
>    because the backslash in '\:boz' makes the colon not at the beginning and
>    the glob match sees '\:boz' and then matches '\:' with literal ':' at the
>    beginning of the pathname ":boz".

Yes. Due to the shell escaping, a shorter way is

git log master -- ::boz

:)

> 
> In very old times, git used to work only from the top-level of the working
> tree.
> 
> The way we give an illusion that a command is restricted within the
> current working directory was by learning the "prefix" returned by
> setup_git_directory() while it chdir(2)'s up to the root level of the
> working tree, and then by limiting the operation to the pathspec given
> from the command line (each of whose elements prefixed by "prefix" by
> calling get_pathspec()).
> 
> Your ':'-prefix trick will naturally work very well with this arrangement.
> Instead of prefixing the "prefix", you would just strip ':' from the front
> for such a magic pathspec element, and that should be all that is necessary.

and pretend prefix == NULL, exactly.

> 
> There is a small worry, though.  Some codepaths have tricks that take
> advantage of the knowledge of the current behaviour that the resulting
> pathspec elements all refer to subtree under the "prefix", and try to
> optimize their tree traversal.  I think dir.c:fill_directory()'s use of
> common_prefix() is safe (it recomputes what is common based on the result
> of get_pathspec(), not blindly using the original "prefix"), but we need
> to make sure there isn't a codepath that blindly believes that the
> original "prefix" defines the extent of the operation.  Anything that
> understands "../" to step outside the cwd should be already safe, so I
> hopefully am being worried too much.

Except for rerere, I've tried all callers, and all work. ls-tree is a
bit strange, but that was true already for rev:path. I think it's OK if
ls-tree does not grok this, but I'll have another look.

> 
> Earlier, the list consensus was that if we were to aim for uniformity, we
> should make everything relative to the root of the working tree when there
> is no pathspec by default, because you can always give a single '.' to
> restrict the extent of the operation to the cwd, but you cannot extend the
> extent of the operation without tediously counting "../".

Hadn't we decided there were exceptions (e.g. grep), and there weren't
that many suggested changes (to repo-wide) left?

>  Would this ':'
> trick affect that argument?  If a command is relative to the cwd with no
> pathspec, you can now give a single ':' to affect the whole tree.

In my view yes. I would even say: If we don't change every single
command to repo-wide default there is no need to change (and break
things) if we have an easy one-character way of saying "repo-wide".

> 
> As I wrote in my response to Jeff in
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133874
> 
> I always thought that it would be the best solution that makes the choice
> of the default irrelevant, and this ":" trick certainly feels like this is
> that solution (I also think having a good default matters).
> 
> And we can start thinking about deprecating --full-tree option, no?  I
> like that, too ;-).
> 

:)

Michael
