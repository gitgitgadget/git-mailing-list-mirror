From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Thu, 30 Oct 2014 17:08:56 -0400
Message-ID: <CAPBPrnuxAPmKe_aRb9USh=cOu4jMZaYzOorXC_RJa8b8ROq+iA@mail.gmail.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
	<xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Vojtek <peter.vojtek@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjwxq-0003E2-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbaJ3VI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:08:59 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58812 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934578AbaJ3VI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:08:58 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so8542897wib.7
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9f0wR0F2X8c6hKFlDX2vgSc5vXWJx783rlDqFm6Q3Ko=;
        b=aqs7qCCrdIdIva8fHG31cvLjA578uIS/E9WCsP2ODShnVDn1Ym90fQaBl1Kw4d8PK/
         EjuLkNRIgqWcq0x2s3huBVuK25OAp3Rxl3cruKtpYS8dMzoc5jX9FJZ/v0glTuwMrwFg
         /uZuX37ZbllDDjKY4OQx3wdT27XjrV9xZaEzjJMcgzu0Jffhu3H1ogeJM8uY0ZZpzsQH
         3r3e13ZJFI7HDaR6YwdXOBuSY5UuVPNSOR4VIzLHCYD1C+ae2C3SzD7INSY3lnK/u48G
         j5ooqsSqHz4pTGNQipDh5hE3Dkl+B6IJ9IpGQYXsd2+fDsLbvw7KIR3ihWYGXFtRdZIE
         eTRQ==
X-Received: by 10.180.90.230 with SMTP id bz6mr22887645wib.67.1414703336760;
 Thu, 30 Oct 2014 14:08:56 -0700 (PDT)
Received: by 10.194.125.229 with HTTP; Thu, 30 Oct 2014 14:08:56 -0700 (PDT)
In-Reply-To: <xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Peter Vojtek <peter.vojtek@gmail.com> writes:
>
>> It seems the commit date can be between 1970 and 2100 (on my 32bit
>> linux),...
>
> The underlying data representation records time as number of seconds
> since epoch (1970-01-01).  Theoretically the codepaths that read
> data could consider negative timestamps to represent times before
> the epoch, but in the context of source code control, negative
> values are more likely to be an indication of a bug or a user
> mistake, and I do not think any existing code in Git is prepared to
> pass such a timestamp as a sane value---instead they diagnose a
> failure and die.

I remember a pretty old thread found some success storing timestamps this way:
http://comments.gmane.org/gmane.comp.version-control.git/152433

-Dan Johnson
