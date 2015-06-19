From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: co-authoring commits
Date: Fri, 19 Jun 2015 20:02:34 +0200
Message-ID: <5584593A.5010406@gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com> <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com> <20150617205931.GB24079@cloud> <xmqqegla57hl.fsf@gitster.dls.corp.google.com> <20150617222828.GB24438@cloud> <xmqq381q551o.fsf@gitster.dls.corp.google.com> <55833758.6010000@gmail.com> <20150619042519.GB26001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, josh@joshtriplett.org,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:03:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60dG-0003fq-Um
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbbFSSDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 14:03:09 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34480 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbbFSSDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:03:00 -0400
Received: by wgfq1 with SMTP id q1so49050345wgf.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d5Vix1flnUUtvCbzLO720tgwlk89n+DudAq+lB4k8fQ=;
        b=xFY8gu1N2gu3DNmZ5Pv/aNgGIRRpF4ugKDZ+6/h6PPQIUeGFgMOlAt1HpB+O7zCBqG
         JPrczVmn/skU5qFt47Pp2ITUgvgFkCCxj/KlHtU/ttnVDjWioOE0TwoYGvs8XuT91spE
         qewWBBDrNUq+61le47+CaXOPdt7NIU8PilIufvyQnztYB8jbuCoCfdc7pcQzZzb46Nvp
         wxjj42uQmAxlUAETo7NAM5XUjfBPg4uJ01BrYlcpQ+XvXQZXza7lo41PoIxeyeDIN77Z
         EihqhhjfjZkn38iWu1Fyv3tg25Is/4OMj9qiaJsoKji4OAcyXlAzF91T9zqk3btVa6BK
         ugHw==
X-Received: by 10.180.99.166 with SMTP id er6mr8966566wib.58.1434736978937;
        Fri, 19 Jun 2015 11:02:58 -0700 (PDT)
Received: from [192.168.1.53] (abre142.neoplus.adsl.tpnet.pl. [83.8.98.142])
        by mx.google.com with ESMTPSA id xa9sm13429191wjc.43.2015.06.19.11.02.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2015 11:02:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150619042519.GB26001@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272175>

On 2015-06-19 at 06:25, Jeff King wrote:
> On Thu, Jun 18, 2015 at 11:25:44PM +0200, Jakub Nar=C4=99bski wrote:
>> Author and committer include datetime in the contents of the
>> field, which is used by Git for heuristics limiting walk. Coauthor
>> would have the same date as author, isn't it? If, after long
>> and involved discussion, we didn't add 'generation' field (for
>> easier cutting history walking), what chance adding 'coauthor'
>> has.
> I don't think the two situations are comparable. I would (and did) ar=
gue
> that a "generation" field is a bad header to bake in because of what =
it
> means (it is redundant with the graph structure).
>
> Whereas "co-author" is not a fundamentally bad; it's just not somethi=
ng
> we chose to support early on, and it would have to be added now.
It is true that "generation" field is redundant with the graph
structure, but it is
not necessarily something bad. You don't avoid using red-black trees or
AVL trees
because they keep some _redundant_ "bookkeeping" data in the node struc=
ture.
Same for "generation" header: it is bookkeeping, but would make Git mor=
e
effective
(faster).

Though I don't think any distributed version control system store such
data in
their equivalent of commit objects... maybe Veracity (I didn't check)..=
=2E
>> OTOH it would be nice to have support for .mailmap, and for
>> grepping... but the former could conceivably be added to the trailer
>> tool, the latter can be done with appropriate regexp in
>> "git log --grep=3D...".
> I don't think we munge trailers during "git log" pretty-printing at a=
ll
> now, but it is certainly something we could add (including mailmap-in=
g
> them).  That doesn't seem like much more work than showing the co-aut=
hor
> field, and it's a lot more generally applicable (you could mailmap
> S-O-B, Reviewed-by, and so forth).
This is certainly something nice to have. Though for author and
committer (and also
for tagger if I remember it correctly) we have mailmap-aware and
not-mailmapped
versions. There isn't anything like that for trailers.
>
> Similarly, something like "git shortlog" would have to learn about
> multiple authors under the "co-author" scheme. But likewise, it would
> not be much more work to teach it something like:
>
>   git shortlog --field=3DReviewed-by
>
> to handle an arbitrary trailer. And that is much more flexible.
It would also be nice to have something like this for blame... but at
least multiple
authors support doesn't make much sense wrt display uless using graphic=
al
blame tool (like "git gui blame").
>
>> I wonder what would break if one used 'Name <e@mai.l>, Name <em@i.l>=
'
>> as the author...
> The "normal" parser we use for pretty-printing goes left-to-right and
> will stop at the first ">", and show only the first author.
>
> Older versions of git would then get the date wrong, complaining abou=
t
> the ",". Newer versions parse the date from right-to-left to work aro=
und
> such bogosities (especially things like "<foo <bar>>") and so will pa=
rse
> back to the second ">".
>
> Fsck will definitely complain about it.
Ah, that is a problem.

If I remember correctly, I have seen somewhere using Bob+Alice for the
name part
and <bob+alice@example.com> or <bob@emai.l+alice@em.ail> for the email
part...
Would this work, I wonder?

[hoping that Thunderbird email didn;t screw up formatting]
--=20
Jakub Nar=C4=99bski
