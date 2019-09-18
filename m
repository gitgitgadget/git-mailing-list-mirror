Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C401F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfIRRVf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:21:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57376 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbfIRRVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:21:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03C5B72CF8;
        Wed, 18 Sep 2019 13:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z1XFcYr/Jxjq
        TcUAPkzhQoksju8=; b=ZzILy9TA+OtlhXtyy8w8gFf7L7sdc0ComsTpKlulgjc3
        zmtJFY6YsTyZOEUd2IvbrY/+HYLuMVLs02OZNKQizWRpx0gcFGUaAz1V0iTDIk76
        YZrisbakZiE15tzyMaSYUwQBq5nZYOwphhQggrQ8Z9nsDwhG8BMYopbWjLlClEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MsWHaQ
        raaNEEZNsqkSvAzYKhTKdldJ4ktSBaNQdXhcL14c0yRYgkOGLlYOwbU3n9fxukdI
        YeT4pQmHTNBWWxPVWCyVonBqCBOVSUBstwNkQAEBj5ndf2aAXWlr/QTQMpUZzmwk
        WypPGgDrIjRDLPF5ZIHAElCGnA1kG6WgiN0TA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F111772CF7;
        Wed, 18 Sep 2019 13:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 010B972CF2;
        Wed, 18 Sep 2019 13:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] hg-to-git: make it compatible with both python3 and python2
References: <0102016d3f74d202-d5b32dd4-0098-4ad0-8ac7-5fde254f7796-000000@eu-west-1.amazonses.com>
        <0102016d43812db5-722fe301-48f7-4b46-93e4-67dc2992629a-000000@eu-west-1.amazonses.com>
Date:   Wed, 18 Sep 2019 10:21:20 -0700
In-Reply-To: <0102016d43812db5-722fe301-48f7-4b46-93e4-67dc2992629a-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22Herv=C3=A9?= Beraud"'s message of "Wed, 18 Sep 2019 08:33:22
 +0000")
Message-ID: <xmqqsgot5xm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCAFF7B6-DA38-11E9-9180-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Herv=C3=A9 Beraud <herveberaud.pro@gmail.com> writes:

> Python 2 is EOL at the end of 2019, many distros
> and systems now come with python 3 is the default version.

Grammo.  s/is the/as their/ or something like that to fix.

> These changes introduce a syntaxe compatible with the both versions of
> python and so with the nearly future python standard.
>
> Introduced changes:
> -------------------

Let's drop the above 5 lines.  A canonical form of log message for
us is to begin with a brief background to make readers realize what
is lacking in the current system (if needed -- and you've done a
good job to make the readers realize that we need to make sure we
work with Py3).  With readers' minds prepared to accept the need for
a change, then you give orders to the codebase to "be like so" in
imperative mood.  E.g.

    	Rewrite features used in hg-to-git that are no longer
    	supported in Python 3, in such a way that an updated code
    	can still be usable with Python 2.

	- print is not ...
	- dict.has_key(key) is no more; ...

You seem to have dropped the change from map() to list comprehention
in this iteration.  I am not into Python deeply enough to care
either way myself, and the original form with map() seems to work
with Python3 (evaluating it seems to result in a map object, instead
of a list, to lazily yield the values, but we are not printing the
result of map() directly with print(), so it should be OK) so from
my point of view, the fewer things we have to defend/justify, the
better ;-)

Will queue.  Thanks.

