From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Wed, 24 Apr 2013 10:53:53 +0200
Message-ID: <51779DA1.7080606@physik.tu-berlin.de>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com> <7vip3em8rs.fsf@alter.siamese.dyndns.org> <CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com> <51767290.2010208@drmicha.warpmail.net> <7va9opi163.fsf@alter.siamese.dyndns.org> <CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com> <7v1ua1hwx6.fsf@alter.siamese.dyndns.org> <CAASwCXcs8Q7qGWSNKttEuk0zPetDWNCse4J-KSm20r9h5XSo3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Joel Jacobson <joel@trustly.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUvSU-00045j-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983Ab3DXIxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:53:40 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:1028 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757725Ab3DXIxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:53:38 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UUvSL-0005B6-Bv; Wed, 24 Apr 2013 10:53:37 +0200
Received: from [141.23.96.137] (wlan-141-23-96-137.tubit.tu-berlin.de [141.23.96.137])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id D97F311401;
	Wed, 24 Apr 2013 10:53:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <CAASwCXcs8Q7qGWSNKttEuk0zPetDWNCse4J-KSm20r9h5XSo3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222241>

On 04/23/2013 09:56 PM, Joel Jacobson wrote:
>> But stepping back a bit, I have a suspicion that your upstream
>> project _only_ cares about what you feed them (either by pushing
>> your work yourself to them, or telling them to pull from your
>> repository).  There is no reason for you to be constantly signing
>> your commits you make during your exploratory development that you
>> may throw-away in the end.
> 
> Your suspicions are correct.
> But I'm a bit paranoid, so it feels better to sign even local commits.
> 
>> It _might_ be a better option to just teach "-S" option to "git
>> rebase" that tells it to replay all the commits with "commit -S",
>> instead of adding commit.gpgSign configuration.
> 
> In my case, I don't do that much exploratory development locally,
> so I usually just commit, pull and push.
> 
> Always signing everything can't really hurt, can it? Takes a few clock
> cycles more, and a few more bytes, but apart from that I don't see any
> problems?
I have my GPG-keys password-protected, and I would be severely annoyed by
GnuPG password prompts popping up on every commit. I think the -S option
to rebase would be the more elegant way. What could be nice would be a
config option that makes "git push" warn/abort in case I try to push an
unsigned head commit to a repo where I want to have signed commits:
> remote.<name>.abortUnsigned
This of course needs an command line override switch.

Something to be considered is whether "git rebase -S" should sign *every*
commit in the series or only the *head* commit.
