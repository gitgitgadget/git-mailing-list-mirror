Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4117E1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeCPWMN (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:12:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64095 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPWML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:12:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 757ABC64AE;
        Fri, 16 Mar 2018 18:12:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=gh9XnQHtTeCSkCIjz0htNAR+nbY=; b=SmdCii2
        VvUIP+fkeyV0kqaC06OFQAaAGVuQiAIA0Yp0XhWb5FpN87fHH6XLl/kp5wGyjqEx
        WMqmV7fh1MCP2V/rNQduJ1cAhT7Cw7rT8tMyHxxIxL3TPGLF/GxGkm2nJHlhJdvj
        4cOY8MQ+pq00TBjkPENk0p4M2LqyK5SNMsck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=sNcaCSwj0sEQz9jX+eMZqjQLiwn8pKq3/
        ZzMKJFVoMEpsv05wa+pLjZrNA1M9kP11uj/2Ck6rYhTFtPQ5KYG31irN25KuOzuk
        yBVnoUJy5LKIAGqr3chwKTu9j5sWTQO9E+aDVJYYIC05x7Sx+sjf1iuf4A8mBd8L
        u2nVuc5BjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D44FC64AD;
        Fri, 16 Mar 2018 18:12:11 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9036C64AC;
        Fri, 16 Mar 2018 18:12:10 -0400 (EDT)
Date:   Fri, 16 Mar 2018 18:12:09 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RelNotes: add details on Perl module changes
Message-ID: <20180316221209.GT6611@zaya.teonanacatl.net>
References: <xmqq7eqb3nct.fsf@gitster-ct.c.googlers.com>
 <20180316220748.4279-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316220748.4279-1-tmz@pobox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Pobox-Relay-ID: 12E70B3A-2967-11E8-A11E-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Document changes to core and non-core Perl module handling in 2.17.

This should have:

Signed-off-by: Todd Zullinger <tmz@pobox.com>

And perhaps also:

Helped-by: Junio C Hamano <gitster@pobox.com>

since I borrowed liberally from your initial text. :)

> ---
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> I haven't wordsmithed it fully, but it should say something along
>>> the lines of ...
>>>
>>>  Documentation/RelNotes/2.16.0.txt | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>
>> Eh, of course the addition should go to 2.17 release notes ;-)  I
>> just happened to be reviewing a topic forked earlier.
> 
> Maybe something like this?  I had intended to suggest a note about
> NO_PERL_CPAN_FALLBACKS as well, so that's included too.  I don't know if that
> should be expanded to provide more of a hint to users/packagers on platforms
> where these modules are harder to install, letting them know that we now have
> fallbacks to Error and Mail::Address.  That might allow scripts which were
> previously excluded to be included on their platforms.
> 
>  Documentation/RelNotes/2.17.0.txt | 14 ++++++++++++++
>  INSTALL                           |  3 ++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.txt
> index c828d37345..085bf1dba1 100644
> --- a/Documentation/RelNotes/2.17.0.txt
> +++ b/Documentation/RelNotes/2.17.0.txt
> @@ -75,6 +75,20 @@ Performance, Internal Implementation, Development Support etc.
>   * The build procedure for perl/ part has been greatly simplified by
>     weaning ourselves off of MakeMaker.
>  
> + * Perl 5.8 or greater has been required since Git 1.7.4 released in
> +   2010, but we continued to assume some core modules may not exist and
> +   used a conditional "eval { require <<module>> }"; we no longer do
> +   this.  Some platforms (Fedora/RedHat/CentOS, for example) ship Perl
> +   without all core modules by default (e.g. Digest::MD5, File::Temp,
> +   File::Spec, Net::Domain, Net::SMTP).  Users on such platforms may
> +   need to install these additional modules.
> +
> + * As a convenience, we install copies of Perl modules we require which
> +   are not part of the core Perl distribution (e.g. Error and
> +   Mail::Address).  Users and packagers whose operating system provides
> +   these modules can set NO_PERL_CPAN_FALLBACKS to avoid installing the
> +   bundled modules.
> +
>   * In preparation for implementing narrow/partial clone, the machinery
>     for checking object connectivity used by gc and fsck has been
>     taught that a missing object is OK when it is referenced by a
> diff --git a/INSTALL b/INSTALL
> index 60e515eaf7..c39006e8e7 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -126,7 +126,8 @@ Issues of note:
>  	  Redhat/Fedora are reported to ship Perl binary package with some
>  	  core modules stripped away (see http://lwn.net/Articles/477234/),
>  	  so you might need to install additional packages other than Perl
> -	  itself, e.g. Time::HiRes.
> +	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
> +	  Net::SMTP, and Time::HiRes.
>  
>  	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
>  	  you are using libcurl older than 7.34.0.  Otherwise you can use

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The secret of life is honesty and fair dealing. If you can fake that,
you've got it made.
    -- Groucho Marx

