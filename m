From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH v2 1/3] send-email: Don't use FQDNs without a '.'
Date: Sat, 10 Apr 2010 09:44:24 -0400
Message-ID: <CD79B09D-D728-4A3A-945F-9D117C15FFB5@gernhardtsoftware.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com> <1270827746-29229-1-git-send-email-brian@gernhardtsoftware.com> <201004091831.49066.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 15:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0azC-00077q-NM
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 15:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0DJNo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 09:44:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49948 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0DJNo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 09:44:28 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C1BBE1FFC058; Sat, 10 Apr 2010 13:44:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.97] (unknown [64.134.103.20])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 5F3C71FFC056;
	Sat, 10 Apr 2010 13:44:23 +0000 (UTC)
In-Reply-To: <201004091831.49066.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144547>


On Apr 9, 2010, at 12:31 PM, Jakub Narebski wrote:

> Note that the comments below are just nitpicking about Perl style.

Fair enough.  I've been using Ruby and Shell far more than Perl recently.  I've gotten a bit rusty.

> A matter of style: in Perl it more usual to use
> 
>  sub <name> {
>  	...
>  }
> 
> style rather than
> 
>  sub <name>
>  {
>  	...
>  }
> 
> Unfortunately git-send-email.perl is a bit inconsistent in the style used;
> 23 subroutines use Perl style, 5 subroutines including previous one i.e.
> sanitize_address use C-like style (one of).

I was copying style from the other functions I was working on.  I'll make my additions more "standard" and add a patch to clean up the rest.

> Also, the usual way of unrolling @_; is to use either
> 
>  my ($par1, $par2, ...) = @_;
> 
> or use
> 
>  mu $par = shift;
> 
> The form $_[0] etc. is used very rarely.  I think it is even against 
> Perl Best Practices (see http://www.perlcritic.org and Perl::Critic).

I knew that.  I really did.  But I started off trying to write

sub valid_fqdn( $domain )

Which would be valid Perl 6, but not Perl 5.  So then I tried using

my $domain = $1

Which, while valid, is wrong.  So I changed it to @_[1], @_[0], and finally $_[0].  My brain wasn't running at 100% yesterday, apparently.

> Style: usually there is no space around function arguments, so 
> 'valid_fqdn($domain);'.

University training is difficult to overcome.  They demanded spaces nearly everywhere, so I type them by something akin to reflex.

Thank you for all the review!
~~ Brian Gernhardt
