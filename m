From: david@lang.hm
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 16:41:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1111021640340.20915@asgard.lang.hm>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vsjm6gkte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 03 00:42:20 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLkRn-0002lk-Ea
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Nov 2011 00:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1KBXmM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 19:42:12 -0400
Received: from mail.lang.hm ([64.81.33.126]:41961 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669Ab1KBXmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 19:42:11 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id pA2NftET008503;
	Wed, 2 Nov 2011 15:41:55 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vsjm6gkte.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184685>

On Wed, 2 Nov 2011, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I hate how anonymous our branches are. Sure, we can use good names for
>> them, but it was a mistake to think we should describe the repository
>> (for gitweb), rather than the branch.
>>
>> Ok, "hate" is a strong word. I don't "hate" it. I don't even think
>> it's a major design issue. But I do think that it would have been
>> nicer if we had had some branch description model.
>> ...
>> Maybe just verifying the email message (with the suggested kind of
>> change to "git request-pull") is actually the right approach. And what
>> I should do is to just wrap my "git pull" in some script that I can
>> just cut-and-paste the gpg-signed thing into, and which just does the
>> "gpg --verify" on it, and then does the "git pull" after that.
>>
>> Because in many ways, "git request-pull" is when you do want to sign
>> stuff. A developer might well want to push out his stuff for some
>> random internal testing (linux-next, for example), and then only later
>> decide "Ok, it was all good, now I want to make it 'official' and ask
>> Linus to pull it", and sign it at *that* time, rather than when
>> actually pushing it out.
>
> You keep saying cut-and-paste, but do you mind feeding the e-mail text
> itself to a tool, instead of cut-and-paste?

think webmail (i.e. gmail), to feed the e-mail itself to a tool you either 
need to cut-n-paste the entire e-mail or you have to first save the mail 
to a text file. both of which are significantly harder than doing a 
cut-n-past of a portion of the message.

David Lang

> The reason I am wondering about this is because in another topic (also in
> 'next') cooking there is an extended support for topic description for the
> branch that states what the purpose of the topic is why the requestor
> wants you to have it (this information can be set and updated with "git
> branch --edit-description").
>
> A respond-to-request-pull wrapper you would use could be:
>
> - Get the e-mail from the standard input;
> - Pick up the signed bits and validate the signature;
> - Perform the requested fetch; and
> - Record the merge (or prepare .git/MERGE_MSG) with both the signed bits.
>
> and the "signed bits" could include:
>
>   - the repository and the branch you were expected to pull;
>   - the topic description.
>
> among other things the requestor can edit when request-pull message is
> prepared.
>
> That would get us back to your "the lieutenant tip is not so special, but
> the merge commit the integrator makes using that tip has the signature for
> this particular pull" model.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
