From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: git-bundle question.
Date: Sun, 11 May 2008 20:19:39 -0500
Message-ID: <5d46db230805111819o7d01523au30fb1abcff8be754@mail.gmail.com>
References: <5d46db230805111511g5bbb0b9amf65fb95266a80504@mail.gmail.com>
	 <7v3aoo2wob.fsf@gitster.siamese.dyndns.org>
	 <5d46db230805111817i786f3402qbfd5ec70d020ab1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 03:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvMit-0002yG-5L
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 03:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYELBTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 21:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYELBTp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 21:19:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:60032 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYELBTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 21:19:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1186228ywe.1
        for <git@vger.kernel.org>; Sun, 11 May 2008 18:19:39 -0700 (PDT)
Received: by 10.150.82.27 with SMTP id f27mr7625292ybb.143.1210555179578;
        Sun, 11 May 2008 18:19:39 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Sun, 11 May 2008 18:19:39 -0700 (PDT)
In-Reply-To: <5d46db230805111817i786f3402qbfd5ec70d020ab1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81826>

forgot to reply to list

On Sun, May 11, 2008 at 8:17 PM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
> On Sun, May 11, 2008 at 7:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Govind Salinas" <govind@sophiasuchtig.com> writes:
>>
>>> I am writing my wrapper over git bundle and I noticed that the
>>> "SPECIFYING REFERENCES" section says that the it will only
>>> bundle things that end in something git-show-ref can find.
>>>
>>> I can probably work around this by silently creating a tag
>>> doing the bundle and deleting the tag, but I want to know why
>>> this restriction is in there in the first place?  If there is a good
>>> reason for it then I will probably just add this info to the
>>> documentation.
>>
>> Because bundle is not just a random collection of objects, a tarball of
>> your .git/objects/.  Instead, it is a (partial) history that leads to a
>> particular (set of) versions.
>>
>> Think of it as what "git fetch $somewhere $that_branch" could give you.
>> It is not giving you just a collection of random objects, but you are
>> choosing from the endpoint the particular repository ($somewhere) is
>> offering you.
>>
>> When you publish your history to be fetched over the network (or locally
>> for that matter), you do not just put bunch of objects there.  You give
>> branches to mark where the histories end.  It's the same deal with
>> bundles, and the only difference is the transfer may go over sneakernet.
>>
>>
>
> Sure, I understand that.  However, I can use a tag to create a bundle
> that does not go to an endpoint.  I can also advance that branch to
> a later commit by whatever mechanism (say committing something)
> and then the bundle no longer points to the endpoint, it points to
> the middle somewhere.  Git, from what I have seen, likes to treat
> HEADs as just another commit and it is a bit surprising to see this
> particular limitation here.  I see this as kind of like git-push where
> the person who has the commits is specifying them, and there you
> can specify any commit.  Although pull/fetch have similar
> limitations, so perhaps it is not so surprising.
>
> If I wanted to share a patch series via bundle and the patches I
> wanted went from HEAD~10..HEAD~5 then I *could* checkout -b
> HEAD~5 or tag HEAD~5, but I do not see an advantage to doing so.
>
> I don't really use bundles, so it's not a big deal to me.  I just
> thought I would ask to make sure I wasn't going to break something.
>
> Thanks,
> Govind.
>
