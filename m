From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: GSOC proposal
Date: Fri, 25 Mar 2011 00:27:20 +0100
Message-ID: <4D8BD358.1030603@web.de>
References: <20110324220104.GA18721@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2twB-00036n-MR
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934354Ab1CXX10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 19:27:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59966 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933783Ab1CXX1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:27:25 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8652B18B5C917;
	Fri, 25 Mar 2011 00:27:23 +0100 (CET)
Received: from [93.246.62.187] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q2tw3-0004Q2-00; Fri, 25 Mar 2011 00:27:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110324220104.GA18721@paksenarrion.iveqy.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19P49otLtpo2RnUf+GRJLh1bWenu95aBLPACn6n
	++ZadzDVQz9uv0KZNTMcCpOiPXw4fM+BXWIn2QPIncPh25U1rw
	hC00pbtL6gJ2Qh3LlahA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169953>

Am 24.03.2011 23:01, schrieb Fredrik Gustafsson:
> Hi,
> I'm interested in working as a student for git in the GSOC program th=
is
> year.
>=20
> I'm running a lot of web projects with heavy use of git submodules (e=
ach
> project has around 40 submodules) and therefore I'm very interested i=
n
> enchant the git submodule experience.

Great to hear that!

> I'm asking for your oppinions and id=E9es for my planned todolist for=
 this
> summer (if I get accepted of course).
>=20
> =3D=3D Preventing false "pointers" =3D=3D
> It's far too easy to push a gitrepo pointing to a submodule version t=
hat
> is not existing on the server. Prevent this by checking for available
> submodule versions before acceptingt the push.

Yes, requiring to force such a push is an issue raised quite often (I
think addressing this issue would be a good starting point for people
who want to get involved in enhancing the submodule experience).

> =3D=3D Threat every module alike =3D=3D
> When failing fetching a submodule, continue fetching the next one
> instead of dying. There's no need to prevent fetching a submodule
> beginning at 'z' just because a failing in fetching a submodule
> beginning at 'a'. The submodules should not be alphabetically dependa=
nt
> as they are now.

I assume you are talking about the implicit fetch done by "git submodul=
e
update" here. The recursive submodule fetch that "git fetch" learned
recently continues to fetch other submodules even if one or more fetche=
s
failed. But you are right that "git submodule update" should attempt to
continue updating the remaining submodules too even if one of those
updates failed along the way (This should be achieved with even less
effort than the push issue mentioned above, so it would be an even
easier starting point for people who want to get involved).

> =3D=3D Make submodule changes globally visible =3D=3D
> Give git-log submodule support. A git log of showing a new version of=
 a
> module should (if choosen by --submodules or alike) also list the
> changes to that submodule since the last version of the submodule was
> commited.

Yeah, adding an option so the user is able to tell "git log" she wants
to see all submodule commits in detail too would also be very nice
(Also some other commands could profit from being able to tell them to
recurse into submodules).

> =3D=3D Move submodules into core =3D=3D
> This last bit is excellent described in the link below.

Assuming that you are referring to placing the repository for each
populated submodule in the superproject's $GIT_DIR/modules, me thinks
that that is the core part of this GSoC project. So I'd be very glad
to have someone on board who wants to solve this issue.

> So, what do you all think? Is it too much? Too little? Is the quests
> relevant to git?

I like it! I think all these issues are relevant to achieve better
submodule support in git and I'm looking forward to see a student
(maybe you? ;-) starting to work on this.

(And, as every year, it's a good idea for a prospective student to get
involved in the git community before his application is accepted ...
sending some patches is a good way to do that, maybe regarding one of
the first two issues raised here? ;-)
