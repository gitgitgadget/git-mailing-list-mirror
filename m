Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7111F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 02:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdAZCc3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 21:32:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57989 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752453AbdAZCc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 21:32:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00FA660ADD;
        Wed, 25 Jan 2017 21:32:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mr4KUikM+FQK0tB73EDFuZRE41U=; b=mUuQod
        FR/99ttQ+2VF+t1aRn2z1acgtGflXi9RPNfS8iJZZn2qQFMyUqc4JGfK2177nor4
        Z34RaYe2Z+EgZ39p0R7UtRcrUCNutpiu2RbmZqyT+1I6l/bCN0Vf9F95oArWOQw8
        MOhPshrhdVJWucxvGKrC76aCksoStYPs5sR/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QIRPOAqgB3Gy0g8YNmauJEf4p/kPoeAo
        UPiR5ERhd4+j+VK0J/+dL4r9IiLhWL5RPqsU2Ebu3pqvl899XnHz/HOG8ucFyN6x
        lkQSCCVERKFjH48hy6i4W4inUIR/eetJaNjxopI3jT/ZPGRSqMZlpksQZxPLzj/n
        fUwTJ3dkFNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAAAD60ADC;
        Wed, 25 Jan 2017 21:32:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 591E060ADB;
        Wed, 25 Jan 2017 21:32:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Force Confirmation for Dropping Changed Lines
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
        <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
        <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
        <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
        <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com>
        <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
        <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com>
Date:   Wed, 25 Jan 2017 18:32:24 -0800
In-Reply-To: <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 25 Jan 2017 16:40:38 -0800")
Message-ID: <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC59F7EE-E36F-11E6-9871-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Setting the merge driver to "unset" will do what you want, but it
> would leave the current branch as the tentative answer and doesn't
> actually make it easy to resolve properly. That would only require
> putting "pom.xml merge=unset" in the .gitattributes file.

Where did you get that "unset" from?  If that is this paragraph in
Documentation/gitattributes.txt:

    Unset::

            Take the version from the current branch as the
            tentative merge result, and declare that the merge has
            conflicts.  This is suitable for binary files that do
            not have a well-defined merge semantics.

you'd need to read the beginning of the file to learn how to declare
that an attribute is Unset for the path.  merge=unset is setting it
to a string value, i.e. you are doing

    String::

            3-way merge is performed using the specified custom
            merge driver.  The built-in 3-way merge driver can be
            explicitly specified by asking for "text" driver; the
            built-in "take the current branch" driver can be
            requested with "binary".

instead, specifying a custom merge driver "unset", which would
require something like

    [merge "unset"]
            name = feel-free merge driver
            driver = filfre %O %A %B %L %P
            recursive = binary

in your configuration file.

> That might be what you want, but it doesn't actually try to update the
> file during the merge so you'd have to hand-fix it yourself.

I think you should be able to do something like

	$ cat >$HOME/bin/fail-3way <<\EOF
	#!/bin/sh
	git merge-file "$@"
	exit 1
	EOF
	$ chmod +x $HOME/bin/fail-3way
	$ cat >>$HOME/.gitconfig <<\EOF
	[merge "fail"]
		name = always fail 3-way merge
		driver = $HOME/bin/fail-3way %A %O %B
		recursive = text
	EOF
	$ echo pom.xml merge=fail >>.gitattributes

to define a custom merge driver whose name is "fail", that runs the
fail-3way program, which runs the bog standard 3-way merge we use
(so that it will do the best-effort textual merge) but always return
with a non-zero status to signal that the result is conflicting and
needs manual resolution.


