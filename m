From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 16:18:19 -0700
Message-ID: <20140521231819.GA24756@hudson.localdomain>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
 <20140521215059.GB13956@hudson.localdomain>
 <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
 <20140521221221.GC13956@hudson.localdomain>
 <xmqqbnuqoj1k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnFme-00072Y-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbaEUXS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:18:29 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64413 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbaEUXS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:18:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so1850558pab.12
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eVNyJgZuam/gHzPZgBbJA9RlIUn1+TAvlVAuakJoYfQ=;
        b=Cx5TKlsVS4pXPnGrCeGiU85iTpLobAWNhquweXuQFmts0u+aMtifJHwUA+SxHtFFhw
         zDOBkYtb6z7DAzzOs5+csx0112I3UfY8shk+nAbeZrGIEiWV6aOaBd6n3AnZOaxnA3jE
         WUYVd884FeCOa96GtrWGwPPXoBrnM8jRzTQG3tEdHeUVO0QUwCEThgNlE2lhKQ9CrVnf
         7qx7JRU6TraHzBs/ZpCkqn8Qi+H1xMEZEXVv2qH0WbkD2gJ653nsrgg70/fprcSnnpOd
         dttxSI9hOziDuyx338yqWOXOndT5PvIh8v496lvOZkOvUtseAxTazMlhqEU+eZtH0mlt
         9wwQ==
X-Received: by 10.66.192.225 with SMTP id hj1mr62666410pac.142.1400714303361;
        Wed, 21 May 2014 16:18:23 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id ci4sm9851012pbb.50.2014.05.21.16.18.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:18:22 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 16:18:19 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqbnuqoj1k.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249858>

On Wed, May 21, 2014 at 03:37:11PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > Below is one of the updated test cases.
> >
> > test_expect_success 'format-patch --signature-file=mail-signature' '
> > 	cat >mail-signature <<-\EOF
> >
> > 	Test User <test.email@kernel.org>
> > 	http://git.kernel.org/cgit/git/git.git
> >
> > 	git.kernel.org/?p=git/git.git;a=summary
> >
> > 	EOF
> > 	git format-patch --stdout --signature-file=mail-signature -1 >output &&
> > 	check_patch output &&
> > 	sed -n -e "/^-- $/,\$p" <output | sed -e "1d" | sed -e "\$d" >output2 &&
> > 	test_cmp mail-signature output2
> > '
> 
> Hmph, there are still few things I do not understand in the above.
> 
>  * Why does mail-signature file have a leading blank line?  Is it
>    typical users would want to have one there?
> 
>  * Similarly, why does mail-signature file need a trailing blank
>    line?  Is it usual users would want to have one there?
> 

I think whatever the user puts in their signature should be reproduced.
It is probably isn't common to have leading or trailing blank lines.
But if they are there they should be reproduced.

>  * Why three sed in the pipeline?  Wouldn't
> 
>     sed -e "1,/^-- \$/d" <output | ...
> 
>    be more direct way to start the pipeline without having to strip
>    the "-- \n" line with the extra one?
> 

Yes, that is much cleaner.

>  * Given a mail-signature file that does not end with an incomplete
>    line (i.e. we did not have to add the newline to make it
>    complete), what are the expected lines in the output after the
>    "-- \n" separator?
> 
>    Whatever it is, I think it is easier to read the tests if done
>    like so:
> 
>      sed -e "1,/^-- \$/d" <output >actual &&
>      {
>          do something to turn mail-signature to what we expect
>      } >expect &&
>      test_cmp expect actual
> 
>    If that "do something" is "to append an extra newline", then it
>    would make it a lot clear to do
> 
>      {
>          cat mail-signature && echo
>      } >expect
> 
>    than a 'sed -e "\$d"' tucked at the end of the pipeline that only
>    tells us we are removing one line that has _something_ without
>    explicitly saying what we are removing, no?
> 

This does make more sense.  Since Git prints a blank line when it prints
the signature, this test also adds a blank line to produce the same
expected result.  This is much better than deleting two lines for no
obvious reason.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
