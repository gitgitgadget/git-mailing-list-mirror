Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B33720951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751222AbdCQWgZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:36:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751182AbdCQWgY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:36:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 941B178A61;
        Fri, 17 Mar 2017 18:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gpk4oiOf7+QB3VrGyHfULpTs2Nw=; b=KoVAh3
        +58u2VP3pthIhRQibMjLH0VDTCYVgFUe1VWvKf8U8sJoCQLJX2tjEdlZB+s9eeEu
        OrNTqYGfWriLqNtDj9bscfYeWFosqXOAMVNQpomnUEqaVeo2ndG4s1NfhnTiR46B
        GC/OQZ7INJTiI4qD9IR5yVxRCDjdYhGK43q0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xuSfNLXS1UOje7VzuKhcTaYt5fxxYkFz
        MgKqW7E44anPOZ5JofgIHEXKkQN6oL6J2xxrlGPAOG/W5N3RrAx8tZhhb4JAQyeI
        q/ezPQfiMZ19pYTiDfPiX2rgGtwLfo9ahI3EPlKsilziBHaP2F1oxQx+uq9VOX+a
        BwRPwLDIFBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89F6478A5F;
        Fri, 17 Mar 2017 18:36:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6E1C78A5E;
        Fri, 17 Mar 2017 18:36:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Nevada Sanchez <sanchez.nevada@gmail.com>, git@vger.kernel.org
Subject: Re: Bug with .gitignore and branch switching
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
        <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
        <20170317220213.GO26789@aiede.mtv.corp.google.com>
Date:   Fri, 17 Mar 2017 15:36:20 -0700
In-Reply-To: <20170317220213.GO26789@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 17 Mar 2017 15:02:13 -0700")
Message-ID: <xmqqefxv5y57.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25526C98-0B62-11E7-AA0F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The most recent example I can find is 2010:
> http://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/.
>
> It also came up in 2007:
> http://public-inbox.org/git/C0E9F681E68D48EB8989022D11FEE3D1@ntdev.corp.microsoft.com/
> Earlier in that year it even made the "What's not in 1.5.2" list.
> http://public-inbox.org/git/11793556383977-git-send-email-junkio@cox.net/
>
> Perhaps those references could be a useful starting point for an
> interested person's thinking.

Thanks for links.  It seems that my thinking back in 1.5.3 timeperiod
was to introduce "precious" attribute.

I noticed that among the four-message "What's not in 1.5.2" series,
3/4 has a large discussion that may be relevant to Brandon's
"submodule is-active" thing.
