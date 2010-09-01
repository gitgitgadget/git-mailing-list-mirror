From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 1 Sep 2010 03:22:56 -0300
Message-ID: <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<7v1v9e803a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 08:23:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqgiu-0003BK-0d
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 08:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0IAGW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 02:22:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:32831 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0IAGW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 02:22:57 -0400
Received: by qyk33 with SMTP id 33so7465419qyk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kVx2GAks+Uo3P1CbHrNfHVyFUOqcolA6/UztXBFRT3c=;
        b=EkCV/CLCll4TSGQHnnIjwafqp+6qxZsDTg8MMmN3fcq5WlklzzKEXoxWQvIZupUPLg
         EcSSKRkjGpitexwYHRv+tilflFImSkhc9pg5i60bXHUuJGc+XkfGsZteWm5y08isGEzF
         vhDSoMmii/5sjBCMOtv+oDSD1UpvDdJ2F4+lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VncmKXQl8dA/pNbF9EpDUyMD6nL2uO1mILGi8Xn7KIWdVGf9Szf6CyM22p2vKZ/6fE
         C/fjxP3MnOc5oPrkRj+Hnb4OyB7MQWgAuNprHkikV79JhYrGLARqT8BivumjcBmRG3ks
         /JrP2C7OwDJhkVK+wjm8Po95gZ/wzKAXMkhNY=
Received: by 10.229.71.225 with SMTP id i33mr4971888qcj.195.1283322176498;
 Tue, 31 Aug 2010 23:22:56 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Tue, 31 Aug 2010 23:22:56 -0700 (PDT)
In-Reply-To: <7v1v9e803a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155019>

On Wed, Sep 1, 2010 at 3:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If the patch were to also move git_version_string[] from git.c to this new
> file, whose sole purpose will be to give the version information, then it
> might be worth it, as we would need to recompile a file with only 10 lines
> instead of git.c with 570 lines, but what the patch does is not even that.
>
It doesn't do that, but if you suggest that, I can fix it up later and
resend it.

>risk causing broken builds?
Hum, how such trivial change can cause that?

>What did we gain through this exercise?  Did we fix any real problem?
All patches should just fix real problems?

I think it just makes more sense, since *all* other commands are in
builtin/ and it's own files.
