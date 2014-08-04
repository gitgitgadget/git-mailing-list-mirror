From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Tue, 5 Aug 2014 00:19:32 +0100
Organization: OPDS
Message-ID: <C4E435A5EF324ABCBCC0930A9EB56141@PhilipOakley>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org><1406994383-5076-2-git-send-email-philipoakley@iee.org><xmqq38dctcmz.fsf@gitster.dls.corp.google.com><F97E9146985F4449A937B9C5CCA1D7F5@PhilipOakley> <xmqqa97jrjk2.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 01:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XERXp-0008NV-2d
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 01:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaHDXTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 19:19:37 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:19690 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752156AbaHDXTg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 19:19:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkYoALMU4FMCYJ75PGdsb2JhbABbgw1jAUWHL4EEy0sFAQIBAQyBBhcFAQEBATg2g34FAQEEAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiCkMtAKQSI9MNYMBgRwFilWHCIV9nFk8Lw
X-IPAS-Result: AkYoALMU4FMCYJ75PGdsb2JhbABbgw1jAUWHL4EEy0sFAQIBAQyBBhcFAQEBATg2g34FAQEEAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiCkMtAKQSI9MNYMBgRwFilWHCIV9nFk8Lw
X-IronPort-AV: E=Sophos;i="5.01,801,1400022000"; 
   d="scan'208";a="563406026"
Received: from host-2-96-158-249.as13285.net (HELO PhilipOakley) ([2.96.158.249])
  by out1.ip05ir2.opaltelecom.net with SMTP; 05 Aug 2014 00:19:32 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254793>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> This however is backwards, no?  The history on 'origin/master' may
>>> not be up-to-date in the sense that if you run 'git fetch' you might
>>> get more, but it absolutely is up-to-date in the sense that it shows
>>> what the origin has to the best of your repository's current
>>> knowledge.
>>
>> I still think that the user/reader shouldn't be creating patches 
>> based
>> on wherever someone else had got to, rather it should just be patches
>> from their own feature branch.
>
> You forked your topic branch off of the shared project history aka
> origin/master and built some.  You may have sent some patches off of
> your previous work to the upstream, and origin/master may or may not
> have applied some of them since your topic forked from it.  The
> patches you are sending out is from your own topic branch.
>
> You may be cooking multiple topics, and your local 'master' branch,
> which you never push back to 'origin/master', may contain any of
> these branches.  You do not fork off a new topic out of there.  Best
> case, you would fork from 'origin/master'; a bit worse case, you
> have to fork from another of your topic branch that your new topic
> has to depend on.
>
> Nowhere I am assuming that "the reader is creating paches based on
> wherever someone else had got to".  Sorry, but I have no idea what
> you are complaining about.

I think we are talking at cross purposes. My starting point is that (the 
examples says that) the reader wants to create a patch series for a 
local branch, relative to their <some name> branch which they branched 
from (e.g. the example, relative to Git, could have been from a 'pu' 
picked up a couple of days earlier, when they'd have said 'git 
format-patch pu' ;-).

Having generated their short patch series, and they probably want to 
expose the series to some collaborator or other for comment, help and 
guidance (or whatever). They may just want to review it themselves. But 
that choice of what to do with it is surely not part of the format-patch 
documentation. So I'm trying to avoid defining a workflow (then or now).

In the case when the patch series is meant to be ready for being applied 
upstream then all the other considerations apply, but the example 
doesn't, at least in my eyes, claim to be that.

IIRC I once did make the mistake of using format-patch on a branch (off 
pu) I hadn't rebased since fetching and updating the local pu, so it 
produced a lot of extra patches, but I digress.
>
>> However the rest of your argument still
>> stands with regard to accidental/unexpected conflicts with other
>> upstream work, and the reader should ensure they are already up to
>> date - maybe it needs a comment line to state that.
>
> Sorry, but I am not sure how much you understood what I wrote.
That may be true. I taken your "not be up-to-date" to be relative to the 
real upstream.

>
> The primary reason why 'origin' in the example should be replaced
> with 'origin/master' is because that is the literal adjustment from
> the pre-separate-remote world order to today's world order.

I was trying to avoid a literal adjustment to what I'd perceived as a 
presumed workflow.

> The
> local branch 'origin' (more specifically, 'refs/heads/origin') used
> to be what we used to keep track of 'master' of the upstream, which
> we use 'refs/remotes/origin/master' these days.
>
> Side note: DWIMming origin to remotes/origin/HEAD to
> remotes/origin/master was invented to keep supporting this
> "'origin' keeps track of the default upstream" convention
> when we transitioned from the old world order to
> separate-remote layout.
>
> And the reason why 'origin' should not be replaced with 'master' is
> because your 'master' may already have patches from the topic you
> are working on, i.e. in your current branch, that the upstream does
> not yet have.

So this a 'develop on master' view, rather than a 'develop on feature 
branches' approach? Which could explain the misunderstanding.

> Running "git format-patch origin/master" will show
> what needs to be accepted by the upstream from you to reproduce your
> work in full; if you run "git format-patch master", it may miss some
> parts that you already have in your local 'master' but not yet in
> the upstream.
>
> I never talked about conflicts, and I still think that it is
> completely outside the scope of these examples.  Avoidance of
> conflicts with the work that is already commited to your upstream
> since you forked is the job for "rebase", not "format-patch".  The
> reason why it is wrong to replace 'origin' in that text with 'master'
> does not have anything to do with conflict avoidance.
>
> Puzzled...
> --
Did any of that help?
--
Philip 
