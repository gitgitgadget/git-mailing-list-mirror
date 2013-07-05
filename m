From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Fri, 5 Jul 2013 12:13:07 +0400
Message-ID: <20130705081307.GC32072@ashu.dyn1.rarus.ru>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <cover.1372719264.git.Alex.Crezoff@gmail.com>
 <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
 <7v61wpbj2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv18p-0005YF-M8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab3GEINO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:13:14 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35312 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab3GEINL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:13:11 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so1823003lba.16
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q29KmcCKxOrh2QKgU1p/TpQlG6kim8Yd+hcJHkf+y6g=;
        b=Vwi2dhANT7chiDeDY6ZRtyG8pOoEh94RolY12EYVI39j3nmZkGrtvVUUXCTMmc5AwO
         A5L1yWJ7aVk0XrEYpc6ELfENmg5MIs85fG4yTpJSDSucYhCupe2IV6/U2Z0PTmP6WKaP
         SUDn4/yOz91R1WCOnjTrcj3TD1qBkSXOypTmuZ6rJkJm2Ks/dTaFx6APw8qVcLFYaUj1
         rbK6EMGh7VvRy4qKlN5JP1CYGzxyspD7iud6mTLNA4iHWFo9WNCml852Dp6619v4Yx7L
         h3R6mVcKJPHc8mAl3/URcqjGx9RakJlwymgt0dt3Vl52dm9ICIf53+aLELljPACV1TI1
         mtPQ==
X-Received: by 10.112.236.33 with SMTP id ur1mr5132195lbc.13.1373011989869;
        Fri, 05 Jul 2013 01:13:09 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id 8sm2492842lbn.9.2013.07.05.01.13.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 01:13:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v61wpbj2y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229636>

On Thu, Jul 04, 2013 at 11:45:57PM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > Function 'test_format' is become hard to read after its change in
> > de6029a2d7734a93a9e27b9c4471862a47dd8123. So, make it more elegant.
> > Also, change 'commit_msg' function to make it more pretty.
> 
> I do not know where you pick up these "more elegant" and "more
> pretty" from, but please refrain from using _only_ such vague and
> subjective phrases to describe the change in the log message.
> Saying "make it <<better>> by doing X" (with various subjective
> adjectives to say "better") is fine, but make sure you have "doing
> X" part in the explanation.
> 
> Perhaps like this.
> 
>     Function 'test_format' has become harder to read after its
>     change in de6029a2 (pretty: Add failing tests: --format output
>     should honor logOutputEncoding, 2013-06-26).  Simplify it by
>     moving its "should we expect it to fail?" parameter to the end.
I'm not sure whether this "last parameter" is needed in that code as far as we
already removed expected to fail tests
> 
> I cannot read why you think the updated commit_msg is "more pretty"
> in the message or in the patch.
> 
> > -commit_msg () {
> > -	# String "initial. initial" partly in German (translated with Google Translate),
> > +commit_msg() {
> 
> Style.  Have SP on both sides of () in a shell function definition.
Could you point me to the coding style guide, please?
> 
> > +	# String "initial. initial" partly in German
> > +	# (translated with Google Translate),
> >  	# encoded in UTF-8, used as a commit log message below.
> >  	msg=$(printf "initial. anf\303\244nglich")
> >  	if test -n "$1"
> 
> This is not "more pretty" but "better commented".
Well, this is "better formatted comment", I guess :)
> 
> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index 2ef96e9..73a1bdb 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > @@ -9,15 +9,17 @@ Documented tests for git reset'
> >  
> >  . ./test-lib.sh
> >  
> > -commit_msg () {
> > -	# String "modify 2nd file (changed)" partly in German(translated with Google Translate),
> > +commit_msg() {
> > +	# String "modify 2nd file (changed)" partly in German
> > +	# (translated with Google Translate),
> >  	# encoded in UTF-8, used as a commit log message below.
> > -	msg=$(printf "modify 2nd file (ge\303\244ndert)")
> > +	printf "modify 2nd file (ge\303\244ndert)" |
> >  	if test -n "$1"
> >  	then
> > -		msg=$(echo $msg | iconv -f utf-8 -t $1)
> > +		iconv -f utf-8 -t $1
> > +	else
> > +		cat
> >  	fi
> > -	echo $msg
> 
> Is it "more pretty"?  The "we have to have cat only because we want
> to pipe into a conditional" look somewhat ugly.
That was a proposition of J6t :-D
(see http://article.gmane.org/gmane.comp.version-control.git/229291):
    >If you wanted to, you could write this as
    >
    >commit_msg () {
    >    # String "modify 2nd file (changed)" partly in German
    >    #(translated with Google Translate),
    >    # encoded in UTF-8, used as a commit log message below.
    >    printf "modify 2nd file (ge\303\244ndert)" |
    >    if test -n "$1"
    >    then
    >        iconv -f utf-8 -t $1
    >    else
    >        cat
    >    fi
    >}
    >
    >but I'm not sure whether it's a lot better.

Last sentence has apperared to be a key

> 
> 	msg="modify 2nd file (ge\303\244ndert)"
>         if test -n "$1"
> 	then
> 		printf "$msg" | iconv -f utf-8 -t "$1"
> 	else
> 		printf "$msg"
> 	fi
> 
> >  }
> >  
> >  test_expect_success 'creating initial files and commits' '

-- 
Alexey Shumkin
