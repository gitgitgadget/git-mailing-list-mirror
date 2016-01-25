From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Mon, 25 Jan 2016 15:42:50 +0100
Message-ID: <20160125144250.GM7100@hank>
References: <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
 <20160122055255.GA14657@sigill.intra.peff.net>
 <20160122060720.GA15681@sigill.intra.peff.net>
 <20160124143403.GL7100@hank>
 <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 15:42:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNiLc-0000C9-U3
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 15:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbcAYOmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 09:42:24 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35799 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbcAYOmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 09:42:22 -0500
Received: by mail-wm0-f46.google.com with SMTP id r129so66867483wmr.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xa6GkHncWE9HE90BFviMW0JaFgVDq4dZZj1lNVp1ZAw=;
        b=BnfqWLFNiUgv3j0abtIL+b4VWrW4Ifc0Uuvva/Qf5ZfURKm8+WAzTVG3yc4NI5YBGd
         M3VGUwbJ7vHhCfWzaMlQTu21HXd4ewi64d+F5n8fBcUOzHxc51v1x8rFe3yzbJTy7OaM
         2yRlt7qbR15PL4JfdSJzBRYn2SA1yPYR9byj8MEdL5Fdu4LOjhNX4KeFbTcwSrrCJFBA
         +Bvf6O2gghkh3sguz5HzsEiMAUoAJz0sLVILOpoIAexKdhDwDab4+SGGddrKlpA8uC8U
         HAph+aXo3VHJmTEgKl5GUim/CBQAl7nKydzy6ygrK/aAVyZcnqe9nNrIgNojkZCEHvdE
         HrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Xa6GkHncWE9HE90BFviMW0JaFgVDq4dZZj1lNVp1ZAw=;
        b=VZ9TT9TCJKF5p2NcOYXHt/QI/UIGpU9u+q2rc9h9Kht1U83vCCNrtzUWsuD/9ctEZA
         W31qu2O2GbBVSEx80sULeCxYEm5N+MXNDUm2VqLn3zzBsg35RZ9GNbfdPQSWVMB8kMJM
         6UjvZwBrcS3bJ5I6PlPwwNP3lqBoNtdXe/RJpaI626MfGnZQmL4KYOLJpG1X4YVoIk+r
         Bt5/7XWAUPUy26DvI4b8RPGAe5tIcxkthz0oOgwIX/+Kr511WRFa9Aznq78MGyCExo0Z
         +ve+pWHQfPbQwiGJnumX/XpvwwP6K7pf60wK+nq+MomANZ/IryvOLHRrs/IVqPzql81F
         LVpA==
X-Gm-Message-State: AG10YOSWiDCUDDM0SN9Q/N8fy3NG6kHZ+zDT+Qrvz+g+bse9vZ9BeWnCo0BJvOIxuyTRkA==
X-Received: by 10.194.200.106 with SMTP id jr10mr20585682wjc.100.1453732941507;
        Mon, 25 Jan 2016 06:42:21 -0800 (PST)
Received: from localhost (host146-106-dynamic.20-79-r.retail.telecomitalia.it. [79.20.106.146])
        by smtp.gmail.com with ESMTPSA id v191sm16452072wme.1.2016.01.25.06.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 06:42:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284734>

On 01/24, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Sorry, but I am confused by all of the above.
> >
> > We write the thing out with write_entry(), possibly applying smudge
> > filters and eol conversion to the "git" representation to create the
> > "working tree" representation in this codepath, right?  The resulting
> > file matches what the user's configuration told us to produce.
> >
> > Until the working tree file is changed by somebody after the above
> > happens, we shouldn't have to check the contents of the file to see
> > if there is a difference.  By definition, that has to match the
> > contents expected to be there by Git.
> >
> > The only case I can think of that the above does not hold is when
> > the smuge/clean and the eol conversion are not a correct round-trip
> > operation pairs, but that would be a misconfiguration.  Otherwise,
> > we'd be _always_ comparing the contents without relying on the
> > cached stat info for any paths whose in-core and working tree
> > representations are different, not just those that are configured
> > with misbehaving smudge/clean pair, no?
>
> To put it differently, if a blob stored at path has CRLF line
> endings and .gitattributes is changed after the fact to say that it
> must have LF line endings, we should treat it as a broken transitory
> state.

Right, I wasn't considering this as a broken state, because t0025 uses
just this to transition between the states.

> There may have to be a way to "fix" an already "wrong" blob
> in the index that is milder than "rm --cached && add .", but I do
> not think write_entry(), which is shared by all the normal codepaths
> that writes out to the working tree, is the best place to do so, if
> doing so forces the contents of the paths to be always re-checked,
> just in case the user is in such a broken transitory state.

Maybe I'm misunderstanding something, but the contents of the paths
are only re-checked if we are in such a broken transition state, and
the file stored in git has crlf line endings, and thus would be
normalized.  In this case we currently re-check the contents of that
file anyway, at least when the file and the index have the same mtime,
and we actually show the correct output.

I'm not too familiar with the eol conversion code, so I might be
missing something.

--
Thomas
