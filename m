From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Doc format-patch: clarify --notes use case
Date: Thu, 25 Oct 2012 23:48:04 +0100
Organization: OPDS
Message-ID: <7427D8D31835443F96156C24D3EB6A5A@PhilipOakley>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org> <1350855250-2844-4-git-send-email-philipoakley@iee.org> <20121025102527.GO8390@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Eric Blake" <eblake@redhat.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:48:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRWDe-00086l-H4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 00:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab2JYWrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 18:47:53 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:20009 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab2JYWrw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 18:47:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArUNAP6/iVBcHl58/2dsb2JhbABEhhaFP7VVAQMBAQKBBoEJghkFAQEEAQgBARkVHgEBIQUGAgMFAgEDDgcBAgICBSECAhQBBBoGBxcGEwgCAQIDAYdtCqsfkm+BIIpBbx5AOoNTMmEDjXGYQoJw
X-IronPort-AV: E=Sophos;i="4.80,650,1344207600"; 
   d="scan'208";a="51716502"
Received: from host-92-30-94-124.as13285.net (HELO PhilipOakley) ([92.30.94.124])
  by out1.ip07ir2.opaltelecom.net with SMTP; 25 Oct 2012 23:47:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208425>

From: "Jeff King" <peff@peff.net> Sent: Thursday, October 25, 2012 11:25 
AM
> On Sun, Oct 21, 2012 at 10:34:10PM +0100, Philip Oakley wrote:
>
>>  The expected use case of this is to write supporting explanation for
>> -the commit that does not belong to the commit log message proper
>> -when (or after) you create the commit, and include it in your patch
>> -submission.  But if you can plan ahead and write it down, there may
>> -not be a good reason not to write it in your commit message, and if
>> -you can't, you can always edit the output of format-patch before
>> -sending it out, so the practical value of this option is somewhat
>> -dubious, unless your workflow is broken.
>> +the commit, that does not belong to the commit log message proper,
>> +and include it with the patch submission. The notes can be 
>> maintained
>> +between versions of the patch series. You can also edit the output 
>> of
>> +format-patch before sending.
>
> I found the "you can also" slightly awkward here, as it was not clear
> why it was mentioned.

I was trying to catch what I think Junio was trying to say about 
'writing it down' and 'can always edit the output' but wasn't exactly 
sure how to read it.

>I think the intent is "this is an alternative that
> does not involve the notes workflow", but it is not clear from the 
> text
> why you would prefer the notes workflow. Here is what I queued 
> instead,
> which tires to clarify that, and also mentions that this workflow 
> needs
> additional setup to track rewritten commits:

Your version below captures the intent. <Ack>
>
> diff --git a/Documentation/git-format-patch.txt 
> b/Documentation/git-format-patch.txt
> index 066dc8b..750b3fa 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -196,13 +196,12 @@ The expected use case of this is to write 
> supporting explanation for
>  after the three-dash line.
> +
> The expected use case of this is to write supporting explanation for
> -the commit that does not belong to the commit log message proper
> -when (or after) you create the commit, and include it in your patch
> -submission.  But if you can plan ahead and write it down, there may
> -not be a good reason not to write it in your commit message, and if
> -you can't, you can always edit the output of format-patch before
> -sending it out, so the practical value of this option is somewhat
> -dubious, unless your workflow is broken.
> +the commit that does not belong to the commit log message proper,
> +and include it with the patch submission. While one can simply write
> +these explanations after `format-patch` has run but before sending,
> +keeping them as git notes allows them to be maintained between 
> versions
> +of the patch series (but see the discussion of the `notes.rewrite.*`
> +configuration in linkgit:git-notes[1] to use this workflow).

Should the notes.rewriteRef also be mentioned (not part of .*), which is 
at the end of the notes configuration and that it must be set may be 
missed by readers? Perhaps "the 'notes.rewrite' configurations", 
dropping the .* and making it plural?

>  a signature to each message produced. Per RFC 3676 the signature
>
>
> I've queued that and your other patches on top of 
> jc/prettier-pretty-note.
>
> -Peff
>
>
> -----

Philip 
