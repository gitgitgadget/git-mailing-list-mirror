From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: co-authoring commits
Date: Thu, 18 Jun 2015 23:25:54 +0200
Message-ID: <CAOvwQ4jb-w4+Ah3ZhVE0j1aXLx1=8tRN3Wo98tz+G-wEqLGAcA@mail.gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617225224.GF4076@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:26:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hKa-0005yV-B7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbFRV0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:26:37 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35517 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbFRV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:26:35 -0400
Received: by obbgp2 with SMTP id gp2so62693399obb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YsHutYplSgd6LSqtIQVTUlKf1dyf4iFotVUWK9qcvOk=;
        b=r+sVavJ/yIkgOaoXMVIHfvHa1OnfNxHTUj+kM5f+Nly2lunSH3EGlw92amzE/vbbuz
         otbGI/zvtS95vYtlx3GRsMlLsUz40BnOgjpYDeQsrL1WP+Fk/pJG3qjA7SOZncX6nQuH
         zI8CkvZnA2fBOm1zId4wqg7E0K3YXFE+mpxJW/y8qNZBXE15Prtmgu84LI93ddRijS1Y
         sgjBWL6zmmtcK0yV2B/zUXxxeIOqicCXljnWnUZ3Wrcw5jI+wyTBtspAcUZ9uZFusPPA
         3W+KNyLBvoST8J+ZJ5j+6gH5K9zn+t3EnuzxOhthQFnVTsnFGZKMkZwG5JUi0XGOzhxH
         SYMg==
X-Received: by 10.202.78.214 with SMTP id c205mr10141017oib.131.1434662794764;
 Thu, 18 Jun 2015 14:26:34 -0700 (PDT)
Received: by 10.76.158.202 with HTTP; Thu, 18 Jun 2015 14:25:54 -0700 (PDT)
In-Reply-To: <20150617225224.GF4076@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272079>

On Thu, Jun 18, 2015 at 12:52 AM, Theodore Ts'o wrote:
> On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> >
> > By allowing multiple authors, you don't have to decide who's the
> > primary author, as in such situations usually there is no primary
> > at all. I sometimes deliberately override the author when
> > committing and add myself just as another co-author in the commit
> > message, but as others have noted it would be really great if we
> > can just specify multiple authors.
>
> Just recently, there a major thread on the IETF mailing list where
> IETF working group had drafts where people were listed as co-authors
> without their permission, and were upset that the fact that their
> name was added made it seem as if they agreed with the end product.
> (i.e., that they were endorsing the I-D). So while adding formal
> coauthor might solves (a few) problems, it can also introduce
> others.

You can misuse signed-off/reviewed-by/etc the same way.

> Ultimately there is one person who can decide which parts of the
> changes to put in the commit that gets sent to the maintainer. So
> there *is* someone who is the primary author; the person who takes
> the final pass on the patch and then hits the send key.

If you (do it in isolation and) want to take full responsibility, yes,
but I consider reviewed-by/signed-off as taking partial responsibility
because it's a vetting process.

> One could imagine some frankly, quite rare example where there is a
> team of people who votes on each commit before it gets sent out and
> where everyone is equal and there is no hierarchy. In that case,
> perhaps you could set the from field to a mailing list address. But
> honestly, how often is that *all* of the authors are completely
> equal[1]?

For that case something like patchwork, phabricator, or gerrit seems
to be the logical tool to use, and should ideally leave a trace of
approvals and such in the resulting commit message(s). If the patch
management tool takes care of merging the commit(s), it can be harder
to misattribute signed-off/reviewed-by/etc, which is a good thing.

> In my personal practice, if I make significant changes to a patch, I
> will indeed simply change the submitter, and then give credit the
> original author. This is the case where I'm essentially saying, "Bob
> did a lot of work, but I made a bunch of changes, so if things break
> horribly, blame *me*, not Bob".
>
> Alternatively, if I just need to make a few cosmetic changes to
> Alice's patch (i.e., fix white spaces, correct spelling, change the
> commit description so it's validly parsable and understandable
> English, etc.), I'll just add a comment in square brackets
> indicating what changes I made before I committed the change. This
> seems to work just fine, and I don't think we should try to fix
> something that isn't broken.

Perfectly valid use cases, but different from the scenarios Josh
mentioned.

You could of course use multiple (everybody makes their own) commits,
where you risk breaking bisectability and avoid the need for equal
co-authorship support. In pair programming such intermediate commits
will quite often be fixups, and when you attempt to squash the fixups
for bisectability's sake, you may get a desire for co-authorship of
the resulting commit.
