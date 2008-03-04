From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one submodule
Date: Wed, 5 Mar 2008 00:00:44 +0800
Message-ID: <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
	 <alpine.LSU.1.00.0803041500170.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZZz-0004Qd-EG
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYCDQAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYCDQAq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:00:46 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:41314 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYCDQAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:00:46 -0500
Received: by an-out-0708.google.com with SMTP id d31so169857and.103
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iTwRoH5FrqaO8aw2YKjBXpM6/9h6YVb1SOafkpr8aQc=;
        b=MywPZsPurdOBOYPbA6AwAN9WjmKvcvgOsqVrgGiBD4OQ2taTBa5WwCTqIvaT41SStvQbWOsEEyby5kW1MNu94a4KTRsWv+SwrmSUbVUytXObYLxikx/u05ofTEQviqRQGrh/x7V2Tx23aB4LB1K3waifVJKIggGZtH/6OdSisQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=adfeZxOoYhHxCd/GEmj/0hXXRYnxJvufnWHi3d4wWJdQT/Z/3DLnjV/YPWZCgwtsZ5V4Q3cXd//cVhNg7Ux1S5gUQm4xtaoBOKg/TKoygFeGfis00l0qrA1DjbOx6AhSXQ9ei7XR5TGT7kk0X3vypQN9xUoFImvwOl486bfCofs=
Received: by 10.100.7.1 with SMTP id 1mr3313752ang.87.1204646444762;
        Tue, 04 Mar 2008 08:00:44 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 08:00:44 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803041500170.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76104>

On Tue, Mar 4, 2008 at 11:01 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Tue, 4 Mar 2008, Ping Yin wrote:
>
>  > When handling multiple modules, init/update/status command will exit
>  > when it fails for one submodule. This patch makes the command continue
>  > bypassing the failure.
>
>  I think that you should not do this.  The failure should not be ignored.
>  Maybe continuing, but not forgetting about the error.  So:
>
>
>  > -             name=$(module_name "$path") || exit
>  > +             name=$(module_name "$path") || continue
>
>  I do not like this.  It should remember that there was something foul, and
>  eventually exit with that status.
>
The error output is not lost and is in module_name
>  Ciao,
>  Dscho
>
>



-- 
Ping Yin
