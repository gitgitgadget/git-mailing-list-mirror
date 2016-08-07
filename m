Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0CA2018E
	for <e@80x24.org>; Sun,  7 Aug 2016 10:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbcHGKmi (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 06:42:38 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37783 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbcHGKmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 06:42:37 -0400
Received: by mail-it0-f49.google.com with SMTP id f6so60179881ith.0
        for <git@vger.kernel.org>; Sun, 07 Aug 2016 03:42:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=57Fap4vWQt18q6s2e0TiR7O1nZkAm+8hLBuxekU/nEA=;
        b=JMyboYzlmnyGvssVYuOvPyPom9VGyr2TwrQrYgmBt2UmvRLWIbHIOTDFwDcHZm4VBm
         42UU4wwkJlSu1jmcGpUY8SYS0Nu/MLBHm3822p/bK+BgFprGDIC0T0NDewbbtQy1Eo5P
         puAqSYXG18/3pl780JjJp0hLkC1Jqa2kJJGmMlJmsdxd6laOYIDhdBPl90qmbDPEBerZ
         CmVN2FkeoEtXq410fqAlIep5kBaVPos8gOS6Vev48xAqFlf/hyPlumf4OPbg49hmBpgt
         moMofJ22PLfUE7m4rPZz4lREMy4I3lpNG5ZYM+GxoBGoSANxzF6ecRx9lX6SzCYkDXvb
         Nq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=57Fap4vWQt18q6s2e0TiR7O1nZkAm+8hLBuxekU/nEA=;
        b=FFm7ULmsG734Cv0+pGQa06gbKZMJHQQlxeRhfAQZRONunEnlhF+3RBKK5oNjvbXTK5
         ow5Y8j22SW0NvBebaIm8aK4scm0Z72e/tZzQzZtQ0qCmQh9HFZxprVui+yVb2hgoPZY4
         6JpvbjzhNheJw+CQf2AtZ6099e6aBtLrkfSqBjYR423l+tdCy50Y/rLyO92j2gt0kaz7
         fSFysFQO5fneJQzdlt98TjQzuUtTwF03HYlTM7nL6fc9J/A8lYhGEkeWCKWAr9gqVk1w
         SdgpMyDM8/a2+rpR0KvrHHPMkp+h3S42hHLc++JIzgae7g8phOTxedGuk87NVHu27Eyg
         v2dQ==
X-Gm-Message-State: AEkoousTktYnbp6ki9+DieLaNXGQcnUnyyR+ym21M7jViw401L3sl9p5Tssv/V+cDfIis9NnPgWVq2JyQ9qAbA==
X-Received: by 10.36.91.134 with SMTP id g128mr13127313itb.42.1470566556915;
 Sun, 07 Aug 2016 03:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Sun, 7 Aug 2016 03:42:06 -0700 (PDT)
In-Reply-To: <20160807080857-mutt-send-email-mst@kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com> <18979417.pyyHNUINeQ@mfick1-lnx>
 <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com> <20160804234920.GA27250@redhat.com>
 <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com> <20160807080857-mutt-send-email-mst@kernel.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 7 Aug 2016 12:42:06 +0200
Message-ID: <CACsJy8DhDMkmq-WCVHSMYVTTfEXNFUUzz5Cq9hQj_tGRUTj3ZA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	"Michael S. Tsirkin" <mst@redhat.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 7, 2016 at 7:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Aug 05, 2016 at 08:39:58AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>> > On Thu, Sep 10, 2015 at 11:39:49AM -0700, Junio C Hamano wrote:
>> >> The problem with "empty commit trick" is that it is a commit whose
>> >> sole purpose is to describe the series, and its presence makes it
>> >> clear where the series ends, but the topology does not tell where
>> >> the series begins, so it is an unsatisifactory half-measure.
>> >
>> > Actually, when using topic branches the series always ends at head, so
>> > it's better to keep the empty commit where series begins.
>>
>> But that would mean that you would need to destroy and recreate more
>> commits than you would need to.  If you have a five-commit series
>> (with the bottom "description" one, you would have six commits) and
>> you are already happy with the bottom two but want to update the
>> third one, you wuld have to "rebase -i" all six of them, reword the
>> bottom "description" to adjust it to describe the new version of the
>> third one _before_ you even do the actual update of the third one.
>>
>> That somehow feels backwards, and that backward-ness comes from the
>> fact that you abused a single-parent commit for the purpose it is
>> not meant to be used (i.e. they are to describe individual changes),
>> because you did not find a better existing mechanism (and I suspect
>> there isn't any, in which case the solution is to invent one, not
>> abusing an existing mechanism that is not suited for it).
>
> A flag that marks a commit "beginning of series" then?

git-notes was mentioned in this thread back in 2015, but I think it's
discarded because of the argument that's part of the cover letter was
not meant to be kept permanently. But I think we can still use it as a
local/temporary place for cover letter instead of the empty commit at
the topic's tip. It is a mark of the beginning of commit, it does not
require rewriting history when you update the cover letter, and
git-merge can be taught to pick it up when you're ready to set it in
stone.
-- 
Duy
