From: demerphq <demerphq@gmail.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 6 Feb 2013 19:18:41 +0100
Message-ID: <CANgJU+Waa2WFGEQz=UmQkS+CRjq94CTeQtobaY=EMiveC_sMww@mail.gmail.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
	<CANgJU+V5bhdpN_kWxQPEJgx24LXLtQJWRbnHwkSgm9zFwzm+fA@mail.gmail.com>
	<7vip65cnt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:25:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39gZ-0002CF-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab3BFSZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:25:09 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:61525 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3BFSZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:25:07 -0500
Received: by mail-qc0-f181.google.com with SMTP id a22so640227qcs.26
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=M15E1nFN/nmgPfn9m988T0RAGwQz3zIHWCLBhlJziyw=;
        b=R7PKN5KafS7EcXAktaRr4Z7brxzszK8CQgBWn/Tkfuy0ns40wn07AW5GAYcSqDtiR0
         GvWXQA27aOjpnVjmjGrJXhuerxaqNguosIMbUpKWtQ0z3D/eAaB++ebod2IU/wCGi4j/
         bC5IDFxj31b9y6Ktf45gYldnzDcNHkl2Juw+5Nd2tQ0sFmORUfkXItf/lFaBgcmIQ4YH
         yRw3cmpC0S0cfeeeS7XO9+DBnDgJR3PvlJo+BPOqCT/yGode43Lkp0oOLS9Ez7gqxZtG
         +4S7fGpVDxljfO219jHa1KfQif6adxJOtX/4ea89ScwCfNw4+heDpf6brYW9sIP2jxN5
         oOGQ==
X-Received: by 10.49.104.136 with SMTP id ge8mr24809416qeb.8.1360174721152;
 Wed, 06 Feb 2013 10:18:41 -0800 (PST)
Received: by 10.49.94.196 with HTTP; Wed, 6 Feb 2013 10:18:41 -0800 (PST)
In-Reply-To: <7vip65cnt3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215615>

On 6 February 2013 19:14, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> As you mention below statement modifiers have their place. For instance
>>
>>   next if $whatever;
>>
>> Is considered preferable to
>>
>> if ($whatever) {
>>   next;
>> }
>>
>> Similarly
>>
>> open my $fh, ">", $filename
>>    or die "Failed to open '$filename': $!";
>>
>> Is considered preferable by most Perl programmers to:
>>
>> my $fh;
>> if ( not open $fh, ">", $filename ) {
>>   die "Failed to open '$filename': $!";
>> }
>
> Yeah, and that is for the same reason.  When you are trying to get a
> birds-eye view of the codeflow, the former makes it clear that "we
> do something, and then we open, and then we ...", without letting
> the error handling (which also is rare case) distract us.

perldoc perlstyle has language which explains this well if you want to
crib a description from somewhere.

>> "unless" often leads to maintenance errors as the expression gets more
>> complicated over time,...
>
> That might also be true, but my comment was not an endorsement for
> (or suggestion against) use of unless.  I was commenting on
> statement modifiers, which some people tend to overuse (or abuse)
> and make the resulting code harder to follow.

That's also my point about unless. They tend to get abused and then
lead to maint devs making errors, and people misunderstanding the
code. The only time that unless IMO is "ok" (ish) is when it really is
a very simple statement. As soon as it mentions more than one var it
should be converted to an if. This applies even more so to the
modifier form.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
