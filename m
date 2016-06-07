From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Documentation: triangular workflow
Date: Tue, 07 Jun 2016 12:12:38 -0700
Message-ID: <xmqqr3c8q0d5.fsf@gitster.mtv.corp.google.com>
References: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, philipoakley@iee.org, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:14:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAMQh-0000Qy-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbcFGTMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 15:12:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754687AbcFGTMm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 15:12:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5192622136;
	Tue,  7 Jun 2016 15:12:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GwHceMZqeIw0
	gDlQh5E210H7j70=; b=jgPti8UI7G1l1o5Ybzm5OYJCNXtfwdj+DetbUvnXN95J
	7CUiRCVyLQilFF6Ceb15OGfVWodAkMfC/UBYayfyadYkyjdtDgpNNH89yzww63NS
	XU6B5QRrQG+KD7zTczw+cNaDYi5TEW0q8ns0hisbsk00wEz4O/vS7UfgpWPtzks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QKxNOU
	wqI6yNx8OjHHvuldYdCpfN0EiD21BKXPhYSB+7aSZePECGPr0NNPNjIX6Fw79OhP
	TFnu1O947e3O1sG45ezHmKVzI3Dd3enViGQqeM5he0C3fR9OOIlXl4Ri+frwYr9A
	iXkRgXQN5yvWwTWQjGMIHMiEIaVWd49raW0rY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4939522135;
	Tue,  7 Jun 2016 15:12:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B274022134;
	Tue,  7 Jun 2016 15:12:39 -0400 (EDT)
In-Reply-To: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	(Jordan DE's message of "Tue, 7 Jun 2016 10:38:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD7C677E-2CE3-11E6-BC34-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296708>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkfl=
ows.txt
> index f16c414..3b5fd09 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -463,6 +463,156 @@ if you get conflicts: `git am -3` will use inde=
x information contained
>  in patches to figure out the merge base.  See linkgit:git-am[1] for
>  other options.
> =20
> +TRIANGULAR WORKFLOW
> +-------------------
> +
> +In some projects, you cannot push directly to the project but have t=
o
> +suggest your commits to the maintainer (e.g. pull requests).
> +For these projects, it's common to use what's called a *triangular
> +workflow*:
> +
> +- Taking the last version of the project by fetching (e.g.
> +  **UPSTREAM**)

"by fetching (e.g. UPSTREAM)" does not finish the sentence nicely.

"... by fetching from **UPSTREAM**" would work better.  So would
"Fetching the latest version from the project (e.g. UPSTREAM)".

> +- Writing modifications and push them to a fork (e.g. **PUBLISH**)
> +- Opening a pull request
> +- Checking of changes by the maintainer and, merging them into the
> +  **UPSTREAM** repository if accepted

You'd want to end these sentences with full-stop, by the way

> +........................................
> +------------------               -----------------
> +| UPSTREAM       |  maintainer   | PUBLISH       |
> +|  git/git       |- - - - - - - -|  me/remote    |
> +------------------       =E2=86=90       -----------------
> +              \                     /
> +               \                   /
> +          fetch=E2=86=93\                 /=E2=86=91push
> +                 \               /
> +                  \             /
> +                   -------------
> +                   |   LOCAL   |
> +                   -------------
> +........................................
> +
> +Git options to use:
> +~~~~~~~~~~~~~~~~~~~
> + - `branch.<branch>.remote`
> + - `branch.<branch>.pushRemote`
> + - `remote.pushDefault`
> + - `push.default`
> +
> +See linkgit:git-config[1].

The title says "options" but listed are configuration variables and
the referred document is also about git-config.  Perhaps retitle it to

	Useful configuration variables
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

or something like that?

One thing after reading the above lines that immediately came to my
mind was this:

    After listing these four and telling the reader to "See ...", is
    there anything else the reader needs to learn from below?

It may make the result a lot more useful document if this gives an
impression to the reader as if you are saying (you do not have to
actually say it) "We will guide you how to set up your workflow in
triangular way, and here are the key configuration variables you
will end up using; don't worry about the details of them, we'll
teach you all about them soon in the following paragraphs."

And I found that "See linkgit:git-config[1]" go directly against
that line of narrative.

> +Push behaviour
> +~~~~~~~~~~~~~~
> + ...
> +
> +Case 2: LOCAL is a clone of **UPSTREAM**
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +'In this case, the remote named `origin` corresponds to **UPSTREAM**=
=2E'
> +
> +Adding **PUBLISH** remote:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +* `git remote add publish <PUBLISH_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It may perhaps be only me, but these blind instructions puts me off,
and what I find lacking is "Why should I do this?"  "What benefit do
I get by doing this".  Start it perhaps like this?

	Because you will be pushing into the publish repository
	often, instead of having to type its URL every time, you
	want a short name you can use to call it.

and then give that "remote add".

> +
> +**Method 1: One option for all branches**
> +
> +Setting `remote.pushDefault` in order to push to **PUBLISH** without
> +argument for push.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +* `git config remote.pushDefault publish`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is not too bad, but I'd say

	With the "remote add" above, you can say "git push publish"
	to push there, instead of saying its URL.  But you may want
	to be even lazier and say just "git push".  To do so:

As a document that is geared toward being a tutorial, I personally
think it is better to stick to one arrangement rather than
presenting case 1/2 as two equivalently valid arrangements and
describe them to equal degree of detail.  Otherwise, after finishing
reading Case 1 and immediately reading Case 2 heading, the reader
would start wondering "Which one should I pick?  What are the pros
and cons?".

A typical reader of this document would have an upstream in mind,
perhaps a clone of it locally, and may or may not yet have a publish
repository, so one valid choice could be to use Case 2.

Whichever one you choose, the description should not begin with
"pushing".  A reader who is the target of this document (i.e. who
owns the LOCAL and PUBLISH repository) begins by cloning and/or
fetching, followed by working on her own change while staying up to
date, and pushing is the last thing she does in the flow.

So I'd recommend reordering the description to

    * Introduction.  As a summary, here are the four configuration
      variables you'll be using to make it easier to arrange.

    * "Preparation".  Clone from the upstream, create an empty
      publish repository and set it as a secondary remote, with
      pushdefault pointing at it.

    * "Staying up-to-date".  You do not have to describe "git fetch"
      or "git pull" from the upstream aka origin with too much
      detail, as having or not having a publish repository does not
      change anything on this side.

    * "Making your work available".  You would want to reiterate the
      fact that "git push" does not go to the upstream but to your
      publishing place thanks to the earlier pushdefault
      configuration.

    * "Alternatively...".  In this section, you could mention
      possible other arrangements.  One could be to set pushdefault
      for each and every branch (aka your Case 2/Method 2), which
      shouldn't be necesssary because at the beginning of the
      document we made it clear that we assume that the reader
      cannot push to upstream--the normal place she would be pushing
      is to her own publishing place, and configuring "usually all
      of them go to my publishing place, but this one alone will go
      someplace else" (1) is an advanced workflow element, and more
      importantly (2) is not specific to triangular workflow.

      Another altenative arrangement worth mentioning may be your
      Case 1, i.e. to point at your publish place and a secondary
      "upstream" pointing at where your upstream publishes their
      work.  You can describe what needs to be changed compared to
      the above three sections.

so that a first-time reader can learn _one_ workable organization
quickly without having to choose blindly between many choices.

Thanks.
