Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D29C1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdBNVkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:40:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36169 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdBNVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:40:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so5513165wmd.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2IV0fugshm9e08rlke28qj7hMWUBTeBu91tq0eCgVg=;
        b=qER90uHxY6UeeBX+j9CdkretKY9ABEr/OUQcOq9esFnNIiMwrOxT0pvDfbhiqoTgND
         3ocsSnnjvBgeTN7qoT1JKKkB6JgBUIjIjrWKP7hUxvlp6jdJ4HNMG5/FKMRKgGxvhfT9
         q4y+/lhbfWlXuPOufibZFDzfTlQMErfX7QfxPw9iy6NS5VLOVWSyHbOkWG8jG4FK7WRH
         +fg0U58SrGr/TiZFK6y57ggG8MxSvy94SUe1OayhU9rTDJFTU6eOR07O1QXWSess6irp
         ekUYng+jqN1AW2BIW+Elk/Ar6LD9ID9EAiv/oZexCAtbNhaK0GWeHd6vtEfxVxCVqKxo
         bsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2IV0fugshm9e08rlke28qj7hMWUBTeBu91tq0eCgVg=;
        b=MewiHzxWG4jBFfB7ze4kkOOOxfcQjlsPgpmor//4A8AkLuW58Cykzi4PMOcQz5oGvm
         js3ljgKVAmfqdgJrJ1KMk86BRnRS+WUXIlbCYiGt2DHJ53sYeMtDCc7Aj8ZztJErs3H/
         XXCjik3FjusR0C3gU0q0cIML9BrGFGBjbhu9m+jT11xTn3NW26znRcCI+vSx58THiYw1
         wOkHImCtumvQM4SqoobY4ieOnAebkXIbGelTcknplnA4TvlgN4y3W1zqBugKmEdtYo2/
         MVvvxLrXtvN927gHwHziyL9NE8X9TQitLBOlLKOqczbPsJt+3cZl3a0/yY0ThgsA8mX6
         YygA==
X-Gm-Message-State: AMke39maXaXJu2hRA9no2c9c66TzsnNlrJtqDA9yCX76nZSr9Fpk95134uHR0/McMLZyUQ==
X-Received: by 10.28.203.75 with SMTP id b72mr5590700wmg.110.1487108411198;
        Tue, 14 Feb 2017 13:40:11 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k142sm5001219wmg.31.2017.02.14.13.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Feb 2017 13:40:10 -0800 (PST)
Date:   Tue, 14 Feb 2017 21:40:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 4/7] stash: introduce new format create
Message-ID: <20170214214045.GG652@hank>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170212215420.16701-5-t.gummerer@gmail.com>
 <vpqefz0ohub.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpqefz0ohub.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Matthieu Moy wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >  create_stash () {
> > -	stash_msg="$1"
> > -	untracked="$2"
> > +	stash_msg=
> > +	untracked=
> > +	new_style=
> > +	while test $# != 0
> > +	do
> > +		case "$1" in
> > +		-m|--message)
> > +			shift
> > +			test -z ${1+x} && usage
> > +			stash_msg="$1"
> > +			new_style=t
> > +			;;
> > +		-u|--include-untracked)
> > +			shift
> > +			test -z ${1+x} && usage
> > +			untracked="$1"
> > +			new_style=t
> > +			;;
> > +		*)
> > +			if test -n "$new_style"
> > +			then
> > +				echo "invalid argument"
> > +				option="$1"
> > +				# TRANSLATORS: $option is an invalid option, like
> > +				# `--blah-blah'. The 7 spaces at the beginning of the
> > +				# second line correspond to "error: ". So you should line
> > +				# up the second line with however many characters the
> > +				# translation of "error: " takes in your language. E.g. in
> > +				# English this is:
> > +				#
> > +				#    $ git stash save --blah-blah 2>&1 | head -n 2
> > +				#    error: unknown option for 'stash save': --blah-blah
> > +				#           To provide a message, use git stash save -- '--blah-blah'
> > +				eval_gettextln "error: unknown option for 'stash create': \$option"
> 
> The TRANSLATORS: hint seems a typoed cut-and-paste from somewhere else.
> There are no 7 spaces in this message.
> 
> Actually, if I read the code correctly, $option is not even necessarily
> an option as you're matching *. Perhaps you meant something like
> 
> 	-*)
> 		option="$1"
> 		# TRANSLATORS: $option is an invalid option, like
> 		# `--blah-blah'. The 7 spaces at the beginning of the
> 		# second line correspond to "error: ". So you should line
> 		# up the second line with however many characters the
> 		# translation of "error: " takes in your language. E.g. in
> 		# English this is:
> 		#
> 		#    $ git stash save --blah-blah 2>&1 | head -n 2
> 		#    error: unknown option for 'stash save': --blah-blah
> 		#           To provide a message, use git stash save -- '--blah-blah'
> 		eval_gettextln "error: unknown option for 'stash save': \$option
>        To provide a message, use git stash save -- '\$option'"
>                 usage
>                 ;;
>         *)
> 		if test -n "$new_style"
> 		then
> 	        	arg="$1"
> 	        	eval_gettextln "error: invalid argument for 'stash create': \$arg"
> 			usage
> 		fi
>                 break
> 		;;
> 
> (untested)
> 
> Also, you may want to guard against
> 
>   git stash create "some message" -m "some other message"
> 
> since you are already rejecting
> 
>   git stash create -m "some message" "some other message"
> 
> ? Or perhaps apply "last one wins" for both "-m message" and
> "message"-without-dash-m.

Thanks, you're right I was missing some cases here.  As I just
indicated in [1] however I think we can just make this an internal
interface, instead of user interface facing, so I think we'll need
less error checking.

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

[1]: http://public-inbox.org/git/20170214213038.GE652@hank/
