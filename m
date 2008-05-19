From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input support to git submodule recurse subcommand
Date: Mon, 19 May 2008 09:48:43 +0600
Message-ID: <7bfdc29a0805182048i1d7a06saf0fda0e0582fcae@mail.gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
	 <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>,
	sverre@rabbelier.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	johan@herland.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 05:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxwNU-0006B8-4c
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 05:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbYESDsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 23:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbYESDsp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 23:48:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:20010 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbYESDso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 23:48:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1014976ywe.1
        for <git@vger.kernel.org>; Sun, 18 May 2008 20:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZMz5dGhxF/hFK9LkaDV9/zMINPJa2dNCJu/964YYBrU=;
        b=guWTXuVkv6WNPWNcgtYXVyNWhcjQmIvdBpgQFtsA1nH+2PcckGr68IdUofLm+aOptfPpIYVGNEvkb57le2BumhuEDe+iMbBYcbi8+wlfKaRa54dxJB+Wb5PuIYXKUta5UMdMLnnWx0jNYj8U8uOTHdgywPZ6NNiVhIAmqIE1j+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WRJOmE3fRUnXX99b2Yq9ZtMgHafSfu+t859b+aKYsZo6Xpi2r/pGboGl4Cog7epu8L/jW7mhh695uCOSlCfVc9jLc+C4/m4amD3aes1GuXgONeDyl3e+0RysYK8X5OEQF0jV+Z36nqUg0NYCwLD5vPLgRaroqEkWynds9V/JLlw=
Received: by 10.150.146.19 with SMTP id t19mr5815152ybd.226.1211168923448;
        Sun, 18 May 2008 20:48:43 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Sun, 18 May 2008 20:48:43 -0700 (PDT)
In-Reply-To: <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82408>

On Tue, May 13, 2008 at 4:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> For example, one module could want to checkout 'master', while another might want
>> to checkout 'work'. The [-a|--customized-argument] argument provides platform
>> just for that. Consider the following command and its followup for further info:
>>......
>.......
> If we want a useful and flexible "recurse", perhaps the only thing we need
> to do is a command that lists a submodule directory path, one path at a
> time, in optionally different traversal order and depth cutoff, so that
> the user can feed it to xargs and do whatever they want to run in there.
>
I am not sure whether I understand it correctly or not, we could
simply provide the shell window by invoking 'sh', right? If we do that
then is there need to use xargs? I am not particularly experienced
with xargs, I was thinking of something as follows:

#!/bin/sh
echo "Submodule a"
(
PS1="module/submodule$" sh
)
echo "" #In case of ctrl+D to ensure that there is a blank line
echo "Submodule a ends"

I do agree that it would be powerful enough to serve all the necessary
purpose for traversing git submodules. If my assumption is right in
what we want then I will resubmit the patch with required changes.

-- 
Imran M Yousuf
