From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 18:04:10 -0500
Message-ID: <20100902230410.GA4850@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-11-git-send-email-avarab@gmail.com>
 <20100902200940.GB2531@burratino>
 <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
 <20100902203711.GE2531@burratino>
 <AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
 <20100902211339.GA2801@burratino>
 <AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIrG-0003Ju-2b
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab0IBXGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 19:06:07 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38133 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab0IBXGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 19:06:05 -0400
Received: by qwh6 with SMTP id 6so1068626qwh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=akKpSNaqBS4vO7pm6emq1gU/ptsrH9JvscxY1DjNrzU=;
        b=No2eEyrVURFZAqOApHB6ZQ4OQG2ZxwQZsOCs5Cx2Qbs4UHCq9tv+wfzil1r51EXCBt
         mW0FwSZ36JYcTAgvflaxlfZX2l7AyeiHao80bvIQfu7Nly2nYuqmhEFq2h+IGXVHeect
         5eXZ+gGic78OUq0y+2OSR/wl2gpAwSAk0GPMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lLFJ/UR+w/E6jMaYWLTcsJNbVs93Rso+58FUr8z75bUhv7l6EiWLOJDIDauxU1/R8C
         L7Zhp60BoUZkcDS37Cz+ppjY9D0fKOlkYYU1k4xSTqUF17/ZxqY6/tyIue5zgsUCz2dL
         Bh4dnZpLNVgjBgvygWCywit33A6pT72DGuwKk=
Received: by 10.229.2.35 with SMTP id 35mr6341465qch.271.1283468764836;
        Thu, 02 Sep 2010 16:06:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm1070501qcq.10.2010.09.02.16.06.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 16:06:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155221>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I can't see why translations in the tree (in po/) should be any
> trouble at all for us. What sort of issues do you see that the sed.gi=
t
> model might solve?

Only two: log noise and the problem of what to base patches on.

As you noticed while gettextizing (which is pretty much a one-time
thing), it is not much fun to do work on strings that aren't even
going to be used.  So translators might want to work against "next",
or at least "master".  How do the translations get back to "maint"?
Someone has to backport them.  What happens when we merge back to
"master"?

Now multiply that by the number of translations.  Making messages
merge up nicely with git tools as they drift from topic to topic if
translators want to keep both "maint" and "master" translated would
require at least a nice custom merge driver. =20

As we noticed before, the .po files are partially automatically
generated anyway.  Merging them as text makes about as much sense
as merging Word-generated .rtf files as text.  To avoid wasting time,
one wants to be able to work with their _content_.

What is that content?

It is a set of key/value pairs: for each string that appears in
the codebase (maybe together with disambiguating translators' notes),
what the translation is for it.  Merging that between branches of the
code base is utterly trivial: take the union.  Actually "merging" as
an operation here does not make sense.  It is not tied to the
development history at all!

Imagine v6.0.0 of git has message "foo".  v6.0.1 changes it to "bar"
because "foo" is not actually true yet, v6.1.0 changes it back to
"foo".  Imagine a linear development history.  Do we want translation
diffs like this:

 commit v6.0.0

 +"foo" is "hello" in language X

 commit v6.0.1

 -"foo" is "hello" in language X
 +"bar" is "goodbye" in language X

 commit v6.1

 -"bar" is "goodbye" in language X
 +"foo" is "hello" in language X

?  But what really happened is this:

 - add foo:hello to translation database
 - add bar:goodbye to translation database

I have been thinking about how to write a merge driver for .po files
(and avoid the tedious merge problems that e.g. the dpkg project runs
into periodically) but the idea of avoiding that altogether is very
appealing to me.
