Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BD81F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 08:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbcHAIzJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 04:55:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:51959 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcHAIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 04:55:07 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYtId-1bpR8s1e7f-00VjSK; Mon, 01 Aug 2016 10:54:49
 +0200
Date:	Mon, 1 Aug 2016 10:54:48 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap
 implementation
In-Reply-To: <xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607301056120.11824@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <20160729161920.3792-2-kcwillford@gmail.com> <xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+rAt0PF16EC9BDjbH0QDljeM5edIu8H0V1ArMyc8npWLl3eWc/t
 7stbuKkoGOYDB+xzHDL8JqlbB3b2ySQgzkj3DVNxkW1sNygj2HLya4Ykm82hSqinn6JoCOE
 T/eWeb/tpFFGpY0LZvOjy0v6pLXC+nJMjfIaUUxL2hXTvJGtC+Qby12RNf4G1OcAUTNLXEs
 8afxUI9i5CPkABVe3IL3Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IYlsdZ5AGpM=:y7UTTphIX+zNaQafLAEXt1
 zKy0ixKKjMrN+z4ksbPDhx81HnQGRoLBXeXv86UAUXm1BjoMAq5mFcLTtbseJE6Neo8ceY1NV
 TMq9qD0ShH0cVLD5v6UBqOzS6MOPC4i0DxGLM0o8Q/j6PiEeufN5dLNa6NsSIyTNujLMfg1LL
 S1SvjF7J7ZYFAcjFCOa60o8y//W0SDHcYHzpVuo4+qcctnRpPHFUF/mgSauVGje2FxFG28fuW
 mcZM3peIhSnOmHD5smttzybBKjsRWxmChhGW3VOf3IWZM0B4bBmLUsyVgXogM4Qv1voS5zdeV
 CH4Q2BIjqn0rfm/Zk+k01T9xL/x4lxqWv5fGClNETrFFtouZChMoep8OvWkhCcpQhKdt5nF46
 QMj+PyfRPxOyrdT4fnfv+ZtDNhelnp9mlaiCfsANmhyr20Or5/W90UKY6d2S17PU5xgQK7mT3
 FMAiifkZ4BNuCiifygnd8sMDp34LzFbBVTCJUtqusxYPZ50D+/0K+3MBcXGQpC9CSZ0hLqUZE
 PjbrJeOHw/JyvGo9hOgDSdFG7bTmr59be2nas/A7AaiZMryHvdnPECo9sctiHnqvd25yORH9o
 4qLYCzZSBQbtzdn+rcwSLoAt3Fv71vTia2E2xAWiqoH3XDrHVZ7bMzjfSVes2FCEoGj5rkrfQ
 yHagQUcXoRuhzC6Ckd80vl1eJjF6XrzO34xDerGC5eFuDucTOerNIPItbH15CQ6SO4nYxsjWF
 P0UdGhLXkkwIVykBkOkk/P05MtRF7jdMRr8KhDyHzQ2d8M1K72oSjkOszmamI1tkLPP9elG70
 D1rCcsz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

first of all: Kevin & I are colleagues and I helped prepare this patch
series. I had the idea to have a two-level patch ID to help e.g. when an
alternate object store is hosted on a (slow) network drive.

On Fri, 29 Jul 2016, Junio C Hamano wrote:

> Kevin Willford <kcwillford@gmail.com> writes:
> 
> >  struct patch_id *add_commit_patch_id(struct commit *commit,
> >  				     struct patch_ids *ids)
> >  {
> > -	return add_commit(commit, ids, 0);
> > +	struct patch_id *key = xcalloc(1, sizeof(*key));
> > +
> > +	if (init_patch_id_entry(key, commit, ids)) {
> > +		free(key);
> > +		return NULL;
> > +	}
> 
> This is a tangent, but this made me wonder if it is safe to simply
> free(3) the result of calling hashmap_entry_init() which is called
> in init_patch_id_entry().  It would obviously become a resource
> leak, if a hashmap_entry (which the api documentation says is "an
> opaque structure") holds any allocated resource.

It would be a serious bug if hashmap_entry_init() played games with
references, given its signature (that this function does not have any
access to the hashmap structure, only to the entry itself):

	void hashmap_entry_init(void *entry, unsigned int hash)

Please note that the `void *entry` really needs to point to a struct whose
first field is of type `struct hashmap_entry`. This is not type-safe, of
course, but C does not allow a strong sub-typing of the kind we want to
use here.

> The fact that hashmap_entry_init() is there but there is no
> corresponding hashmap_entry_clear() hints that there is nothing to
> be worried about and I can see from the implementation of
> hashmap_entry_init() that no extra resource is held inside, but an
> API user should not have to guess.  We may want to do one of the two
> things:
> 
>  * document that an embedded hashmap_entry does not hold any
>    resource that need to be released and it is safe to free the user
>    structure that embeds one; or
> 
>  * implement hashmap_entry_clear() that currently is a no-op.

Urgh. The only reason we have hashmap_entry_init() is that we *may* want
to extend `struct hashmap_entry` at some point. That is *already*
over-engineered because that point in time seems quite unlikely to arrive,
like, ever.

In that light, as you said, why would we overengineer things even further
by introducing a hashmap_entry_clear(), especially given that we won't
catch any forgotten _clear() calls, given that it is a no-op anyway?

Let's just not.

Ciao,
Dscho