> Rewriting features that are no longer supported (or recommended)
> in Python 3 in the hg-to-git script.py so that it can be used with both
> Python 2 and 3, namely:
>
> - print is not a statement; use print() function instead.
> - dict.has_key(key) is no more; use "key in dict" instead.
>
> Signed-off-by: Herv=C3=A9 Beraud <herveberaud.pro@gmail.com>
> ---
>  contrib/hg-to-git/hg-to-git.py | 50 +++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-g=
it.py
> index de3f81667ed97..bb2822d4a5e17 100755
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ b/contrib/hg-to-git/hg-to-git.py
> @@ -42,7 +42,7 @@
> =20
>  def usage():
> =20
> -        print """\
> +        print("""\
>  %s: [OPTIONS] <hgprj>
> =20
>  options:
> @@ -54,7 +54,7 @@ def usage():
> =20
>  required:
>      hgprj:  name of the HG project to import (directory)
> -""" % sys.argv[0]
> +""" % sys.argv[0])
> =20
>  #---------------------------------------------------------------------=
---------
> =20
> @@ -104,22 +104,22 @@ def getgitenv(user, date):
>  if state:
>      if os.path.exists(state):
>          if verbose:
> -            print 'State does exist, reading'
> +            print('State does exist, reading')
>          f =3D open(state, 'r')
>          hgvers =3D pickle.load(f)
>      else:
> -        print 'State does not exist, first run'
> +        print('State does not exist, first run')
> =20
>  sock =3D os.popen('hg tip --template "{rev}"')
>  tip =3D sock.read()
>  if sock.close():
>      sys.exit(1)
>  if verbose:
> -    print 'tip is', tip
> +    print('tip is', tip)
> =20
>  # Calculate the branches
>  if verbose:
> -    print 'analysing the branches...'
> +    print('analysing the branches...')
>  hgchildren["0"] =3D ()
>  hgparents["0"] =3D (None, None)
>  hgbranch["0"] =3D "master"
> @@ -154,15 +154,15 @@ def getgitenv(user, date):
>          else:
>              hgbranch[str(cset)] =3D "branch-" + str(cset)
> =20
> -if not hgvers.has_key("0"):
> -    print 'creating repository'
> +if "0" not in hgvers:
> +    print('creating repository')
>      os.system('git init')
> =20
>  # loop through every hg changeset
>  for cset in range(int(tip) + 1):
> =20
>      # incremental, already seen
> -    if hgvers.has_key(str(cset)):
> +    if str(cset) in hgvers:
>          continue
>      hgnewcsets +=3D 1
> =20
> @@ -180,27 +180,27 @@ def getgitenv(user, date):
>      os.write(fdcomment, csetcomment)
>      os.close(fdcomment)
> =20
> -    print '-----------------------------------------'
> -    print 'cset:', cset
> -    print 'branch:', hgbranch[str(cset)]
> -    print 'user:', user
> -    print 'date:', date
> -    print 'comment:', csetcomment
> +    print('-----------------------------------------')
> +    print('cset:', cset)
> +    print('branch:', hgbranch[str(cset)])
> +    print('user:', user)
> +    print('date:', date)
> +    print('comment:', csetcomment)
>      if parent:
> -	print 'parent:', parent
> +	print('parent:', parent)
>      if mparent:
> -        print 'mparent:', mparent
> +        print('mparent:', mparent)
>      if tag:
> -        print 'tag:', tag
> -    print '-----------------------------------------'
> +        print('tag:', tag)
> +    print('-----------------------------------------')
> =20
>      # checkout the parent if necessary
>      if cset !=3D 0:
>          if hgbranch[str(cset)] =3D=3D "branch-" + str(cset):
> -            print 'creating new branch', hgbranch[str(cset)]
> +            print('creating new branch', hgbranch[str(cset)])
>              os.system('git checkout -b %s %s' % (hgbranch[str(cset)], =
hgvers[parent]))
>          else:
> -            print 'checking out branch', hgbranch[str(cset)]
> +            print('checking out branch', hgbranch[str(cset)])
>              os.system('git checkout %s' % hgbranch[str(cset)])
> =20
>      # merge
> @@ -209,7 +209,7 @@ def getgitenv(user, date):
>              otherbranch =3D hgbranch[mparent]
>          else:
>              otherbranch =3D hgbranch[parent]
> -        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
> +        print('merging', otherbranch, 'into', hgbranch[str(cset)])
>          os.system(getgitenv(user, date) + 'git merge --no-commit -s ou=
rs "" %s %s' % (hgbranch[str(cset)], otherbranch))
> =20
>      # remove everything except .git and .hg directories
> @@ -233,12 +233,12 @@ def getgitenv(user, date):
> =20
>      # delete branch if not used anymore...
>      if mparent and len(hgchildren[str(cset)]):
> -        print "Deleting unused branch:", otherbranch
> +        print("Deleting unused branch:", otherbranch)
>          os.system('git branch -d %s' % otherbranch)
> =20
>      # retrieve and record the version
>      vvv =3D os.popen('git show --quiet --pretty=3Dformat:%H').read()
> -    print 'record', cset, '->', vvv
> +    print('record', cset, '->', vvv)
>      hgvers[str(cset)] =3D vvv
> =20
>  if hgnewcsets >=3D opt_nrepack and opt_nrepack !=3D -1:
> @@ -247,7 +247,7 @@ def getgitenv(user, date):
>  # write the state for incrementals
>  if state:
>      if verbose:
> -        print 'Writing state'
> +        print('Writing state')
>      f =3D open(state, 'w')
>      pickle.dump(hgvers, f)
> =20
>
> --
> https://github.com/git/git/pull/458
