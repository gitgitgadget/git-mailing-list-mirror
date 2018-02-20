Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5711F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBTTOQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:14:16 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41515 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBTTOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:14:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id f14so13053215wre.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gFWBTTgImg53wMb9pW6/hlQHs0XhT7zTxSzk04Xc6EE=;
        b=KqvUZZikyk3C78O4etNQfkjrOBP7ni7lUvzPRr2sTGO0m/LL84YNzFoejTWsEhUpiJ
         f2LejMqLcxtrxfERV4W4fVbxjdUP0CLZy+V/sAvLYBUAqYtU26U3ZRJYu5jY8OPjY6ur
         u2lhxnB/v60sLnCIMeZoIdxghy/Ox4bBCUIta9TE2ssXBRtQ67NCmuLxSanfyjw6wFdX
         Z99CXF0RQ2XsWxryJ756WpWO3NRYaZHWS5iPkvzO5LsAFxDszHNevNP7DjTks1TTTuuf
         a+0j+trW/MZYvoYigK09db2+J1pe776Z6RvaxRzuOTYL/K6BQOaqu8tZIluEAhE8ZUwN
         UTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gFWBTTgImg53wMb9pW6/hlQHs0XhT7zTxSzk04Xc6EE=;
        b=gA5dk1JgXCn+XJkjMf82H/8xBbBN9V8zU64SSacNOB758R9rkarGiCRhY1lUbEsVow
         ZA+n608c/3nR4M2mKR5xjqrwoBMIUN6yGa5BgQZHKIfqRcTd6eOM/Moxb5C6JGjdQPsD
         sZ0q/WR9ovwSxMj7WBcGCPN5y5m2njoICsbSBaDUNP//x4QCgecewjY7TiLTzTizVnfZ
         opRe/ypLZDdVKdR3pmFwkPpKkeIvI2ochPYxgokdNWtO8WWvRLvQ3SEjpAwWUssUhD3S
         OX3ja7I/4KVtT5ptMzryz94MIMvIHcZicgCiWHcuMSsx98x6OaefqQMchwzbLSUH6MSC
         G6KA==
X-Gm-Message-State: APf1xPA+LtQkn0Wuf+RqcggdfAD0MVRXmxirCuTb9DA4xNzu1xRqm4Y4
        AvUigNwkHbTP6PnX5kV78Cw=
X-Google-Smtp-Source: AH8x2272cJFXq/fssSua5NAtRefCb42uHWlYnxeGOHGlmdqJCrwe5VIyelt+bcaj2g4xkiE9W4xwuQ==
X-Received: by 10.223.201.133 with SMTP id f5mr579480wrh.99.1519154052974;
        Tue, 20 Feb 2018 11:14:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r70sm33057645wmg.30.2018.02.20.11.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:14:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make hg-to-git compatible with python2.x and 3.x
References: <01020161992fe7ce-b41bf370-1480-4efe-8980-0c52fb9b9be5-000000@eu-west-1.amazonses.com>
        <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
Date:   Tue, 20 Feb 2018 11:14:10 -0800
In-Reply-To: <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22Herv=C3=A9?= Beraud"'s message of "Tue, 20 Feb 2018 16:52:34
 +0000")
Message-ID: <xmqqwoz7324d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hervé Beraud <herveberaud.pro@gmail.com> writes:

> Signed-off-by: Hervé Beraud <herveberaud.pro@gmail.com>
> ---
>  contrib/hg-to-git/hg-to-git.py | 52 +++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

I think you shrunk the scope of the change, but I feel that it is
still a bit under-explained.  Let me try to write a proposed commit
log message and ask you to see if I understood the idea behind the
changes correctly:

    Rewrite features that are no longer supported (or recommended)
    in Python 3 in the script so that it can be used with both
    Python 2 and 3, namely:

    - print is not a statement; use print() function instead.
    - dict.has_key(key) is no more; use "key in dict" instead.
    - map(lambda ..., collection) is not liked; use list comprehension.

Hopefully this would also serve as an illustration of the kind of
things we want in our log message.

I am not sure about the change from map(lambda ...) to list
comprehension, though.  Not that I have a preference for or against
(I am not a Python person), but I do not know if this is a change
necessary to run with Python 3 or if it is merely more preferred to
use list comprehension.

Thanks.

> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
> index de3f81667ed97..8fa7698df5c20 100755
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ b/contrib/hg-to-git/hg-to-git.py
> @@ -42,7 +42,7 @@
>  
>  def usage():
>  
> -        print """\
> +        print("""\
>  %s: [OPTIONS] <hgprj>
>  
>  options:
> @@ -54,7 +54,7 @@ def usage():
>  
>  required:
>      hgprj:  name of the HG project to import (directory)
> -""" % sys.argv[0]
> +""" % sys.argv[0])
>  
>  #------------------------------------------------------------------------------
>  
> @@ -104,29 +104,29 @@ def getgitenv(user, date):
>  if state:
>      if os.path.exists(state):
>          if verbose:
> -            print 'State does exist, reading'
> +            print('State does exist, reading')
>          f = open(state, 'r')
>          hgvers = pickle.load(f)
>      else:
> -        print 'State does not exist, first run'
> +        print('State does not exist, first run')
>  
>  sock = os.popen('hg tip --template "{rev}"')
>  tip = sock.read()
>  if sock.close():
>      sys.exit(1)
>  if verbose:
> -    print 'tip is', tip
> +    print('tip is', tip)
>  
>  # Calculate the branches
>  if verbose:
> -    print 'analysing the branches...'
> +    print('analysing the branches...')
>  hgchildren["0"] = ()
>  hgparents["0"] = (None, None)
>  hgbranch["0"] = "master"
>  for cset in range(1, int(tip) + 1):
>      hgchildren[str(cset)] = ()
>      prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().strip().split(' ')
> -    prnts = map(lambda x: x[:x.find(':')], prnts)
> +    prnts = [x[:x.find(':')] for x in prnts]
>      if prnts[0] != '':
>          parent = prnts[0].strip()
>      else:
> @@ -154,15 +154,15 @@ def getgitenv(user, date):
>          else:
>              hgbranch[str(cset)] = "branch-" + str(cset)
>  
> -if not hgvers.has_key("0"):
> -    print 'creating repository'
> +if "0" not in hgvers:
> +    print('creating repository')
>      os.system('git init')
>  
>  # loop through every hg changeset
>  for cset in range(int(tip) + 1):
>  
>      # incremental, already seen
> -    if hgvers.has_key(str(cset)):
> +    if str(cset) in hgvers:
>          continue
>      hgnewcsets += 1
>  
> @@ -180,27 +180,27 @@ def getgitenv(user, date):
>      os.write(fdcomment, csetcomment)
>      os.close(fdcomment)
>  
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
>  
>      # checkout the parent if necessary
>      if cset != 0:
>          if hgbranch[str(cset)] == "branch-" + str(cset):
> -            print 'creating new branch', hgbranch[str(cset)]
> +            print('creating new branch', hgbranch[str(cset)])
>              os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
>          else:
> -            print 'checking out branch', hgbranch[str(cset)]
> +            print('checking out branch', hgbranch[str(cset)])
>              os.system('git checkout %s' % hgbranch[str(cset)])
>  
>      # merge
> @@ -209,7 +209,7 @@ def getgitenv(user, date):
>              otherbranch = hgbranch[mparent]
>          else:
>              otherbranch = hgbranch[parent]
> -        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
> +        print('merging', otherbranch, 'into', hgbranch[str(cset)])
>          os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
>  
>      # remove everything except .git and .hg directories
> @@ -233,12 +233,12 @@ def getgitenv(user, date):
>  
>      # delete branch if not used anymore...
>      if mparent and len(hgchildren[str(cset)]):
> -        print "Deleting unused branch:", otherbranch
> +        print("Deleting unused branch:", otherbranch)
>          os.system('git branch -d %s' % otherbranch)
>  
>      # retrieve and record the version
>      vvv = os.popen('git show --quiet --pretty=format:%H').read()
> -    print 'record', cset, '->', vvv
> +    print('record', cset, '->', vvv)
>      hgvers[str(cset)] = vvv
>  
>  if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
> @@ -247,7 +247,7 @@ def getgitenv(user, date):
>  # write the state for incrementals
>  if state:
>      if verbose:
> -        print 'Writing state'
> +        print('Writing state')
>      f = open(state, 'w')
>      pickle.dump(hgvers, f)
>  
>
> --
> https://github.com/git/git/pull/458
