From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 10:19:49 -0000
Organization: OPDS
Message-ID: <5D290031F60941368FB1A36464201DCF@PhilipOakley>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com><1329624946-32173-1-git-send-email-pclouds@gmail.com><A716A27D407F401DAAC373027D5CFF2A@PhilipOakley> <87mx8dj4at.fsf@thomas.inf.ethz.ch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	=?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
To: "Thomas Rast" <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:19:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzQLc-0008Gx-08
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 11:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab2BTKTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 05:19:50 -0500
Received: from smtp2go.com ([207.58.142.213]:43439 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2BTKTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 05:19:49 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191059>

From: "Thomas Rast" <trast@inf.ethz.ch> Sent: Monday, February 20, 2012 8:29 
AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> If I have a renamed file which is a git object, such a "Git_Object", was
>> 8c-something-or-other, what is the easiest way of examining / decoding /
>> recreating the original file (either as its sha1, or a cat-file).
>>
>> I don't appear to be able to unzip the file in its raw format...  I'm 
>> using
>> Msysgit on windows XP.

Correction to reply to  xu's message: and I have /NOT/ located an
unzip programme that will take the plain git object and decode it.

>
> The SHA1 is over the decompressed object contents.  The file simply
> holds a zlib-compressed stream of those contents.  (It's pretty much
> like gzip without the file header.)
>
> You can use any bindings to zlib and something that does sha1, e.g. in
> python:
>
>  $ cd g/.git/objects/aa/  # my git.git
>  $ ls
>  592bda986a8380b64acd8cbb3d5bdfcbc0834d 
> 6322a757bee31919f54edcc127608a3d724c99
>  $ python
>  Python 2.7.2 (default, Aug 19 2011, 20:41:43) [GCC] on linux2
>  Type "help", "copyright", "credits" or "license" for more information.
>  >>> import hashlib
>  >>> 
> hashlib.sha1(open('592bda986a8380b64acd8cbb3d5bdfcbc0834d').read().decode('zlib')).digest().encode('hex')
>  'aa592bda986a8380b64acd8cbb3d5bdfcbc0834d'
>
> Notice that the first byte of the hash goes into the directory name.
>

At the moment I'm in a Catch 22 situation where I can't make the first step 
of examining the deflated contents, so I can't do all those next steps to 
get the sha1 etc.. Have I misunderstood your suggestions?

Philip 
