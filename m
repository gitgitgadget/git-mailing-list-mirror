From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 13:37:52 +0200
Message-ID: <51767290.2010208@drmicha.warpmail.net>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com> <7vip3em8rs.fsf@alter.siamese.dyndns.org> <CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Jacobson <joel@trustly.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 13:37:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUbXj-0007P0-JD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3DWLhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 07:37:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36802 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163Ab3DWLhp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 07:37:45 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AB73C20887;
	Tue, 23 Apr 2013 07:37:44 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 23 Apr 2013 07:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=N4Z1cx/x2oVyV9AD2ccSYc
	9RmK4=; b=j0LDO6cU1H534x2TsbI4xLuQf/r1LGyjJJJXceerGsy+h8EFcAAG8h
	a2mm2ZNp7QLgZIP4/oVzpAQHFmMhddHzDA98Ln5KYe8g1rH2g9BfiVNygWX+0xef
	1FbvB0Lv94ghkFiWQ8xvyEqPesGLazWe43S/js4q69M03KBSEU+mk=
X-Sasl-enc: kNQOBYzw26VRTJkulTWEd8o2vPRLlW/MJNoGwonRIA73 1366717064
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DAF16C8000F;
	Tue, 23 Apr 2013 07:37:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222144>

Joel Jacobson venit, vidit, dixit 23.04.2013 02:00:
> On Tue, Apr 23, 2013 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> No docs?  No tests?
> 
> Maybe simply adding this text to git-commit.txt,
> 
> The default can be changed by the 'commit.gpg-sign' configuration
> variable (see linkgit:git-config[1]).
> 
> after,
> 
> -S[<keyid>]::
> --gpg-sign[=<keyid>]::
> GPG-sign commit.
> 
> would be sufficient?
> 
> Not sure what the proper way to test this,
> could you please suggest any other unit test I could look at for inspiration?
> 
>> As to the design, any regular configuration variable settings must
>> be overridable from the command line for a single invocation. Please
>> design an escape hatch in, for somebody who has this configuration
>> variable set, but does not want to sign this commit he is about to
>> make.
> 
> Something like --no-gpg-sign?
> 
>> Also do we generally use dash in the configuration variable names?
>> I thought the norm was section.CamelCase.
> 
> Since the command line long option is "gpg-sign", I thought it was best
> to use exactly the same term in the configuration variable name to
> avoid confusion. Is there any problem with dashes in variable names?
> 

Not really a problem, but as Junio writes, we don't use dashes in the
config.

As for the command line override:

Don't we have "git -c commit.gpgsign=false" and such these days, so that
we don't have to inflate options any more?

Michael
