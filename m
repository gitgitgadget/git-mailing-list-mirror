From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 00/10] Cleaning up --help-all inconsistencies
Date: Wed, 16 Feb 2011 08:46:49 +0100
Message-ID: <4D5B80E9.90606@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net> <cover.1297774306.git.git@drmicha.warpmail.net> <7v1v39p1cv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 08:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppc9c-0006b9-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 08:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab1BPHt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 02:49:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57146 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758600Ab1BPHtz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 02:49:55 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4990C20903;
	Wed, 16 Feb 2011 02:49:54 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 16 Feb 2011 02:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tEJ1/EFOC0PwiTF3k41KM8VKCTg=; b=bkVowYstYeuDCXY+UY8QWFgEo0tvthC1B32Uwxl3Jh/9vC7gtE+v8Uf0v2eyNWn3YdzG2dQTzBm2XgBmSRY2LfZWTk4cNLbrS2SaNNNDKvQEuWOmE9fiNlmJg0l9r5qkueFRo2ntIypoMHHN8/0yinhBN4y2g8fArrrqVNqtDEE=
X-Sasl-enc: URR9mh3w56gh6fnm9TgdenkEa74Dgg0KZgDv2Hq2GlQv 1297842594
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53314443FA0;
	Wed, 16 Feb 2011 02:49:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7v1v39p1cv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166928>

Junio C Hamano venit, vidit, dixit 15.02.2011 20:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> v2 incorporates the changes as discussed so far.
> 
> Looked reasonable; thanks.
> 
>> It comes with three bonus patches which enforce the use of lowercase
>> <identifiers> (as per CodingGuidelines) in command messages (usage).
>>
>> Besides the guidelines, this is also the prevailing style in code.
> 
> Not that I am opposed to this change, but I don't see anything that says
> we want lower-case in CodingGuidelines. "Placeholders are enclosed in
> angle brackets." is the only thing it says as far as I can tell.

It's not expressed explicitly, but the examples there are all lowercase.
Your patch below makes it explicit.

Having a second look at documentation, there aren't many changes to do -
I would tend to leave things like <URL>, <FQDN>, possibly <UUID> (since
they are abbreviations) uppercase; unsure about <CVSROOT> (like the env
var). What do you think?

> So perhaps insert this before the last three patches.
> 
> -- >8 --
> Subject: CodingGuidelines: downcase placeholders in usage messages
> 
> We accumulated some inconsistencies without an explicit guidance to spell
> this out over time.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index ba2006d..fe1c1e5 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -152,7 +152,7 @@ Writing Documentation:
>   when writing or modifying command usage strings and synopsis sections
>   in the manual pages:
>  
> - Placeholders are enclosed in angle brackets:
> + Placeholders are spelled in lowercase and enclosed in angle brackets:
>     <file>
>     --sort=<key>
>     --abbrev[=<n>]
