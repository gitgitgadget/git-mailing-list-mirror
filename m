From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 02/14] pull: pass verbosity, --progress flags to fetch and merge
Date: Fri, 22 May 2015 21:38:17 +0800
Message-ID: <CACRoPnRR60DK7tE7yenSX0wouGSQDMDpcphjCdCr-GGdkfPrYQ@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-3-git-send-email-pyokagan@gmail.com>
	<4213f4fa8fb52fb020c2e9b5d78fbf7b@www.dscho.org>
	<CACRoPnRVcjcegRU8J6a=X6uN=b7fhJyD9=js4LqJ7ORX6gT=jg@mail.gmail.com>
	<f90387a786c1e0f4287c9fee405f8e2f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 15:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvn9h-00030w-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbbEVNiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:38:23 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33005 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408AbbEVNiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:38:21 -0400
Received: by lami4 with SMTP id i4so12846932lam.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9hpSBC1gW8VFmJxAydD0hiwPM4XTXywuOmcHr03qdRU=;
        b=P7OI98ZuHGBU+PN4RFQqWRSteehw7p7lPFXYGzxo8P7KhKa98+bq4XtStQtHNq3n4T
         GuozTrw3hUdJpp+Gw6qRHkrBk6UYF8PQtXb5p0zfuNgBLCPi6DuaGyBpS/WxQif6fq/e
         XXoSKOGQO5BRZ2EmXBJzR7h+CitLaMRz26iciB6Pk98KNiRrnC7B3TBw+nkAopo68owL
         Xo+z/GHuwI8ditW1ohbWleQIVBOewq+oSZqrPIHMtoRNd8nmL6Ver1GnpE+sSyQ7Qp7N
         nwd1i0R1/AAxXzAe9PLSQS+Bhwjq9CmcgqVaxfE8rleIGuzE8owzBmwBbwNr33diUSBL
         KTHg==
X-Received: by 10.153.6.6 with SMTP id cq6mr4553769lad.74.1432301898035; Fri,
 22 May 2015 06:38:18 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 22 May 2015 06:38:17 -0700 (PDT)
In-Reply-To: <f90387a786c1e0f4287c9fee405f8e2f@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269715>

Hi Johannes,

On Thu, May 21, 2015 at 11:59 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-21 11:48, Paul Tan wrote:
>> Unfortunately, the usage of strbuf means that we lose the ability to
>> know if an option was not provided at all (the value is NULL). This is
>> important as some of these options are used to override the default
>> configured behavior.
>
> Would this not be implied by the strbuf's len being 0?

You're right >.< I think I need more coffee as well ;-)

It would mean adding STRBUF_INIT's to all of the option variables, but
I don't think it is a problem. strbufs it is, then.

>>> You might also want to verify that arg is `NULL` when `unset != 0`. Something like this:
>>
>> Hmm, would there be a situation where arg is NULL when `unset != 0`?
>
> I forgot to say that my suggestion was purely meant as defensive coding. Yes, `arg` *should* be `NULL` when `unset != 0`. Should ;-)
>
> By the way, just to make sure: My comments and suggestions are no demands; you should feel very free to reject them when you feel that your code is better without the suggested changes. I am just trying to be helpful.

Thanks, your comments have been really helpful. I really do appreciate it :).

Regards,
Paul
