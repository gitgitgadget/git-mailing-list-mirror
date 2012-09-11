From: demerphq <demerphq@gmail.com>
Subject: Re: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Tue, 11 Sep 2012 18:58:22 +0200
Message-ID: <CANgJU+UwR=UKHy8hnZhFRiaysjMaJpFO1M20DbRTCQN7GUpJQQ@mail.gmail.com>
References: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
	<m2ehmlwxb2.fsf@igel.home>
	<CACBZZX4Egrx_vrKNV68pL8DL4xkLd5j8o-1t4+fA7+Ai758-9g@mail.gmail.com>
	<m2a9x9wwma.fsf@igel.home>
	<CACBZZX61pfus=coO4bh8LwKb578nrnL-gQqa_xQH__uqSe9fJA@mail.gmail.com>
	<7vk3w0ijqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTnD-0005Ua-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab2IKQ6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 12:58:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50457 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab2IKQ6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 12:58:22 -0400
Received: by ieje11 with SMTP id e11so1262385iej.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RI3fkjayfgaj5XmGj+iJKjNeD67C2Po1iRW6GLfVOgI=;
        b=WbspgP9nIJo16GVSUzQCZJ50+749DMjv4w6qm4h5vTwyy+dTVmSOKN0OupY4AeNPty
         Ie1+1BmkRVQ4TyzvBsUjeaXIIiCPhD436cDsjlgPV2Fh0/ngrzEPbymG1aLMIS99VDOx
         9GTQTuQBD4TFq0Eb6dBA2PypDwr5CTt3YReksUj7FwHP9a1S5PC6oLWgPzGsOt5llwje
         KsAIz66ONpPkim8VdxLM/INbARLle6Uc9uCbWEaNmNCEdKB7Coh/GauOpsIrUd8cXd0Y
         fP6ik0ImSYxTQHc768QgiIZGA0admyV0fRs95XTsapn5sSopnZXbJjoCjtdK3606Dht0
         jSyA==
Received: by 10.50.140.65 with SMTP id re1mr17070133igb.68.1347382702190; Tue,
 11 Sep 2012 09:58:22 -0700 (PDT)
Received: by 10.64.55.134 with HTTP; Tue, 11 Sep 2012 09:58:22 -0700 (PDT)
In-Reply-To: <7vk3w0ijqx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205251>

On 11 September 2012 18:53, Junio C Hamano <gitster@pobox.com> wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Sep 1, 2012 at 6:12 PM, Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> I don't get what you mean, what committer info?
>>>
>>> GIT_COMMITTER_{NAME,EMAIL}.  A tagger isn't really an author.
>>
>> Ah, am I the only one that finds that a bit counterintuitive to the
>> point of wanting to submit a patch to change it?
>>
>> If you've created a tag you're the *author* of that tag, the
>> author/committer distinction for commit objects is there for e.g.
>> rebases and applying commits via e.g. git-am.
>>
>> We don't have a similar facility for tags (you have to push them
>> around directly), but we *could* and in that case having a
>> Tag-Committer as well well as a Tagger would make sense.
>>
>> Junio, what do you think?
>
> Unless your name is Linus Torvalds and it is early in year 2005, I
> wouldn't even think about it.
>
> When we introduced "tagger name can be overriden with environment",
> we could have added GIT_TAGGER_{NAME,EMAIL}, but we didn't.  Given
> that tagging happens far far less often than committing, I think it
> was a sensible thing to do.
>
> It is a perfectly normal thing in Git for you to commit a patch
> authored by other people on behalf of them (and that is why AUTHOR
> exists as a separate name from the committer), but you still stand
> behind the commits you create by setting COMMITTER of them to you.
> The fact that it was _you_ who create the tag has similar weight
> that you have your name as the committer in commit objects, so in
> that sense, I think the semantics used for the name in tag is far
> closer to COMMITTER than AUTHOR.
>
> I guess I wouldn't mind too much if "git tag" learned a "--tagger"
> option, and honored GIT_TAGGER_{NAME,EMAIL} if set (and otherwise,
> fall back to GIT_COMMITTER_{NAME,EMAIL}), but I do not know if it is
> worth it.  How often would you want to _lie_ about your identity
> when you are tagging, and what legitimate reason do you have for
> doing so?

Interestingly this came up because of the opposite problem. We wanted
to *prevent* users from telling lies about who they are.

IOW, when we do a rollout with git-deploy we want to automatically set
their username from a secondary authenticated source before we create
a rollout tag in their name.

cheers,
Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
