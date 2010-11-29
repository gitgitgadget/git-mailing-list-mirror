From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Mon, 29 Nov 2010 11:12:11 -0600
Message-ID: <20101129171211.GL8037@burratino>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Huddleston <jeremyhu@apple.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 18:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7HA-00028B-0x
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab0K2RMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 12:12:23 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:41501 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0K2RMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 12:12:20 -0500
Received: by fxm9 with SMTP id 9so1982504fxm.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FZG3Ma9bFsf0fbmyNa+94l8f5fLl5Ai1X7bd3gVGymo=;
        b=xCumM66bNl16yKWQELcuDvoST7dtsYoUKxCqp3lS5FAhLHz/fL3Yz8slJtIWJexC1c
         r6sfLuRKWIonB74yfevmXR3FQCwC/k1+T7se3H0x0EG2jkLU5Etj+8e8t9683W8tlHW4
         8VmjMf4AX8nKTWdGnXv9DzJX1834pfBCBEf+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fG5qD3LhVUTzaEgrVqrsTnXbaLowcsXalg4d8hMKGIS/xuqLdbfs3H5EV5XwbPqHnH
         pGdEYuoHssM3rXWRmM2gwmzX6q9v6EA9w2jxbOi0w+C2P86BmUvBs6xSPshK2nsUgSiy
         EX/J1uOGEauGQEPf93nEY8GZy0zxePTzum9nA=
Received: by 10.223.71.207 with SMTP id i15mr3579940faj.9.1291050739255;
        Mon, 29 Nov 2010 09:12:19 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id f24sm714191fak.0.2010.11.29.09.12.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 09:12:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162405>

Thiago Farina wrote:
> On Mon, Nov 29, 2010 at 2:57 PM, Jeremy Huddleston <jeremyhu@apple.com> wrote:

>> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
>> Reviewed-by: Matt Wright <mww@apple.com>

I like the idea, but could you add a short commit message
explaining the existing behavior and what improvement this makes?

> Why not #if defined(__APPLE__), like above?

More importantly, please search for #ifdef in existing code to get
some examples of how we like to do platform-specific things.

The section "2) #ifdefs are ugly" of
linux-2.6/Documentation/SubmittingPatches explains the rationale.

Regards,
Jonathan
