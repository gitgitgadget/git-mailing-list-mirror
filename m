From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 08:02:30 -0000
Organization: OPDS
Message-ID: <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Richard Weinberger" <richard@nod.at>, <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 09:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKOqW-0001lm-DB
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 09:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419Ab3CZICf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 04:02:35 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38573 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759490Ab3CZICb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 04:02:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmcJAAFEUVFOl3N//2dsb2JhbABDjBa3bQQBgQUXdIIaBQEBBAEIAQEuHgEBIQsCAwUCAQMVAQIJJRQBBAgSBgcXBgESCAIBAgMBh3EDCQqxU4YZDYlbjE2BOhZwC4JmYQOIQYVwhlaNSYUbgS+BWzw
X-IronPort-AV: E=Sophos;i="4.84,910,1355097600"; 
   d="scan'208";a="423159414"
Received: from host-78-151-115-127.as13285.net (HELO PhilipOakley) ([78.151.115.127])
  by out1.ip02ir2.opaltelecom.net with SMTP; 26 Mar 2013 08:02:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219143>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, March 25, 2013 10:06 PM
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Richard Weinberger wrote:
>>
>>> In my scripts I'm setting GIT_DIR to use git-fetch and git-reset 
>>> without changing the
>>> current working directory all the time.
>>
>> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
>> GIT_DIR is explicitly set.
>
> And it *WILL* be that way til the end of time.  Unless you are at
> the top level of your working tree, you are supposed to tell where
> the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.

Should this important warning be part of the git(1) documentation on the 
environment variables (and possibly other places) given the consequences 
of this case? It wasn't something I'd appreciated from a simple reading.

>
> And that is the answer you should be giving here, not implicit
> stuff, which is an implementation detail to help aliases.  I do not
> know how things will break when the end user sets and exports it to
> the environment, and I do not think we would want to make any
> promise on how it works.
> --
Philip 
